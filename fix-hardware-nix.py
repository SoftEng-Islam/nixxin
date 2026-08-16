import re, sys

path = "users/softeng/hardware.nix"
with open(path, "r", encoding="utf-8") as f:
    s = f.read()

old_needle = '"username=win"'
if old_needle not in s:
    print("Didn't find the expected line — file may already be fixed, or content differs. Aborting, no changes made.")
    sys.exit(1)

s2 = s.replace(
    '      "username=win"\n      "password=1122"\n',
    '      "credentials=/etc/nixos/secrets/windows-share.cred"\n'
)

# Also swap the inline comment above the block, if present as-is.
s2 = s2.replace(
    '# $ sudo mount.cifs //192.168.1.3/windows_shared ~/windows -o user=win,password=1122,uid=$(id -u),gid=$(id -g),x-gvfs-show',
    '# Credentials live outside the repo in a root-only file, NOT in git.\n'
    '  # Create it once on the target machine (not committed):\n'
    '  #   sudo install -m 600 /dev/null /etc/nixos/secrets/windows-share.cred\n'
    '  #   sudo tee /etc/nixos/secrets/windows-share.cred <<\'EOF\'\n'
    '  #   username=win\n'
    '  #   password=REPLACE_ME\n'
    '  #   EOF\n'
    '  # $ sudo mount.cifs //192.168.1.3/windows_shared ~/windows -o credentials=/etc/nixos/secrets/windows-share.cred,uid=$(id -u),gid=$(id -g),x-gvfs-show'
)

if s2 == s:
    print("Replacement made no change — pattern matched password line but not the surrounding text as expected. Check manually.")
    sys.exit(1)

with open(path, "w", encoding="utf-8") as f:
    f.write(s2)

print("Done. Diff:")
