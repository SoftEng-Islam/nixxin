// Experimental ALIB stub for firmware that references \_SB.ALIB but doesn't
// define it (causing ATC0/ATCS AE_NOT_FOUND errors).
//
// If this doesn't fix the boot errors, we may need to match the exact return
// value format expected by your firmware callers.
//
DefinitionBlock ("", "SSDT", 2, "NIXXIN", "ALIBNOOP", 0x00000000)
{
    Scope (\_SB)
    {
        Method (ALIB, 2, NotSerialized)
        {
            // Most callers store ALIB's return value into a Buffer (e.g. the
            // ATCS/ATC* methods under \_SB.PCI0.VGA). Return an appropriately
            // sized zeroed buffer to avoid type/size issues.
            Return (Buffer (0xFF){})
        }
    }
}

