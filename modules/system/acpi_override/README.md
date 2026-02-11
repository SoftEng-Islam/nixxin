# ACPI override (DSDT/SSDT)

This repo supports overriding buggy firmware ACPI tables via initrd embedding.

- Put compiled AML files (`*.aml`) in this directory, or ASL sources (`*.asl`)
  (they will be compiled to AML during the Nix build).
- They get embedded into the initrd at `/kernel/firmware/acpi/<name>.aml`.

Entry point: `modules/system/configuration.nix` (search for `acpiOverrideDir`).

## Important: initrd must be uncompressed

Linux only scans an **uncompressed** leading initrd CPIO archive for ACPI table
overrides. If initrd is compressed, the kernel will not see
`/kernel/firmware/acpi/*.aml` early enough and will ignore the overrides.

This repo sets `boot.initrd.compressor = "none"` automatically when override
tables are present.

## Dump + disassemble current tables (run on the target machine)

```bash
sudo mkdir -p /tmp/acpi
sudo sh -c 'cd /tmp/acpi && acpidump -b'
sudo chown -R "$USER:$USER" /tmp/acpi
cd /tmp/acpi
iasl -d *.dat
rg -n "ALIB|ATC0|ATCS" *.dsl
```

## Troubleshooting

If you still see `AE_NOT_FOUND` for `\_SB.ALIB` after adding an override:

```bash
# 1) Verify initrd is uncompressed (should say "ASCII cpio archive")
file /run/current-system/initrd

# 2) Check for kernel lockdown (Secure Boot can cause overrides to be ignored)
cat /sys/kernel/security/lockdown 2>/dev/null || true

# 3) See whether the kernel mentioned loading/ignoring override tables
sudo journalctl -k -b | rg -n "ACPI.*(override|upgrade)|locked down|firmware/acpi"
```

## Build an override table from ASL

```bash
iasl -tc ssdt-alib.asl
# outputs: ssdt-alib.aml
```

Then copy `ssdt-alib.asl` (or the resulting `ssdt-alib.aml`) into this
directory and rebuild NixOS.
