{ pkgs, ... }:

let
  journal-live = pkgs.writeShellScriptBin "pc-journal-live" ''
    set -euo pipefail

    # Configuration
    DEFAULT_FILENAME="journal_live_$(date +%Y%m%d_%H%M%S).log"
    
    # Colors
    BOLD="\033[1m"
    BLUE="\033[34m"
    GREEN="\033[32m"
    YELLOW="\033[33m"
    RED="\033[31m"
    RESET="\033[0m"

    show_help() {
      echo -e "''${BOLD}PC Journal Live Logger''${RESET}"
      echo -e "Saves system logs to a file in real-time."
      echo
      echo -e "''${BOLD}Usage:''${RESET}"
      echo -e "  pc-journal-live [OUTPUT_FILE]    Start logging to specified file or default"
      echo -e "  pc-journal-live --help           Show this message"
      echo
      echo -e "''${BOLD}Examples:''${RESET}"
      echo -e "  pc-journal-live                  Logs to ./''${DEFAULT_FILENAME}"
      echo -e "  pc-journal-live debug.log        Logs to ./debug.log"
      echo -e "  sudo pc-journal-live             Logs with root permissions (required for full logs)"
    }

    if [[ "''${1:-}" == "--help" || "''${1:-}" == "-h" ]]; then
      show_help
      exit 0
    fi

    OUTPUT_FILE="''${1:-$DEFAULT_FILENAME}"

    # Check for journalctl access
    if ! journalctl -n 1 >/dev/null 2>&1; then
      echo -e "''${YELLOW}Warning:''${RESET} Limited access to system logs. Consider running with ''${BOLD}sudo''${RESET}."
    fi

    echo -e "''${BLUE}==>''${RESET} ''${BOLD}Monitoring journalctl...''${RESET}"
    echo -e "''${GREEN}==>''${RESET} Saving to: ''${BOLD}$OUTPUT_FILE''${RESET}"
    echo -e "''${GREEN}==>''${RESET} Press ''${BOLD}Ctrl+C''${RESET} to stop and save."
    echo

    # Start the follow mode
    # -f follows the journal
    journalctl -f | tee "$OUTPUT_FILE"
  '';
in
{
  environment.systemPackages = [ journal-live ];
}
