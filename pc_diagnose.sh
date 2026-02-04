#!/usr/bin/env bash

#
# pc_diagnose.sh
# -------------
# Safe, read-only system diagnostics (Linux/NixOS). Designed to work even when
# optional tools are missing. By default it avoids sudo prompts and large logs.
#
# Examples:
#   ./pc_diagnose.sh
#   ./pc_diagnose.sh --sudo --full -o /tmp/pc_report.txt
#   ./pc_diagnose.sh --redact -o /tmp/pc_report_redacted.txt

set -u
set -o pipefail

FULL=0
REDACT=0
INCLUDE_ENV=0
NO_COLOR=0
OUTPUT_FILE=""
SUDO_MODE="auto" # auto|ask|never

usage() {
  cat <<'EOF'
Usage: ./pc_diagnose.sh [options]

Options:
  -o, --output FILE   Write report to FILE (also prints to stdout).
  --full              Include extra checks + larger log excerpts.
  --sudo              Use sudo for privileged checks (dmidecode/smartctl/journalctl/...).
  --no-sudo           Never attempt sudo (default: only run privileged checks if already root).
  --redact            Redact common identifiers (IPs/MACs/UUID-like patterns) from output.
  --env               Include environment variables (may contain secrets).
  --no-color          Disable ANSI colors (also obeys NO_COLOR=1).
  -h, --help          Show this help.
EOF
}

die() {
  echo "error: $*" >&2
  exit 2
}

have() { command -v "$1" >/dev/null 2>&1; }
is_tty() { [[ -t 1 ]]; }
is_root() { [[ ${EUID:-$(id -u)} -eq 0 ]]; }

color_setup() {
  if [[ $NO_COLOR -eq 1 || -n "${NO_COLOR:-}" || ! -t 1 ]]; then
    C_BOLD=""; C_DIM=""; C_RESET=""; C_RED=""; C_YELLOW=""
    return
  fi
  C_BOLD=$'\033[1m'
  C_DIM=$'\033[2m'
  C_RESET=$'\033[0m'
  C_RED=$'\033[31m'
  C_YELLOW=$'\033[33m'
}

section() {
  echo
  echo "${C_BOLD}===== $* =====${C_RESET}"
}

subsection() {
  echo
  echo "${C_BOLD}--- $* ---${C_RESET}"
}

note() {
  echo "${C_DIM}# $*${C_RESET}"
}

warn() {
  echo "${C_YELLOW}warning:${C_RESET} $*" >&2
}

redact_text() {
  # Best-effort redaction for sharing logs publicly.
  # - MAC addresses
  # - IPv4 addresses
  # - UUID-ish strings
  # - Long hex tokens (>= 16 chars)
  sed -E \
    -e 's/\b([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}\b/XX:XX:XX:XX:XX:XX/g' \
    -e 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/<IPV4>/g' \
    -e 's/\b[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\b/<UUID>/g' \
    -e 's/\b[0-9A-Fa-f]{16,}\b/<HEX>/g'
}

print_cmd() {
  local pretty
  pretty=$(printf '%q ' "$@")
  echo "${C_DIM}\$ ${pretty% }${C_RESET}"
}

run_cmd() {
  local label="$1"
  shift

  local cmd=("$@")
  local bin="${cmd[0]}"
  if ! have "$bin"; then
    note "$label: missing '$bin' (skipped)"
    return 0
  fi

  echo "${C_BOLD}$label:${C_RESET}"
  print_cmd "${cmd[@]}"

  local out rc
  out="$("${cmd[@]}" 2>&1)"
  rc=$?
  if [[ $REDACT -eq 1 ]]; then
    out="$(printf '%s' "$out" | redact_text)"
  fi
  if [[ -n "$out" ]]; then
    printf '%s\n' "$out"
  fi
  if [[ $rc -ne 0 ]]; then
    echo "${C_RED}(exit $rc)${C_RESET}"
  fi
}

run_root() {
  local label="$1"
  shift

  if is_root; then
    run_cmd "$label" "$@"
    return 0
  fi

  if [[ $SUDO_MODE == "never" ]]; then
    note "$label: needs root (skipped; --no-sudo)"
    return 0
  fi
  if [[ $SUDO_MODE == "auto" ]]; then
    note "$label: needs root (skipped; re-run with --sudo)"
    return 0
  fi
  if ! have sudo; then
    note "$label: needs root (skipped; sudo missing)"
    return 0
  fi

  if sudo -n true 2>/dev/null; then
    run_cmd "$label" sudo -n "$@"
    return 0
  fi

  if is_tty; then
    run_cmd "$label" sudo "$@"
    return 0
  fi

  note "$label: needs root (skipped; sudo requires password and no tty)"
}

read_file() {
  local path="$1"
  if [[ ! -e "$path" ]]; then
    return 1
  fi
  if [[ ! -r "$path" ]]; then
    echo "(unreadable)"
    return 0
  fi
  cat "$path" 2>/dev/null || echo "(read error)"
}

kv_from_file() {
  local key="$1"
  local path="$2"
  if [[ -e "$path" ]]; then
    local val
    val="$(read_file "$path" | head -n 1)"
    [[ $REDACT -eq 1 ]] && val="$(printf '%s' "$val" | redact_text)"
    printf '%-18s %s\n' "${key}:" "$val"
  fi
}

collect_dmi_sysfs() {
  local base="/sys/class/dmi/id"
  [[ -d "$base" ]] || return 0
  subsection "DMI (sysfs)"
  kv_from_file "sys_vendor" "$base/sys_vendor"
  kv_from_file "product_name" "$base/product_name"
  kv_from_file "product_version" "$base/product_version"
  kv_from_file "board_vendor" "$base/board_vendor"
  kv_from_file "board_name" "$base/board_name"
  kv_from_file "board_version" "$base/board_version"
  kv_from_file "bios_vendor" "$base/bios_vendor"
  kv_from_file "bios_version" "$base/bios_version"
  kv_from_file "bios_date" "$base/bios_date"
}

collect_cpufreq_sysfs() {
  local base="/sys/devices/system/cpu/cpufreq"
  [[ -d "$base" ]] || return 0
  subsection "CPU frequency policy (sysfs)"
  local p
  for p in "$base"/policy*; do
    [[ -d "$p" ]] || continue
    local name gov min max cur
    name="$(basename "$p")"
    gov="$(read_file "$p/scaling_governor" | head -n 1)"
    min="$(read_file "$p/scaling_min_freq" | head -n 1)"
    max="$(read_file "$p/scaling_max_freq" | head -n 1)"
    cur="$(read_file "$p/scaling_cur_freq" | head -n 1)"
    if [[ $REDACT -eq 1 ]]; then
      gov="$(printf '%s' "$gov" | redact_text)"
      min="$(printf '%s' "$min" | redact_text)"
      max="$(printf '%s' "$max" | redact_text)"
      cur="$(printf '%s' "$cur" | redact_text)"
    fi
    printf '%s: governor=%s min=%s max=%s cur=%s\n' "$name" "$gov" "$min" "$max" "$cur"
  done
}

collect_amd_gpu_sysfs() {
  local base="/sys/class/drm"
  [[ -d "$base" ]] || return 0

  local card
  local found=0
  for card in "$base"/card*; do
    [[ -d "$card/device" ]] || continue
    if [[ -r "$card/device/vendor" ]]; then
      local vendor
      vendor="$(read_file "$card/device/vendor" | head -n 1)"
      [[ "$vendor" == "0x1002" ]] || continue
      found=1

      subsection "AMD GPU (sysfs): $(basename "$card")"
      kv_from_file "device" "$card/device/device"
      kv_from_file "subsystem" "$card/device/subsystem_device"
      kv_from_file "power_profile" "$card/device/power_dpm_force_performance_level"
      kv_from_file "power_state" "$card/device/power_dpm_state"

      if [[ -r "$card/device/gpu_busy_percent" ]]; then
        local busy
        busy="$(read_file "$card/device/gpu_busy_percent" | head -n 1)"
        printf '%-18s %s%%\n' "gpu_busy:" "$busy"
      fi

      if [[ -r "$card/device/mem_info_vram_used" && -r "$card/device/mem_info_vram_total" ]]; then
        local used total
        used="$(read_file "$card/device/mem_info_vram_used" | head -n 1)"
        total="$(read_file "$card/device/mem_info_vram_total" | head -n 1)"
        printf '%-18s %s / %s bytes\n' "vram_used:" "$used" "$total"
      fi

      if [[ $FULL -eq 1 ]]; then
        if [[ -r "$card/device/pp_dpm_sclk" ]]; then
          echo
          echo "pp_dpm_sclk:"
          read_file "$card/device/pp_dpm_sclk" | head -n 30
        fi
        if [[ -r "$card/device/pp_dpm_mclk" ]]; then
          echo
          echo "pp_dpm_mclk:"
          read_file "$card/device/pp_dpm_mclk" | head -n 30
        fi
      fi
    fi
  done

  [[ $found -eq 1 ]] || return 0
}

setup_output() {
  [[ -n "$OUTPUT_FILE" ]] || return 0
  mkdir -p "$(dirname "$OUTPUT_FILE")" 2>/dev/null || true
  if have tee; then
    exec > >(tee "$OUTPUT_FILE") 2>&1
  else
    exec >"$OUTPUT_FILE" 2>&1
  fi
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -o|--output)
        [[ $# -ge 2 ]] || die "--output requires a file path"
        OUTPUT_FILE="$2"
        shift 2
        ;;
      --full) FULL=1; shift ;;
      --sudo) SUDO_MODE="ask"; shift ;;
      --no-sudo) SUDO_MODE="never"; shift ;;
      --redact) REDACT=1; shift ;;
      --env) INCLUDE_ENV=1; shift ;;
      --no-color) NO_COLOR=1; shift ;;
      -h|--help) usage; exit 0 ;;
      *)
        die "unknown option: $1 (try --help)"
        ;;
    esac
  done
}

main() {
  parse_args "$@"
  color_setup
  setup_output

  section "pc_diagnose"
  note "read-only diagnostics; no settings are changed"
  note "run with --sudo for more hardware/log details; add --full for extra checks"
  echo "timestamp: $(date -Is 2>/dev/null || date)"
  echo "user:      $(id -un 2>/dev/null || true) (uid=$(id -u 2>/dev/null || true))"
  echo "hostname:  $(hostname 2>/dev/null || true)"

  section "Tooling"
  note "missing tools are OK; sections will be skipped or show errors"
  local tool
  for tool in bash awk sed grep hostnamectl lscpu lspci lsblk smartctl dmidecode sensors journalctl systemctl ip nmcli resolvectl powerprofilesctl upower nvidia-smi clinfo btrfs findmnt zramctl vmstat iostat cpufreq-info cpupower; do
    if have "$tool"; then
      printf '%-18s %s\n' "$tool:" "ok"
    else
      printf '%-18s %s\n' "$tool:" "missing"
    fi
  done

  section "System"
  run_cmd "OS release" bash -c '[[ -r /etc/os-release ]] && cat /etc/os-release || echo "/etc/os-release not found"'
  run_cmd "Kernel" uname -a
  run_cmd "Uptime" bash -c 'uptime -p 2>/dev/null || uptime'
  run_cmd "Hostnamectl" hostnamectl
  run_cmd "Current cmdline" cat /proc/cmdline

  subsection "Nix / NixOS"
  run_cmd "nixos-version" nixos-version
  run_cmd "nix --version" nix --version
  run_cmd "nix-env --version" nix-env --version
  if [[ -e /run/current-system ]]; then
    run_cmd "/run/current-system" readlink -f /run/current-system
  fi
  if [[ $FULL -eq 1 ]]; then
    run_cmd "Generations" nixos-rebuild list-generations
  else
    run_cmd "Generations (latest)" bash -c 'command -v nixos-rebuild >/dev/null 2>&1 || { echo "nixos-rebuild not installed"; exit 0; }; nixos-rebuild list-generations 2>/dev/null | head -n 16'
  fi

  section "Hardware"
  run_cmd "CPU (lscpu subset)" bash -c 'command -v lscpu >/dev/null 2>&1 || { echo "lscpu not installed"; exit 0; }; lscpu 2>/dev/null | awk -F: '"'"'/Model name|Architecture|Vendor ID|CPU\(s\)|Thread|Core|Socket|CPU max MHz|CPU min MHz|MHz/ {gsub(/^[ \t]+/,"",$2); printf "%-22s %s\n",$1":",$2}'"'"''
  subsection "CPU frequency (tools)"
  run_cmd "cpufreq-info" cpufreq-info
  run_cmd "cpupower frequency-info" cpupower frequency-info
  if [[ $FULL -eq 1 ]]; then
    run_cmd "cpupower idle-info" cpupower idle-info
  fi
  run_cmd "Memory" free -h
  collect_cpufreq_sysfs
  collect_dmi_sysfs
  if [[ $FULL -eq 1 ]]; then
    run_root "Motherboard (dmidecode)" dmidecode -t baseboard
    run_root "BIOS (dmidecode)" dmidecode -t bios
    run_root "RAM modules (dmidecode)" dmidecode --type 17
  else
    run_root "Motherboard (dmidecode summary)" bash -c 'command -v dmidecode >/dev/null 2>&1 || { echo "dmidecode not installed"; exit 0; }; dmidecode -t baseboard 2>/dev/null | grep -E "Manufacturer:|Product Name:|Version:|Serial Number:" || true'
    run_root "BIOS (dmidecode summary)" bash -c 'command -v dmidecode >/dev/null 2>&1 || { echo "dmidecode not installed"; exit 0; }; dmidecode -t bios 2>/dev/null | grep -E "Vendor:|Version:|Release Date:|BIOS Revision:" || true'
    run_root "RAM modules (dmidecode summary)" bash -c 'command -v dmidecode >/dev/null 2>&1 || { echo "dmidecode not installed"; exit 0; }; dmidecode --type 17 2>/dev/null | grep -E "Locator:|Size:|Speed:|Configured Memory Speed:|Manufacturer:|Part Number:|Serial Number:" | grep -v "No Module Installed" || true'
  fi

  subsection "GPU"
  run_cmd "PCI display devices" bash -c 'command -v lspci >/dev/null 2>&1 || { echo "lspci not installed"; exit 0; }; lspci -nnk 2>/dev/null | awk '"'"'BEGIN{RS=""; FS="\n"} $0 ~ /(VGA compatible controller|3D controller|Display controller)/ {print $0 "\n"}'"'"''
  run_cmd "OpenCL (clinfo subset)" bash -c 'command -v clinfo >/dev/null 2>&1 || { echo "clinfo not installed"; exit 0; }; clinfo 2>/dev/null | grep -E "Platform Name|Device Name|Device Type|Max Compute Units|Max Clock Frequency|Global Memory Size|Local Memory Size" || true'
  collect_amd_gpu_sysfs
  run_cmd "DRM devices" bash -c 'ls -l /dev/dri 2>/dev/null || echo "/dev/dri not present"'

  section "Storage"
  run_cmd "Block devices" bash -c 'command -v lsblk >/dev/null 2>&1 || { echo "lsblk not installed"; exit 0; }; lsblk -o NAME,MODEL,SIZE,TYPE,FSTYPE,MOUNTPOINTS 2>/dev/null || lsblk -o NAME,MODEL,SIZE,TYPE,FSTYPE,MOUNTPOINT 2>/dev/null'
  run_cmd "Filesystem usage" df -hT
  run_cmd "Swap" bash -c 'swapon --show 2>/dev/null || true'

  subsection "Btrfs"
  run_cmd "btrfs filesystem show" btrfs filesystem show
  if [[ $FULL -eq 1 ]]; then
    if have findmnt; then
      while IFS= read -r mp; do
        [[ -n "$mp" ]] || continue
        run_cmd "btrfs filesystem df ($mp)" btrfs filesystem df "$mp"
        run_root "btrfs device stats ($mp)" btrfs device stats "$mp"
      done < <(findmnt -rn -t btrfs -o TARGET 2>/dev/null)
    else
      run_cmd "btrfs filesystem df (/)" btrfs filesystem df /
      run_root "btrfs device stats (/)" btrfs device stats /
    fi
  fi

  subsection "SMART (health)"
  if have lsblk; then
    while IFS= read -r disk; do
      [[ -n "$disk" ]] || continue
      case "$disk" in
        zram*|loop*|ram*) continue ;;
      esac
      run_root "smartctl -H /dev/$disk" smartctl -H "/dev/$disk"
      if [[ $FULL -eq 1 ]]; then
        run_root "smartctl -A /dev/$disk" smartctl -A "/dev/$disk"
      fi
    done < <(lsblk -dn -o NAME,TYPE 2>/dev/null | awk '$2=="disk"{print $1}')
  else
    note "SMART: lsblk missing (skipped)"
  fi

  section "Network"
  run_cmd "Interfaces" ip -br link
  run_cmd "Addresses" ip -br addr
  run_cmd "Routes" ip route
  run_cmd "DNS (resolvectl)" resolvectl status
  run_cmd "DNS (/etc/resolv.conf)" cat /etc/resolv.conf
  run_cmd "NetworkManager" nmcli -t general status
  if [[ $FULL -eq 1 ]]; then
    run_cmd "Connectivity (ping IP)" bash -c 'ping -c 1 -W 1 1.1.1.1 2>/dev/null || true'
    run_cmd "Connectivity (ping DNS)" bash -c 'ping -c 1 -W 1 one.one.one.one 2>/dev/null || true'
  fi

  section "Power"
  run_cmd "Power profiles" powerprofilesctl list
  run_cmd "Battery (upower)" bash -c 'command -v upower >/dev/null 2>&1 || { echo "upower not installed"; exit 0; }; upower -e 2>/dev/null | grep -E "(battery|BAT)" -m 1 | xargs -r upower -i 2>/dev/null || true'

  section "Temperatures"
  run_cmd "sensors" sensors
  run_cmd "NVIDIA (nvidia-smi)" nvidia-smi

  section "System health"
  run_cmd "Failed units" systemctl --failed --no-pager
  run_cmd "Top CPU processes" bash -c 'ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu | head -n 15'
  run_cmd "Top MEM processes" bash -c 'ps -eo pid,ppid,comm,%cpu,%mem --sort=-%mem | head -n 15'

  section "Performance"
  run_cmd "PSI (cpu)" cat /proc/pressure/cpu
  run_cmd "PSI (memory)" cat /proc/pressure/memory
  run_cmd "PSI (io)" cat /proc/pressure/io
  run_cmd "ZRAM (zramctl)" zramctl
  if [[ $FULL -eq 1 ]]; then
    run_cmd "vmstat (5 samples)" bash -c 'command -v vmstat >/dev/null 2>&1 || { echo "vmstat not installed"; exit 0; }; vmstat 1 5'
    run_cmd "iostat (1 sample)" bash -c 'command -v iostat >/dev/null 2>&1 || { echo "iostat not installed"; exit 0; }; iostat -xz 1 1'
  fi

  section "Logs"
  run_cmd "Kernel (dmesg warnings/errors)" bash -c 'dmesg --color=never --level=err,warn 2>/dev/null | tail -n 200 || dmesg 2>/dev/null | tail -n 200 || true'
  if [[ $FULL -eq 1 ]]; then
    if [[ $SUDO_MODE == "ask" ]] || is_root; then
      run_root "Journal (current boot, warnings+)" journalctl -b --no-pager -p warning -n 400
      run_root "Journal (previous boot, errors)" journalctl -b -1 --no-pager -p err -n 200
    else
      run_cmd "Journal (current boot, warnings+)" journalctl -b --no-pager -p warning -n 400
      run_cmd "Journal (previous boot, errors)" journalctl -b -1 --no-pager -p err -n 200
    fi
  else
    if [[ $SUDO_MODE == "ask" ]] || is_root; then
      run_root "Journal (current boot, errors)" journalctl -b --no-pager -p err -n 200
    else
      run_cmd "Journal (current boot, errors)" journalctl -b --no-pager -p err -n 200
    fi
  fi

  if [[ $INCLUDE_ENV -eq 1 ]]; then
    section "Environment"
    warn "--env enabled; output may include secrets"
    run_cmd "env" env
  fi

  section "Done"
  note "Tip: ./pc_diagnose.sh --sudo --full -o /tmp/pc_report.txt"
}

main "$@"
