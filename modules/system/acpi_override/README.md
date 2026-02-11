# ACPI override (DSDT/SSDT)

This repo supports overriding buggy firmware ACPI tables via initrd embedding.

- Put compiled AML files (`*.aml`) in this directory, or ASL sources (`*.asl`)
  (they will be compiled to AML during the Nix build).
- They get embedded into the initrd at `/kernel/firmware/acpi/<name>.aml`.

Entry point: `modules/system/configuration.nix` (search for `acpiOverrideDir`).

## Dump + disassemble current tables (run on the target machine)

```bash
sudo mkdir -p /tmp/acpi
sudo sh -c 'cd /tmp/acpi && acpidump -b'
sudo chown -R "$USER:$USER" /tmp/acpi
cd /tmp/acpi
iasl -d *.dat
rg -n "ALIB|ATC0|ATCS" *.dsl
```

## Build an override table from ASL

```bash
iasl -tc ssdt-alib.asl
# outputs: ssdt-alib.aml
```

Then copy `ssdt-alib.asl` (or the resulting `ssdt-alib.aml`) into this
directory and rebuild NixOS.
