# n8n Troubleshooting & Operations Guide

This guide contains the most essential commands, common gotchas, and important bits of information for administering the `n8n` setup on this NixOS machine.

## Important Information (Read Before Using n8n)

### 1. Database Backend
Modern versions of `n8n` (1.x+) **no longer support MongoDB**. The default, zero-configuration database is `sqlite`. If you need higher performance or multiple executor nodes, use `postgresdb`. If you previously had `mongodb` defined in your Nix configuration (`DB_TYPE = "mongodb"`), `n8n` will automatically fall back to SQLite and issue a warning.

### 2. Manual Startup Behavior
In the `n8n.nix` module, the `wantedBy = lib.mkForce [ ];` flag is applied to the service. This deliberately removes `n8n` from the default startup target. This means **n8n will NOT launch on system boot automatically** or after a NixOS rebuild. You must start it manually whenever you want it online:
```bash
sudo systemctl start n8n
```

### 3. File Execution & Permissions
- All workflow data, credentials, and settings are stored locally in `/var/lib/n8n`.
- Due to strict file permissions and systemd sandboxing in NixOS, `n8n` requires explicit permission to write to its database state directory. The `n8n.nix` file has been configured with `ReadWritePaths = [ "/var/lib/n8n" ]` to prevent `SQLITE_READONLY` errors.
- If you run into situations where `n8n` complains about not being able to write to its configuration file, you may need to reset ownership: `sudo chown -R n8n:n8n /var/lib/n8n`.

### 4. Nginx Reverse Proxy
`n8n` listens privately on `127.0.0.1:5678`. Nginx functions as a secure HTTPS reverse proxy layer routing to it. `n8n` is accessible securely via `https://localhost` or the `*.local` hostname provided in `n8n.nix`.

---

## Operations & Debugging Commands

Here are all the operational commands necessary to verify, fix, and maintain proper function of the `n8n` workflow engine and its Nginx proxy.

### Service Management (n8n)

**Start the n8n service manually:**
```bash
sudo systemctl start n8n
```

**Restart the n8n service:**
*(Useful after manual tweaks to `/var/lib/n8n/` configs if needed, though NixOS rebuilds generally encompass restarts)*
```bash
sudo systemctl restart n8n
```

**Check if n8n is running (Status):**
```bash
sudo systemctl status n8n
```
*Look for `Active: active (running)`. If it says `inactive (dead)`, the service is stopped or failed.*

### Log Inspection (n8n)

**View recent n8n logs:**
```bash
sudo journalctl -u n8n.service -n 100 --no-pager
```

**Follow n8n logs in real-time (Tailing):**
*(Great for debugging workflows running live as you trigger them! Use `Ctrl+C` to exit.)*
```bash
sudo journalctl -u n8n.service -f
```

### Log Inspection & Status (Nginx)

**Check if Nginx is active:**
*(If you get a 502 Bad Gateway or 500 error in your browser, check this)*
```bash
sudo systemctl status nginx
```

**View Nginx system logs:**
```bash
sudo journalctl -u nginx.service -n 100 --no-pager
```

### System Configuration & OS Level Fixes

**Rebuild the System (Apply Nix adjustments):**
*(Run this inside `/home/softeng/nixxin` to apply any changes made to `modules/automation/n8n.nix`)*
```bash
sudo nixos-rebuild switch --flake .
```

**Fix n8n Permission Errors (SQLite Readonly or config crashes):**
*(If you ever see a `SQLITE_READONLY` error in the journals or if `root` accidentally hijacked the files during testing)*
```bash
sudo chown -R n8n:n8n /var/lib/n8n
sudo systemctl restart n8n
```

**Checking Nginx Syntax:**
Nginx doesn't add its binary to your global `PATH` under the default NixOS security profile, so running `sudo nginx -t` directly in the shell throws `command not found`. Instead, `NixOS` automatically tests your declarative Nginx config syntax during `nixos-rebuild switch` and won't substitute a bad configuration. If it fails, the rebuild explicitly halts and shows you the Nginx syntax error.
