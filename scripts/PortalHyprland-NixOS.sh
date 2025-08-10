#!/run/current-system/sw/bin/bash

# Find all portals executables actually running
portal_list=$(ps -fu bt|grep xdg-desktop-portal|grep -v grep|sort|awk -F " " '{print $8}')

for portal in $portal_list; do
  # Get the name of executable
  portal_name=$(basename -- "$portal")

# Check if the executable is valid and exists
  if [ -x "$portal" ]; then
    # Kill the active one and restart it
    killall "$portal_name"
    sleep 1
    "$portal" &
    exit 0
  fi
done

# If no valid executable is found, report an error
echo "ERROR: No valid xdg-portal-desktop found"
exit
