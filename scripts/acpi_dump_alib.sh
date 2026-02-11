#!/usr/bin/env bash
set -euo pipefail

out_dir="${1:-/tmp/acpi-dump-$(date +%Y%m%d-%H%M%S)}"
user_group="$(id -gn)"

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

need acpidump
need iasl
need rg

echo "==> Dumping ACPI tables to: $out_dir"
sudo mkdir -p "$out_dir"
sudo sh -c "cd '$out_dir' && acpidump -b"
sudo chown -R "$USER:$user_group" "$out_dir"

cd "$out_dir"

echo "==> Disassembling (*.dat -> *.dsl)"
iasl -d ./*.dat >/dev/null

echo "==> Searching for ALIB/ATC0/ATCS references"
rg -n "ALIB|ATC0|ATCS" ./*.dsl > alib_hits.txt || true

extract_method_block() {
  local method="$1"
  local file="$2"
  awk -v method="$method" '
    BEGIN { in=0; depth=0; }
    {
      if (in == 0 && $0 ~ "Method[[:space:]]*\\(" method "([,)]|[[:space:]])") {
        in=1;
      }
      if (in == 1) {
        print;
        depth += gsub(/\{/, "{");
        depth -= gsub(/\}/, "}");
        if (depth == 0 && $0 ~ /\}/) {
          exit 0;
        }
      }
    }
  ' "$file"
}

extract_first() {
  local pattern="$1"
  local out_file="$2"
  local file

  file="$(rg -l "$pattern" ./*.dsl 2>/dev/null | head -n 1 || true)"
  if [[ -z "${file:-}" ]]; then
    return 0
  fi

  if [[ "$pattern" == "Method (ALIB" || "$pattern" == "Method (ATC0" || "$pattern" == "Method (ATCS" ]]; then
    local method
    method="$(echo "$pattern" | sed -E 's/^Method \\(([A-Z0-9_]+).*$/\\1/')"
    extract_method_block "$method" "$file" > "$out_file" || true
  else
    rg -n "$pattern" "$file" > "$out_file" || true
  fi
}

extract_first "Method (ALIB" ALIB_method.dsl || true
extract_first "Method (ATC0" ATC0_method.dsl || true
extract_first "Method (ATCS" ATCS_method.dsl || true

echo "==> Done"
echo "  - $out_dir/alib_hits.txt"
echo "  - $out_dir/ALIB_method.dsl (if found)"
echo "  - $out_dir/ATC0_method.dsl (if found)"
echo "  - $out_dir/ATCS_method.dsl (if found)"
