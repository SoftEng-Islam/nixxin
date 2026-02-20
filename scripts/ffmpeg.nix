{
  pkgs,
  ...
}:
let
  ffmpeg = pkgs.ffmpeg-full;
  fmpeg = pkgs.writeShellScriptBin "fmpeg" ''
    set -euo pipefail

    usage() {
      cat <<'EOF'
fmpeg [-i] <input> [ffmpeg args...] <output>

Runs:
  ffmpeg -i <input> -c:v libsvtav1 -c:a copy <output>

Examples:
  fmpeg input.mp4 output.mkv
  fmpeg -i input.mp4 -vf scale=1920:-2 output.mkv
EOF
    }

    if [[ $# -eq 0 ]] || [[ "''${1:-}" == "-h" ]] || [[ "''${1:-}" == "--help" ]] || [[ "''${1:-}" == "help" ]]; then
      usage
      exit 0
    fi

    if [[ $# -lt 2 ]]; then
      usage >&2
      exit 2
    fi

    if [[ "$1" == "-i" ]]; then
      if [[ $# -lt 3 ]]; then
        usage >&2
        exit 2
      fi
      shift
    fi

    input="$1"
    shift

    output="''${@: -1}"
    if [[ $# -gt 1 ]]; then
      extras=("''${@:1:$#-1}")
    else
      extras=()
    fi

    exec ${ffmpeg}/bin/ffmpeg -i "$input" -c:v libsvtav1 -c:a copy "''${extras[@]}" "$output"
  '';
in
{
  environment.systemPackages = [
    fmpeg
  ];
}
