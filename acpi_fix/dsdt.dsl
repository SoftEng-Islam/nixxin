/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250807 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 *
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of dsdt.dat
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000DE31 (56881)
 *     Revision         0x02
 *     Checksum         0xA3
 *     OEM ID           "HPQOEM"
 *     OEM Table ID     "805A    "
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20121018 (538054680)
 */
DefinitionBlock ("", "DSDT", 2, "HPQOEM", "805A    ", 0x00000001)
{
    External (_SB_.APTS, MethodObj)    // 1 Arguments
    External (_SB_.AWAK, MethodObj)    // 1 Arguments


    Scope (\_SB)
    {
        Method (ALIB, 2, NotSerialized)
        {
            Return (Zero)
        }
    }

    OperationRegion (HPSA, SystemMemory, 0x7EF91000, 0x00000008)
    Field (HPSA, AnyAcc, Lock, Preserve)
    {
        SFG1,   4,
        SFG2,   4,
        Offset (0x04),
        LPDP,   16,
        OSIF,   8,
        PRDT,   8
    }

    Name (GOSI, 0xFF)
    Method (GTOS, 0, Serialized)
    {
        If ((GOSI == 0xFF))
        {
            GOSI = Zero
            If (CondRefOf (\_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    GOSI = One
                }

                If (_OSI ("Windows 2001"))
                {
                    GOSI = 0x04
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    GOSI = 0x04
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    GOSI = 0x05
                }

                If (_OSI ("Windows 2006"))
                {
                    GOSI = 0x06
                }

                If (_OSI ("Windows 2009"))
                {
                    GOSI = 0x07
                }

                If (_OSI ("Windows 2012"))
                {
                    GOSI = 0x08
                }

                If (_OSI ("Windows 2013"))
                {
                    GOSI = 0x09
                }

                If (_OSI ("Windows 2015"))
                {
                    GOSI = 0x0A
                }
            }

            OSIF = GOSI /* \GOSI */
        }

        Return (GOSI) /* \GOSI */
    }

    Method (B2I4, 3, Serialized)
    {
        Name (INTE, 0xFFFFFFFF)
        INTE &= Zero
        Local2 = Arg2
        If ((Local2 > 0x04))
        {
            Local2 = 0x04
        }

        Local1 = (Arg1 * 0x08)
        Local3 = (Local2 * 0x08)
        CreateField (Arg0, Local1, Local3, TINT)
        INTE = TINT /* \B2I4.TINT */
        Return (INTE) /* \B2I4.INTE */
    }

    Name (B2SD, "                                                                                                                                                                                                                                                               ")
    Name (B2S4, "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ")
    Method (B2ST, 2, Serialized)
    {
        If ((Arg1 > Zero))
        {
            Local0 = Buffer (Arg1){}
            Local0 = Arg0
            If ((Arg1 > 0x0100))
            {
                B2S4 = Local0
                Local1 = B2S4 /* \B2S4 */
            }
            Else
            {
                B2SD = Local0
                Local1 = B2SD /* \B2SD */
            }
        }
        Else
        {
            B2SD = Arg0
            Local1 = B2SD /* \B2SD */
        }

        Return (Local1)
    }

    OperationRegion (HPGF, SystemMemory, 0x7EF87000, 0x00000210)
    Field (HPGF, AnyAcc, Lock, Preserve)
    {
        EDID,   2048,
        PAID,   32,
        PHSZ,   8,
        PVSZ,   8,
        BRCT,   8,
        BCCT,   8,
        BMAP,   88,
        BCLV,   216,
        BRLV,   200,
        BRNT,   400,
        BPWG,   16,
        BPWO,   16,
        PNFL,   8,
        VRMS,   32,
        VRMB,   32,
        DCAP,   8,
        WDPE,   8,
        WDSA,   16,
        WDST,   16,
        WDGN,   16,
        WDSS,   16,
        BRID,   8,
        VACC,   8,
        ASGM,   8,
        EDSZ,   32,
        APTI,   8,
        GDP1,   32,
        GDP2,   32,
        GDP3,   32,
        GDP4,   32,
        HDLS,   8,
        SDPE,   8,
        SDPG,   32,
        SDPA,   8,
        SDTE,   8,
        SDTG,   32,
        SDTA,   8,
        SHSE,   8,
        SHSG,   32,
        SHSA,   8,
        SUOE,   8,
        SUOG,   32,
        SUOA,   8,
        GP01,   32,
        GP02,   32,
        GP03,   32,
        GP04,   224,
        VRS2,   32,
        VRB2,   32,
        GC6E,   8,
        GC6G,   32,
        GC6A,   8,
        GETE,   8,
        GETG,   32,
        GETA,   8,
        DHIE,   8,
        DHIG,   32,
        DHIA,   8,
        VHIE,   8,
        VHIG,   32,
        VHIA,   8,
        ABNV,   8,
        ABXV,   8,
        DMY1,   8,
        HGDG,   32
    }

    OperationRegion (HPWM, SystemMemory, 0x7EF8D000, 0x00002818)
    Field (HPWM, AnyAcc, Lock, Preserve)
    {
        PWOT,   32,
        PWOI,   32,
        PUWB,   81920,
        PUWS,   32,
        STIC,   16,
        INIC,   16,
        ENIC,   16,
        OLIC,   16,
        PWIC,   16,
        BUIC,   16
    }

    Device (_SB.WMIB)
    {
        Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
        Name (_UID, One)  // _UID: Unique ID
        Mutex (PUMX, 0x00)
        Name (WDST, Package (0x0B)
        {
            "",
            "",
            "",
            One,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero
        })
        Name (WDIN, Package (0x0C)
        {
            "",
            "",
            "",
            One,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero
        })
        Name (WDEN, Package (0x0B)
        {
            "",
            "",
            "",
            One,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            "",
            Zero
        })
        Name (WDLI, Package (0x0A)
        {
            "",
            "",
            "",
            One,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero
        })
        Name (WDPA, Package (0x0E)
        {
            "",
            "",
            "",
            One,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero
        })
        Name (WDBU, Package (0x10)
        {
            "",
            "",
            "",
            One,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero,
            Zero
        })
        Name (WDG, Buffer (0xF0)
        {
            /* 0000 */  0xE3, 0x08, 0x8D, 0x98, 0xF4, 0x68, 0x35, 0x4C,  // .....h5L
            /* 0008 */  0xAF, 0x3E, 0x6A, 0x1B, 0x81, 0x06, 0xF8, 0x3C,  // .>j....<
            /* 0010 */  0x53, 0x54, 0x00, 0x00, 0x3D, 0xDE, 0x32, 0x82,  // ST..=.2.
            /* 0018 */  0x3D, 0x66, 0x27, 0x43, 0xA8, 0xF4, 0xE2, 0x93,  // =f'C....
            /* 0020 */  0xAD, 0xB9, 0xBF, 0x05, 0x49, 0x4E, 0x00, 0x00,  // ....IN..
            /* 0028 */  0x49, 0x4B, 0x11, 0x2D, 0xFB, 0x2D, 0x30, 0x41,  // IK.-.-0A
            /* 0030 */  0xB8, 0xFE, 0x4A, 0x3C, 0x09, 0xE7, 0x51, 0x33,  // ..J<..Q3
            /* 0038 */  0x45, 0x4E, 0x00, 0x00, 0x46, 0x97, 0xEA, 0x14,  // EN..F...
            /* 0040 */  0x1F, 0xCE, 0x98, 0x40, 0xA0, 0xE0, 0x70, 0x45,  // ...@..pE
            /* 0048 */  0xCB, 0x4D, 0xA7, 0x45, 0x4F, 0x4C, 0x00, 0x00,  // .M.EOL..
            /* 0050 */  0x28, 0x20, 0x2F, 0x32, 0x84, 0x0F, 0x01, 0x49,  // ( /2...I
            /* 0058 */  0x98, 0x8E, 0x01, 0x51, 0x76, 0x04, 0x9E, 0x2D,  // ...Qv..-
            /* 0060 */  0x50, 0x57, 0x00, 0x00, 0xB6, 0x63, 0x4E, 0xDF,  // PW...cN.
            /* 0068 */  0xBC, 0x3B, 0x58, 0x48, 0x97, 0x37, 0xC7, 0x4F,  // .;XH.7.O
            /* 0070 */  0x82, 0xF8, 0x21, 0xF3, 0x42, 0x55, 0x00, 0x00,  // ..!.BU..
            /* 0078 */  0x2D, 0x7C, 0x22, 0x41, 0xE1, 0x80, 0x3F, 0x42,  // -|"A..?B
            /* 0080 */  0x8B, 0x8E, 0x87, 0xE3, 0x27, 0x55, 0xA0, 0xEB,  // ....'U..
            /* 0088 */  0x50, 0x45, 0x02, 0x00, 0x36, 0x64, 0x1F, 0x8F,  // PE..6d..
            /* 0090 */  0x42, 0x9F, 0xC8, 0x42, 0xBA, 0xDC, 0x0E, 0x94,  // B..B....
            /* 0098 */  0x24, 0xF2, 0x0C, 0x9A, 0x53, 0x53, 0x00, 0x00,  // $...SS..
            /* 00A0 */  0xEB, 0x91, 0x4C, 0x1F, 0x5C, 0xDC, 0x0B, 0x46,  // ..L.\..F
            /* 00A8 */  0x95, 0x1D, 0xC7, 0xCB, 0x9B, 0x4B, 0x8D, 0x5E,  // .....K.^
            /* 00B0 */  0x42, 0x53, 0x01, 0x02, 0x61, 0xA6, 0x91, 0x73,  // BS..a..s
            /* 00B8 */  0x3A, 0x22, 0xDB, 0x47, 0xA7, 0x7A, 0x7B, 0xE8,  // :".G.z{.
            /* 00C0 */  0x4C, 0x60, 0x82, 0x2D, 0x55, 0x49, 0x01, 0x02,  // L`.-UI..
            /* 00C8 */  0x18, 0x43, 0x81, 0x2B, 0xE8, 0x4B, 0x07, 0x47,  // .C.+.K.G
            /* 00D0 */  0x9D, 0x84, 0xA1, 0x90, 0xA8, 0x59, 0xB5, 0xD0,  // .....Y..
            /* 00D8 */  0x80, 0x00, 0x01, 0x08, 0x21, 0x12, 0x90, 0x05,  // ....!...
            /* 00E0 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f.......
            /* 00E8 */  0xC9, 0x06, 0x29, 0x10, 0x5A, 0x5A, 0x01, 0x00   // ..).ZZ..
        })
        Name (WDUN, Ones)
        Method (_WDG, 0, Serialized)
        {
            If (WDUN)
            {
                Acquire (PUMX, 0xFFFF)
                WDUN = Zero
                GSWS (0x04F3)
                UWIC (Zero, STIC)
                UWIC (One, INIC)
                UWIC (0x02, ENIC)
                UWIC (0x03, OLIC)
                If ((PWIC == Zero))
                {
                    Local0 = One
                }
                Else
                {
                    Local0 = PWIC /* \PWIC */
                }

                UWIC (0x04, Local0)
                UWIC (0x05, BUIC)
                UWIC (0x06, SizeOf (CBWE))
                UWIC (0x07, WSSC)
                Release (PUMX)
            }

            Return (WDG) /* \_SB_.WMIB.WDG_ */
        }

        Method (UWIC, 2, Serialized)
        {
            Local0 = (Arg0 * 0x14)
            Local0 += 0x12
            WDG [Local0] = Arg1
        }

        Name (WQZZ, Buffer (0x1CF5)
        {
            /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
            /* 0008 */  0xE5, 0x1C, 0x00, 0x00, 0x18, 0x96, 0x00, 0x00,  // ........
            /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
            /* 0018 */  0x28, 0xB9, 0x86, 0x00, 0x01, 0x06, 0x18, 0x42,  // (......B
            /* 0020 */  0x10, 0x3D, 0x10, 0x92, 0x64, 0x82, 0x42, 0x04,  // .=..d.B.
            /* 0028 */  0x12, 0x01, 0x61, 0x18, 0x14, 0x01, 0x01, 0x92,  // ..a.....
            /* 0030 */  0x0B, 0x0E, 0x45, 0x82, 0x42, 0xF5, 0x27, 0x90,  // ..E.B.'.
            /* 0038 */  0x1C, 0x10, 0x99, 0x14, 0xA0, 0x5B, 0x80, 0x73,  // .....[.s
            /* 0040 */  0x01, 0xD2, 0x05, 0x18, 0x06, 0x91, 0x63, 0x01,  // ......c.
            /* 0048 */  0x96, 0x05, 0xE8, 0x44, 0x91, 0x6D, 0x10, 0x11,  // ...D.m..
            /* 0050 */  0x18, 0x2B, 0x41, 0x07, 0x10, 0x02, 0xF5, 0x00,  // .+A.....
            /* 0058 */  0x3C, 0x0A, 0xEE, 0x1A, 0x50, 0xE6, 0x47, 0x40,  // <...P.G@
            /* 0060 */  0x20, 0x0A, 0x82, 0x43, 0xC9, 0x80, 0x90, 0x72,  //  ..C...r
            /* 0068 */  0x38, 0x4D, 0xA0, 0xE4, 0x91, 0x50, 0x88, 0xC2,  // 8M...P..
            /* 0070 */  0x46, 0x83, 0x12, 0x02, 0x21, 0x87, 0x93, 0x91,  // F...!...
            /* 0078 */  0x4D, 0x01, 0x52, 0x05, 0x98, 0x15, 0x20, 0x54,  // M.R... T
            /* 0080 */  0x80, 0x45, 0x20, 0x8D, 0xC7, 0xD0, 0x4D, 0xCF,  // .E ...M.
            /* 0088 */  0x47, 0x9E, 0x21, 0x89, 0xFC, 0x41, 0xA0, 0x46,  // G.!..A.F
            /* 0090 */  0x66, 0x68, 0x1B, 0x9C, 0x96, 0x30, 0x43, 0xD6,  // fh...0C.
            /* 0098 */  0x3E, 0x2C, 0x2A, 0x16, 0x42, 0x0A, 0x20, 0x34,  // >,*.B. 4
            /* 00A0 */  0x1E, 0xF0, 0x2B, 0x14, 0xE0, 0x1B, 0x41, 0xB2,  // ..+...A.
            /* 00A8 */  0xB1, 0xC9, 0x80, 0x12, 0x0C, 0x34, 0x70, 0xF4,  // .....4p.
            /* 00B0 */  0x28, 0x3C, 0x68, 0x5C, 0x80, 0x41, 0x53, 0x51,  // (<h\.ASQ
            /* 00B8 */  0x20, 0x94, 0xC0, 0x52, 0x20, 0xE4, 0x15, 0x51,  //  ..R ..Q
            /* 00C0 */  0xF3, 0x2A, 0x11, 0x55, 0x47, 0x00, 0x8F, 0x24,  // .*.UG..$
            /* 00C8 */  0xCA, 0x63, 0x01, 0x1B, 0x37, 0xF0, 0x59, 0x85,  // .c..7.Y.
            /* 00D0 */  0x81, 0xFD, 0xFF, 0x1F, 0x18, 0x17, 0x03, 0xA2,  // ........
            /* 00D8 */  0xB1, 0x1C, 0x45, 0xD0, 0x03, 0x0F, 0x6A, 0xE1,  // ..E...j.
            /* 00E0 */  0x33, 0x27, 0x93, 0x3C, 0x46, 0x47, 0x85, 0x90,  // 3'.<FG..
            /* 00E8 */  0x04, 0x08, 0xCD, 0x21, 0x34, 0x46, 0x12, 0x84,  // ...!4F..
            /* 00F0 */  0x9C, 0x8E, 0x02, 0x05, 0x17, 0x3E, 0xCC, 0xF1,  // .....>..
            /* 00F8 */  0x19, 0xE7, 0xF8, 0x0C, 0xCF, 0x47, 0xDB, 0xFA,  // .....G..
            /* 0100 */  0xAC, 0x85, 0x10, 0x10, 0x8F, 0x73, 0x7C, 0x6C,  // .....s|l
            /* 0108 */  0xC0, 0xE0, 0x38, 0x18, 0x00, 0x87, 0x01, 0xE3,  // ..8.....
            /* 0110 */  0x13, 0x0D, 0x58, 0x4E, 0x06, 0x8C, 0x1A, 0x8F,  // ..XN....
            /* 0118 */  0xA1, 0x4F, 0x8B, 0x21, 0x1E, 0x5F, 0xD8, 0xB7,  // .O.!._..
            /* 0120 */  0x0A, 0x13, 0x54, 0x0F, 0x2A, 0x0B, 0x43, 0x03,  // ..T.*.C.
            /* 0128 */  0x0D, 0xA0, 0x87, 0x06, 0x5F, 0xE4, 0xD0, 0x4C,  // ...._..L
            /* 0130 */  0xE9, 0x21, 0x50, 0xAD, 0x78, 0x9A, 0xF7, 0x91,  // .!P.x...
            /* 0138 */  0xC7, 0x3C, 0xB7, 0x28, 0x6F, 0x03, 0xCF, 0x01,  // .<.(o...
            /* 0140 */  0xFC, 0xB4, 0xE0, 0xE1, 0xF8, 0x58, 0xE0, 0x71,  // .....X.q
            /* 0148 */  0xDA, 0x18, 0x84, 0x94, 0x41, 0xC8, 0x19, 0x84,  // ....A...
            /* 0150 */  0xA4, 0x41, 0x28, 0xD9, 0x10, 0x50, 0x83, 0xF5,  // .A(..P..
            /* 0158 */  0x10, 0x30, 0x53, 0x4D, 0xE0, 0x24, 0x23, 0x40,  // .0SM.$#@
            /* 0160 */  0x65, 0x80, 0x90, 0xD5, 0xE9, 0xEA, 0x2C, 0x12,  // e.....,.
            /* 0168 */  0xE2, 0x34, 0x7B, 0x3F, 0x16, 0x90, 0xB1, 0x3E,  // .4{?...>
            /* 0170 */  0x18, 0x58, 0xB3, 0x80, 0xFF, 0xFF, 0x08, 0xCF,  // .X......
            /* 0178 */  0x35, 0xF6, 0x99, 0x3D, 0x1D, 0x60, 0x56, 0x11,  // 5..=.`V.
            /* 0180 */  0xAE, 0xE8, 0x1B, 0x06, 0x41, 0x7B, 0xB6, 0xF0,  // ....A{..
            /* 0188 */  0x35, 0x23, 0x60, 0xB8, 0x08, 0xE1, 0xD8, 0x1D,  // 5#`.....
            /* 0190 */  0xE0, 0x24, 0x3D, 0x92, 0x08, 0x2F, 0x08, 0xEC,  // .$=../..
            /* 0198 */  0xC4, 0x10, 0xE4, 0x6D, 0xC5, 0x93, 0x37, 0xAC,  // ...m..7.
            /* 01A0 */  0xA7, 0xDC, 0x27, 0x94, 0x40, 0x83, 0x19, 0xDB,  // ..'.@...
            /* 01A8 */  0x97, 0x01, 0x36, 0x2A, 0x5F, 0x0C, 0xE0, 0xCF,  // ..6*_...
            /* 01B0 */  0x24, 0xAC, 0x91, 0x4F, 0xF4, 0x50, 0x4D, 0x30,  // $..O.PM0
            /* 01B8 */  0xF9, 0xC5, 0x00, 0xCA, 0x2C, 0x7C, 0x3D, 0xF1,  // ....,|=.
            /* 01C0 */  0x15, 0xC1, 0xA8, 0x2F, 0x06, 0x2C, 0xE5, 0xC5,  // .../.,..
            /* 01C8 */  0x00, 0x54, 0x37, 0x0C, 0x5F, 0x0C, 0xE0, 0xCB,  // .T7._...
            /* 01D0 */  0xBD, 0x18, 0x80, 0x42, 0xDC, 0x3D, 0x80, 0x7A,  // ...B.=.z
            /* 01D8 */  0x80, 0x90, 0xAC, 0x71, 0x52, 0x6B, 0x37, 0x03,  // ...qRk7.
            /* 01E0 */  0x72, 0x36, 0x60, 0x30, 0x9E, 0x61, 0x18, 0x63,  // r6`0.a.c
            /* 01E8 */  0x84, 0xF1, 0x28, 0xC3, 0x98, 0x60, 0xEE, 0xDB,  // ..(..`..
            /* 01F0 */  0x01, 0xF4, 0x9C, 0xC3, 0x40, 0x25, 0xBC, 0x1D,  // ....@%..
            /* 01F8 */  0x40, 0x39, 0x07, 0x74, 0x79, 0x34, 0xA1, 0xA7,  // @9.ty4..
            /* 0200 */  0x80, 0xA7, 0x03, 0xCF, 0xEE, 0x8D, 0xC0, 0xBE,  // ........
            /* 0208 */  0xC6, 0x2A, 0x98, 0x40, 0x11, 0x1F, 0x34, 0xF8,  // .*.@..4.
            /* 0210 */  0xD4, 0xA2, 0xF8, 0x54, 0xE0, 0xB5, 0xD4, 0x08,  // ...T....
            /* 0218 */  0x27, 0x9C, 0x33, 0xF1, 0x54, 0x0D, 0x67, 0xA0,  // '.3.T.g.
            /* 0220 */  0xAA, 0xE1, 0x10, 0xFF, 0x7F, 0x38, 0xEC, 0xA9,  // .....8..
            /* 0228 */  0xE0, 0x35, 0x80, 0x41, 0xBC, 0xB1, 0x9C, 0x96,  // .5.A....
            /* 0230 */  0x11, 0x61, 0x1C, 0x52, 0x1E, 0x19, 0x6C, 0x0B,  // .a.R..l.
            /* 0238 */  0x87, 0x40, 0x86, 0x79, 0x27, 0x60, 0x90, 0x15,  // .@.y'`..
            /* 0240 */  0x9F, 0x77, 0x08, 0xF0, 0x2B, 0x42, 0x9C, 0x08,  // .w..+B..
            /* 0248 */  0xEF, 0x0C, 0xEC, 0xB2, 0x00, 0xBE, 0x48, 0x97,  // ......H.
            /* 0250 */  0x05, 0x34, 0xB4, 0x4F, 0x32, 0xBE, 0x20, 0x18,  // .4.O2. .
            /* 0258 */  0xF6, 0xC4, 0x59, 0x80, 0xBB, 0x02, 0xA8, 0x40,  // ..Y....@
            /* 0260 */  0x7D, 0x57, 0x80, 0x7F, 0x21, 0x78, 0x57, 0x00,  // }W..!xW.
            /* 0268 */  0xC3, 0xBC, 0x7C, 0x2B, 0xE0, 0x9A, 0x0E, 0x25,  // ..|+...%
            /* 0270 */  0xE8, 0x33, 0x89, 0xAF, 0x0B, 0xB8, 0x29, 0xB2,  // .3....).
            /* 0278 */  0x54, 0x47, 0x05, 0xE8, 0x29, 0x26, 0x81, 0xD2,  // TG..)&..
            /* 0280 */  0x7F, 0x54, 0x80, 0x34, 0xC3, 0x27, 0x92, 0xD7,  // .T.4.'..
            /* 0288 */  0x00, 0x9F, 0x16, 0xF8, 0x59, 0x88, 0x5D, 0x47,  // ....Y.]G
            /* 0290 */  0x70, 0x57, 0x12, 0x86, 0xF2, 0x6C, 0xE0, 0x4B,  // pW...l.K
            /* 0298 */  0x16, 0x3F, 0x1C, 0xC0, 0x00, 0xF7, 0x2C, 0x0E,  // .?....,.
            /* 02A0 */  0x31, 0x42, 0x6C, 0x76, 0xE0, 0x7A, 0x35, 0x78,  // 1Blv.z5x
            /* 02A8 */  0x2F, 0xF0, 0x85, 0x88, 0xFF, 0xFF, 0x4F, 0x06,  // /.....O.
            /* 02B0 */  0xE0, 0x13, 0x08, 0x8C, 0x3E, 0x1A, 0xD8, 0xAF,  // ....>...
            /* 02B8 */  0x00, 0x84, 0xE0, 0x65, 0x8E, 0x43, 0x73, 0x89,  // ...e.Cs.
            /* 02C0 */  0xF0, 0xA4, 0x63, 0xF8, 0x48, 0xCF, 0x2C, 0x7C,  // ..c.H.,|
            /* 02C8 */  0x06, 0xA7, 0xE5, 0x11, 0x98, 0xC0, 0x07, 0x1E,  // ........
            /* 02D0 */  0x32, 0x00, 0x7A, 0xCE, 0xF1, 0x00, 0xF8, 0x31,  // 2.z....1
            /* 02D8 */  0x22, 0xFE, 0xE1, 0x84, 0x0D, 0x1C, 0x3E, 0xCA,  // ".....>.
            /* 02E0 */  0x39, 0x1C, 0x8F, 0xAF, 0x24, 0x11, 0xEA, 0x82,  // 9...$...
            /* 02E8 */  0xD0, 0x21, 0xC2, 0x08, 0x07, 0x10, 0xE5, 0xBC,  // .!......
            /* 02F0 */  0xDF, 0x14, 0x4C, 0xE0, 0xE3, 0x80, 0x0F, 0x0C,  // ..L.....
            /* 02F8 */  0xFC, 0x14, 0xE7, 0x21, 0xC1, 0x98, 0x72, 0x14,  // ...!..r.
            /* 0300 */  0x7B, 0x9C, 0x14, 0x19, 0x1E, 0x3B, 0x35, 0x78,  // {....;5x
            /* 0308 */  0x3C, 0x1C, 0x1A, 0x87, 0xF8, 0x40, 0x70, 0xAE,  // <....@p.
            /* 0310 */  0x56, 0x3A, 0x43, 0xE4, 0x29, 0xC2, 0x93, 0x3A,  // V:C.)..:
            /* 0318 */  0xC2, 0x03, 0xC4, 0x0E, 0x80, 0xCB, 0x7B, 0x55,  // ......{U
            /* 0320 */  0x19, 0xC8, 0x3F, 0x04, 0x09, 0x82, 0x41, 0x5D,  // ..?...A]
            /* 0328 */  0x64, 0x7C, 0xD2, 0xC3, 0x0F, 0x81, 0x1D, 0x26,  // d|.....&
            /* 0330 */  0xD8, 0x39, 0xC9, 0x70, 0xFC, 0x00, 0xE0, 0x51,  // .9.p...Q
            /* 0338 */  0xBD, 0xE1, 0xBC, 0x74, 0x79, 0x98, 0x3E, 0x22,  // ...ty.>"
            /* 0340 */  0x84, 0x64, 0x47, 0x31, 0xDC, 0xA9, 0xC2, 0x57,  // .dG1...W
            /* 0348 */  0x05, 0x5F, 0x45, 0x8C, 0xF8, 0xB0, 0xE2, 0x53,  // ._E....S
            /* 0350 */  0x83, 0xA1, 0x60, 0x1C, 0x06, 0x30, 0x37, 0x42,  // ..`..07B
            /* 0358 */  0xDF, 0x13, 0x0C, 0xF5, 0x9E, 0x74, 0x18, 0x8F,  // .....t..
            /* 0360 */  0x84, 0x26, 0xF0, 0xA5, 0xE1, 0x28, 0x30, 0x47,  // .&...(0G
            /* 0368 */  0x0E, 0xDF, 0x96, 0x0C, 0xEF, 0xFF, 0x3F, 0x81,  // ......?.
            /* 0370 */  0xDD, 0x9F, 0x13, 0x84, 0xFF, 0x94, 0xF3, 0x7E,  // .......~
            /* 0378 */  0xF1, 0x16, 0xF0, 0xA8, 0x10, 0x23, 0xCA, 0x83,  // .....#..
            /* 0380 */  0x4A, 0x94, 0x48, 0xA7, 0x1B, 0x85, 0x79, 0xBB,  // J.H...y.
            /* 0388 */  0x39, 0x08, 0x22, 0x4A, 0x73, 0x73, 0x13, 0x52,  // 9."Jss.R
            /* 0390 */  0xA0, 0x28, 0x47, 0x1E, 0x33, 0x4E, 0xAC, 0x20,  // .(G.3N.
            /* 0398 */  0x81, 0xDE, 0x37, 0xA2, 0x84, 0x8D, 0x11, 0x2E,  // ..7.....
            /* 03A0 */  0x50, 0xFB, 0xC7, 0x04, 0x36, 0x64, 0x7A, 0x56,  // P...6dzV
            /* 03A8 */  0xC0, 0x9D, 0x1D, 0xE0, 0x4E, 0x8F, 0x9F, 0x1E,  // ....N...
            /* 03B0 */  0x00, 0x27, 0x40, 0x4F, 0x0F, 0x60, 0x3B, 0x6F,  // .'@O.`;o
            /* 03B8 */  0xC0, 0x3D, 0x10, 0x20, 0xBE, 0x2B, 0x06, 0xA2,  // .=. .+..
            /* 03C0 */  0xC1, 0xAF, 0x2C, 0x14, 0x8E, 0x87, 0xBE, 0x59,  // ..,....Y
            /* 03C8 */  0xD1, 0x63, 0x09, 0xEE, 0x70, 0xE0, 0x23, 0x83,  // .c..p.#.
            /* 03D0 */  0x0F, 0x90, 0xB8, 0xA1, 0xF8, 0x50, 0x81, 0x3C,  // .....P.<
            /* 03D8 */  0x0B, 0x80, 0x62, 0xF4, 0x6C, 0x04, 0xEC, 0x06,  // ..b.l...
            /* 03E0 */  0xF3, 0xD2, 0xF2, 0xDE, 0xE0, 0xFF, 0xFF, 0x1C,  // ........
            /* 03E8 */  0x7C, 0x4A, 0xC1, 0x1D, 0x04, 0xC0, 0x77, 0x0C,  // |J....w.
            /* 03F0 */  0x00, 0xEF, 0x60, 0xB8, 0xAC, 0x31, 0xA3, 0x84,  // ..`..1..
            /* 03F8 */  0xC0, 0x68, 0xCC, 0xB8, 0x43, 0x08, 0x3F, 0x11,  // .h..C.?.
            /* 0400 */  0xE0, 0xC6, 0xEC, 0x71, 0x7B, 0xCC, 0xB8, 0xE3,  // ...q{...
            /* 0408 */  0x2C, 0x1F, 0xD5, 0x53, 0x46, 0x28, 0x1F, 0x38,  // ,..SF(.8
            /* 0410 */  0xD8, 0x39, 0xE3, 0x8D, 0x80, 0x0F, 0x1D, 0x78,  // .9.....x
            /* 0418 */  0x1C, 0x60, 0x70, 0x47, 0x0A, 0x30, 0x5E, 0x0E,  // .`pG.0^.
            /* 0420 */  0xD8, 0xD8, 0xC1, 0x1D, 0x84, 0x9C, 0x02, 0x59,  // .......Y
            /* 0428 */  0x3A, 0x8C, 0xC6, 0x8E, 0x93, 0x0D, 0xA4, 0x63,  // :......c
            /* 0430 */  0x8C, 0x0F, 0xB9, 0x1E, 0x3B, 0x6E, 0xB0, 0x1E,  // ....;n..
            /* 0438 */  0x3B, 0xEE, 0xF8, 0x82, 0xFF, 0xFF, 0x1F, 0x5F,  // ;......_
            /* 0440 */  0xE0, 0x8F, 0x81, 0x8B, 0x1F, 0x06, 0xFA, 0xE6,  // ........
            /* 0448 */  0xE7, 0xD1, 0x19, 0xDC, 0xC3, 0xF6, 0x09, 0x26,  // .......&
            /* 0450 */  0xC6, 0x1B, 0x4C, 0x88, 0x47, 0x96, 0x97, 0x96,  // ..L.G...
            /* 0458 */  0x08, 0x0F, 0x2D, 0xBE, 0xB9, 0xBC, 0xB4, 0xF8,  // ..-.....
            /* 0460 */  0x16, 0x63, 0x94, 0x10, 0x11, 0x0E, 0x26, 0xCE,  // .c....&.
            /* 0468 */  0x13, 0x8C, 0x11, 0x0E, 0x3C, 0x8A, 0x21, 0x22,  // ....<.!"
            /* 0470 */  0x9C, 0x40, 0x88, 0x93, 0x3E, 0xD9, 0x20, 0xE1,  // .@..>. .
            /* 0478 */  0x63, 0x84, 0x8D, 0x16, 0xE5, 0x09, 0x86, 0x8D,  // c.......
            /* 0480 */  0x85, 0x9F, 0x57, 0x3C, 0x78, 0x7E, 0x5A, 0xF3,  // ..W<x~Z.
            /* 0488 */  0x5D, 0xD0, 0x93, 0x39, 0xC7, 0x87, 0x2C, 0x4F,  // ]..9..,O
            /* 0490 */  0xED, 0x71, 0xD2, 0x87, 0x59, 0xDC, 0xA0, 0x1E,  // .q..Y...
            /* 0498 */  0x1C, 0xD9, 0x5D, 0xC7, 0xC7, 0x6B, 0xEC, 0x29,  // ..]..k.)
            /* 04A0 */  0xC8, 0x43, 0xE0, 0x27, 0x02, 0x5F, 0x10, 0x3D,  // .C.'._.=
            /* 04A8 */  0x59, 0xDF, 0xF5, 0xD8, 0xBD, 0xCC, 0x18, 0xD5,  // Y.......
            /* 04B0 */  0x4F, 0x01, 0x75, 0x4C, 0x39, 0x83, 0x57, 0x08,  // O.uL9.W.
            /* 04B8 */  0x76, 0xCF, 0xF3, 0x21, 0xDB, 0x77, 0x49, 0x36,  // v..!.wI6
            /* 04C0 */  0x0A, 0xDC, 0x21, 0xC1, 0x67, 0x24, 0x7E, 0xAA,  // ..!.g$~.
            /* 04C8 */  0xF0, 0x30, 0x3C, 0x0A, 0x18, 0x33, 0x78, 0x47,  // .0<..3xG
            /* 04D0 */  0x38, 0xB4, 0x10, 0x07, 0xFC, 0xBE, 0xCB, 0x86,  // 8.......
            /* 04D8 */  0x1A, 0xE3, 0xF4, 0x7C, 0xFE, 0x60, 0x83, 0x80,  // ...|.`..
            /* 04E0 */  0x0F, 0x75, 0xA8, 0x1E, 0xE6, 0x51, 0xBD, 0x14,  // .u...Q..
            /* 04E8 */  0x32, 0x9C, 0xB3, 0x83, 0x3B, 0x08, 0xEC, 0xF1,  // 2...;...
            /* 04F0 */  0xC3, 0x83, 0xE0, 0x37, 0x4B, 0x3E, 0x08, 0x76,  // ...7K>.v
            /* 04F8 */  0xBE, 0x79, 0x83, 0x33, 0xC8, 0x31, 0xFC, 0xFF,  // .y.3.1..
            /* 0500 */  0x8F, 0x01, 0xEE, 0x99, 0xCA, 0x47, 0x13, 0xC4,  // .....G..
            /* 0508 */  0x11, 0x10, 0x7D, 0xFE, 0xF0, 0x18, 0xDE, 0xE4,  // ..}.....
            /* 0510 */  0xF8, 0x70, 0xB0, 0x47, 0x0F, 0xDC, 0x49, 0x04,  // .p.G..I.
            /* 0518 */  0xEE, 0xB1, 0xEB, 0xA0, 0x7D, 0x8D, 0xF3, 0x45,  // ....}..E
            /* 0520 */  0x0B, 0xC6, 0x7D, 0xEF, 0x59, 0x04, 0xFC, 0x18,  // ..}.Y...
            /* 0528 */  0x8F, 0x2D, 0xE0, 0x38, 0x94, 0x80, 0x3B, 0xD8,  // .-.8..;.
            /* 0530 */  0x71, 0x8D, 0x43, 0x28, 0x0A, 0x8C, 0x0E, 0x25,  // q.C(...%
            /* 0538 */  0xB8, 0x18, 0x40, 0x82, 0x71, 0x8C, 0x33, 0x1A,  // ..@.q.3.
            /* 0540 */  0xFA, 0x12, 0xE9, 0x43, 0x1A, 0x9C, 0x41, 0xC3,  // ...C..A.
            /* 0548 */  0x9E, 0xE7, 0x13, 0x0A, 0xB7, 0x27, 0x40, 0xD1,  // .....'@.
            /* 0550 */  0x09, 0x05, 0x64, 0xB8, 0xCF, 0x20, 0xD8, 0x13,  // ..d.. ..
            /* 0558 */  0x02, 0x3F, 0x83, 0xF0, 0xFF, 0x3F, 0xF4, 0x71,  // .?...?.q
            /* 0560 */  0xBF, 0x37, 0xFA, 0xD4, 0xC8, 0xE6, 0xFE, 0x10,  // .7......
            /* 0568 */  0x70, 0x02, 0xE7, 0xCE, 0x4E, 0xCD, 0xB8, 0x33,  // p...N..3
            /* 0570 */  0x03, 0xF6, 0xFC, 0xE1, 0x21, 0xF0, 0x73, 0x81,  // ....!.s.
            /* 0578 */  0x87, 0xEF, 0x21, 0xE0, 0x07, 0xFF, 0xC0, 0x6C,  // ..!....l
            /* 0580 */  0x70, 0x30, 0x9E, 0x22, 0x7C, 0xED, 0xE0, 0xE0,  // p0."|...
            /* 0588 */  0xFC, 0x34, 0x60, 0x70, 0xFE, 0x0A, 0xF5, 0x79,  // .4`p...y
            /* 0590 */  0x9E, 0x81, 0x63, 0x4F, 0xBD, 0xBE, 0x77, 0x78,  // ..cO..wx
            /* 0598 */  0xBE, 0x3E, 0x54, 0xE0, 0x6F, 0x7A, 0x3E, 0x54,  // .>T.oz>T
            /* 05A0 */  0x80, 0xE3, 0xF0, 0xC0, 0x0F, 0x2B, 0x6C, 0x08,  // .....+l.
            /* 05A8 */  0x8F, 0x02, 0xF8, 0x53, 0x8B, 0x8F, 0x7F, 0x71,  // ...S...q
            /* 05B0 */  0x9E, 0x22, 0xD8, 0x6D, 0x04, 0x7B, 0xB8, 0x00,  // .".m.{..
            /* 05B8 */  0x1C, 0x45, 0x3B, 0x8B, 0xA1, 0xC2, 0x9C, 0xC5,  // .E;.....
            /* 05C0 */  0xE8, 0xFF, 0xFF, 0x1C, 0x85, 0x38, 0x8B, 0xD1,  // .....8..
            /* 05C8 */  0xC3, 0x05, 0xE0, 0x42, 0xF0, 0xF1, 0x00, 0x34,  // ...B...4
            /* 05D0 */  0x07, 0x81, 0xC7, 0x05, 0x5F, 0x08, 0x8E, 0xE4,  // ...._...
            /* 05D8 */  0x40, 0x9E, 0x0E, 0x00, 0x9F, 0xF2, 0x48, 0xE8,  // @.....H.
            /* 05E0 */  0xF9, 0xC8, 0x82, 0x60, 0x50, 0xE7, 0x03, 0x9F,  // ...`P...
            /* 05E8 */  0x50, 0x7C, 0xEC, 0xE0, 0x67, 0x03, 0xDF, 0xC8,  // P|..g...
            /* 05F0 */  0x3D, 0x54, 0x7E, 0x6A, 0xF6, 0x49, 0x9B, 0x07,  // =T~j.I..
            /* 05F8 */  0xFF, 0x49, 0xCB, 0x06, 0x8C, 0x02, 0x0D, 0x03,  // .I......
            /* 0600 */  0x35, 0x22, 0x1F, 0x91, 0xFC, 0xFF, 0x3F, 0xB7,  // 5"....?.
            /* 0608 */  0xE1, 0x02, 0x0C, 0x8D, 0x9E, 0xC3, 0x61, 0x1C,  // ......a.
            /* 0610 */  0x70, 0x7D, 0x0E, 0xC7, 0x0E, 0xC8, 0xE7, 0x70,  // p}.....p
            /* 0618 */  0xF8, 0xE7, 0x68, 0xF8, 0x63, 0x63, 0xA7, 0x7B,  // ..h.cc.{
            /* 0620 */  0x3E, 0x30, 0x58, 0xD7, 0x6F, 0xCC, 0xC0, 0xC0,  // >0X.o...
            /* 0628 */  0xF6, 0x2D, 0xF2, 0xC0, 0x80, 0x23, 0xEA, 0xD9,  // .-...#..
            /* 0630 */  0xF8, 0x0A, 0xE1, 0x81, 0x81, 0x0D, 0xD0, 0x03,  // ........
            /* 0638 */  0x03, 0x3E, 0xB1, 0x20, 0xE4, 0x64, 0x60, 0xA8,  // .>. .d`.
            /* 0640 */  0x53, 0x86, 0x91, 0x63, 0x3E, 0x71, 0x78, 0x18,  // S..c>qx.
            /* 0648 */  0x3E, 0x54, 0x44, 0x7D, 0x06, 0x78, 0xC4, 0x63,  // >TD}.x.c
            /* 0650 */  0x63, 0xE3, 0xFF, 0xFF, 0xB1, 0x81, 0xE3, 0xD8,  // c.......
            /* 0658 */  0xE2, 0xB1, 0x81, 0xFF, 0x08, 0x8F, 0x1F, 0x1B,  // ........
            /* 0660 */  0x9C, 0xB1, 0x3C, 0x9A, 0xF8, 0x32, 0x73, 0x64,  // ..<..2sd
            /* 0668 */  0xA7, 0x71, 0x66, 0xAF, 0x21, 0x3E, 0xDA, 0x3D,  // .qf.!>.=
            /* 0670 */  0x7E, 0x7B, 0x6C, 0xE0, 0xB2, 0x30, 0x36, 0xA0,  // ~{l..06.
            /* 0678 */  0x14, 0x72, 0x6C, 0xE8, 0x43, 0x8A, 0x4F, 0x01,  // .rl.C.O.
            /* 0680 */  0x36, 0x8E, 0x4A, 0xE6, 0xE1, 0xE3, 0x95, 0x4F,  // 6.J....O
            /* 0688 */  0x0C, 0x47, 0x17, 0xE4, 0x0D, 0xDD, 0x97, 0x0B,  // .G......
            /* 0690 */  0x1F, 0x69, 0x0C, 0xE6, 0x4B, 0x8B, 0xCF, 0xA0,  // .i..K...
            /* 0698 */  0x7C, 0x88, 0xE0, 0xD2, 0x30, 0x44, 0xA0, 0x14,  // |...0D..
            /* 06A0 */  0x6A, 0x88, 0xE8, 0xF1, 0xF8, 0xFF, 0x7F, 0x99,  // j.......
            /* 06A8 */  0x39, 0x44, 0x36, 0x34, 0xF0, 0x7E, 0x63, 0x34,  // 9D64.~c4
            /* 06B0 */  0x34, 0x20, 0x14, 0x6E, 0x68, 0xE8, 0xC3, 0x9A,  // 4 .nh...
            /* 06B8 */  0x0F, 0x01, 0x0C, 0xC2, 0xB7, 0x01, 0x76, 0x15,  // ......v.
            /* 06C0 */  0xF0, 0x55, 0xC8, 0x03, 0x7C, 0x12, 0x65, 0xC3,  // .U..|.e.
            /* 06C8 */  0x03, 0xDF, 0xA0, 0x3C, 0x3C, 0xE0, 0x13, 0x1E,  // ...<<...
            /* 06D0 */  0xD8, 0xAB, 0xF0, 0xF0, 0xE8, 0x59, 0xC9, 0xC3,  // .....Y..
            /* 06D8 */  0x83, 0x07, 0xF2, 0x18, 0xC1, 0xCE, 0x21, 0x1E,  // ......!.
            /* 06E0 */  0x1C, 0x38, 0x4C, 0x0C, 0x0E, 0x14, 0x47, 0x7F,  // .8L...G.
            /* 06E8 */  0xDC, 0x10, 0xD8, 0x65, 0xD6, 0x13, 0xE7, 0x57,  // ...e...W
            /* 06F0 */  0x16, 0x0F, 0x0A, 0xC6, 0xFF, 0xFF, 0x08, 0x00,  // ........
            /* 06F8 */  0xE7, 0x38, 0x03, 0xBE, 0x60, 0x87, 0x03, 0xF4,  // .8..`...
            /* 0700 */  0x31, 0x91, 0x8D, 0xE1, 0x21, 0xE2, 0xC1, 0xD5,  // 1...!...
            /* 0708 */  0x03, 0xF1, 0xB5, 0xE3, 0xB5, 0x18, 0x77, 0x34,  // ......w4
            /* 0710 */  0x00, 0x97, 0x8A, 0xA3, 0x01, 0x50, 0x3A, 0xD8,  // .....P:.
            /* 0718 */  0x82, 0xE3, 0x9E, 0xE6, 0xA3, 0x1D, 0x66, 0x8E,  // ......f.
            /* 0720 */  0x1E, 0xC0, 0xF3, 0x9B, 0x47, 0xCB, 0xCF, 0x6F,  // ....G..o
            /* 0728 */  0x80, 0xA3, 0xA0, 0x07, 0x5B, 0x3A, 0x70, 0x47,  // ....[:pG
            /* 0730 */  0x83, 0x41, 0x9D, 0xDF, 0x70, 0xFF, 0xFF, 0xF3,  // .A..p...
            /* 0738 */  0x1B, 0xFC, 0x08, 0xE0, 0x3A, 0xD3, 0xF8, 0xFC,  // ....:...
            /* 0740 */  0x02, 0x67, 0xA8, 0x07, 0xED, 0x6B, 0x82, 0x67,  // .g...k.g
            /* 0748 */  0xED, 0x1B, 0x17, 0x3B, 0x27, 0x80, 0x6B, 0x40,  // ...;'.k@
            /* 0750 */  0x3E, 0xE9, 0x00, 0x47, 0xE0, 0x93, 0x78, 0xC0,  // >..G..x.
            /* 0758 */  0x3F, 0x34, 0x30, 0x0F, 0xCB, 0x43, 0x03, 0x3E,  // ?40..C.>
            /* 0760 */  0x47, 0x03, 0xDC, 0x89, 0x02, 0x3C, 0xB7, 0x11,  // G....<..
            /* 0768 */  0xDC, 0x81, 0x02, 0x78, 0xFC, 0xFF, 0x0F, 0x14,  // ...x....
            /* 0770 */  0xC0, 0xE9, 0x88, 0xEF, 0x71, 0x71, 0x68, 0x1C,  // ....qqh.
            /* 0778 */  0xE2, 0x43, 0xDA, 0x39, 0xFB, 0xFC, 0x75, 0xA6,  // .C.9..u.
            /* 0780 */  0xB8, 0xB3, 0x08, 0x18, 0xC6, 0xC0, 0xE5, 0x2F,  // ......./
            /* 0788 */  0x89, 0x8A, 0x78, 0x60, 0x48, 0x30, 0x0C, 0xEA,  // ..x`H0..
            /* 0790 */  0x04, 0xE4, 0xA1, 0xF8, 0x60, 0xC0, 0x81, 0x7D,  // ....`..}
            /* 0798 */  0x44, 0x60, 0xE7, 0x02, 0x76, 0x80, 0x32, 0x1C,  // D`..v.2.
            /* 07A0 */  0x3F, 0x0B, 0xF8, 0x94, 0xF0, 0x50, 0x73, 0x1C,  // ?....Ps.
            /* 07A8 */  0x8F, 0x9B, 0xBE, 0x9B, 0x19, 0x92, 0x5D, 0x0D,  // ......].
            /* 07B0 */  0x9E, 0x7F, 0xB0, 0xA7, 0x5D, 0x38, 0x47, 0x5C,  // ....]8G\
            /* 07B8 */  0x70, 0x11, 0xF8, 0xAC, 0xE3, 0x51, 0xF0, 0xD3,  // p....Q..
            /* 07C0 */  0x83, 0xE7, 0xF8, 0xC6, 0xE0, 0xD3, 0x03, 0x73,  // .......s
            /* 07C8 */  0x2F, 0xC0, 0xDC, 0xA1, 0x5B, 0x08, 0xC7, 0xF4,  // /...[...
            /* 07D0 */  0xFA, 0x10, 0xE3, 0xA8, 0x1F, 0x1B, 0xDA, 0x12,  // ........
            /* 07D8 */  0xA0, 0x0D, 0x45, 0x77, 0x80, 0x97, 0x81, 0x28,  // ..Ew...(
            /* 07E0 */  0x21, 0x8E, 0x20, 0x52, 0x6B, 0x28, 0x9A, 0x79,  // !. Rk(.y
            /* 07E8 */  0xA4, 0x28, 0x01, 0xE3, 0x19, 0xA6, 0xB1, 0xC9,  // .(......
            /* 07F0 */  0x08, 0x32, 0x46, 0xE8, 0x38, 0xC1, 0xA2, 0x44,  // .2F.8..D
            /* 07F8 */  0x7B, 0x05, 0x68, 0x7F, 0x10, 0x44, 0xEC, 0xD1,  // {.h..D..
            /* 0800 */  0x84, 0x46, 0x3A, 0x59, 0xA2, 0x87, 0xED, 0x63,  // .F:Y...c
            /* 0808 */  0x36, 0xFE, 0xB4, 0x8A, 0xFB, 0xFF, 0x5F, 0x55,  // 6....._U
            /* 0810 */  0xFC, 0x05, 0xF0, 0x01, 0x00, 0xEF, 0x12, 0x50,  // .......P
            /* 0818 */  0x57, 0x47, 0x8F, 0xDB, 0xE7, 0x0D, 0xF0, 0x5F,  // WG....._
            /* 0820 */  0x2F, 0xB0, 0x47, 0x04, 0x0D, 0x02, 0x35, 0x32,  // /.G...52
            /* 0828 */  0x43, 0x7B, 0x9C, 0x6F, 0x33, 0x86, 0x7C, 0x72,  // C{.o3.|r
            /* 0830 */  0xF2, 0x20, 0xC9, 0x09, 0x15, 0x68, 0x0C, 0xFE,  // . ...h..
            /* 0838 */  0x69, 0xC3, 0xD7, 0x76, 0xCF, 0xD7, 0x27, 0x2F,  // i..v..'/
            /* 0840 */  0xEC, 0x71, 0x04, 0xEE, 0x35, 0x81, 0x1F, 0x48,  // .q..5..H
            /* 0848 */  0x00, 0x67, 0x40, 0x0F, 0x24, 0x60, 0xFA, 0xFF,  // .g@.$`..
            /* 0850 */  0x1F, 0x48, 0xE0, 0x0C, 0x15, 0x37, 0x04, 0x1E,  // .H...7..
            /* 0858 */  0x61, 0x45, 0xF4, 0x30, 0x60, 0xD1, 0x30, 0xA8,  // aE.0`.0.
            /* 0860 */  0x33, 0x14, 0xB8, 0xC4, 0x81, 0xEB, 0xF0, 0xE8,  // 3.......
            /* 0868 */  0xF3, 0x2A, 0x9C, 0x41, 0x9D, 0x76, 0xEF, 0x17,  // .*.A.v..
            /* 0870 */  0x10, 0x72, 0x39, 0xF0, 0xA0, 0xCF, 0xE7, 0x49,  // .r9....I
            /* 0878 */  0x81, 0x1D, 0xA2, 0x80, 0xFF, 0xD8, 0xE0, 0xDC,  // ........
            /* 0880 */  0x00, 0x9E, 0x6C, 0x23, 0x1C, 0x1B, 0xD8, 0x4F,  // ..l#...O
            /* 0888 */  0x51, 0xC0, 0xE9, 0xBC, 0x05, 0xE7, 0x5A, 0xC3,  // Q.....Z.
            /* 0890 */  0x6E, 0xE0, 0xB8, 0xA1, 0x61, 0xFF, 0xFF, 0x43,  // n...a..C
            /* 0898 */  0x83, 0x7F, 0x7C, 0xF7, 0x81, 0x10, 0x30, 0x70,  // ..|...0p
            /* 08A0 */  0x10, 0xE2, 0x97, 0x8A, 0x67, 0x22, 0x7E, 0xE0,  // ....g"~.
            /* 08A8 */  0x02, 0x9C, 0x9F, 0x48, 0xF8, 0x69, 0xCB, 0x27,  // ...H.i.'
            /* 08B0 */  0x12, 0x7E, 0xE0, 0x02, 0xFF, 0xFF, 0xFF, 0xC0,  // .~......
            /* 08B8 */  0x05, 0xCC, 0xEF, 0x57, 0xEF, 0x0C, 0x2F, 0x0D,  // ...W../.
            /* 08C0 */  0x9E, 0xD3, 0xFB, 0x96, 0x31, 0x5E, 0xB4, 0x8C,  // ....1^..
            /* 08C8 */  0x10, 0x85, 0xDD, 0x06, 0xA2, 0xD9, 0xDB, 0x81,  // ........
            /* 08D0 */  0x8B, 0x9C, 0xBA, 0x38, 0x66, 0xA4, 0xA7, 0xAF,  // ...8f...
            /* 08D8 */  0x60, 0x91, 0x22, 0x1E, 0x4E, 0x94, 0x10, 0xC1,  // `.".N...
            /* 08E0 */  0x5E, 0x27, 0x9E, 0xBC, 0x1E, 0xB8, 0x98, 0xE0,  // ^'......
            /* 08E8 */  0x03, 0x17, 0xD0, 0x71, 0x7D, 0xE0, 0x02, 0xB4,  // ...q}...
            /* 08F0 */  0x9E, 0x9B, 0x70, 0xC0, 0xFE, 0xFF, 0x1F, 0xB8,  // ..p.....
            /* 08F8 */  0xC0, 0x74, 0x22, 0x01, 0x5C, 0x8F, 0x15, 0xC6,  // .t".\...
            /* 0900 */  0x18, 0x78, 0x98, 0xE3, 0x08, 0x3F, 0x54, 0xE2,  // .x...?T.
            /* 0908 */  0xE0, 0xA8, 0xF4, 0x83, 0x16, 0x3D, 0x74, 0xFB,  // .....=t.
            /* 0910 */  0x44, 0x81, 0x9F, 0xCB, 0x33, 0xB7, 0xEF, 0x07,  // D...3...
            /* 0918 */  0x3E, 0x14, 0x81, 0xFD, 0xA4, 0x05, 0x1C, 0x0E,  // >.......
            /* 0920 */  0xE8, 0xB8, 0xFF, 0x3F, 0x81, 0x03, 0x1D, 0x9F,  // ...?....
            /* 0928 */  0xD0, 0xA3, 0xF0, 0xA1, 0x1D, 0x77, 0xCC, 0x02,  // .....w..
            /* 0930 */  0xFE, 0x91, 0x81, 0xBD, 0x0A, 0x0F, 0x8C, 0xB2,  // ........
            /* 0938 */  0x18, 0xF5, 0x0D, 0xE2, 0x10, 0xDF, 0xEF, 0x7D,  // .......}
            /* 0940 */  0x96, 0x7B, 0xCF, 0xF0, 0x25, 0x00, 0x73, 0xD3,  // .{..%.s.
            /* 0948 */  0xF7, 0x89, 0x80, 0x1D, 0x7B, 0x7C, 0xD2, 0x02,  // ....{|..
            /* 0950 */  0x4E, 0x43, 0x60, 0xF7, 0x1F, 0xCF, 0x9C, 0x0F,  // NC`.....
            /* 0958 */  0xE1, 0x6C, 0x3C, 0x7A, 0xDC, 0x89, 0x00, 0x7C,  // .l<z...|
            /* 0960 */  0xC7, 0x12, 0xF0, 0x9C, 0x2C, 0x30, 0x33, 0x08,  // ....,03.
            /* 0968 */  0xFF, 0xF4, 0xC1, 0x8E, 0x82, 0x3E, 0xBF, 0x78,  // .....>.x
            /* 0970 */  0xD2, 0x2F, 0x2A, 0x3E, 0x96, 0x80, 0xED, 0xFF,  // ./*>....
            /* 0978 */  0x7F, 0xEE, 0x02, 0x3C, 0x46, 0x39, 0x74, 0xA1,  // ...<F9t.
            /* 0980 */  0xC4, 0x9F, 0xBB, 0x00, 0x81, 0xB7, 0x2E, 0xDF,  // ........
            /* 0988 */  0x94, 0x23, 0xBC, 0x08, 0x9C, 0x41, 0x88, 0x67,  // .#...A.g
            /* 0990 */  0xAD, 0xF7, 0xAD, 0x48, 0xBE, 0x03, 0xC4, 0x79,  // ...H...y
            /* 0998 */  0xEE, 0x32, 0xD8, 0x6B, 0xC7, 0x83, 0x44, 0x94,  // .2.k..D.
            /* 09A0 */  0x67, 0x66, 0x43, 0x3D, 0x37, 0x1B, 0xEA, 0xE4,  // gfC=7...
            /* 09A8 */  0x9F, 0x99, 0x8D, 0x15, 0x36, 0xD0, 0xE3, 0xD7,  // ....6...
            /* 09B0 */  0x5B, 0x57, 0x48, 0x23, 0x3C, 0x77, 0x31, 0xE1,  // [WH#<w1.
            /* 09B8 */  0xE7, 0x2E, 0xA8, 0xFF, 0xFF, 0x73, 0x17, 0xC0,  // .....s..
            /* 09C0 */  0x85, 0xA3, 0x02, 0xEE, 0xDC, 0x05, 0xB6, 0x33,  // .......3
            /* 09C8 */  0x09, 0x60, 0xED, 0x08, 0xE0, 0xFF, 0xFF, 0x99,  // .`......
            /* 09D0 */  0x04, 0xCC, 0xA3, 0x85, 0x79, 0xF6, 0x40, 0x1C,  // ....y.@.
            /* 09D8 */  0xBC, 0x50, 0xE1, 0x1F, 0x07, 0x86, 0x43, 0x05,  // .P....C.
            /* 09E0 */  0x3F, 0x55, 0xD0, 0xF3, 0x14, 0x70, 0x39, 0x30,  // ?U...p90
            /* 09E8 */  0x03, 0x27, 0x21, 0x27, 0x18, 0x9D, 0xA7, 0x70,  // .'!'...p
            /* 09F0 */  0xE3, 0x31, 0xE8, 0xD3, 0x83, 0xAF, 0x04, 0xFC,  // .1......
            /* 09F8 */  0x30, 0xC5, 0x42, 0x43, 0xC8, 0xC2, 0xC9, 0x0B,  // 0.BC....
            /* 0A00 */  0x68, 0x1D, 0xA6, 0xC0, 0x71, 0x65, 0x09, 0x8C,  // h...qe..
            /* 0A08 */  0xBD, 0x1D, 0xBC, 0xCB, 0x79, 0x12, 0x8F, 0x26,  // ....y..&
            /* 0A10 */  0xC7, 0x19, 0xE2, 0xDD, 0xDA, 0x04, 0x0F, 0x06,  // ........
            /* 0A18 */  0x91, 0xDE, 0x6B, 0xD8, 0x00, 0xA3, 0xBF, 0x44,  // ..k....D
            /* 0A20 */  0x98, 0xE0, 0xFF, 0xFF, 0x68, 0x05, 0x0C, 0x21,  // ....h..!
            /* 0A28 */  0xCE, 0x86, 0x9F, 0x2E, 0x8C, 0x79, 0x3A, 0xFC,  // .....y:.
            /* 0A30 */  0x68, 0x05, 0xB0, 0xF0, 0xFF, 0x7F, 0xB4, 0x02,  // h.......
            /* 0A38 */  0xFB, 0xC5, 0xCA, 0x63, 0x3E, 0xE3, 0xB7, 0xA9,  // ...c>...
            /* 0A40 */  0xA7, 0xA9, 0x28, 0xEF, 0xC7, 0xAF, 0x54, 0xEF,  // ..(...T.
            /* 0A48 */  0x06, 0xC6, 0x7A, 0x08, 0x78, 0xAA, 0xF2, 0x9D,  // ..z.x...
            /* 0A50 */  0xCA, 0xC7, 0x8A, 0x27, 0x64, 0xA3, 0xC4, 0x7A,  // ...'d..z
            /* 0A58 */  0xB9, 0x32, 0x66, 0x8C, 0x60, 0xEF, 0x55, 0x31,  // .2f.`.U1
            /* 0A60 */  0x1F, 0xB3, 0x3C, 0xC2, 0x68, 0xC1, 0x7D, 0x42,  // ..<.h.}B
            /* 0A68 */  0xE6, 0x47, 0x2B, 0x80, 0x61, 0x67, 0x12, 0x18,  // .G+.ag..
            /* 0A70 */  0xFF, 0xFF, 0x33, 0x09, 0xE0, 0xE8, 0x68, 0x05,  // ..3...h.
            /* 0A78 */  0xF6, 0xD1, 0xC2, 0x1C, 0x05, 0x8F, 0xFA, 0x1E,  // ........
            /* 0A80 */  0x31, 0x10, 0x0D, 0x07, 0x83, 0x3A, 0xC2, 0x12,  // 1....:..
            /* 0A88 */  0x20, 0x99, 0x00, 0x51, 0xA8, 0xA3, 0x15, 0xFA,  //  ..Q....
            /* 0A90 */  0x20, 0xE2, 0x61, 0x3F, 0x34, 0x78, 0x12, 0xA7,  //  .a?4x..
            /* 0A98 */  0xEA, 0x5B, 0xC3, 0x51, 0x3C, 0x01, 0xF8, 0x70,  // .[.Q<..p
            /* 0AA0 */  0x05, 0xFC, 0x87, 0x06, 0x6B, 0x12, 0xC5, 0x0F,  // ....k...
            /* 0AA8 */  0x0D, 0xDA, 0xFF, 0xFF, 0x94, 0x0C, 0xBC, 0x8F,  // ........
            /* 0AB0 */  0x6B, 0xC0, 0xE5, 0x80, 0x0C, 0xBE, 0x81, 0x81,  // k.......
            /* 0AB8 */  0xE3, 0x90, 0xE6, 0xE3, 0x1A, 0xEE, 0x40, 0xE4,  // ......@.
            /* 0AC0 */  0x81, 0xC5, 0x7C, 0x05, 0x8B, 0xF0, 0x08, 0xE6,  // ..|.....
            /* 0AC8 */  0x6B, 0x06, 0x3B, 0xF1, 0xF9, 0xB4, 0x12, 0x28,  // k.;....(
            /* 0AD0 */  0xCA, 0x6B, 0x0B, 0x3F, 0x4E, 0x83, 0x4B, 0xC7,  // .k.?N.K.
            /* 0AD8 */  0x71, 0x1A, 0x50, 0xF0, 0xFF, 0x3F, 0x12, 0xC0,  // q.P..?..
            /* 0AE0 */  0x99, 0x85, 0x2F, 0x58, 0xEC, 0x48, 0x00, 0x36,  // ../X.H.6
            /* 0AE8 */  0x1F, 0x47, 0x02, 0xA0, 0x34, 0x0C, 0x1F, 0xE6,  // .G..4...
            /* 0AF0 */  0xC0, 0x06, 0x73, 0x30, 0xAF, 0xED, 0xF6, 0x7E,  // ..s0...~
            /* 0AF8 */  0xD8, 0xA3, 0x47, 0x39, 0xC0, 0x7A, 0x84, 0x73,  // ..G9.z.s
            /* 0B00 */  0x1C, 0x4A, 0xF4, 0x51, 0x0E, 0xEA, 0xFF, 0xFF,  // .J.Q....
            /* 0B08 */  0x28, 0x07, 0x58, 0xBA, 0x33, 0x18, 0xE1, 0xFC,  // (.X.3...
            /* 0B10 */  0x43, 0x3C, 0x40, 0x84, 0x78, 0x8A, 0x33, 0x48,  // C<@.x.3H
            /* 0B18 */  0x9C, 0x20, 0x2F, 0x03, 0x8F, 0x72, 0xBE, 0xC9,  // . /..r..
            /* 0B20 */  0xC5, 0x79, 0x9A, 0x8B, 0xF2, 0x2E, 0x67, 0x84,  // .y....g.
            /* 0B28 */  0x87, 0x6E, 0x03, 0xF9, 0xC4, 0xED, 0x7B, 0xDC,  // .n....{.
            /* 0B30 */  0x53, 0xDD, 0xCB, 0x9C, 0x6F, 0xDD, 0xBE, 0x80,  // S...o...
            /* 0B38 */  0xFB, 0x28, 0xC7, 0x04, 0x1F, 0xE5, 0x00, 0x2A,  // .(.....*
            /* 0B40 */  0xFC, 0xFF, 0x8F, 0x72, 0x70, 0xCF, 0xAA, 0xE0,  // ...rp...
            /* 0B48 */  0x39, 0xCA, 0xC1, 0x38, 0x91, 0x00, 0xAE, 0xC7,  // 9..8....
            /* 0B50 */  0x0A, 0x63, 0x0C, 0x5C, 0xDD, 0xA3, 0xC7, 0xA7,  // .c.\....
            /* 0B58 */  0x22, 0x2A, 0xEA, 0x3C, 0x22, 0x18, 0xCE, 0xE2,  // "*.<"...
            /* 0B60 */  0x43, 0x90, 0xCF, 0x06, 0xFC, 0x04, 0xE2, 0x11,  // C.......
            /* 0B68 */  0x54, 0x3C, 0x4E, 0x7A, 0xEA, 0xF0, 0xC1, 0x8E,  // T<Nz....
            /* 0B70 */  0x9D, 0x0E, 0x1C, 0x7E, 0x90, 0xF4, 0xB4, 0x08,  // ...~....
            /* 0B78 */  0x9E, 0x73, 0x0B, 0xBC, 0xDB, 0x08, 0x9C, 0x53,  // .s.....S
            /* 0B80 */  0x81, 0xFF, 0xFF, 0xA7, 0x02, 0xC0, 0x4B, 0xFE,  // ......K.
            /* 0B88 */  0x57, 0x9A, 0xA0, 0x1D, 0xE0, 0x15, 0x2E, 0x1B,  // W.......
            /* 0B90 */  0x47, 0x32, 0xCA, 0xE1, 0x98, 0x0F, 0x1C, 0x4D,  // G2.....M
            /* 0B98 */  0x93, 0x9D, 0x78, 0x60, 0xC6, 0x82, 0xD4, 0x49,  // ..x`...I
            /* 0BA0 */  0xC0, 0xA7, 0x0E, 0x07, 0x82, 0x91, 0x76, 0x12,  // ......v.
            /* 0BA8 */  0x8D, 0xC6, 0x70, 0x56, 0x0B, 0x23, 0x38, 0x83,  // ..pV.#8.
            /* 0BB0 */  0xF8, 0xCC, 0xE3, 0x5C, 0x27, 0x16, 0xB4, 0x0A,  // ...\'...
            /* 0BB8 */  0x10, 0x9D, 0x56, 0x30, 0x41, 0xEE, 0x68, 0x74,  // ..V0A.ht
            /* 0BC0 */  0xDE, 0xBE, 0x1B, 0xF0, 0xEB, 0x8B, 0xC7, 0x62,  // .......b
            /* 0BC8 */  0x60, 0xDF, 0xBA, 0xC0, 0x31, 0x17, 0xAB, 0x01,  // `...1...
            /* 0BD0 */  0x45, 0x0D, 0xC0, 0x68, 0x98, 0x53, 0xC0, 0xC3,  // E..h.S..
            /* 0BD8 */  0x19, 0xB8, 0xEE, 0x71, 0x9E, 0x1B, 0xEE, 0xA6,  // ...q....
            /* 0BE0 */  0x62, 0xAD, 0x53, 0xD1, 0xE9, 0xE4, 0x7D, 0xE0,  // b.S...}.
            /* 0BE8 */  0xE0, 0xC0, 0xFA, 0xFF, 0x1F, 0x1C, 0x8C, 0xD9,  // ........
            /* 0BF0 */  0x7B, 0x70, 0xB0, 0xD0, 0x3C, 0x38, 0xB0, 0x65,  // {p..<8.e
            /* 0BF8 */  0x1B, 0x1C, 0x5A, 0xC9, 0x5D, 0x84, 0x1C, 0x3E,  // ..Z.]..>
            /* 0C00 */  0xF0, 0xB3, 0x03, 0x0E, 0x80, 0x9E, 0x1D, 0x2C,  // .......,
            /* 0C08 */  0x24, 0xCF, 0x0E, 0x6C, 0xFA, 0xCE, 0x22, 0xA0,  // $..l..".
            /* 0C10 */  0x00, 0xF2, 0xBD, 0xC3, 0xE7, 0x96, 0x67, 0x0F,  // ......g.
            /* 0C18 */  0x36, 0x86, 0x47, 0x17, 0xA3, 0x19, 0x9D, 0x6B,  // 6.G....k
            /* 0C20 */  0xBA, 0x4D, 0xA0, 0x54, 0xDC, 0x26, 0x28, 0x88,  // .M.T.&(.
            /* 0C28 */  0x6F, 0x00, 0x4E, 0x48, 0xA3, 0xDB, 0x20, 0x6E,  // o.NH.. n
            /* 0C30 */  0x26, 0xC6, 0x7F, 0xC4, 0xF0, 0x11, 0xE1, 0x90,  // &.......
            /* 0C38 */  0xCE, 0xD6, 0x04, 0xF3, 0x40, 0xEA, 0xBD, 0xA1,  // ....@...
            /* 0C40 */  0xBB, 0x14, 0x84, 0xD9, 0x87, 0x7C, 0x70, 0xF1,  // .....|p.
            /* 0C48 */  0x34, 0x7C, 0xBD, 0x21, 0xF7, 0x0E, 0x3A, 0x6D,  // 4|.!..:m
            /* 0C50 */  0x9F, 0x19, 0x30, 0xA7, 0x55, 0x5F, 0x2D, 0x13,  // ..0.U_-.
            /* 0C58 */  0x58, 0xD6, 0x55, 0x82, 0x7A, 0xB8, 0x80, 0xD0,  // X.U.z...
            /* 0C60 */  0x0B, 0x8D, 0xAF, 0x5D, 0x09, 0x1E, 0x04, 0x7D,  // ...]...}
            /* 0C68 */  0x0C, 0xFB, 0xFF, 0xBF, 0x97, 0xB0, 0xB3, 0x57,  // .......W
            /* 0C70 */  0x82, 0x57, 0xAF, 0x04, 0xF3, 0x0E, 0x02, 0x35,  // .W.....5
            /* 0C78 */  0x2A, 0x0F, 0x02, 0x73, 0x94, 0x34, 0xC1, 0x7C,  // *..s.4.|
            /* 0C80 */  0x63, 0x40, 0x25, 0xBB, 0x74, 0xD2, 0x33, 0xCC,  // c@%.t.3.
            /* 0C88 */  0x3B, 0x8C, 0x2F, 0x09, 0xBE, 0x7E, 0xF8, 0xDC,  // ;./..~..
            /* 0C90 */  0xE2, 0x05, 0xBC, 0x7A, 0xC2, 0x20, 0x78, 0x06,  // ...z. x.
            /* 0C98 */  0x7A, 0x75, 0x31, 0x54, 0x9C, 0xC0, 0xAF, 0x02,  // zu1T....
            /* 0CA0 */  0x6F, 0x34, 0x21, 0x82, 0x19, 0xF6, 0xF0, 0x43,  // o4!....C
            /* 0CA8 */  0xBE, 0xC5, 0xF8, 0xF8, 0xE6, 0x1B, 0x40, 0xAC,  // ......@.
            /* 0CB0 */  0xD7, 0x11, 0x8F, 0x94, 0x1F, 0x5B, 0x0E, 0x28,  // .....[.(
            /* 0CB8 */  0xD2, 0x4B, 0x95, 0x27, 0xE0, 0xB3, 0x8C, 0x4F,  // .K.'...O
            /* 0CC0 */  0x5B, 0x27, 0xE5, 0x6B, 0x9B, 0xD1, 0x5F, 0x21,  // ['.k.._!
            /* 0CC8 */  0x7C, 0xF8, 0x31, 0xB2, 0xCF, 0x39, 0xEC, 0xDC,  // |.1..9..
            /* 0CD0 */  0xC5, 0x06, 0xC5, 0x11, 0x1F, 0x18, 0x5E, 0x6A,  // ......^j
            /* 0CD8 */  0x3C, 0x15, 0x76, 0x05, 0x60, 0x07, 0x07, 0x7E,  // <.v.`..~
            /* 0CE0 */  0x05, 0xF0, 0xC1, 0x81, 0x1D, 0x8B, 0x30, 0xC7,  // ......0.
            /* 0CE8 */  0x4A, 0x70, 0x9D, 0x6C, 0x7C, 0x72, 0x00, 0x33,  // Jp.l|r.3
            /* 0CF0 */  0x3C, 0xE6, 0x40, 0xEA, 0xF3, 0x86, 0x6F, 0x06,  // <.@...o.
            /* 0CF8 */  0x1E, 0x17, 0x3F, 0x72, 0xF8, 0xA8, 0xCA, 0xB0,  // ..?r....
            /* 0D00 */  0x4F, 0xD3, 0x47, 0xA3, 0x17, 0x59, 0x9F, 0x5E,  // O.G..Y.^
            /* 0D08 */  0x30, 0xB0, 0xBE, 0x34, 0x70, 0x58, 0xA3, 0x85,  // 0..4pX..
            /* 0D10 */  0x7D, 0x0C, 0x38, 0x73, 0x5F, 0x88, 0x70, 0x87,  // }.8s_.p.
            /* 0D18 */  0x3A, 0xB0, 0xFC, 0xFF, 0x01, 0xF1, 0xB7, 0x92,  // :.......
            /* 0D20 */  0x47, 0x0E, 0x4F, 0xC0, 0x80, 0x2C, 0xF7, 0xBA,  // G.O..,..
            /* 0D28 */  0x74, 0x20, 0xE2, 0xE7, 0x46, 0xAB, 0x3B, 0x10,  // t ..F.;.
            /* 0D30 */  0x21, 0x30, 0x9E, 0xF6, 0x1E, 0x3F, 0x3C, 0x1B,  // !0...?<.
            /* 0D38 */  0x1F, 0x05, 0x7C, 0x8C, 0xF2, 0xCC, 0xCF, 0x28,  // ..|....(
            /* 0D40 */  0xD2, 0x2B, 0x83, 0xB5, 0x9C, 0x88, 0x50, 0x2A,  // .+....P*
            /* 0D48 */  0x60, 0x14, 0x98, 0x46, 0x77, 0x0E, 0x1E, 0x11,  // `..Fw...
            /* 0D50 */  0x46, 0x70, 0x06, 0xF1, 0x68, 0x7D, 0x73, 0x01,  // Fp..h}s.
            /* 0D58 */  0xA6, 0x67, 0x22, 0xE0, 0x12, 0x72, 0x76, 0xE8,  // .g"..rv.
            /* 0D60 */  0x8B, 0x33, 0x9B, 0xB6, 0x71, 0xDF, 0x00, 0x7D,  // .3..q..}
            /* 0D68 */  0xF8, 0xF4, 0xC4, 0x4F, 0x1B, 0xC6, 0xC9, 0x08,  // ...O....
            /* 0D70 */  0xB0, 0xF1, 0xFF, 0xBF, 0xEB, 0x00, 0xFC, 0xFF,  // ........
            /* 0D78 */  0xFF, 0xDF, 0x75, 0x00, 0x3B, 0xF7, 0x07, 0xDF,  // ..u.;...
            /* 0D80 */  0x75, 0x80, 0x6B, 0x88, 0x55, 0xE9, 0xAE, 0xC3,  // u.k.U...
            /* 0D88 */  0x0F, 0x00, 0x8E, 0xBA, 0x20, 0xDD, 0x0A, 0x22,  // .... .."
            /* 0D90 */  0x1E, 0x82, 0x07, 0xF9, 0x28, 0x60, 0xD8, 0xB3,  // ....(`..
            /* 0D98 */  0x7C, 0x1C, 0xF6, 0x70, 0x4C, 0x30, 0xDC, 0x55,  // |..pL0.U
            /* 0DA0 */  0x83, 0x0E, 0xCD, 0xB1, 0x28, 0x24, 0xE4, 0xA6,  // ....($..
            /* 0DA8 */  0x83, 0x8A, 0x7E, 0x7F, 0xA0, 0x20, 0x06, 0xF4,  // ..~.. ..
            /* 0DB0 */  0x55, 0x12, 0xB0, 0xF2, 0xFF, 0xBF, 0xB5, 0x00,  // U.......
            /* 0DB8 */  0xBB, 0x30, 0x83, 0x46, 0xC9, 0xBF, 0x2D, 0x51,  // .0.F..-Q
            /* 0DC0 */  0x10, 0x0F, 0xDA, 0xD2, 0x6E, 0x2D, 0xA0, 0x38,  // ....n-.8
            /* 0DC8 */  0x04, 0xF8, 0xD6, 0x02, 0x5F, 0xDE, 0xAD, 0x05,  // ...._...
            /* 0DD0 */  0x14, 0xB7, 0x00, 0x1F, 0x0D, 0xF8, 0x71, 0xC1,  // ......q.
            /* 0DD8 */  0x07, 0x0E, 0xDF, 0x58, 0x7C, 0x37, 0x26, 0x17,  // ...X|7&.
            /* 0DE0 */  0x16, 0xA8, 0xE3, 0xE7, 0xE0, 0xBE, 0xC6, 0xBF,  // ........
            /* 0DE8 */  0xB0, 0xC0, 0x38, 0x99, 0x80, 0xE3, 0x48, 0x02,  // ..8...H.
            /* 0DF0 */  0xD8, 0xF9, 0xFF, 0x1F, 0x49, 0xC0, 0x02, 0xE9,  // ....I...
            /* 0DF8 */  0x23, 0x09, 0x70, 0x8D, 0xB4, 0x2A, 0x2A, 0xE2,  // #.p..**.
            /* 0E00 */  0x3D, 0xA0, 0x53, 0x89, 0x61, 0xF8, 0xE8, 0x7C,  // =.S.a..|
            /* 0E08 */  0x66, 0xC0, 0x5F, 0x39, 0x18, 0x38, 0x3B, 0x91,  // f._9.8;.
            /* 0E10 */  0x19, 0x8E, 0x0F, 0xDC, 0xE3, 0x7B, 0x21, 0x3B,  // .....{!;
            /* 0E18 */  0xAD, 0x87, 0x02, 0xDF, 0xC9, 0x0C, 0xC9, 0xAE,  // ........
            /* 0E20 */  0xE0, 0xB8, 0xC3, 0x83, 0xC7, 0xFE, 0x50, 0xE4,  // ......P.
            /* 0E28 */  0x1B, 0xC2, 0x0B, 0x82, 0x2F, 0x07, 0x0C, 0x0A,  // ..../...
            /* 0E30 */  0xC6, 0x2D, 0x1C, 0x73, 0x04, 0x87, 0x43, 0x70,  // .-.s..Cp
            /* 0E38 */  0xC6, 0x47, 0x81, 0x19, 0xA4, 0x2F, 0x20, 0xAF,  // .G.../ .
            /* 0E40 */  0x07, 0x1E, 0x2C, 0x73, 0x7F, 0xA0, 0xD2, 0x09,  // ..,s....
            /* 0E48 */  0xE6, 0x71, 0xEA, 0xC9, 0xA0, 0x39, 0x14, 0x9D,  // .q...9..
            /* 0E50 */  0x09, 0x4E, 0xA1, 0xAD, 0x61, 0x09, 0xE7, 0x81,  // .N..a...
            /* 0E58 */  0x22, 0x44, 0x94, 0x60, 0xAF, 0x54, 0x6F, 0x0C,  // "D.`.To.
            /* 0E60 */  0xCF, 0xEB, 0x51, 0xE2, 0x45, 0x0A, 0x18, 0x2D,  // ..Q.E..-
            /* 0E68 */  0x4A, 0xB0, 0xDE, 0x20, 0x04, 0x1A, 0x29, 0x44,  // J.. ..)D
            /* 0E70 */  0xC0, 0x10, 0xAF, 0x13, 0xB1, 0xC2, 0x45, 0x6F,  // ......Eo
            /* 0E78 */  0x7F, 0x10, 0x24, 0xC0, 0x9B, 0x42, 0xD7, 0x14,  // ..$..B..
            /* 0E80 */  0x47, 0x3A, 0xC4, 0xA0, 0x87, 0xED, 0x3B, 0x39,  // G:....;9
            /* 0E88 */  0x9F, 0x56, 0x90, 0xE3, 0xF2, 0x41, 0x06, 0x43,  // .V...A.C
            /* 0E90 */  0xF0, 0xF0, 0xE1, 0x2F, 0x80, 0x0F, 0x00, 0xD8,  // .../....
            /* 0E98 */  0xFF, 0x3F, 0x41, 0xD7, 0x80, 0x9A, 0xF9, 0xE3,  // .?A.....
            /* 0EA0 */  0x01, 0x58, 0x0E, 0x17, 0xF0, 0x07, 0xFE, 0x04,  // .X......
            /* 0EA8 */  0x83, 0x3B, 0xAB, 0x68, 0x10, 0xA8, 0x93, 0x0A,  // .;.h....
            /* 0EB0 */  0x3F, 0x5D, 0xF9, 0x6E, 0xEE, 0x1B, 0x90, 0x09,  // ?].n....
            /* 0EB8 */  0x2C, 0xF6, 0x20, 0x42, 0xC7, 0x03, 0xFE, 0xA1,  // ,. B....
            /* 0EC0 */  0xBF, 0xD6, 0xFB, 0x50, 0xE1, 0xF9, 0xFA, 0x72,  // ...P...r
            /* 0EC8 */  0xEF, 0xCB, 0x3F, 0x58, 0xAE, 0x09, 0xFC, 0xFA,  // ..?X....
            /* 0ED0 */  0x0F, 0x78, 0x14, 0x3C, 0x2E, 0x14, 0x34, 0x0E,  // .x.<..4.
            /* 0ED8 */  0xF1, 0xA9, 0xEE, 0xD4, 0x7D, 0x66, 0x39, 0x61,  // ....}f9a
            /* 0EE0 */  0xDC, 0xFF, 0x7F, 0xC4, 0x6C, 0xBC, 0xE0, 0x3A,  // ....l..:
            /* 0EE8 */  0x7F, 0x20, 0xDE, 0x24, 0x3E, 0x96, 0xD0, 0xF0,  // . .$>...
            /* 0EF0 */  0x27, 0x13, 0x40, 0xE0, 0x8C, 0x9E, 0x4C, 0x3C,  // '.@...L<
            /* 0EF8 */  0xEF, 0x77, 0x92, 0x67, 0xA1, 0x43, 0x88, 0xF1,  // .w.g.C..
            /* 0F00 */  0x46, 0x12, 0xC4, 0x08, 0x4F, 0x26, 0xEC, 0x42,  // F...O&.B
            /* 0F08 */  0xF2, 0x40, 0x12, 0xE2, 0xC9, 0xC4, 0xD7, 0x92,  // .@......
            /* 0F10 */  0x60, 0x21, 0x9E, 0x4C, 0x18, 0x58, 0xE8, 0x58,  // `!.L.X.X
            /* 0F18 */  0xAF, 0x45, 0x31, 0xD8, 0x4D, 0xC5, 0x70, 0x4F,  // .E1.M.pO
            /* 0F20 */  0x26, 0x2C, 0xF8, 0x23, 0x43, 0xB7, 0x47, 0x9F,  // &,.#C.G.
            /* 0F28 */  0x4C, 0x00, 0x43, 0xFF, 0xFF, 0x93, 0x09, 0xB0,  // L.C.....
            /* 0F30 */  0x3F, 0x52, 0xF9, 0xC4, 0x86, 0x1B, 0x85, 0x0F,  // ?R......
            /* 0F38 */  0x16, 0x11, 0xD9, 0x59, 0x87, 0x0C, 0x9A, 0xDE,  // ...Y....
            /* 0F40 */  0xF7, 0xC0, 0x61, 0x64, 0x60, 0x40, 0xE1, 0x30,  // ..ad`@.0
            /* 0F48 */  0x86, 0x3F, 0xC7, 0x91, 0x13, 0x0C, 0x28, 0xCE,  // .?....(.
            /* 0F50 */  0x13, 0x98, 0x93, 0xC8, 0x73, 0xC2, 0x8B, 0x05,  // ....s...
            /* 0F58 */  0x3B, 0xB9, 0x00, 0x6E, 0xAE, 0xC0, 0x04, 0x87,  // ;..n....
            /* 0F60 */  0xFC, 0xFF, 0x4F, 0x2E, 0xE0, 0x3C, 0x97, 0xC3,  // ..O..<..
            /* 0F68 */  0x18, 0x03, 0xD7, 0xFF, 0xCA, 0xF4, 0x31, 0x8F,  // ......1.
            /* 0F70 */  0x4A, 0x7A, 0xFE, 0x19, 0x86, 0xB2, 0xF8, 0x84,  // Jz......
            /* 0F78 */  0xE0, 0x73, 0x01, 0x3F, 0x21, 0x78, 0x04, 0x6F,  // .s.?!x.o
            /* 0F80 */  0x5B, 0xC7, 0xC9, 0x4E, 0x26, 0xBE, 0x6E, 0xF8,  // [..N&.n.
            /* 0F88 */  0x64, 0xC0, 0x0E, 0x9F, 0x1E, 0xA4, 0x47, 0x86,  // d.....G.
            /* 0F90 */  0x3B, 0x0F, 0x80, 0xED, 0xC0, 0x02, 0xEB, 0x50,  // ;......P
            /* 0F98 */  0x00, 0xB8, 0xD1, 0x68, 0x62, 0xE4, 0x4C, 0x1F,  // ...hb.L.
            /* 0FA0 */  0x88, 0x0E, 0xB4, 0x9C, 0xC3, 0x29, 0x16, 0xA7,  // .....)..
            /* 0FA8 */  0x1B, 0xA6, 0x0F, 0x3E, 0xBE, 0x9B, 0x9C, 0xCA,  // ...>....
            /* 0FB0 */  0xA9, 0xE2, 0x4F, 0x94, 0x56, 0x0D, 0xA9, 0x93,  // ..O.V...
            /* 0FB8 */  0x25, 0xD7, 0x0B, 0xA3, 0x68, 0x0F, 0x22, 0x9D,  // %...h.".
            /* 0FC0 */  0x46, 0x79, 0x18, 0x18, 0xC1, 0x19, 0xC4, 0x87,  // Fy......
            /* 0FC8 */  0x1A, 0x67, 0x3B, 0xD4, 0xA0, 0x95, 0x08, 0xF8,  // .g;.....
            /* 0FD0 */  0xFF, 0x5F, 0xAD, 0x3D, 0x06, 0x76, 0xA6, 0x05,  // ._.=.v..
            /* 0FD8 */  0xCC, 0x5C, 0x7F, 0x7D, 0x73, 0xC1, 0xBD, 0x24,  // .\.}s..$
            /* 0FE0 */  0x7C, 0x73, 0xC1, 0xCC, 0x0D, 0x38, 0x8C, 0xDF,  // |s...8..
            /* 0FE8 */  0x73, 0x83, 0x85, 0xE6, 0xB9, 0xC1, 0xBF, 0xBD,  // s.......
            /* 0FF0 */  0x60, 0xA3, 0xCD, 0x0D, 0x8D, 0xCC, 0xE6, 0xF6,  // `.......
            /* 0FF8 */  0x1C, 0x10, 0xE1, 0x15, 0xC1, 0x87, 0x0F, 0x8F,  // ........
            /* 1000 */  0x0E, 0x38, 0x00, 0x7A, 0x74, 0xB0, 0x90, 0x3C,  // .8.zt..<
            /* 1008 */  0x3A, 0xF0, 0xFC, 0xFF, 0x47, 0xC7, 0xD2, 0x8D,  // :...G...
            /* 1010 */  0x0E, 0xAD, 0x05, 0x44, 0x2E, 0x4F, 0x53, 0xE4,  // ...D.OS.
            /* 1018 */  0x64, 0x72, 0x7A, 0x4F, 0xB9, 0xBE, 0xB2, 0x7A,  // drzO...z
            /* 1020 */  0x7A, 0xC0, 0x63, 0x00, 0x9E, 0x1E, 0x2C, 0x34,  // z.c...,4
            /* 1028 */  0x4F, 0x0F, 0x6C, 0x11, 0x2F, 0x19, 0xE8, 0xDB,  // O.l./...
            /* 1030 */  0x87, 0x91, 0x5F, 0xA0, 0x7D, 0x5E, 0x32, 0xA8,  // .._.}^2.
            /* 1038 */  0xEF, 0x36, 0x30, 0x46, 0x08, 0x1C, 0x6E, 0xD5,  // .60F..n.
            /* 1040 */  0x1E, 0x21, 0x2C, 0x34, 0x1F, 0x34, 0xC0, 0x16,  // .!,4.4..
            /* 1048 */  0x6F, 0x84, 0xE8, 0x61, 0xF9, 0x4E, 0x72, 0x7E,  // o..a.Nr~
            /* 1050 */  0x27, 0x77, 0x7C, 0xC0, 0x0A, 0xD8, 0xE3, 0xE3,  // 'w|.....
            /* 1058 */  0xFF, 0xFF, 0xF1, 0x61, 0x51, 0x7C, 0x74, 0x07,  // ...aQ|t.
            /* 1060 */  0xCE, 0x99, 0xB6, 0xA4, 0xD3, 0x0D, 0x4F, 0x01,  // ......O.
            /* 1068 */  0xA3, 0x93, 0x8B, 0x41, 0x7C, 0x1F, 0xB1, 0x42,  // ...A|..B
            /* 1070 */  0x10, 0x1D, 0xDD, 0xE1, 0xEB, 0x81, 0xD4, 0xD1,  // ........
            /* 1078 */  0x1D, 0xFE, 0x95, 0xDD, 0x47, 0x77, 0xF8, 0xA3,  // ....Gw..
            /* 1080 */  0x3B, 0x1E, 0x66, 0xE3, 0x58, 0x44, 0xCF, 0x57,  // ;.f.XD.W
            /* 1088 */  0x3E, 0x26, 0x26, 0x78, 0x95, 0xF0, 0x61, 0xE2,  // >&&x..a.
            /* 1090 */  0x39, 0x89, 0x1D, 0xDF, 0x7D, 0x70, 0x4C, 0xF0,  // 9...}pL.
            /* 1098 */  0xC0, 0xF8, 0xD4, 0xCE, 0x4E, 0x8D, 0x21, 0x8D,  // ....N.!.
            /* 10A0 */  0xCA, 0x60, 0x0D, 0xF1, 0xFC, 0xC6, 0xF4, 0xAD,  // .`......
            /* 10A8 */  0x4F, 0xE7, 0x78, 0xB8, 0x7A, 0x00, 0x35, 0x16,  // O.x.z.5.
            /* 10B0 */  0xAE, 0x04, 0x46, 0xE7, 0x78, 0xFC, 0x85, 0xE1,  // ..F.x...
            /* 10B8 */  0x75, 0xCA, 0x0B, 0x08, 0xE6, 0x79, 0x45, 0x78,  // u....yEx
            /* 10C0 */  0x61, 0xF0, 0x49, 0x9C, 0x9F, 0x8E, 0x1E, 0xA9,  // a.I.....
            /* 10C8 */  0x0C, 0x15, 0x27, 0xF0, 0x2B, 0xC1, 0x9B, 0x56,  // ..'.+..V
            /* 10D0 */  0x88, 0x60, 0x86, 0x7D, 0x0C, 0x78, 0xDC, 0x30,  // .`.}.x.0
            /* 10D8 */  0xAA, 0x4F, 0xA0, 0xC6, 0x7A, 0x48, 0xF2, 0x88,  // .O..zH..
            /* 10E0 */  0xF9, 0x6D, 0xEA, 0x80, 0x22, 0x3D, 0xFD, 0x78,  // .m.."=.x
            /* 10E8 */  0x02, 0xBE, 0xDE, 0xF3, 0xFF, 0xFF, 0xF5, 0x1E,  // ........
            /* 10F0 */  0xEE, 0x8D, 0xD1, 0x83, 0xE2, 0x88, 0x0F, 0x0E,  // ........
            /* 10F8 */  0x0F, 0x21, 0x9E, 0x0A, 0xBB, 0x3D, 0x61, 0xC0,  // .!...=a.
            /* 1100 */  0x8E, 0xC0, 0x47, 0x41, 0x7E, 0x78, 0x09, 0x14,  // ..GA~x..
            /* 1108 */  0xA5, 0x78, 0x4C, 0xDD, 0x1C, 0x3C, 0x43, 0x83,  // .xL..<C.
            /* 1110 */  0x62, 0xE0, 0x0F, 0x92, 0xCD, 0x2E, 0xAE, 0xB1,  // b.......
            /* 1118 */  0x7C, 0x2F, 0x31, 0x22, 0x76, 0x40, 0x0C, 0x25,  // |/1"v@.%
            /* 1120 */  0xD2, 0x09, 0x54, 0x8F, 0x42, 0xE6, 0xE0, 0x11,  // ..T.B...
            /* 1128 */  0x79, 0x36, 0x9E, 0x0E, 0x3B, 0x75, 0xE0, 0x27,  // y6..;u.'
            /* 1130 */  0xE1, 0x33, 0x93, 0xEF, 0xAF, 0x1E, 0x90, 0x87,  // .3......
            /* 1138 */  0xC2, 0xA7, 0xC8, 0x80, 0xE1, 0xC0, 0xBC, 0x04,  // ........
            /* 1140 */  0x30, 0x68, 0x0F, 0x9F, 0xA1, 0xBF, 0x16, 0x19,  // 0h......
            /* 1148 */  0x9D, 0x9F, 0x76, 0x4E, 0xC7, 0xE7, 0x4D, 0x1F,  // ..vN..M.
            /* 1150 */  0x35, 0x7C, 0x0F, 0xC0, 0x9C, 0xC8, 0x7C, 0x02,  // 5|....|.
            /* 1158 */  0xF0, 0x89, 0x8D, 0x01, 0x3D, 0xF9, 0x1B, 0xD5,  // ....=...
            /* 1160 */  0xF7, 0x52, 0x76, 0xF5, 0xC1, 0x20, 0x9D, 0x46,  // .Rv.. .F
            /* 1168 */  0x94, 0x48, 0xAF, 0x03, 0xFC, 0x76, 0xC6, 0xC1,  // .H...v..
            /* 1170 */  0x02, 0x1D, 0x2B, 0x9F, 0x4C, 0x3C, 0x4F, 0xD8,  // ..+.L<O.
            /* 1178 */  0x23, 0x85, 0x73, 0xC5, 0x60, 0x07, 0x13, 0x7E,  // #.s.`..~
            /* 1180 */  0xC5, 0xF0, 0xC1, 0x84, 0x5D, 0x02, 0x31, 0x37,  // ....].17
            /* 1188 */  0x4C, 0x70, 0x5D, 0x31, 0x7C, 0x32, 0x81, 0xF7,  // Lp]1|2..
            /* 1190 */  0xFF, 0x3F, 0x99, 0x80, 0x01, 0x1E, 0x73, 0x37,  // .?....s7
            /* 1198 */  0xF5, 0x79, 0xC6, 0xB2, 0xC6, 0x85, 0x3A, 0xD2,  // .y....:.
            /* 11A0 */  0xF8, 0x24, 0xF3, 0x7C, 0x6C, 0xEC, 0x87, 0x01,  // .$.|l...
            /* 11A8 */  0x4F, 0xFA, 0x30, 0x9F, 0x9D, 0x7C, 0x55, 0xE3,  // O.0..|U.
            /* 11B0 */  0xB0, 0xBE, 0x94, 0x70, 0x58, 0xA3, 0x85, 0x7D,  // ...pX..}
            /* 11B8 */  0x1D, 0x30, 0xEC, 0x03, 0x20, 0xEE, 0x9A, 0x0B,  // .0.. ...
            /* 11C0 */  0x16, 0x40, 0xFC, 0x25, 0xE1, 0xC1, 0xC0, 0x13,  // .@.%....
            /* 11C8 */  0x30, 0x20, 0x8B, 0x73, 0xA3, 0x46, 0x05, 0xB8,  // 0 .s.F..
            /* 11D0 */  0x54, 0x03, 0x02, 0xAF, 0xD2, 0x3E, 0xC7, 0xBC,  // T....>..
            /* 11D8 */  0xC3, 0x3C, 0x14, 0xBC, 0xCB, 0x44, 0x08, 0xF2,  // .<...D..
            /* 11E0 */  0x34, 0xFD, 0x8E, 0x10, 0x21, 0x54, 0xA0, 0x97,  // 4...!T..
            /* 11E8 */  0x6A, 0xE3, 0x05, 0x7D, 0x99, 0x88, 0x12, 0x27,  // j..}...'
            /* 11F0 */  0x4A, 0x84, 0x50, 0xC6, 0x38, 0x97, 0xA7, 0x83,  // J.P.8...
            /* 11F8 */  0x97, 0x9A, 0x70, 0x8F, 0x09, 0x81, 0x9F, 0x1C,  // ..p.....
            /* 1200 */  0x9E, 0xAA, 0x8D, 0x70, 0x8C, 0x2F, 0xD5, 0x4C,  // ...p./.L
            /* 1208 */  0xFC, 0x45, 0x46, 0xF7, 0x24, 0x5F, 0xAA, 0xF1,  // .EF.$_..
            /* 1210 */  0xFF, 0xFF, 0x4B, 0x35, 0xC0, 0x87, 0x61, 0xF8,  // ..K5..a.
            /* 1218 */  0x36, 0x0B, 0x8E, 0x6B, 0x02, 0xBF, 0xCF, 0x02,  // 6..k....
            /* 1220 */  0xFE, 0xFE, 0xFF, 0xE7, 0x16, 0x4F, 0xE3, 0x9D,  // .....O..
            /* 1228 */  0x19, 0xDC, 0xC3, 0x85, 0x3D, 0x0C, 0xAE, 0xE9,  // ....=...
            /* 1230 */  0x9A, 0xAB, 0xF3, 0x0D, 0x57, 0x01, 0x83, 0xBA,  // ....W...
            /* 1238 */  0x36, 0x83, 0x2B, 0xED, 0x1A, 0x04, 0xEA, 0x23,  // 6.+....#
            /* 1240 */  0x8D, 0x4F, 0x18, 0xB8, 0xE3, 0x82, 0x4F, 0x17,  // .O....O.
            /* 1248 */  0xB8, 0xDB, 0x3B, 0xCC, 0x4B, 0x8A, 0xCF, 0x7C,  // ..;.K..|
            /* 1250 */  0x98, 0x9B, 0x83, 0x07, 0xE4, 0x13, 0x04, 0xF8,  // ........
            /* 1258 */  0x2F, 0x7D, 0xD8, 0x55, 0xB0, 0x43, 0x22, 0xFE,  // /}.U.C".
            /* 1260 */  0xFE, 0x65, 0xD0, 0x73, 0x0C, 0xEA, 0x03, 0xCF,  // .e.s....
            /* 1268 */  0x2B, 0x86, 0xAF, 0x09, 0x0F, 0x13, 0x8E, 0x7A,  // +......z
            /* 1270 */  0x0A, 0xA2, 0x63, 0x03, 0xC7, 0x61, 0x03, 0x1C,  // ..c..a..
            /* 1278 */  0x47, 0x1B, 0xDC, 0x31, 0xC7, 0xE7, 0x10, 0x1C,  // G..1....
            /* 1280 */  0xDC, 0x7B, 0x81, 0x87, 0xE1, 0x7B, 0x8E, 0x47,  // .{...{.G
            /* 1288 */  0xC4, 0xFE, 0xFF, 0x23, 0xF2, 0xF8, 0x1F, 0x22,  // ...#..."
            /* 1290 */  0x5E, 0x38, 0x22, 0x04, 0xC4, 0x9F, 0xA9, 0xF8,  // ^8".....
            /* 1298 */  0x80, 0xC1, 0x97, 0x67, 0xC0, 0xBA, 0x1C, 0xE2,  // ...g....
            /* 12A0 */  0x06, 0xEC, 0x21, 0x3D, 0x5C, 0x18, 0xF5, 0x89,  // ..!=\...
            /* 12A8 */  0xCC, 0xE8, 0xAF, 0x2F, 0xCF, 0x77, 0x26, 0xB0,  // .../.w&.
            /* 12B0 */  0x72, 0x58, 0x5D, 0x0F, 0x3D, 0x60, 0x70, 0x00,  // rX].=`p.
            /* 12B8 */  0x7A, 0xC0, 0xF0, 0xCF, 0x16, 0x6F, 0x8A, 0x60,  // z....o.`
            /* 12C0 */  0xB8, 0x68, 0xFA, 0xB8, 0xE0, 0x43, 0x8F, 0x15,  // .h...C..
            /* 12C8 */  0xDD, 0x14, 0xD1, 0xF7, 0x44, 0x1F, 0x11, 0xB1,  // ....D...
            /* 12D0 */  0x77, 0x09, 0x72, 0x44, 0x84, 0x7A, 0x97, 0xF0,  // w.rD.z..
            /* 12D8 */  0x1C, 0xF8, 0x21, 0x8F, 0x0D, 0xF5, 0xBD, 0xE7,  // ..!.....
            /* 12E0 */  0x19, 0xCE, 0x07, 0xAB, 0xF7, 0x00, 0x9F, 0x3C,  // .......<
            /* 12E8 */  0x1E, 0xDD, 0xD8, 0xA9, 0x90, 0x1D, 0xB7, 0x3C,  // .......<
            /* 12F0 */  0x5E, 0x9F, 0x33, 0x7C, 0xC1, 0x64, 0x43, 0x36,  // ^.3|.dC6
            /* 12F8 */  0xD8, 0xAB, 0x86, 0xCF, 0x5F, 0x3E, 0x10, 0xE2,  // ...._>..
            /* 1300 */  0x0E, 0x51, 0xBE, 0xFA, 0xF1, 0x43, 0x08, 0x3B,  // .Q...C.;
            /* 1308 */  0x91, 0x1C, 0xF5, 0xFB, 0x9B, 0x4F, 0x28, 0x27,  // .....O('
            /* 1310 */  0x74, 0x20, 0xBE, 0xB3, 0x81, 0xF3, 0x60, 0xED,  // t ....`.
            /* 1318 */  0x7B, 0x05, 0xE6, 0xFF, 0x7F, 0xF9, 0x65, 0x23,  // {.....e#
            /* 1320 */  0xC3, 0x1C, 0x0D, 0x60, 0x5D, 0x42, 0xC0, 0x75,  // ...`]B.u
            /* 1328 */  0xC7, 0xF0, 0x25, 0x04, 0xF8, 0x04, 0xBD, 0x44,  // ..%....D
            /* 1330 */  0xA0, 0xAF, 0x19, 0x1E, 0xDD, 0x23, 0x00, 0xE6,  // .....#..
            /* 1338 */  0x8A, 0xC1, 0x8E, 0x05, 0x3E, 0x6C, 0xF8, 0x1A,  // ....>l..
            /* 1340 */  0xC0, 0xEE, 0x05, 0x0E, 0x73, 0x8F, 0x00, 0x15,  // ....s...
            /* 1348 */  0xA8, 0x87, 0x07, 0x5F, 0xED, 0x3D, 0x02, 0x14,  // ..._.=..
            /* 1350 */  0xE7, 0x56, 0x1F, 0x1A, 0x3C, 0x50, 0xAB, 0x3A,  // .V..<P.:
            /* 1358 */  0xC1, 0x42, 0x39, 0xC0, 0xF2, 0xD3, 0x2B, 0xBF,  // .B9...+.
            /* 1360 */  0x15, 0xB0, 0x7C, 0x37, 0x09, 0xE8, 0x79, 0x66,  // ..|7..yf
            /* 1368 */  0x81, 0x4A, 0x72, 0x93, 0x80, 0x0E, 0xF3, 0x7C,  // .Jr....|
            /* 1370 */  0xFE, 0x32, 0xC3, 0xE6, 0x7F, 0xE0, 0xBE, 0x7E,  // .2.....~
            /* 1378 */  0x62, 0x06, 0x69, 0x94, 0xB7, 0x3C, 0x9F, 0xC1,  // b.i..<..
            /* 1380 */  0xF8, 0xFF, 0xFF, 0x0C, 0xE1, 0x63, 0x2B, 0x3B,  // .....c+;
            /* 1388 */  0x53, 0xF0, 0x13, 0x2C, 0xEE, 0x0E, 0x60, 0x94,  // S..,..`.
            /* 1390 */  0x67, 0x4F, 0x4F, 0x80, 0x9D, 0x6A, 0x8D, 0xFC,  // gOO..j..
            /* 1398 */  0x8E, 0xEF, 0x4B, 0x84, 0xEF, 0x45, 0x98, 0x13,  // ..K..E..
            /* 13A0 */  0x05, 0xF8, 0x4E, 0x21, 0x3E, 0x24, 0xE0, 0xCE,  // ..N!>$..
            /* 13A8 */  0x02, 0x1E, 0xCB, 0xD3, 0x2A, 0xBB, 0x20, 0x81,  // ....*. .
            /* 13B0 */  0xEF, 0x38, 0xE2, 0xC3, 0x04, 0xF8, 0x07, 0x86,  // .8......
            /* 13B8 */  0x8F, 0x7C, 0x27, 0x40, 0x9D, 0x3C, 0x38, 0xEA,  // .|'@.<8.
            /* 13C0 */  0xD9, 0x3E, 0xC2, 0x1A, 0xF5, 0xBD, 0xEA, 0xE1,  // .>......
            /* 13C8 */  0xCD, 0x57, 0x09, 0x7E, 0x31, 0xE0, 0xC1, 0xAE,  // .W.~1...
            /* 13D0 */  0x48, 0xA0, 0xF2, 0x30, 0x3A, 0xD0, 0x0D, 0x01,  // H..0:...
            /* 13D8 */  0x33, 0x73, 0x3E, 0x84, 0xB3, 0xF1, 0xE8, 0x71,  // 3s>....q
            /* 13E0 */  0xA7, 0x10, 0xF0, 0x0D, 0xCE, 0xC0, 0xFF, 0xFF,  // ........
            /* 13E8 */  0x57, 0x46, 0xEC, 0xF5, 0x1F, 0x3B, 0x51, 0xCC,  // WF...;Q.
            /* 13F0 */  0xA9, 0x00, 0x7C, 0xC3, 0xF0, 0x89, 0x05, 0xF8,  // ..|.....
            /* 13F8 */  0xDC, 0x70, 0xC1, 0x71, 0xAD, 0xC3, 0x9E, 0x71,  // .p.q...q
            /* 1400 */  0x70, 0x17, 0x42, 0xC0, 0xCE, 0xB0, 0x78, 0x88,  // p.B...x.
            /* 1408 */  0x8F, 0x8A, 0xCF, 0x08, 0x54, 0x36, 0x0C, 0xEA,  // ....T6..
            /* 1410 */  0xE6, 0x07, 0x2E, 0x79, 0x97, 0x5D, 0x7A, 0xC6,  // ...y.]z.
            /* 1418 */  0xF7, 0xE0, 0xC1, 0xF0, 0xFF, 0x1F, 0x3C, 0xF6,  // ......<.
            /* 1420 */  0xB0, 0xC0, 0xA7, 0x8F, 0x1D, 0x3F, 0x60, 0x67,  // .....?`g
            /* 1428 */  0xA8, 0xB8, 0xFB, 0x25, 0x18, 0xA7, 0x8A, 0x1D,  // ...%....
            /* 1430 */  0x02, 0x0F, 0xBC, 0x22, 0x2A, 0xF5, 0x0C, 0xA0,  // ..."*...
            /* 1438 */  0x88, 0x30, 0xA8, 0x93, 0x93, 0xAF, 0xD0, 0x80,  // .0......
            /* 1440 */  0x93, 0x11, 0xE3, 0xEE, 0x92, 0x70, 0xA7, 0xFC,  // .....p..
            /* 1448 */  0x5A, 0xEF, 0x1B, 0x8E, 0xEF, 0x25, 0xA7, 0xCB,  // Z....%..
            /* 1450 */  0xFE, 0xFF, 0xD3, 0x65, 0x38, 0x0F, 0x28, 0xFC,  // ...e8.(.
            /* 1458 */  0x56, 0x0D, 0xE3, 0x2C, 0xF0, 0x08, 0xF0, 0x3E,  // V..,...>
            /* 1460 */  0xCF, 0x6F, 0xD5, 0x6F, 0xD1, 0x2F, 0x04, 0x4F,  // .o.o./.O
            /* 1468 */  0x57, 0x21, 0x5E, 0xB0, 0x9E, 0x0D, 0xDE, 0x7D,  // W!^....}
            /* 1470 */  0x62, 0x3C, 0x4E, 0x3F, 0x59, 0xC7, 0x09, 0xF3,  // b<N?Y...
            /* 1478 */  0xF8, 0xF3, 0x56, 0x6D, 0x8C, 0xA3, 0x89, 0x18,  // ..Vm....
            /* 1480 */  0xE5, 0xDC, 0x1E, 0x06, 0x22, 0x9F, 0x4B, 0x94,  // ....".K.
            /* 1488 */  0xF7, 0x8B, 0x17, 0x82, 0x88, 0xD1, 0x0C, 0x11,  // ........
            /* 1490 */  0x34, 0x46, 0xA0, 0x58, 0x81, 0xE2, 0xBD, 0x55,  // 4F.X...U
            /* 1498 */  0x33, 0xE1, 0xB7, 0x6A, 0x40, 0xCD, 0x81, 0x06,  // 3..j@...
            /* 14A0 */  0x7F, 0xAB, 0x06, 0xEE, 0xA7, 0x07, 0xDC, 0xAD,  // ........
            /* 14A8 */  0x1A, 0x6C, 0xA7, 0x14, 0xF8, 0xFF, 0xFF, 0x53,  // .l.....S
            /* 14B0 */  0x0A, 0x60, 0xE5, 0x46, 0x8E, 0x3B, 0xA5, 0x80,  // .`.F.;..
            /* 14B8 */  0x73, 0xB4, 0xF0, 0x46, 0xC1, 0xD5, 0xBD, 0x26,  // s..F...&
            /* 14C0 */  0x7C, 0x0E, 0xA2, 0x7A, 0x60, 0x50, 0x47, 0x21,  // |..z`PG!
            /* 14C8 */  0x70, 0xE5, 0x7E, 0xB3, 0x68, 0x10, 0x96, 0x78,  // p.~.h..x
            /* 14D0 */  0xAE, 0x44, 0x43, 0x7B, 0x4A, 0x6F, 0x22, 0x1E,  // .DC{Jo".
            /* 14D8 */  0xCF, 0x9B, 0xA1, 0xEF, 0x0D, 0xA1, 0x9F, 0xCD,  // ........
            /* 14E0 */  0x2C, 0xE7, 0x4C, 0x09, 0xAA, 0x87, 0xB7, 0x4F,  // ,.L....O
            /* 14E8 */  0x10, 0xF0, 0x2F, 0x25, 0x3E, 0x53, 0xC2, 0xE7,  // ../%>S..
            /* 14F0 */  0xF3, 0x28, 0x3D, 0x18, 0x43, 0xFA, 0x48, 0xC9,  // .(=.C.H.
            /* 14F8 */  0x41, 0x9E, 0x48, 0x1E, 0x2E, 0xD8, 0xFF, 0xFF,  // A.H.....
            /* 1500 */  0x36, 0x09, 0xFB, 0x8C, 0x72, 0x00, 0x18, 0x59,  // 6...r..Y
            /* 1508 */  0x37, 0x49, 0xF4, 0x41, 0x92, 0x63, 0xC4, 0xF5,  // 7I.A.c..
            /* 1510 */  0xAD, 0xD1, 0xF7, 0x61, 0x1F, 0x09, 0xCE, 0xE7,  // ...a....
            /* 1518 */  0x61, 0x10, 0x8C, 0x67, 0x3A, 0x8F, 0x9A, 0x1F,  // a..g:...
            /* 1520 */  0x58, 0xF8, 0xF8, 0x39, 0xF8, 0xFB, 0xC1, 0xD3,  // X..9....
            /* 1528 */  0xA5, 0x0F, 0x3B, 0x21, 0x1E, 0x7C, 0xF8, 0x99,  // ..;!.|..
            /* 1530 */  0x0E, 0x5C, 0x2A, 0xCE, 0x74, 0x40, 0xE2, 0x04,  // .\*.t@..
            /* 1538 */  0x0C, 0xE3, 0xB4, 0x80, 0x1B, 0x88, 0xCF, 0x7F,  // ........
            /* 1540 */  0xD8, 0x29, 0x9F, 0x08, 0x3B, 0xC0, 0x60, 0x46,  // .)..;.`F
            /* 1548 */  0x07, 0xAE, 0xB1, 0xF9, 0x94, 0x09, 0x7C, 0x34,  // ......|4
            /* 1550 */  0x3C, 0x6B, 0x74, 0xB4, 0xC0, 0xCF, 0xEC, 0xFF,  // <kt.....
            /* 1558 */  0xFF, 0xE8, 0xC1, 0x8E, 0x16, 0xB8, 0xBC, 0x47,  // .......G
            /* 1560 */  0x0B, 0x50, 0x0D, 0xCB, 0x43, 0x83, 0x7F, 0x73,  // .P..C..s
            /* 1568 */  0x79, 0xB4, 0x00, 0xC3, 0x51, 0x82, 0x9F, 0x0D,  // y...Q...
            /* 1570 */  0x7C, 0x94, 0xF0, 0xE9, 0x17, 0x7F, 0x82, 0xF1,  // |.......
            /* 1578 */  0xF1, 0x97, 0x7B, 0x03, 0xA6, 0x17, 0x0C, 0x2B,  // ..{....+
            /* 1580 */  0xA0, 0xD6, 0x01, 0x03, 0x6E, 0xE2, 0x61, 0xA0,  // ....n.a.
            /* 1588 */  0xB2, 0x1E, 0x70, 0xE9, 0x54, 0x9F, 0x8D, 0x3C,  // ..p.T..<
            /* 1590 */  0xF2, 0x67, 0x08, 0xB3, 0x1F, 0xD1, 0x6B, 0x99,  // .g....k.
            /* 1598 */  0x8F, 0x39, 0x3E, 0x9C, 0x18, 0x25, 0xA0, 0xCF,  // .9>..%..
            /* 15A0 */  0xBE, 0x0C, 0x10, 0x73, 0xEE, 0x37, 0x46, 0x40,  // ...s.7F@
            /* 15A8 */  0x58, 0x17, 0x19, 0x63, 0xC3, 0x42, 0x3A, 0xA4,  // X..c.B:.
            /* 15B0 */  0xE7, 0x4F, 0x86, 0xC5, 0x6F, 0x36, 0x41, 0x9F,  // .O..o6A.
            /* 15B8 */  0x1C, 0x8C, 0x84, 0xB9, 0x03, 0xF8, 0x70, 0x65,  // ......pe
            /* 15C0 */  0x20, 0x7E, 0x12, 0x78, 0x07, 0xF1, 0x0D, 0xEB,  //  ~.x....
            /* 15C8 */  0x14, 0x70, 0x67, 0x61, 0x76, 0x37, 0x32, 0x14,  // .pgav72.
            /* 15D0 */  0xBF, 0x28, 0xBC, 0x08, 0xF8, 0xCA, 0xC1, 0x6E,  // .(.....n
            /* 15D8 */  0x0C, 0xE0, 0xC3, 0x0A, 0x8C, 0xFD, 0xFF, 0xDF,  // ........
            /* 15E0 */  0x1A, 0xC1, 0x30, 0xFA, 0xE7, 0x24, 0x76, 0xE6,  // ..0..$v.
            /* 15E8 */  0xF2, 0x54, 0x5F, 0x1B, 0x01, 0xFF, 0xA1, 0xEF,  // .T_.....
            /* 15F0 */  0x8C, 0xA8, 0x98, 0xD7, 0x46, 0x40, 0xE1, 0xFF,  // ....F@..
            /* 15F8 */  0xFF, 0xDA, 0x08, 0xBC, 0xEE, 0x26, 0xAF, 0x8D,  // .....&..
            /* 1600 */  0x60, 0x17, 0x7F, 0x6D, 0x04, 0x68, 0x72, 0xF5,  // `..m.hr.
            /* 1608 */  0xC3, 0x5D, 0x1B, 0xC1, 0x76, 0x4C, 0x61, 0xFF,  // .]..vLa.
            /* 1610 */  0xFF, 0x63, 0x0A, 0xE0, 0xEC, 0x12, 0x45, 0x8E,  // .c....E.
            /* 1618 */  0x29, 0x20, 0x1E, 0x2E, 0xEC, 0x0B, 0x33, 0xE2,  // ) ....3.
            /* 1620 */  0x65, 0x40, 0x0F, 0x05, 0x8E, 0x08, 0x83, 0xBA,  // e@......
            /* 1628 */  0x38, 0x82, 0x2B, 0x0A, 0xA5, 0x40, 0x7D, 0xC2,  // 8.+..@}.
            /* 1630 */  0x00, 0xDC, 0xFC, 0xFF, 0x4F, 0x18, 0x3C, 0xD0,  // ....O.<.
            /* 1638 */  0xC8, 0xD0, 0xA3, 0xF0, 0xA8, 0x70, 0xF7, 0x3B,  // .....p.;
            /* 1640 */  0xF0, 0xDC, 0x59, 0x3C, 0x72, 0x0F, 0x0C, 0xF8,  // ..Y<r...
            /* 1648 */  0xC4, 0x1A, 0x18, 0xFA, 0x8C, 0x03, 0x77, 0x6C,  // ......wl
            /* 1650 */  0xE0, 0x3A, 0x95, 0x00, 0x87, 0xB1, 0xE1, 0xEF,  // .:......
            /* 1658 */  0x8D, 0x1E, 0x1B, 0x6E, 0x20, 0x3E, 0x4A, 0x3C,  // ...n >J<
            /* 1660 */  0xAF, 0xB1, 0xB3, 0x02, 0x0E, 0xFC, 0xEC, 0x5E,  // .......^
            /* 1668 */  0x8D, 0xF8, 0xE8, 0xC0, 0x05, 0xE8, 0xD1, 0x01,  // ........
            /* 1670 */  0x8F, 0xFF, 0xFF, 0x41, 0x00, 0xEE, 0xE8, 0x70,  // ...A...p
            /* 1678 */  0x07, 0x27, 0xCC, 0xD8, 0xC0, 0x26, 0x61, 0x6C,  // .'...&al
            /* 1680 */  0x40, 0x29, 0xDF, 0x65, 0x18, 0x0A, 0xF4, 0x2B,  // @).e...+
            /* 1688 */  0x26, 0x43, 0x7C, 0x45, 0xF1, 0xCD, 0xC3, 0x04,  // &C|E....
            /* 1690 */  0xB3, 0x5C, 0x31, 0x41, 0x33, 0x34, 0x83, 0x7A,  // .\1A34.z
            /* 1698 */  0x68, 0xF0, 0xCF, 0x7F, 0xE4, 0x8A, 0x09, 0xFD,  // h.......
            /* 16A0 */  0x7E, 0xE9, 0x03, 0x87, 0xCF, 0x57, 0x66, 0xF5,  // ~....Wf.
            /* 16A8 */  0x15, 0x13, 0xCE, 0xD9, 0x27, 0x42, 0x02, 0x67,  // ....'B.g
            /* 16B0 */  0xBC, 0x0F, 0x43, 0xCF, 0x34, 0x06, 0x54, 0x9A,  // ..C.4.T.
            /* 16B8 */  0x4B, 0x2F, 0x3D, 0xB1, 0x84, 0x38, 0xD1, 0xDE,  // K/=..8..
            /* 16C0 */  0x4F, 0x67, 0xF4, 0xB0, 0xE1, 0x63, 0xAF, 0x67,  // Og...c.g
            /* 16C8 */  0xFB, 0x68, 0xE0, 0x41, 0xFA, 0xC4, 0xC1, 0xEE,  // .h.A....
            /* 16D0 */  0xC4, 0xBE, 0x20, 0x3D, 0xC7, 0x18, 0xED, 0x3D,  // .. =...=
            /* 16D8 */  0xC2, 0xE7, 0x9D, 0x67, 0x4A, 0x23, 0x84, 0x63,  // ...gJ#.c
            /* 16E0 */  0x27, 0x38, 0x8F, 0xC4, 0x97, 0x4C, 0xFF, 0xFF,  // '8...L..
            /* 16E8 */  0xE7, 0xE9, 0x13, 0x0F, 0xF6, 0xE8, 0xC3, 0x8F,  // ........
            /* 16F0 */  0x6C, 0x0C, 0xDB, 0xD7, 0x01, 0x36, 0x2A, 0xDF,  // l....6*.
            /* 16F8 */  0x72, 0x8D, 0x6D, 0xD0, 0xC7, 0x2C, 0x4F, 0x9B,  // r.m..,O.
            /* 1700 */  0x5D, 0x28, 0xC1, 0x27, 0xE9, 0x48, 0x8B, 0xBE,  // ](.'.H..
            /* 1708 */  0xF6, 0x19, 0xF5, 0x81, 0xD4, 0x37, 0x61, 0x5F,  // .....7a_
            /* 1710 */  0x81, 0x9E, 0xB3, 0x3C, 0x1D, 0x4F, 0xC4, 0xB7,  // ...<.O..
            /* 1718 */  0x05, 0xA3, 0xBF, 0x23, 0xB0, 0xD8, 0x77, 0x04,  // ...#..w.
            /* 1720 */  0x50, 0xDD, 0x07, 0xF8, 0x1D, 0x01, 0xEE, 0x54,  // P......T
            /* 1728 */  0xDE, 0x11, 0xC0, 0xA0, 0xEF, 0x42, 0x40, 0x07,  // .....B@.
            /* 1730 */  0xEA, 0xF9, 0x79, 0xAC, 0x3E, 0xD2, 0xFA, 0x92,  // ..y.>...
            /* 1738 */  0xF0, 0x98, 0xC0, 0x60, 0x7C, 0xBD, 0x33, 0x86,  // ...`|.3.
            /* 1740 */  0x61, 0x3C, 0xD2, 0x30, 0x3E, 0x28, 0x70, 0x15,  // a<.0>(p.
            /* 1748 */  0xF7, 0x5A, 0xE8, 0xA9, 0xE7, 0x81, 0xCA, 0x7B,  // .Z.....{
            /* 1750 */  0x50, 0x80, 0x72, 0x23, 0xE8, 0xF2, 0x28, 0x8E,  // P.r#..(.
            /* 1758 */  0x1A, 0x9F, 0x4F, 0x03, 0xF6, 0x35, 0x59, 0xDD,  // ..O..5Y.
            /* 1760 */  0x57, 0x7D, 0x39, 0xF6, 0xA5, 0x83, 0xDD, 0x65,  // W}9....e
            /* 1768 */  0xD9, 0xDD, 0x90, 0xDD, 0xBD, 0xC2, 0xBD, 0xDC,  // ........
            /* 1770 */  0xFA, 0xD0, 0xE0, 0xEB, 0x82, 0xC7, 0x68, 0xD5,  // ......h.
            /* 1778 */  0x70, 0xD0, 0xAE, 0x06, 0x41, 0xFE, 0xFF, 0x0F,  // p...A...
            /* 1780 */  0x02, 0x3E, 0x72, 0x79, 0x5A, 0x46, 0x84, 0x71,  // .>ryZF.q
            /* 1788 */  0xF8, 0x65, 0x67, 0xC3, 0x38, 0xBE, 0xE9, 0xFA,  // .eg.8...
            /* 1790 */  0x54, 0xC0, 0x0E, 0x5B, 0xBE, 0x19, 0x18, 0xF8,  // T..[....
            /* 1798 */  0x41, 0xE1, 0x65, 0xDB, 0xC7, 0x07, 0x36, 0xB4,  // A.e...6.
            /* 17A0 */  0xB7, 0x05, 0x4F, 0x20, 0xD6, 0x9B, 0x03, 0x8C,  // ..O ....
            /* 17A8 */  0x93, 0x03, 0xF8, 0xB4, 0x3F, 0x14, 0x74, 0x10,  // ....?.t.
            /* 17B0 */  0xC7, 0x9F, 0x1C, 0x60, 0x1C, 0x16, 0x0C, 0x11,  // ...`....
            /* 17B8 */  0xFE, 0x1D, 0x80, 0x29, 0x84, 0xD6, 0xC1, 0x01,  // ...)....
            /* 17C0 */  0x3C, 0x1E, 0x0E, 0x0E, 0xA0, 0xB8, 0xF4, 0x90,  // <.......
            /* 17C8 */  0x83, 0x03, 0xF4, 0x10, 0x17, 0x04, 0x6A, 0xE5,  // ......j.
            /* 17D0 */  0xC6, 0x48, 0x8F, 0xD7, 0xE0, 0x39, 0x40, 0x70,  // .H...9@p
            /* 17D8 */  0x58, 0x43, 0xC4, 0x35, 0x46, 0x60, 0x63, 0x44,  // XC.5F`cD
            /* 17E0 */  0xF6, 0x31, 0x82, 0x61, 0xC4, 0x36, 0x46, 0x70,  // .1.a.6Fp
            /* 17E8 */  0x63, 0x44, 0xF7, 0x31, 0x82, 0xA1, 0x17, 0x8F,  // cD.1....
            /* 17F0 */  0x23, 0x8C, 0x08, 0xBE, 0x4A, 0x70, 0x2D, 0xA7,  // #...Jp-.
            /* 17F8 */  0x10, 0x5D, 0x25, 0xE0, 0x66, 0x5F, 0x99, 0x86,  // .]%.f_..
            /* 1800 */  0xC6, 0x53, 0x93, 0xE8, 0x2A, 0x81, 0xF9, 0xFF,  // .S..*...
            /* 1808 */  0x5F, 0x25, 0xF8, 0x45, 0xDA, 0x27, 0x59, 0x76,  // _%.E.'Yv
            /* 1810 */  0x9B, 0x80, 0x75, 0x73, 0xF1, 0x8D, 0xC8, 0xC7,  // ..us....
            /* 1818 */  0x17, 0xDC, 0x11, 0x86, 0x9D, 0xF4, 0x7D, 0xD6,  // ......}.
            /* 1820 */  0xC4, 0x9C, 0x20, 0x60, 0x9C, 0x1C, 0x70, 0x87,  // .. `..p.
            /* 1828 */  0x08, 0x70, 0x1D, 0x14, 0x18, 0xCA, 0x03, 0x0D,  // .p......
            /* 1830 */  0x47, 0x62, 0x70, 0xAF, 0x03, 0x11, 0x22, 0xC1,  // Gbp...".
            /* 1838 */  0x98, 0x14, 0xBB, 0x05, 0xFA, 0x78, 0xC3, 0xCE,  // .....x..
            /* 1840 */  0x13, 0x1E, 0x96, 0x6F, 0x18, 0xFC, 0xD2, 0xE3,  // ...o....
            /* 1848 */  0x2B, 0x38, 0x3B, 0x19, 0xF2, 0x8B, 0xE3, 0x43,  // +8;....C
            /* 1850 */  0x84, 0x51, 0xA2, 0xB1, 0x93, 0x43, 0x84, 0x93,  // .Q...C..
            /* 1858 */  0x7B, 0x0A, 0xF1, 0x99, 0xC3, 0x67, 0x38, 0xCC,  // {....g8.
            /* 1860 */  0x0D, 0xF2, 0xB8, 0x0E, 0xCA, 0xD7, 0x4B, 0x36,  // ......K6
            /* 1868 */  0x6C, 0xE3, 0x18, 0xF6, 0x39, 0xC8, 0x33, 0xF0,  // l...9.3.
            /* 1870 */  0x58, 0x62, 0x1F, 0x90, 0x21, 0xD9, 0xB0, 0xD8,  // Xb..!...
            /* 1878 */  0x10, 0x8D, 0xE7, 0xF3, 0x0D, 0xC3, 0x89, 0xE5,  // ........
            /* 1880 */  0x71, 0x62, 0x27, 0xC3, 0xB0, 0xCF, 0xD6, 0xD3,  // qb'.....
            /* 1888 */  0xE0, 0x07, 0x0D, 0xDF, 0x09, 0xDE, 0xD6, 0x31,  // .......1
            /* 1890 */  0xC7, 0x01, 0xDF, 0x42, 0x60, 0xDF, 0x14, 0x1E,  // ...B`...
            /* 1898 */  0x8F, 0x8C, 0xF2, 0x9E, 0xC2, 0x6E, 0x23, 0x60,  // .....n#`
            /* 18A0 */  0xFD, 0xFF, 0xDF, 0x46, 0x70, 0x47, 0xCF, 0xE7,  // ...FpG..
            /* 18A8 */  0x76, 0xF0, 0x40, 0xBC, 0xB3, 0x19, 0xFD, 0x79,  // v.@....y
            /* 18B0 */  0xEA, 0x9C, 0xD9, 0x1C, 0x8E, 0xC6, 0x63, 0xF0,  // ......c.
            /* 18B8 */  0x61, 0xC2, 0xE7, 0x57, 0xC0, 0xCD, 0xB0, 0xB8,  // a..W....
            /* 18C0 */  0xEC, 0xE7, 0xA2, 0x81, 0x7C, 0xE7, 0x90, 0x50,  // ....|..P
            /* 18C8 */  0x18, 0xD4, 0xE1, 0xCE, 0x47, 0x74, 0xC0, 0xC9,  // ....Gt..
            /* 18D0 */  0x79, 0x1C, 0xF6, 0x94, 0xDF, 0x60, 0x8C, 0xF0,  // y....`..
            /* 18D8 */  0xEC, 0x12, 0x38, 0xC6, 0x49, 0xBC, 0x88, 0xBC,  // ..8.I...
            /* 18E0 */  0xB8, 0x18, 0x3D, 0xD6, 0xF3, 0x38, 0xBB, 0x28,  // ..=..8.(
            /* 18E8 */  0x1C, 0x43, 0x28, 0x9F, 0x31, 0x42, 0xC4, 0x8A,  // .C(.1B..
            /* 18F0 */  0x62, 0xD4, 0x20, 0x8F, 0x0B, 0xFE, 0xFF, 0x83,  // b. .....
            /* 18F8 */  0x3C, 0xCB, 0x44, 0x38, 0x94, 0xB8, 0xC6, 0x7B,  // <.D8...{
            /* 1900 */  0x1E, 0x67, 0x22, 0x87, 0x4C, 0x0F, 0x7B, 0xE4,  // .g".L.{.
            /* 1908 */  0x1C, 0x0D, 0xB2, 0x63, 0x03, 0x60, 0xEE, 0x74,  // ...c.`.t
            /* 1910 */  0x80, 0x3B, 0x45, 0x83, 0x69, 0xB0, 0xB0, 0x07,  // .;E.i...
            /* 1918 */  0xC1, 0x15, 0xDA, 0xF4, 0xA9, 0xD1, 0xA8, 0x55,  // .......U
            /* 1920 */  0x83, 0x32, 0x35, 0xCA, 0x34, 0xA8, 0xD5, 0xA7,  // .25.4...
            /* 1928 */  0x52, 0x63, 0xC6, 0xA4, 0x1C, 0x04, 0x74, 0x80,  // Rc....t.
            /* 1930 */  0xF2, 0x6F, 0xC2, 0x31, 0x40, 0xE8, 0x5D, 0xCA,  // .o.1@.].
            /* 1938 */  0xA3, 0xF3, 0x89, 0xC2, 0x40, 0x16, 0x05, 0x22,  // ....@.."
            /* 1940 */  0x20, 0x07, 0x00, 0xA2, 0xA1, 0x40, 0x68, 0x48,  //  ....@hH
            /* 1948 */  0x30, 0x2A, 0x8B, 0x46, 0x40, 0x0E, 0x00, 0x42,  // 0*.F@..B
            /* 1950 */  0x43, 0x81, 0xD0, 0x90, 0x14, 0x3A, 0x97, 0x12,  // C....:..
            /* 1958 */  0x0A, 0x01, 0x59, 0x28, 0x08, 0x15, 0x0E, 0x42,  // ..Y(...B
            /* 1960 */  0xC3, 0x81, 0x50, 0xD5, 0x0F, 0x05, 0x81, 0xFA,  // ..P.....
            /* 1968 */  0xFF, 0x9F, 0x12, 0x44, 0x40, 0x4E, 0x0E, 0x42,  // ...D@N.B
            /* 1970 */  0x75, 0x7F, 0xC0, 0x04, 0x62, 0xB9, 0x1F, 0x40,  // u...b..@
            /* 1978 */  0x01, 0x3A, 0x1C, 0x88, 0x80, 0x1C, 0x18, 0x84,  // .:......
            /* 1980 */  0x7E, 0xBF, 0x0C, 0x62, 0xAD, 0x20, 0x74, 0xA5,  // ~..b. t.
            /* 1988 */  0x06, 0xB5, 0x14, 0x2D, 0x40, 0x4C, 0x1E, 0x08,  // ...-@L..
            /* 1990 */  0x95, 0x0B, 0x22, 0x30, 0x47, 0x03, 0xA2, 0x71,  // .."0G..q
            /* 1998 */  0x41, 0x68, 0x7C, 0x30, 0x2A, 0xD5, 0x0B, 0x10,  // Ah|0*...
            /* 19A0 */  0x93, 0x0F, 0x42, 0xE3, 0x80, 0xE8, 0x74, 0x40,  // ..B...t@
            /* 19A8 */  0x9E, 0x0D, 0x1A, 0x30, 0x01, 0xA1, 0x22, 0x41,  // ...0.."A
            /* 19B0 */  0x04, 0xE6, 0x58, 0x40, 0x34, 0x2A, 0x08, 0x8D,  // ..X@4*..
            /* 19B8 */  0x0E, 0x46, 0xA5, 0x9B, 0x19, 0x00, 0x05, 0xA1,  // .F......
            /* 19C0 */  0xF1, 0x40, 0x74, 0xFE, 0x26, 0x6A, 0x80, 0x98,  // .@t.&j..
            /* 19C8 */  0x44, 0x10, 0x2A, 0x19, 0x44, 0x60, 0x8E, 0x0A,  // D.*.D`..
            /* 19D0 */  0x44, 0xE3, 0x83, 0x50, 0x39, 0x6E, 0xC0, 0x58,  // D..P9n.X
            /* 19D8 */  0x04, 0x10, 0x1D, 0x09, 0x08, 0x08, 0x8D, 0x09,  // ........
            /* 19E0 */  0x42, 0xA5, 0xBC, 0x19, 0x04, 0x68, 0xF9, 0x20,  // B....h.
            /* 19E8 */  0x02, 0x72, 0x24, 0x10, 0x1A, 0x11, 0x8C, 0x8A,  // .r$.....
            /* 19F0 */  0xD5, 0x73, 0x24, 0xA0, 0x20, 0x34, 0x10, 0x88,  // .s$. 4..
            /* 19F8 */  0x86, 0x48, 0xFC, 0x0C, 0x91, 0x82, 0x50, 0x91,  // .H....P.
            /* 1A00 */  0x20, 0x02, 0xB3, 0x44, 0x45, 0x20, 0x2C, 0x20,  //  ..DE ,
            /* 1A08 */  0x08, 0x0D, 0xF5, 0x88, 0x11, 0xA0, 0x83, 0x82,  // ........
            /* 1A10 */  0xD0, 0xE0, 0x20, 0x1A, 0x38, 0xB1, 0x34, 0x70,  // .. .8.4p
            /* 1A18 */  0x0A, 0x42, 0xE3, 0x80, 0x08, 0xCC, 0xF1, 0x81,  // .B......
            /* 1A20 */  0xA8, 0x24, 0x4D, 0x03, 0xA5, 0x20, 0x1A, 0x06,  // .$M.. ..
            /* 1A28 */  0x31, 0x35, 0x0C, 0x0A, 0x42, 0x63, 0xB8, 0x02,  // 15..Bc..
            /* 1A30 */  0x64, 0xD1, 0x40, 0x68, 0x54, 0x10, 0x1D, 0x1F,  // d.@hT...
            /* 1A38 */  0xC8, 0xC3, 0x56, 0x40, 0x96, 0x0A, 0x42, 0xFF,  // ..V@..B.
            /* 1A40 */  0xFF, 0xD2, 0x41, 0x04, 0xE6, 0xC0, 0x40, 0x54,  // ..A...@T
            /* 1A48 */  0xC4, 0xBB, 0xE5, 0xF0, 0x18, 0x08, 0x15, 0x0B,  // ........
            /* 1A50 */  0x22, 0x40, 0x0B, 0x7E, 0x43, 0x09, 0xC4, 0x71,  // "@.~C..q
            /* 1A58 */  0x41, 0x68, 0xA8, 0xCF, 0x93, 0x86, 0x47, 0x40,  // Ah....G@
            /* 1A60 */  0x68, 0x70, 0x10, 0x81, 0x59, 0xE8, 0x0F, 0x4F,  // hp..Y..O
            /* 1A68 */  0x40, 0x16, 0x0F, 0x42, 0xC3, 0x80, 0xD0, 0x90,  // @..B....
            /* 1A70 */  0x20, 0xF4, 0x5D, 0xE2, 0xA3, 0x06, 0xF9, 0xE5,  //  .].....
            /* 1A78 */  0xE9, 0x38, 0x40, 0x40, 0xA8, 0xD8, 0x5F, 0x9F,  // .8@@.._.
            /* 1A80 */  0x8E, 0x00, 0x04, 0x84, 0x06, 0x02, 0xD1, 0x11,  // ........
            /* 1A88 */  0x80, 0xA8, 0x1B, 0x14, 0x05, 0xA1, 0x22, 0x41,  // ......"A
            /* 1A90 */  0x04, 0xE6, 0x40, 0x40, 0x34, 0x24, 0x08, 0x0D,  // ..@@4$..
            /* 1A98 */  0x0D, 0x46, 0xC5, 0xBA, 0x1B, 0x02, 0x05, 0xA1,  // .F......
            /* 1AA0 */  0x81, 0x40, 0x68, 0x50, 0x10, 0x1D, 0x3B, 0x88,  // .@hP..;.
            /* 1AA8 */  0xBC, 0x63, 0x07, 0x05, 0xA1, 0xC2, 0x41, 0x04,  // .c....A.
            /* 1AB0 */  0x66, 0xE1, 0xFE, 0x40, 0x58, 0x6C, 0x10, 0xAA,  // f..@Xl..
            /* 1AB8 */  0xE9, 0xAF, 0x12, 0x90, 0xE8, 0x03, 0xA1, 0x9A,  // ........
            /* 1AC0 */  0x41, 0x64, 0x64, 0x18, 0x06, 0x11, 0xA0, 0xB3,  // Add.....
            /* 1AC8 */  0x82, 0xD1, 0xDC, 0x20, 0x54, 0xCB, 0x97, 0x48,  // ... T..H
            /* 1AD0 */  0x80, 0x16, 0x06, 0xA2, 0x03, 0x01, 0x01, 0xD1,  // ........
            /* 1AD8 */  0xE1, 0x81, 0x80, 0xD0, 0x98, 0x80, 0x34, 0x33,  // ......43
            /* 1AE0 */  0x20, 0x4D, 0xF4, 0xD2, 0x11, 0x98, 0xF3, 0x81,  //  M......
            /* 1AE8 */  0x50, 0x1D, 0x9F, 0x9A, 0x20, 0x24, 0x36, 0x88,  // P... $6.
            /* 1AF0 */  0x40, 0x2D, 0xE2, 0x5D, 0x13, 0x94, 0x84, 0x00,  // @-.]....
            /* 1AF8 */  0xD1, 0x11, 0x81, 0x80, 0xD0, 0xC0, 0x20, 0xF4,  // ...... .
            /* 1B00 */  0x6D, 0x66, 0x10, 0x27, 0x03, 0xA1, 0x29, 0x41,  // mf.'..)A
            /* 1B08 */  0x68, 0x72, 0x10, 0x0D, 0xC0, 0x32, 0x1E, 0x57,  // hr...2.W
            /* 1B10 */  0x1A, 0x80, 0xD5, 0x83, 0x08, 0xCC, 0x49, 0x40,  // ......I@
            /* 1B18 */  0x68, 0x3A, 0x10, 0x01, 0x3A, 0x2A, 0x20, 0xFD,  // h:..:* .
            /* 1B20 */  0xFF, 0x07, 0x51, 0x79, 0xDC, 0xA0, 0x20, 0x34,  // ..Qy.. 4
            /* 1B28 */  0x3E, 0x08, 0x4D, 0xFB, 0x62, 0x14, 0xA8, 0xB3,  // >.M.b...
            /* 1B30 */  0x83, 0x08, 0xD4, 0xDA, 0xDF, 0x3B, 0xC1, 0x48,  // .....;.H
            /* 1B38 */  0x22, 0x10, 0x9A, 0x13, 0x84, 0xE6, 0x06, 0xA1,  // ".......
            /* 1B40 */  0x41, 0x1E, 0x48, 0x8F, 0x34, 0x0C, 0x84, 0x06,  // A.H.4...
            /* 1B48 */  0x05, 0xD1, 0x00, 0x9C, 0x1A, 0x44, 0x03, 0x70,  // .....D.p
            /* 1B50 */  0xA6, 0x97, 0x52, 0x30, 0x92, 0x10, 0x84, 0xE6,  // ..R0....
            /* 1B58 */  0x07, 0xA1, 0x8A, 0x5F, 0x47, 0x41, 0x89, 0x7E,  // ..._GA.~
            /* 1B60 */  0x10, 0x81, 0x3A, 0x3F, 0x88, 0xC0, 0xAC, 0xEA,  // ..:?....
            /* 1B68 */  0x3D, 0xA5, 0xA3, 0x0C, 0x01, 0xA1, 0xDA, 0x41,  // =......A
            /* 1B70 */  0xA8, 0xAE, 0x27, 0x51, 0x50, 0x92, 0x0A, 0x84,  // ..'QP...
            /* 1B78 */  0x26, 0xFD, 0x17, 0x05, 0x21, 0x3A, 0xDF, 0x7C,  // &...!:.|
            /* 1B80 */  0x87, 0xC2, 0x40, 0x34, 0x30, 0x02, 0x42, 0x73,  // ..@40.Bs
            /* 1B88 */  0x83, 0x51, 0x69, 0x6A, 0x8F, 0x35, 0x14, 0x44,  // .Qij.5.D
            /* 1B90 */  0x83, 0xB1, 0x76, 0x10, 0x81, 0x39, 0x31, 0x18,  // ..v..91.
            /* 1B98 */  0x55, 0xE1, 0x16, 0x8C, 0x49, 0x02, 0x11, 0x98,  // U...I...
            /* 1BA0 */  0xB3, 0x80, 0xE8, 0x60, 0x40, 0xC0, 0x68, 0x58,  // ...`@.hX
            /* 1BA8 */  0x30, 0x2A, 0xF4, 0x43, 0xF5, 0xA0, 0xC1, 0x40,  // 0*.C...@
            /* 1BB0 */  0x04, 0xE6, 0x24, 0x20, 0x3A, 0xF0, 0x10, 0xBB,  // ..$ :...
            /* 1BB8 */  0x07, 0x1E, 0x0A, 0x22, 0x30, 0x6B, 0x05, 0x11,  // ..."0k..
            /* 1BC0 */  0x98, 0x83, 0x82, 0xD1, 0xF0, 0x60, 0x54, 0x89,  // .....`T.
            /* 1BC8 */  0x5E, 0x30, 0x96, 0x1A, 0x44, 0x60, 0x56, 0xFB,  // ^0..D`V.
            /* 1BD0 */  0x82, 0x7A, 0xF4, 0x60, 0x3F, 0xA8, 0x80, 0x24,  // .z.`?..$
            /* 1BD8 */  0x1A, 0x88, 0x06, 0x47, 0xFE, 0xD5, 0x02, 0xB3,  // ...G....
            /* 1BE0 */  0x60, 0x10, 0x1A, 0x03, 0x84, 0xC6, 0x02, 0xA1,  // `.......
            /* 1BE8 */  0x92, 0x1F, 0x8A, 0x3A, 0x9E, 0x10, 0x10, 0x1A,  // ...:....
            /* 1BF0 */  0xF7, 0x43, 0x15, 0x8C, 0x48, 0xF8, 0x75, 0xEA,  // .C..H.u.
            /* 1BF8 */  0xE0, 0x42, 0x40, 0x74, 0x80, 0x20, 0x40, 0x34,  // .B@t. @4
            /* 1C00 */  0x18, 0x08, 0x0D, 0x0A, 0xC8, 0xDF, 0x64, 0x02,  // ......d.
            /* 1C08 */  0xF4, 0xFF, 0x3F, 0x04, 0x88, 0x00, 0x09, 0x08,  // ..?.....
            /* 1C10 */  0x0D, 0x0A, 0x42, 0x15, 0x3D, 0xEB, 0x1E, 0x0E,  // ..B.=...
            /* 1C18 */  0x18, 0x88, 0x40, 0xAD, 0xEB, 0x05, 0xFD, 0x50,  // ..@....P
            /* 1C20 */  0xC0, 0x40, 0xA8, 0x76, 0x10, 0x81, 0x39, 0x33,  // .@.v..93
            /* 1C28 */  0x10, 0xD5, 0xF1, 0x87, 0x7D, 0x30, 0x60, 0x20,  // ....}0`
            /* 1C30 */  0x34, 0x04, 0x08, 0xD5, 0xF8, 0xBC, 0x13, 0xA8,  // 4.......
            /* 1C38 */  0xF3, 0x80, 0x08, 0xC8, 0x19, 0x41, 0x68, 0x66,  // .....Ahf
            /* 1C40 */  0x30, 0xAA, 0xF4, 0xF5, 0x15, 0x88, 0xA8, 0x07,  // 0.......
            /* 1C48 */  0xA1, 0x69, 0x40, 0x68, 0x4A, 0x10, 0x01, 0x5A,  // .i@hJ..Z
            /* 1C50 */  0xD9, 0x8B, 0x54, 0x43, 0x27, 0x20, 0x54, 0x3D,  // ..TC' T=
            /* 1C58 */  0x88, 0xC0, 0x9C, 0xFE, 0x07, 0xA8, 0x63, 0x05,  // ......c.
            /* 1C60 */  0x79, 0x8A, 0x09, 0xC4, 0xCA, 0xFF, 0x6C, 0x07,  // y.....l.
            /* 1C68 */  0xC0, 0x40, 0x68, 0x3A, 0x10, 0x9A, 0x1F, 0x84,  // .@h:....
            /* 1C70 */  0x6A, 0x7D, 0x96, 0x05, 0x25, 0xF9, 0x40, 0x34,  // j}..%.@4
            /* 1C78 */  0x20, 0x02, 0x42, 0x35, 0x7C, 0x46, 0x0F, 0x80,  //  .B5|F..
            /* 1C80 */  0x81, 0x68, 0x00, 0x04, 0x84, 0xA6, 0x03, 0xA3,  // .h......
            /* 1C88 */  0x6A, 0xDE, 0xC2, 0x81, 0x88, 0x42, 0x10, 0xAA,  // j....B..
            /* 1C90 */  0x18, 0x84, 0xE6, 0x03, 0xA1, 0x01, 0xDF, 0xF5,  // ........
            /* 1C98 */  0x3A, 0x30, 0x90, 0xEF, 0x9F, 0x0E, 0x21, 0x04,  // :0....!.
            /* 1CA0 */  0x84, 0xC6, 0xF1, 0x7F, 0x18, 0xA3, 0x20, 0x34,  // ...... 4
            /* 1CA8 */  0x2C, 0x88, 0xC0, 0x2C, 0x2C, 0xC0, 0x31, 0x88,  // ,..,,.1.
            /* 1CB0 */  0x82, 0x50, 0xF1, 0x20, 0x3A, 0x20, 0x10, 0x20,  // .P. : .
            /* 1CB8 */  0x2A, 0xA1, 0xC0, 0xC1, 0x80, 0x82, 0x68, 0x10,  // *.....h.
            /* 1CC0 */  0x04, 0x88, 0x86, 0x03, 0xA1, 0x61, 0xC1, 0xA8,  // .....a..
            /* 1CC8 */  0xBC, 0x04, 0x47, 0x06, 0x0A, 0x42, 0x23, 0x80,  // ..G..B#.
            /* 1CD0 */  0x08, 0xCC, 0x91, 0x81, 0xA8, 0x8C, 0x06, 0xC3,  // ........
            /* 1CD8 */  0xA3, 0x11, 0xC0, 0x58, 0x32, 0x10, 0x1D, 0x53,  // ...X2..S
            /* 1CE0 */  0x08, 0x08, 0xD5, 0x9C, 0x01, 0x8C, 0xFD, 0xFF,  // ........
            /* 1CE8 */  0x93, 0x82, 0x08, 0xC8, 0xE9, 0x41, 0x68, 0xDC,  // .....Ah.
            /* 1CF0 */  0x12, 0x60, 0xEC, 0xFF, 0x0F                     // .`...
        })
        Name (SBUF, Buffer (0x1000){})
        Method (GHBE, 4, Serialized)
        {
            Local6 = SizeOf (Arg0)
            Local0 = DerefOf (Arg1)
            Local7 = 0x04
            If (((Local0 + 0x02) < Local6))
            {
                Local1 = DerefOf (Arg0 [Local0])
                Local0++
                Local2 = DerefOf (Arg0 [Local0])
                Local0++
                If ((Local2 & 0x80))
                {
                    Local3 = (Local2 & 0x7F)
                    If ((Local3 <= 0x04))
                    {
                        Local2 = B2I4 (Arg0, Local0, Local3)
                        Local0 += Local3
                    }
                    Else
                    {
                        Local2 = Local6
                    }
                }

                If (((Local0 + Local2) < Local6))
                {
                    Local7 = Zero
                }

                Arg1 = Local0
                Arg2 = Local1
                Arg3 = Local2
            }

            Return (Local7)
        }

        Method (UPRP, 4, Serialized)
        {
            Local6 = SizeOf (Arg1)
            Local0 = DerefOf (Arg2)
            If ((Local0 < Local6))
            {
                Local7 = Zero
                Arg1 [Local0] = Arg0
                If (Arg3)
                {
                    Local0++
                    Arg2 = Local0
                }
            }
            Else
            {
                Local7 = 0x04
            }

            Return (Local7)
        }

        Method (WHIB, 5, Serialized)
        {
            Local0 = DerefOf (Arg1)
            Local1 = DerefOf (Arg3)
            If ((Arg4 > 0x04))
            {
                Local7 = 0x04
            }
            Else
            {
                Local2 = B2I4 (Arg0, Local0, Arg4)
                Local0 += Arg4
                Local7 = UPRP (Local2, Arg2, RefOf (Local1), Ones)
            }

            Arg1 = Local0
            Arg3 = Local1
            Return (Local7)
        }

        Method (AFUL, 3, Serialized)
        {
            Local0 = DerefOf (Arg1)
            Local3 = (Local0 + Arg2)
            Local2 = (Arg2 >> One)
            Local4 = Buffer (Local2){}
            Local1 = Zero
            Local7 = One
            While (((Local0 < Local3) && (Local1 < Local2)))
            {
                Local5 = DerefOf (Arg0 [Local0])
                Local0 += 0x02
                If ((Local7 && (Local5 != Zero)))
                {
                    Local4 [Local1] = Local5
                    Local1++
                }
                Else
                {
                    Local7 = Zero
                }
            }

            Local6 = B2ST (Local4, Local1)
            Arg1 = Local0
            Return (Local6)
        }

        Method (WHSB, 5, Serialized)
        {
            Local0 = DerefOf (Arg1)
            Local1 = DerefOf (Arg3)
            Local6 = AFUL (Arg0, RefOf (Local0), Arg4)
            Local7 = UPRP (Local6, Arg2, RefOf (Local1), Ones)
            Arg1 = Local0
            Arg3 = Local1
            Return (Local7)
        }

        Method (WHNS, 4, Serialized)
        {
            Local0 = DerefOf (Arg1)
            Local1 = DerefOf (Arg3)
            Local7 = GHBE (Arg0, RefOf (Local0), RefOf (Local2), RefOf (Local3))
            If (((Local7 == Zero) && ((Local0 + Local3) < SizeOf (Arg0))))
            {
                If ((Local2 == 0x02))
                {
                    Local7 = WHIB (Arg0, RefOf (Local0), Arg2, RefOf (Local1), Local3)
                }
                ElseIf ((Local2 == 0x1E))
                {
                    Local7 = WHSB (Arg0, RefOf (Local0), Arg2, RefOf (Local1), Local3)
                }
                Else
                {
                    Local7 = 0x04
                }

                Arg1 = Local0
                Arg3 = Local1
            }

            Return (Local7)
        }

        Method (WHSQ, 4, Serialized)
        {
            Local0 = DerefOf (Arg1)
            Local1 = DerefOf (Arg3)
            Local7 = GHBE (Arg0, RefOf (Local0), RefOf (Local2), RefOf (Local3))
            If ((Local7 == Zero))
            {
                Local4 = Local1
                Local1++
                Local2 = Zero
                Local3 += Local0
                While (((Local7 == Zero) && (Local0 < Local3)))
                {
                    Local7 = WHNS (Arg0, RefOf (Local0), Arg2, RefOf (Local1))
                    If ((Local7 == Zero))
                    {
                        Local2++
                    }
                }

                If ((Local7 == Zero))
                {
                    Local7 = UPRP (Local2, Arg2, RefOf (Local4), Zero)
                }

                Arg1 = Local0
                Arg3 = Local1
            }

            Return (Local7)
        }

        Method (QPUW, 4, Serialized)
        {
            Local4 = Package (0x02)
                {
                    0x04,
                    Zero
                }
            If ((Arg1 >= Arg2))
            {
                Return (Local4)
            }

            Acquire (PUMX, 0xFFFF)
            PWOT = Arg0
            PWOI = Arg1
            PUWS = 0x04
            GSWS (0x01F3)
            Local7 = PUWS /* \PUWS */
            If ((Local7 == Zero))
            {
                Local0 = Zero
                Local1 = Zero
                Local6 = PUWB /* \PUWB */
                Local7 = GHBE (Local6, RefOf (Local0), RefOf (Local3), RefOf (Local2))
                If (((Local7 == Zero) && (Local3 == 0x30)))
                {
                    Local2 += Local0
                    While (((Local7 == Zero) && (Local0 < Local2)))
                    {
                        If ((DerefOf (Local6 [Local0]) == 0x30))
                        {
                            Local7 = WHSQ (Local6, RefOf (Local0), Arg3, RefOf (Local1))
                        }
                        Else
                        {
                            Local7 = WHNS (Local6, RefOf (Local0), Arg3, RefOf (Local1))
                        }
                    }

                    Local4 [One] = Local1
                    While (((Local7 == Zero) && (Local1 < SizeOf (Arg3))))
                    {
                        Arg3 [Local1] = ""
                        Local1++
                    }
                }
                Else
                {
                    Local7 = 0x04
                }
            }

            Release (PUMX)
            Local4 [Zero] = Local7
            Return (Local4)
        }

        Method (WQST, 1, Serialized)
        {
            Name (QURT, Package (0x32){})
            Local0 = QPUW (Zero, Arg0, STIC, QURT)
            If ((DerefOf (Local0 [Zero]) == Zero))
            {
                Return (QURT) /* \_SB_.WMIB.WQST.QURT */
            }
            Else
            {
                Return (WDST) /* \_SB_.WMIB.WDST */
            }
        }

        Method (WQIN, 1, Serialized)
        {
            Name (QURT, Package (0x32){})
            Local0 = QPUW (One, Arg0, INIC, QURT)
            If ((DerefOf (Local0 [Zero]) == Zero))
            {
                Return (QURT) /* \_SB_.WMIB.WQIN.QURT */
            }
            Else
            {
                Return (WDIN) /* \_SB_.WMIB.WDIN */
            }
        }

        Method (WQEN, 1, Serialized)
        {
            Name (QURT, Package (0x32){})
            Local0 = QPUW (0x02, Arg0, ENIC, QURT)
            If ((DerefOf (Local0 [Zero]) == Zero))
            {
                Return (QURT) /* \_SB_.WMIB.WQEN.QURT */
            }
            Else
            {
                Return (WDEN) /* \_SB_.WMIB.WDEN */
            }
        }

        Method (WQOL, 1, Serialized)
        {
            Name (QURT, Package (0x32){})
            Local0 = QPUW (0x03, Arg0, OLIC, QURT)
            If ((DerefOf (Local0 [Zero]) == Zero))
            {
                Local1 = DerefOf (Local0 [One])
                Local1++
                Local3 = Zero
                TBUF = DerefOf (QURT [One])
                While (((Local3 < SizeOf (TBUF)) && (Local1 < SizeOf (QURT))))
                {
                    Local5 = Zero
                    While (((Local3 < SizeOf (TBUF)) && (Local5 < SizeOf (SBUF))))
                    {
                        Local7 = DerefOf (TBUF [Local3])
                        Local3++
                        If ((Local7 < 0x20))
                        {
                            Local3 = SizeOf (TBUF)
                        }
                        ElseIf ((Local7 != 0x2C))
                        {
                            SBUF [Local5] = Local7
                            Local5++
                        }
                        Else
                        {
                            Break
                        }
                    }

                    If ((Local5 > Zero))
                    {
                        If ((Local5 < SizeOf (SBUF)))
                        {
                            SBUF [Local5] = Zero
                            Local5++
                        }

                        QURT [Local1] = B2ST (SBUF, Local5)
                        Local1++
                    }
                }

                Local2 = DerefOf (Local0 [One])
                Local1--
                QURT [Local2] = (Local1 - Local2)
                Return (QURT) /* \_SB_.WMIB.WQOL.QURT */
            }
            Else
            {
                Return (WDLI) /* \_SB_.WMIB.WDLI */
            }
        }

        Method (WQPW, 1, Serialized)
        {
            Name (QURT, Package (0x32){})
            Local0 = QPUW (0x04, Arg0, PWIC, QURT)
            If ((DerefOf (Local0 [Zero]) == Zero))
            {
                Return (QURT) /* \_SB_.WMIB.WQPW.QURT */
            }
            Else
            {
                Return (WDPA) /* \_SB_.WMIB.WDPA */
            }
        }

        Method (WQBU, 1, Serialized)
        {
            Name (QURT, Package (0x32){})
            Local0 = QPUW (0x05, Arg0, BUIC, QURT)
            If ((DerefOf (Local0 [Zero]) == Zero))
            {
                Return (QURT) /* \_SB_.WMIB.WQBU.QURT */
            }
            Else
            {
                Return (WDBU) /* \_SB_.WMIB.WDBU */
            }
        }

        Name (TBUF, Buffer (0x2800){})
        Method (SHBE, 4, Serialized)
        {
            Local6 = SizeOf (Arg2)
            Local0 = DerefOf (Arg3)
            If (((Local0 + 0x04) < Local6))
            {
                Arg2 [Local0] = Arg0
                Local0++
                Arg2 [Local0] = 0x82
                Local0++
                CreateWordField (Arg2, Local0, SSIZ)
                SSIZ = Arg1
                Local0 += 0x02
                If (((Local0 + Arg1) < Local6))
                {
                    Local7 = Zero
                }

                Arg3 = Local0
            }
            Else
            {
                Local7 = 0x04
            }

            Return (Local7)
        }

        Method (WSTB, 4, Serialized)
        {
            Local0 = Zero
            Local1 = SizeOf (Arg0)
            Local2 = Zero
            Local7 = SHBE (0x30, One, Arg1, RefOf (Local2))
            Local3 = Zero
            While (((Local7 == Zero) && (Local0 < Local1)))
            {
                Local5 = DerefOf (Arg0 [Local0])
                Local0++
                Local5 += (DerefOf (Arg0 [Local0]) << 0x08)
                Local0++
                Local6 = (Local5 + 0x02)
                Local7 = SHBE (0x1E, Local6, Arg1, RefOf (Local2))
                Local4 = (Local0 + Local5)
                If ((Local4 <= Local1))
                {
                    While ((Local0 < Local4))
                    {
                        Arg1 [Local2] = DerefOf (Arg0 [Local0])
                        Local0++
                        Local2++
                    }

                    Arg1 [Local2] = Zero
                    Local2++
                    Arg1 [Local2] = Zero
                    Local2++
                    Local3++
                }
                Else
                {
                    Local7 = 0x04
                }
            }

            If ((Local7 == Zero))
            {
                If (((Local3 >= Arg2) && (Local3 <= Arg3)))
                {
                    CreateWordField (Arg1, 0x02, BSIZ)
                    BSIZ = (Local2 - 0x04)
                }
                Else
                {
                    Local7 = 0x05
                }
            }

            Return (Local7)
        }

        Name (BNSD, Package (0x01)
        {
            ""
        })
        Method (BSNS, 1, Serialized)
        {
            Local0 = Zero
            CreateWordField (Arg0, Local0, SSIZ)
            Local0 += 0x02
            BNSD [Zero] = AFUL (Arg0, RefOf (Local0), SSIZ)
        }

        Method (BGNS, 0, Serialized)
        {
            Return (DerefOf (BNSD [Zero]))
        }

        Method (WSBS, 1, Serialized)
        {
            Acquire (PUMX, 0xFFFF)
            Local7 = WSTB (Arg0, TBUF, 0x02, 0x03)
            PUWB = TBUF /* \_SB_.WMIB.TBUF */
            If ((Local7 == Zero))
            {
                BSNS (Arg0)
                PUWS = 0x04
                GSWS (0x02F3)
                Local7 = PUWS /* \PUWS */
                If ((Local7 == Zero))
                {
                    GBME (Zero)
                }
                ElseIf ((Local7 == 0x06))
                {
                    GBME (One)
                }
            }

            Release (PUMX)
            Return (Local7)
        }

        Method (WSSD, 1, Serialized)
        {
            Acquire (PUMX, 0xFFFF)
            Local7 = WSTB (Arg0, TBUF, 0x02, 0x02)
            PUWB = TBUF /* \_SB_.WMIB.TBUF */
            If ((Local7 == Zero))
            {
                PUWS = 0x04
                GSWS (0x03F3)
                Local7 = PUWS /* \PUWS */
                If ((Local7 == Zero))
                {
                    GBME (Zero)
                }
                ElseIf ((Local7 == 0x06))
                {
                    GBME (One)
                }
            }

            Release (PUMX)
            Return (Local7)
        }

        Method (WFTE, 1, Serialized)
        {
            Local7 = 0x04
            Return (Local7)
        }

        Method (WMBS, 3, Serialized)
        {
            Local7 = One
            If ((Arg1 == One))
            {
                Local7 = WSBS (Arg2)
            }
            ElseIf ((Arg1 == 0x02))
            {
                Local7 = WSSD (Arg2)
            }
            ElseIf ((Arg1 == 0x03))
            {
                Local7 = WFTE (Arg2)
            }

            Return (Local7)
        }

        Method (WMUI, 3, Serialized)
        {
            Local7 = One
            If ((Arg1 == One))
            {
                Acquire (PUMX, 0xFFFF)
                Local7 = WSTB (Arg0, TBUF, 0x06, 0x06)
                PUWB = TBUF /* \_SB_.WMIB.TBUF */
                If ((Local7 == Zero))
                {
                    PUWS = 0x04
                    Local7 = PUWS /* \PUWS */
                }

                Release (PUMX)
            }

            Return (Local7)
        }

        Name (CBWE, Package (0x02)
        {
            Package (0x05)
            {
                "BIOS Configuration Change",
                "BIOS Settings",
                0x04,
                0x05,
                0x02
            },

            Package (0x05)
            {
                "BIOS Configuration Security",
                "An attempt has been made to Access BIOS features unsuccessfully",
                0x04,
                0x0A,
                0x06
            }
        })
        Name (UKEV, Package (0x05)
        {
            "Unknown Event",
            "Unknown event type",
            Zero,
            Zero,
            Zero
        })
        Mutex (BEMX, 0x00)
        Name (BEID, 0xFF)
        Method (_WED, 1, Serialized)  // _Wxx: Wake Event, xx=0x00-0xFF
        {
            Acquire (BEMX, 0xFFFF)
            Local0 = BEID /* \_SB_.WMIB.BEID */
            BEID = 0xFF
            Release (BEMX)
            Switch (ToInteger (Local0))
            {
                Case (Zero)
                {
                    DerefOf (CBWE [Local0]) [One] = BGNS ()
                    Local1 = DerefOf (CBWE [Local0])
                }
                Case (One)
                {
                    Local1 = DerefOf (CBWE [Local0])
                }
                Default
                {
                    Local1 = UKEV /* \_SB_.WMIB.UKEV */
                }

            }

            Return (Local1)
        }

        Method (GBME, 1, Serialized)
        {
            Acquire (BEMX, 0xFFFF)
            BEID = Arg0
            Release (BEMX)
            Notify (WMIB, 0x80) // Status Change
        }

        Name (PEVT, Package (0x07)
        {
            "",
            "",
            "root\\wmi",
            "HPBIOS_BIOSEvent",
            Zero,
            Zero,
            Zero
        })
        Method (WQPE, 1, Serialized)
        {
            PEVT [Zero] = DerefOf (DerefOf (CBWE [Arg0]) [
                Zero])
            PEVT [One] = DerefOf (DerefOf (CBWE [Arg0]) [
                One])
            PEVT [0x04] = DerefOf (DerefOf (CBWE [Arg0]) [
                0x02])
            PEVT [0x05] = DerefOf (DerefOf (CBWE [Arg0]) [
                0x03])
            PEVT [0x06] = DerefOf (DerefOf (CBWE [Arg0]) [
                0x04])
            Return (PEVT) /* \_SB_.WMIB.PEVT */
        }

        OperationRegion (HWSS, SystemMemory, 0x7EF85000, 0x00000802)
        Field (HWSS, AnyAcc, Lock, Preserve)
        {
            WSSC,   16,
            WSSB,   16384
        }

        Name (SENS, Package (0x08)
        {
            "BIOS Post Error",
            " ",
            One,
            "BIOS Post Error",
            One,
            One,
            "Post Error Occurred",
            "Post Error Occurred"
        })
        Method (WQSS, 1, Serialized)
        {
            Local7 = Zero
            Local5 = Zero
            Local0 = WSSB /* \_SB_.WMIB.WSSB */
            While (((Local5 < 0x0800) && (Local7 < Arg0)))
            {
                Local1 = (DerefOf (Local0 [Local5]) + 0x02)
                Local5 += Local1
                Local7++
            }

            If (((Local5 < 0x0800) && (Local7 == Arg0)))
            {
                Local3 = DerefOf (Local0 [Local5])
                Local2 = Buffer (Local3){}
                Local5++
                Local6 = Zero
                While (((Local5 < 0x0800) && (Local6 < Local3)))
                {
                    Local2 [Local6] = DerefOf (Local0 [Local5])
                    Local6++
                    Local5++
                }

                SENS [One] = B2ST (Local2, Local3)
                SENS [0x04] = DerefOf (Local0 [Local5])
            }
            Else
            {
                SENS [One] = "Unknown Error"
                SENS [0x04] = Zero
            }

            Return (SENS) /* \_SB_.WMIB.SENS */
        }
    }

    OperationRegion (HPWV, SystemMemory, 0x7EF8B000, 0x0000107C)
    Field (HPWV, AnyAcc, Lock, Preserve)
    {
        SNIN,   32,
        COMD,   32,
        CMTP,   32,
        DASI,   32,
        DASO,   32,
        PVWB,   33536,
        PVWS,   32,
        RTCD,   32
    }

    Device (_SB.WMIV)
    {
        Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
        Name (_UID, 0x02)  // _UID: Unique ID
        Name (BORN, Buffer (0x08){})
        Method (FBCD, 3, Serialized)
        {
            Local2 = Package (0x01)
                {
                    0x04
                }
            CreateByteField (Arg2, Zero, FCIP)
            If ((Arg0 == Zero))
            {
                Switch (FCIP)
                {
                    Case (0x08)
                    {
                        Local6 = 0x11
                    }
                    Case (0x0A)
                    {
                        Local6 = 0x02
                    }
                    Default
                    {
                        Local6 = One
                    }

                }

                Local2 = FSEC (Arg2, Local6, FCIP)
            }

            If ((Arg0 == One))
            {
                Local2 = FGIF (FCIP)
            }

            If ((Arg0 == 0x02))
            {
                Local2 = FGAE (FCIP)
            }

            If ((Arg0 == 0x03))
            {
                Local2 = FGAU (FCIP)
            }

            If ((Arg0 == 0x04))
            {
                Local2 = FGFS ()
            }

            If ((Arg0 == 0x05))
            {
                Local2 = FBPS (Arg2)
            }

            If ((Arg0 == 0x06))
            {
                Local2 = FGLW ()
            }

            Return (Local2)
        }

        Method (FSEC, 3, Serialized)
        {
            If ((FGLC () != Zero))
            {
                Return (Package (0x01)
                {
                    0x40
                })
            }

            Switch (Arg2)
            {
                Case (Zero)
                {
                    ^^PCI0.LPCB.EC0.FBCM = Arg2
                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
                Case (One)
                {
                    ^^PCI0.LPCB.EC0.FBCM = Arg2
                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
                Case (0x02)
                {
                    ^^PCI0.LPCB.EC0.FBCM = Arg2
                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
                Case (0x08)
                {
                    ^^PCI0.LPCB.EC0.FBCM = Arg2
                    Local2 = One
                    Local3 = One
                    While ((Local3 != Arg1))
                    {
                        ^^PCI0.LPCB.EC0.FBID = DerefOf (Arg0 [Local2])
                        Local2++
                        Local3++
                    }

                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
                Case (0x0A)
                {
                    ^^PCI0.LPCB.EC0.FBCM = Arg2
                    Local2 = One
                    Local3 = One
                    While ((Local3 != Arg1))
                    {
                        ^^PCI0.LPCB.EC0.FBID = DerefOf (Arg0 [Local2])
                        Local2++
                        Local3++
                    }

                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
                Default
                {
                    Return (Package (0x01)
                    {
                        0x06
                    })
                }

            }
        }

        Method (FGIF, 1, Serialized)
        {
            If ((FGLC () != Zero))
            {
                Return (Package (0x01)
                {
                    0x40
                })
            }

            Switch (Arg0)
            {
                Case (Zero)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x04){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = Zero
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local1 = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                    DerefOf (Local0 [One]) [Zero] = Local1
                    Return (Local0)
                }
                Case (One)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x80){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = One
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x20))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x02)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x80){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x02
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x20))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x03)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x80){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x03
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x20))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x04)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x80){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x04
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x20))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x05)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x80){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x05
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x20))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x08)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x1000){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x08
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x1000))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x09)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x1000){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x09
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x1000))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x0A)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x80){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x0A
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x02)
                        {
                            0x41,
                            Zero
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x06))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x0B)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x04){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x0B
                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != One))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x0C)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x04){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x0C
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != One))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Case (0x0F)
                {
                    Local0 = Package (0x02)
                        {
                            Zero,
                            Buffer (0x04){}
                        }
                    ^^PCI0.LPCB.EC0.FBGI = 0x0F
                    If ((FLCC () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            0x41
                        })
                    }

                    Local3 = Zero
                    Local2 = Zero
                    While ((Local3 != 0x04))
                    {
                        DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBGI /* \_SB_.PCI0.LPCB.EC0_.FBGI */
                        Local2++
                        Local3++
                    }

                    Return (Local0)
                }
                Default
                {
                    Return (Package (0x01)
                    {
                        0x06
                    })
                }

            }
        }

        Method (FGAE, 1, Serialized)
        {
            If ((FGLC () != Zero))
            {
                Return (Package (0x01)
                {
                    0x40
                })
            }

            If ((Arg0 < 0x0100))
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        Buffer (0x80){}
                    }
                ^^PCI0.LPCB.EC0.FBAE = Arg0
                If ((FLCC () == Zero))
                {
                    Return (Package (0x01)
                    {
                        0x41
                    })
                }

                Local3 = Zero
                Local2 = Zero
                While ((Local3 != 0x10))
                {
                    DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FBAE /* \_SB_.PCI0.LPCB.EC0_.FBAE */
                    Local2++
                    Local3++
                }

                Return (Local0)
            }
            Else
            {
                Return (Package (0x01)
                {
                    0x06
                })
            }
        }

        Method (FGAU, 1, Serialized)
        {
            If ((FGLC () != Zero))
            {
                Return (Package (0x01)
                {
                    0x40
                })
            }

            If ((Arg0 < 0x0100))
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        Buffer (0x80){}
                    }
                ^^PCI0.LPCB.EC0.FUAE = Arg0
                If ((FLCC () == Zero))
                {
                    Return (Package (0x01)
                    {
                        0x41
                    })
                }

                Local3 = Zero
                Local2 = Zero
                While ((Local3 != 0x10))
                {
                    DerefOf (Local0 [One]) [Local2] = ^^PCI0.LPCB.EC0.FUAE /* \_SB_.PCI0.LPCB.EC0_.FUAE */
                    Local2++
                    Local3++
                }

                Return (Local0)
            }
            Else
            {
                Return (Package (0x01)
                {
                    0x06
                })
            }
        }

        Method (FGFS, 0, NotSerialized)
        {
            Local0 = Package (0x02)
                {
                    Zero,
                    Buffer (0x04){}
                }
            DerefOf (Local0 [One]) [Zero] = ^^PCI0.LPCB.EC0.FBCB /* \_SB_.PCI0.LPCB.EC0_.FBCB */
            DerefOf (Local0 [One]) [One] = ^^PCI0.LPCB.EC0.FBW1 /* \_SB_.PCI0.LPCB.EC0_.FBW1 */
            DerefOf (Local0 [One]) [0x02] = ^^PCI0.LPCB.EC0.FBW2 /* \_SB_.PCI0.LPCB.EC0_.FBW2 */
            Return (Local0)
        }

        Method (FGLC, 0, NotSerialized)
        {
            Local0 = ^^PCI0.LPCB.EC0.FBCM /* \_SB_.PCI0.LPCB.EC0_.FBCM */
            Return (Local0)
        }

        Method (FGLW, 0, NotSerialized)
        {
            Local0 = Package (0x02)
                {
                    Zero,
                    Buffer (0x04){}
                }
            DerefOf (Local0 [One]) [Zero] = ^^PCI0.LPCB.EC0.FBCM /* \_SB_.PCI0.LPCB.EC0_.FBCM */
            Return (Local0)
        }

        Method (FLCC, 0, NotSerialized)
        {
            Local0 = Zero
            While (((Local0 != 0x64) & (FGLC () == One)))
            {
                Sleep (0x64)
                Local0++
            }

            If ((Local0 >= 0x64))
            {
                Return (Zero)
            }
            Else
            {
                Return (One)
            }
        }

        Method (FBPS, 1, Serialized)
        {
            If ((FGLC () != Zero))
            {
                Return (Package (0x01)
                {
                    0x40
                })
            }

            Local0 = Package (0x02)
                {
                    Zero,
                    Buffer (0x04){}
                }
            ^^PCI0.LPCB.EC0.FRPS = DerefOf (Arg0 [Zero])
            ^^PCI0.LPCB.EC0.FRPS = DerefOf (Arg0 [One])
            ^^PCI0.LPCB.EC0.FRPS = DerefOf (Arg0 [0x02])
            ^^PCI0.LPCB.EC0.FRPS = DerefOf (Arg0 [0x03])
            If ((FLCC () == Zero))
            {
                Return (Package (0x01)
                {
                    0x41
                })
            }

            DerefOf (Local0 [One]) [Zero] = ^^PCI0.LPCB.EC0.FRPS /* \_SB_.PCI0.LPCB.EC0_.FRPS */
            Return (Local0)
        }

        Method (HVWC, 4, Serialized)
        {
            Switch (ToInteger (Arg0))
            {
                Case (One)
                {
                    Local2 = VRBC (Arg1, Arg2, Arg3)
                }
                Case (0x02)
                {
                    Local2 = VWBC (Arg1, Arg2, Arg3)
                }
                Case (0x00020006)
                {
                    Local2 = FBCD (Arg1, Arg2, Arg3)
                }
                Default
                {
                    Local2 = Package (0x01)
                        {
                            0x03
                        }
                }

            }

            Return (Local2)
        }

        Method (VRBC, 3, Serialized)
        {
            If ((Arg0 == 0x10))
            {
                Local2 = Package (0x02)
                    {
                        Zero,
                        Zero
                    }
                Local2 [One] = BORN /* \_SB_.WMIV.BORN */
                Return (Local2)
            }

            If ((Arg0 == 0x46))
            {
                Local2 = Package (0x01)
                    {
                        Zero
                    }
                Return (Local2)
            }

            If ((Arg0 == 0x47))
            {
                Local3 = Buffer (0x04)
                    {
                         0x55, 0x44, 0x66, 0x77                           // UDfw
                    }
                Local2 = Package (0x02)
                    {
                        Zero,
                        Zero
                    }
                Local2 [One] = Local3
                Return (Local2)
            }

            If ((Arg0 == 0x48))
            {
                Local3 = Buffer (0x0400)
                    {
                         0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA, 0x99, 0x88   // ........
                    }
                Local2 = Package (0x02)
                    {
                        Zero,
                        Zero
                    }
                Local2 [One] = Local3
                Return (Local2)
            }

            If ((Arg0 == 0x49))
            {
                Local3 = Buffer (0x1000)
                    {
                        /* 0000 */  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,  // ........
                        /* 0008 */  0x08, 0x09, 0x0A                                 // ...
                    }
                Local2 = Package (0x02)
                    {
                        Zero,
                        Zero
                    }
                Local2 [One] = Local3
                Return (Local2)
            }

            Return (Package (0x01)
            {
                0x04
            })
        }

        Method (VWBC, 3, Serialized)
        {
            Local2 = Package (0x01)
                {
                    0x04
                }
            If ((Arg0 == 0x10))
            {
                CreateField (Arg2, Zero, (SizeOf (BORN) * 0x08), TBUF)
                BORN = TBUF /* \_SB_.WMIV.VWBC.TBUF */
                Local2 [Zero] = Zero
                Return (Local2)
            }

            If ((Arg0 == 0x49))
            {
                Local3 = Buffer (0x04)
                    {
                         0x99                                             // .
                    }
                Local2 = Package (0x02)
                    {
                        Zero,
                        Zero
                    }
                Local2 [One] = Local3
                Return (Local2)
            }

            Return (Local2)
        }

        Method (HVWP, 4, Serialized)
        {
            Switch (ToInteger (Arg0))
            {
                Case (One)
                {
                    Switch (ToInteger (Arg1))
                    {
                        Case (0x30)
                        {
                            Local2 = GEID ()
                        }
                        Default
                        {
                            Local2 = Package (0x01)
                                {
                                    0x04
                                }
                        }

                    }
                }
                Case (0x02)
                {
                    Local2 = Package (0x01)
                        {
                            0x04
                        }
                }
                Default
                {
                    Local2 = Package (0x01)
                        {
                            0x03
                        }
                }

            }

            Return (Local2)
        }

        Method (GEID, 0, NotSerialized)
        {
            Local1 = EDID /* \EDID */
            Local2 = Package (0x02)
                {
                    Zero,
                    Zero
                }
            Local2 [One] = Local1
            Return (Local2)
        }

        Name (WQZZ, Buffer (0x086F)
        {
            /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
            /* 0008 */  0x5F, 0x08, 0x00, 0x00, 0xBE, 0x3A, 0x00, 0x00,  // _....:..
            /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
            /* 0018 */  0x98, 0x58, 0x9C, 0x00, 0x01, 0x06, 0x18, 0x42,  // .X.....B
            /* 0020 */  0x10, 0x13, 0x10, 0x12, 0xE0, 0x81, 0xC2, 0x04,  // ........
            /* 0028 */  0x43, 0x43, 0x28, 0xB2, 0x06, 0x18, 0x8C, 0x04,  // CC(.....
            /* 0030 */  0x08, 0xC9, 0x81, 0x90, 0x0B, 0x26, 0x26, 0x40,  // .....&&@
            /* 0038 */  0x04, 0x84, 0xBC, 0x0A, 0xB0, 0x29, 0xC0, 0x24,  // .....).$
            /* 0040 */  0x88, 0xFA, 0xF7, 0x87, 0x28, 0x09, 0x0E, 0x25,  // ....(..%
            /* 0048 */  0x04, 0x42, 0x12, 0x05, 0x98, 0x17, 0xA0, 0x5B,  // .B.....[
            /* 0050 */  0x80, 0x61, 0x01, 0xB6, 0x05, 0x98, 0x16, 0xE0,  // .a......
            /* 0058 */  0x18, 0x92, 0x4A, 0x03, 0xA7, 0x04, 0x96, 0x02,  // ..J.....
            /* 0060 */  0x21, 0xA1, 0x02, 0x94, 0x0B, 0xF0, 0x2D, 0x40,  // !.....-@
            /* 0068 */  0x3B, 0xA2, 0x24, 0x0B, 0xB0, 0x0C, 0x23, 0x02,  // ;.$...#.
            /* 0070 */  0x8F, 0x22, 0xB2, 0xD1, 0x38, 0x41, 0xD9, 0xD0,  // ."..8A..
            /* 0078 */  0x28, 0x19, 0x10, 0xF2, 0x2C, 0xC0, 0x3A, 0x30,  // (...,.:0
            /* 0080 */  0x21, 0xB0, 0x7B, 0x01, 0xD6, 0x04, 0x98, 0x9B,  // !.{.....
            /* 0088 */  0x85, 0x8C, 0xCD, 0x45, 0x10, 0x0D, 0x62, 0xC8,  // ...E..b.
            /* 0090 */  0x96, 0x00, 0x87, 0x48, 0x82, 0x89, 0x11, 0x25,  // ...H...%
            /* 0098 */  0x58, 0xBC, 0x8A, 0x87, 0x21, 0x94, 0x1B, 0x0D,  // X...!...
            /* 00A0 */  0x15, 0xA9, 0x32, 0x14, 0x59, 0x44, 0x91, 0x42,  // ..2.YD.B
            /* 00A8 */  0x01, 0xCE, 0x04, 0x08, 0xC3, 0x95, 0x46, 0x50,  // ......FP
            /* 00B0 */  0x21, 0xC4, 0x8A, 0x14, 0xAB, 0xFD, 0x41, 0x90,  // !.....A.
            /* 00B8 */  0xF8, 0x16, 0x20, 0xAA, 0x00, 0x51, 0xA4, 0xD1,  // .. ..Q..
            /* 00C0 */  0xA0, 0x86, 0x97, 0xE0, 0x70, 0x3D, 0xD4, 0x73,  // ....p=.s
            /* 00C8 */  0xEC, 0x5C, 0x80, 0xF4, 0x49, 0x0A, 0xE4, 0x20,  // .\..I..
            /* 00D0 */  0xCF, 0xA2, 0xCE, 0x71, 0x12, 0x90, 0x04, 0xC6,  // ...q....
            /* 00D8 */  0x4A, 0xD0, 0xC1, 0xC0, 0xA1, 0xB8, 0x06, 0xD4,  // J.......
            /* 00E0 */  0x8C, 0x8F, 0x97, 0x09, 0x82, 0x43, 0x0D, 0xD1,  // .....C..
            /* 00E8 */  0x03, 0x0D, 0x77, 0x02, 0x87, 0xC8, 0x00, 0x3D,  // ..w....=
            /* 00F0 */  0xA9, 0xA3, 0xC1, 0x1C, 0x00, 0x3C, 0xB8, 0x93,  // .....<..
            /* 00F8 */  0x79, 0x0F, 0x28, 0x55, 0x80, 0xD9, 0x31, 0x6B,  // y.(U..1k
            /* 0100 */  0x60, 0x09, 0x8E, 0xC7, 0xD0, 0xA7, 0x7B, 0x3E,  // `.....{>
            /* 0108 */  0x27, 0x9C, 0xC0, 0xF2, 0x07, 0x81, 0x1A, 0x99,  // '.......
            /* 0110 */  0xA1, 0x3D, 0xCA, 0xD3, 0x8A, 0x19, 0xF2, 0xF0,  // .=......
            /* 0118 */  0x0F, 0x8B, 0x89, 0x85, 0x90, 0x02, 0x08, 0x8D,  // ........
            /* 0120 */  0x07, 0xDE, 0xFF, 0x7F, 0x3C, 0xE0, 0xB9, 0x01,  // ....<...
            /* 0128 */  0x3C, 0x13, 0x44, 0x78, 0x25, 0x88, 0xED, 0x01,  // <.Dx%...
            /* 0130 */  0x25, 0x18, 0x16, 0x42, 0x46, 0x56, 0xE1, 0xF1,  // %..BFV..
            /* 0138 */  0xD0, 0x51, 0xD8, 0xE9, 0x70, 0x34, 0xAD, 0x78,  // .Q..p4.x
            /* 0140 */  0x26, 0x18, 0x0E, 0x42, 0x5F, 0x00, 0x09, 0x10,  // &..B_...
            /* 0148 */  0x35, 0x6C, 0x7A, 0x58, 0xE0, 0xE7, 0x04, 0x76,  // 5lzX...v
            /* 0150 */  0x33, 0x38, 0x83, 0x47, 0x00, 0x8F, 0xE4, 0x84,  // 38.G....
            /* 0158 */  0x7C, 0x9C, 0xF0, 0xC0, 0xE0, 0x03, 0xE2, 0xBD,  // |.......
            /* 0160 */  0x4F, 0x99, 0x8C, 0xE0, 0x4C, 0x0D, 0xE8, 0xE3,  // O...L...
            /* 0168 */  0x80, 0x87, 0xC2, 0x87, 0xE8, 0xF1, 0x9D, 0xF2,  // ........
            /* 0170 */  0xF1, 0xFA, 0x74, 0x61, 0x59, 0xE3, 0x84, 0x7E,  // ..taY..~
            /* 0178 */  0x87, 0xF0, 0xEC, 0x8E, 0xE1, 0x8F, 0x43, 0x02,  // ......C.
            /* 0180 */  0x22, 0x42, 0xC8, 0xC9, 0x29, 0x00, 0x0D, 0x7C,  // "B..)..|
            /* 0188 */  0xBA, 0x67, 0x17, 0xE1, 0x74, 0x3D, 0x29, 0x07,  // .g..t=).
            /* 0190 */  0x1A, 0x06, 0x1D, 0x27, 0x38, 0xCE, 0x03, 0xE0,  // ...'8...
            /* 0198 */  0x18, 0x27, 0xFC, 0x73, 0x01, 0xFC, 0x01, 0xF2,  // .'.s....
            /* 01A0 */  0x53, 0xC6, 0x2B, 0x46, 0x02, 0xC7, 0x1C, 0x21,  // S.+F...!
            /* 01A8 */  0x5A, 0xCC, 0x08, 0x21, 0xC0, 0x3F, 0x55, 0x14,  // Z..!.?U.
            /* 01B0 */  0x3E, 0x10, 0xF2, 0xFF, 0x1F, 0x23, 0xB8, 0x00,  // >....#..
            /* 01B8 */  0x3D, 0x46, 0xE0, 0x1B, 0x70, 0x8C, 0xE8, 0xA3,  // =F..p...
            /* 01C0 */  0x04, 0x57, 0x7F, 0xD0, 0xA0, 0x03, 0x04, 0x17,  // .W......
            /* 01C8 */  0xA8, 0x07, 0x08, 0x7C, 0xA3, 0x1F, 0x3D, 0xD0,  // ...|..=.
            /* 01D0 */  0xE3, 0xB2, 0xE8, 0xF3, 0x80, 0x8C, 0x9F, 0x68,  // .......h
            /* 01D8 */  0x34, 0x2F, 0x7E, 0x3A, 0xE0, 0x87, 0x0F, 0xF0,  // 4/~:....
            /* 01E0 */  0x80, 0x7A, 0x48, 0x38, 0x50, 0xCC, 0xB4, 0x39,  // .zH8P..9
            /* 01E8 */  0xE8, 0xB3, 0xCB, 0xA1, 0x63, 0x87, 0x0B, 0xEF,  // ....c...
            /* 01F0 */  0xFF, 0x3F, 0x5C, 0xF0, 0x9C, 0x40, 0xC0, 0x25,  // .?\..@.%
            /* 01F8 */  0x0F, 0x16, 0x3D, 0x5C, 0xFB, 0x15, 0x80, 0x10,  // ..=\....
            /* 0200 */  0xBA, 0xCC, 0x5B, 0x89, 0x66, 0x15, 0xE1, 0x88,  // ..[.f...
            /* 0208 */  0x61, 0x9C, 0x83, 0x4C, 0x60, 0x91, 0xF0, 0xA8,  // a..L`...
            /* 0210 */  0xE3, 0x85, 0xE1, 0xF9, 0x59, 0x28, 0xFA, 0xC1,  // ....Y(..
            /* 0218 */  0x9C, 0x4A, 0xF8, 0x83, 0x89, 0x72, 0x0A, 0x47,  // .J...r.G
            /* 0220 */  0x63, 0xB9, 0x08, 0xD2, 0x05, 0xA1, 0xA3, 0x93,  // c.......
            /* 0228 */  0x11, 0xCE, 0x20, 0xCA, 0xD9, 0x9D, 0xB1, 0x09,  // .. .....
            /* 0230 */  0x7C, 0x94, 0xF2, 0x11, 0x80, 0x9F, 0x5B, 0x3C,  // |.....[<
            /* 0238 */  0x22, 0x18, 0xE7, 0xA5, 0x28, 0xF6, 0x38, 0x27,  // "...(.8'
            /* 0240 */  0x42, 0x50, 0xE0, 0x70, 0x50, 0x41, 0x9E, 0x0E,  // BP.pPA..
            /* 0248 */  0x3E, 0x6D, 0x51, 0xE9, 0x30, 0xA8, 0x03, 0x17,  // >mQ.0...
            /* 0250 */  0x60, 0x65, 0x12, 0x11, 0x9E, 0x25, 0x6A, 0x83,  // `e...%j.
            /* 0258 */  0xD0, 0xA9, 0xE1, 0x6D, 0xE2, 0x6D, 0xCB, 0xB7,  // ...m.m..
            /* 0260 */  0x80, 0x38, 0xA7, 0xD9, 0xDB, 0x81, 0x8B, 0x60,  // .8.....`
            /* 0268 */  0x44, 0xA8, 0x19, 0x8A, 0x9C, 0xB4, 0x22, 0xC6,  // D.....".
            /* 0270 */  0x88, 0xF2, 0xB8, 0x65, 0x94, 0xB7, 0xAD, 0x17,  // ...e....
            /* 0278 */  0x80, 0x78, 0x27, 0xF6, 0xFF, 0x7F, 0xDE, 0x32,  // .x'....2
            /* 0280 */  0x46, 0xF0, 0xC8, 0x0F, 0x5C, 0x2C, 0xC6, 0xEA,  // F...\,..
            /* 0288 */  0xF5, 0x5F, 0xF3, 0x81, 0x0B, 0xE0, 0xF9, 0xFF,  // ._......
            /* 0290 */  0xFF, 0x7C, 0x82, 0x0F, 0x7A, 0x18, 0x42, 0x0F,  // .|..z.B.
            /* 0298 */  0xC3, 0x53, 0x39, 0x97, 0x4A, 0xA7, 0x22, 0xC4,  // .S9.J.".
            /* 02A0 */  0xA8, 0x61, 0xA2, 0x3E, 0x43, 0xF9, 0x6E, 0xE1,  // .a.>C.n.
            /* 02A8 */  0x03, 0x11, 0xF8, 0xCE, 0x5C, 0xC0, 0xF9, 0x98,  // ....\...
            /* 02B0 */  0x82, 0x3B, 0xD3, 0x80, 0xC7, 0xE7, 0x0C, 0x04,  // .;......
            /* 02B8 */  0x72, 0x2A, 0x3E, 0xD4, 0x00, 0x16, 0x44, 0x3F,  // r*>...D?
            /* 02C0 */  0x21, 0x7C, 0xA2, 0xA1, 0x32, 0x61, 0x50, 0x87,  // !|..2aP.
            /* 02C8 */  0x1A, 0xE0, 0xF0, 0xFF, 0x3F, 0xD4, 0x00, 0xA3,  // ....?...
            /* 02D0 */  0x2B, 0xCC, 0xD3, 0xE8, 0x39, 0x3F, 0xCB, 0xF8,  // +...9?..
            /* 02D8 */  0x54, 0xE3, 0x43, 0xA9, 0x71, 0x0C, 0xF1, 0x32,  // T.C.q..2
            /* 02E0 */  0xF3, 0x50, 0xE3, 0x63, 0xC1, 0x2B, 0xA9, 0x0F,  // .P.c.+..
            /* 02E8 */  0x35, 0x86, 0x8A, 0xF3, 0x50, 0xE3, 0xE1, 0x06,  // 5...P...
            /* 02F0 */  0x8A, 0xFA, 0x66, 0xF3, 0x6C, 0x63, 0xF4, 0xF8,  // ..f.lc..
            /* 02F8 */  0xBE, 0xA1, 0x1A, 0xE2, 0xA1, 0x86, 0x49, 0x5E,  // ......I^
            /* 0300 */  0xA9, 0xC6, 0xE2, 0x43, 0x0D, 0xC0, 0xAB, 0xFF,  // ...C....
            /* 0308 */  0xFF, 0xA1, 0x06, 0xE0, 0xDB, 0xD1, 0x00, 0xCE,  // ........
            /* 0310 */  0x91, 0x11, 0x77, 0x34, 0x00, 0xD7, 0xA1, 0x14,  // ..w4....
            /* 0318 */  0x38, 0xFC, 0xFF, 0x8F, 0x06, 0xC0, 0xE3, 0x28,  // 8......(
            /* 0320 */  0x04, 0xE6, 0x0B, 0x8D, 0x8F, 0x42, 0x80, 0x05,  // .....B..
            /* 0328 */  0xD9, 0xE7, 0x20, 0x94, 0xD0, 0xA3, 0x10, 0x20,  // .. ....
            /* 0330 */  0xE8, 0xF6, 0xF3, 0x14, 0xF1, 0xEC, 0xE3, 0xCB,  // ........
            /* 0338 */  0xCF, 0x03, 0x41, 0x84, 0xD7, 0x7C, 0x9F, 0x82,  // ..A..|..
            /* 0340 */  0x7C, 0xC8, 0xF7, 0x51, 0x88, 0xC1, 0x18, 0xCA,  // |..Q....
            /* 0348 */  0xD7, 0x20, 0x1F, 0x85, 0x18, 0xD4, 0x6B, 0x90,  // . ....k.
            /* 0350 */  0xEF, 0xFB, 0x06, 0x79, 0xBC, 0x08, 0x12, 0x3B,  // ...y...;
            /* 0358 */  0xCA, 0xFF, 0x3F, 0xD0, 0xA3, 0x10, 0x13, 0x7D,  // ..?....}
            /* 0360 */  0x14, 0x02, 0x68, 0xFF, 0xFF, 0x3F, 0x0A, 0x01,  // ..h..?..
            /* 0368 */  0xFC, 0x0B, 0x70, 0x34, 0x00, 0xDD, 0xB4, 0x1E,  // ..p4....
            /* 0370 */  0x85, 0xC0, 0x7B, 0x67, 0x39, 0xED, 0x13, 0xF0,  // ..{g9...
            /* 0378 */  0x59, 0x08, 0xFB, 0xFF, 0x3F, 0x0B, 0x01, 0x2C,  // Y...?..,
            /* 0380 */  0x39, 0x0A, 0x1D, 0xC5, 0x59, 0xBE, 0x0A, 0x3D,  // 9...Y..=
            /* 0388 */  0x01, 0xBC, 0x00, 0xC4, 0x08, 0xF3, 0x0E, 0xF4,  // ........
            /* 0390 */  0x92, 0xC9, 0xEE, 0xE2, 0xC6, 0x79, 0x72, 0x39,  // .....yr9
            /* 0398 */  0x8B, 0x27, 0x71, 0x5F, 0x82, 0x7C, 0xA0, 0x78,  // .'q_.|.x
            /* 03A0 */  0x16, 0x32, 0xD4, 0xE9, 0x06, 0x7D, 0x23, 0xF7,  // .2...}#.
            /* 03A8 */  0xC0, 0x62, 0xC6, 0x0F, 0xF1, 0x3C, 0x64, 0x88,  // .b...<d.
            /* 03B0 */  0x67, 0x21, 0xC0, 0xC8, 0xFF, 0xFF, 0x2C, 0x04,  // g!....,.
            /* 03B8 */  0xF0, 0xFF, 0xFF, 0x7F, 0x16, 0x02, 0x5C, 0xBF,  // ......\.
            /* 03C0 */  0x00, 0x7C, 0x16, 0x02, 0x9E, 0x27, 0x80, 0x07,  // .|...'..
            /* 03C8 */  0x6D, 0x9F, 0x85, 0x00, 0x43, 0xFF, 0xFF, 0xB3,  // m...C...
            /* 03D0 */  0x10, 0x60, 0xE4, 0x70, 0x79, 0xFE, 0xAF, 0x40,  // .`.py..@
            /* 03D8 */  0xC7, 0xF2, 0x1E, 0xE1, 0x59, 0x9F, 0xE4, 0xEB,  // ....Y...
            /* 03E0 */  0xA5, 0x67, 0xFA, 0x50, 0xF0, 0x2C, 0xC4, 0xB0,  // .g.P.,..
            /* 03E8 */  0x0E, 0xC3, 0x67, 0x21, 0x06, 0xF1, 0xA2, 0x69,  // ..g!...i
            /* 03F0 */  0x88, 0x17, 0x4E, 0x1F, 0x06, 0x18, 0xF0, 0x2B,  // ..N....+
            /* 03F8 */  0xA7, 0x81, 0x82, 0x04, 0x7A, 0x16, 0x02, 0x58,  // ....z..X
            /* 0400 */  0xF2, 0xFF, 0x3F, 0x0B, 0x01, 0xFC, 0xFF, 0xFF,  // ..?.....
            /* 0408 */  0x9F, 0x85, 0x80, 0xD8, 0x1A, 0x75, 0x16, 0x02,  // .....u..
            /* 0410 */  0x96, 0xB7, 0x95, 0x67, 0x6C, 0x9F, 0x56, 0x9E,  // ...gl.V.
            /* 0418 */  0x85, 0x00, 0x0B, 0xB9, 0x8C, 0x1C, 0x84, 0x30,  // .......0
            /* 0420 */  0x11, 0x1F, 0x0E, 0x3E, 0x66, 0x02, 0x7A, 0xFE,  // ...>f.z.
            /* 0428 */  0xFF, 0x53, 0x7C, 0x71, 0x37, 0xC6, 0x13, 0xC0,  // .S|q7...
            /* 0430 */  0x8B, 0xC4, 0x63, 0x26, 0x3B, 0x6A, 0x1A, 0xE6,  // ..c&;j..
            /* 0438 */  0x59, 0xC8, 0x78, 0x67, 0xF1, 0x1A, 0xF0, 0x04,  // Y.xg....
            /* 0440 */  0xEF, 0xC9, 0x3F, 0x0B, 0x31, 0xB0, 0xC3, 0x0A,  // ..?.1...
            /* 0448 */  0xF6, 0x28, 0x64, 0x50, 0x83, 0xC7, 0x0E, 0x11,  // .(dP....
            /* 0450 */  0x26, 0xD0, 0xB3, 0x10, 0x8B, 0xFB, 0x5C, 0xD1,  // &.....\.
            /* 0458 */  0x79, 0xC2, 0x67, 0x21, 0xC0, 0xC9, 0xD5, 0xE0,  // y.g!....
            /* 0460 */  0x59, 0x08, 0x30, 0x71, 0xD8, 0xF0, 0x59, 0x03,  // Y.0q..Y.
            /* 0468 */  0x3C, 0xC3, 0xF7, 0xA8, 0xCE, 0xE1, 0xF1, 0x18,  // <.......
            /* 0470 */  0x78, 0xFD, 0xFF, 0x0F, 0x1A, 0xE0, 0xC9, 0xAA,  // x.......
            /* 0478 */  0xE3, 0x9C, 0xC0, 0x72, 0x2F, 0x5A, 0x36, 0x0E,  // ...r/Z6.
            /* 0480 */  0x34, 0x74, 0x44, 0x56, 0x07, 0xA4, 0xB1, 0x61,  // 4tDV...a
            /* 0488 */  0x2E, 0x25, 0x91, 0x4F, 0x8E, 0x8D, 0xDA, 0x8A,  // .%.O....
            /* 0490 */  0xE0, 0x74, 0x66, 0xF2, 0x09, 0xC0, 0x5A, 0x28,  // .tf...Z(
            /* 0498 */  0xA4, 0x80, 0x46, 0x63, 0x31, 0xBC, 0x33, 0x1F,  // ..Fc1.3.
            /* 04A0 */  0x9D, 0x28, 0x88, 0x01, 0x7D, 0x1C, 0xB2, 0x8D,  // .(..}...
            /* 04A8 */  0x43, 0x01, 0x6A, 0x2F, 0x9A, 0x02, 0x39, 0xE7,  // C.j/..9.
            /* 04B0 */  0x60, 0xF4, 0xCF, 0x8E, 0xCE, 0xC6, 0x77, 0x02,  // `.....w.
            /* 04B8 */  0xAE, 0x01, 0x42, 0xA7, 0x04, 0x43, 0x5B, 0xCD,  // ..B..C[.
            /* 04C0 */  0x2C, 0x51, 0x60, 0xC6, 0x7F, 0x8A, 0x31, 0x81,  // ,Q`...1.
            /* 04C8 */  0xCF, 0x31, 0xF8, 0x83, 0x01, 0x7E, 0xE0, 0x2F,  // .1...~./
            /* 04D0 */  0x06, 0x55, 0xDF, 0x0B, 0x74, 0x5F, 0xB0, 0xBA,  // .U..t_..
            /* 04D8 */  0x9B, 0x0C, 0x84, 0x19, 0x99, 0xA0, 0xBE, 0xD3,  // ........
            /* 04E0 */  0x01, 0x28, 0x80, 0x7C, 0x21, 0xF0, 0x39, 0xEA,  // .(.|!.9.
            /* 04E8 */  0xA1, 0x80, 0x4D, 0x24, 0x44, 0x98, 0x68, 0x46,  // ..M$D.hF
            /* 04F0 */  0x47, 0x4C, 0x18, 0x15, 0x7D, 0xC2, 0x14, 0xC4,  // GL..}...
            /* 04F8 */  0x13, 0x76, 0xAC, 0x09, 0xA3, 0x67, 0xE2, 0x8B,  // .v...g..
            /* 0500 */  0x0E, 0x1B, 0x31, 0x26, 0xC4, 0xD5, 0x03, 0xDA,  // ..1&....
            /* 0508 */  0x04, 0x83, 0xFA, 0x52, 0x04, 0x6B, 0xC8, 0x7C,  // ...R.k.|
            /* 0510 */  0x2C, 0xBE, 0x40, 0xE0, 0xA6, 0xCC, 0xFE, 0xFF,  // ,.@.....
            /* 0518 */  0x53, 0x06, 0xD7, 0x9C, 0xD8, 0x35, 0xC1, 0x97,  // S....5..
            /* 0520 */  0x1D, 0xDC, 0x9C, 0xC1, 0x08, 0x8F, 0xB9, 0x8B,  // ........
            /* 0528 */  0xF1, 0xAB, 0x93, 0x47, 0xC7, 0x0F, 0x0A, 0xBE,  // ...G....
            /* 0530 */  0xE1, 0x30, 0xEC, 0x27, 0x33, 0xCF, 0xE8, 0xBD,  // .0.'3...
            /* 0538 */  0xCC, 0xD7, 0x38, 0x0C, 0xAC, 0xC7, 0xCB, 0x61,  // ..8....a
            /* 0540 */  0x8D, 0x16, 0xF6, 0xD0, 0xDE, 0x43, 0x7C, 0x88,  // .....C|.
            /* 0548 */  0xF1, 0x79, 0xC2, 0x18, 0x61, 0x7D, 0x7B, 0x01,  // .y..a}{.
            /* 0550 */  0xC7, 0x3D, 0x0B, 0xFE, 0x5D, 0x03, 0x3C, 0x97,  // .=..].<.
            /* 0558 */  0x10, 0xDF, 0x35, 0x00, 0x6B, 0xFF, 0xFF, 0xBB,  // ..5.k...
            /* 0560 */  0x06, 0xC0, 0x8F, 0x6B, 0x82, 0xEF, 0x1A, 0xC0,  // ...k....
            /* 0568 */  0x7B, 0xE8, 0xBE, 0x6B, 0x00, 0xBF, 0xFF, 0xFF,  // {..k....
            /* 0570 */  0x5D, 0x03, 0x97, 0xFD, 0xAE, 0x81, 0x3A, 0x06,  // ].....:.
            /* 0578 */  0x58, 0xE1, 0x5D, 0x03, 0xDA, 0x95, 0xED, 0x7D,  // X.]....}
            /* 0580 */  0xED, 0x09, 0xCB, 0x9A, 0x2E, 0x1B, 0x28, 0x35,  // ......(5
            /* 0588 */  0x97, 0x0D, 0x80, 0x04, 0x52, 0x26, 0x8C, 0x0A,  // ....R&..
            /* 0590 */  0x3F, 0x61, 0x0A, 0xE2, 0x09, 0x3B, 0xD8, 0x65,  // ?a...;.e
            /* 0598 */  0x03, 0x14, 0x31, 0x2E, 0x1B, 0xA0, 0x1F, 0xDB,  // ..1.....
            /* 05A0 */  0x29, 0x83, 0xEF, 0xFF, 0x7F, 0xBE, 0x87, 0x73,  // )......s
            /* 05A8 */  0x4F, 0x60, 0xB7, 0x0D, 0xE0, 0x0D, 0xE9, 0xDB,  // O`......
            /* 05B0 */  0x06, 0x70, 0xCD, 0x7F, 0xDB, 0x40, 0x71, 0x58,  // .p...@qX
            /* 05B8 */  0xE5, 0x6D, 0x03, 0xE2, 0x49, 0x9E, 0x11, 0x58,  // .m..I..X
            /* 05C0 */  0xD5, 0x75, 0x03, 0xA5, 0xE7, 0xBA, 0x01, 0xC8,  // .u......
            /* 05C8 */  0xFB, 0xFF, 0x5F, 0x37, 0x80, 0x87, 0x98, 0x09,  // .._7....
            /* 05D0 */  0xA3, 0xE2, 0x4F, 0x98, 0x82, 0x78, 0xC2, 0x8E,  // ..O..x..
            /* 05D8 */  0x76, 0xDD, 0x00, 0x45, 0x90, 0xEB, 0x06, 0xE8,  // v..E....
            /* 05E0 */  0xE7, 0xF5, 0xBA, 0x01, 0x1C, 0x2E, 0x0A, 0x98,  // ........
            /* 05E8 */  0xFB, 0x06, 0xF0, 0x86, 0xE5, 0xF7, 0x0D, 0xE0,  // ........
            /* 05F0 */  0xF9, 0xFF, 0xBF, 0x6F, 0x80, 0xE7, 0x26, 0x8E,  // ...o..&.
            /* 05F8 */  0xB9, 0x6F, 0x00, 0x6C, 0xFE, 0xFF, 0x5F, 0xF5,  // .o.l.._.
            /* 0600 */  0x70, 0x17, 0x05, 0xCC, 0x7D, 0x03, 0x78, 0x5F,  // p...}.x_
            /* 0608 */  0xA4, 0x7D, 0xDF, 0x00, 0xAE, 0xD2, 0xD6, 0xEF,  // .}......
            /* 0610 */  0xC1, 0xD1, 0x13, 0x82, 0xC7, 0x87, 0xBB, 0x5F,  // ......._
            /* 0618 */  0x7A, 0x7C, 0xBE, 0x9B, 0x83, 0x63, 0x90, 0xC7,  // z|...c..
            /* 0620 */  0x78, 0x68, 0x07, 0xFC, 0xFA, 0xEE, 0x89, 0xF9,  // xh......
            /* 0628 */  0x6E, 0x0E, 0xFC, 0xCF, 0x04, 0xC7, 0x83, 0x81,  // n.......
            /* 0630 */  0xC6, 0x21, 0xB6, 0x7A, 0x69, 0x20, 0x47, 0x83,  // .!.zi G.
            /* 0638 */  0xF8, 0xFC, 0xFF, 0x0F, 0xCD, 0xE0, 0x8C, 0x55,  // .......U
            /* 0640 */  0xFC, 0xC9, 0x1F, 0xE1, 0x1C, 0x43, 0x67, 0x87,  // .....Cg.
            /* 0648 */  0x83, 0xC4, 0x0E, 0x82, 0x07, 0x5B, 0xB5, 0x09,  // .....[..
            /* 0650 */  0x14, 0x1A, 0x42, 0x51, 0x60, 0x50, 0x2C, 0x3E,  // ..BQ`P,>
            /* 0658 */  0x60, 0xE0, 0x87, 0xCD, 0xCE, 0x02, 0x4C, 0x12,  // `.....L.
            /* 0660 */  0x1C, 0xEA, 0x08, 0xE0, 0xFB, 0x44, 0xF3, 0xE3,  // .....D..
            /* 0668 */  0xD0, 0xDD, 0xE0, 0x50, 0x3D, 0x96, 0x87, 0x02,  // ...P=...
            /* 0670 */  0x7A, 0x06, 0xC4, 0x1D, 0x33, 0xC8, 0xA4, 0x3D,  // z...3..=
            /* 0678 */  0xA3, 0x88, 0x4F, 0x09, 0xA7, 0x14, 0x26, 0x81,  // ..O...&.
            /* 0680 */  0xCF, 0x0F, 0x0C, 0x8D, 0x13, 0xBC, 0x36, 0x84,  // ......6.
            /* 0688 */  0xC6, 0x9C, 0x14, 0xEC, 0xF9, 0x8E, 0x21, 0x60,  // ......!`
            /* 0690 */  0x13, 0xD8, 0xFD, 0x25, 0x43, 0xD6, 0x06, 0xAE,  // ...%C...
            /* 0698 */  0x5B, 0x92, 0x21, 0x7A, 0xC3, 0x91, 0x2D, 0x14,  // [.!z..-.
            /* 06A0 */  0x4D, 0x27, 0xCA, 0xFB, 0x46, 0x14, 0x3B, 0x43,  // M'..F.;C
            /* 06A8 */  0x10, 0x46, 0x94, 0x60, 0x41, 0x1E, 0x15, 0x62,  // .F.`A..b
            /* 06B0 */  0x45, 0x79, 0x29, 0x30, 0x42, 0xC4, 0x10, 0xAF,  // Ey)0B...
            /* 06B8 */  0x1C, 0x81, 0x4E, 0x38, 0x7C, 0x90, 0xC7, 0xA6,  // ..N8|...
            /* 06C0 */  0x38, 0xED, 0x0F, 0x82, 0xC4, 0x7A, 0x12, 0x68,  // 8....z.h
            /* 06C8 */  0x2C, 0x8E, 0x34, 0x1A, 0xD4, 0x39, 0xC0, 0xC3,  // ,.4..9..
            /* 06D0 */  0xF5, 0x21, 0xC6, 0xC3, 0x7F, 0x08, 0x31, 0xC8,  // .!....1.
            /* 06D8 */  0x41, 0x9E, 0xDB, 0xA3, 0xC2, 0x71, 0xFA, 0x2A,  // A....q.*
            /* 06E0 */  0x61, 0x82, 0x17, 0x00, 0x1F, 0x54, 0xE0, 0xB8,  // a....T..
            /* 06E8 */  0x06, 0xD4, 0x8C, 0x9F, 0x31, 0xC0, 0x72, 0x1C,  // ....1.r.
            /* 06F0 */  0xF7, 0x49, 0x05, 0xEE, 0x78, 0x7C, 0x3F, 0x60,  // .I..x|?`
            /* 06F8 */  0x13, 0x4E, 0x60, 0xF9, 0x83, 0x40, 0x1D, 0x67,  // .N`..@.g
            /* 0700 */  0xF8, 0x3C, 0x5F, 0x58, 0x0C, 0xF9, 0x98, 0x60,  // .<_X...`
            /* 0708 */  0x02, 0x8B, 0x15, 0xF0, 0xFF, 0x3F, 0xD9, 0xB0,  // .....?..
            /* 0710 */  0xF1, 0x80, 0xFF, 0x1E, 0xF3, 0x78, 0xE1, 0x93,  // .....x..
            /* 0718 */  0x89, 0xE7, 0x6B, 0x82, 0x11, 0x21, 0xE4, 0x64,  // ..k..!.d
            /* 0720 */  0x3C, 0xE8, 0x3B, 0x04, 0xE6, 0x7A, 0xC3, 0xCE,  // <.;..z..
            /* 0728 */  0x2D, 0x5C, 0xD4, 0x41, 0x03, 0x75, 0x5A, 0xF0,  // -\.A.uZ.
            /* 0730 */  0x41, 0x81, 0xDD, 0x8C, 0x30, 0xC7, 0x75, 0x7E,  // A...0.u~
            /* 0738 */  0x56, 0x01, 0xFF, 0x08, 0xE1, 0xDF, 0x1E, 0x3C,  // V......<
            /* 0740 */  0x2F, 0x5F, 0x19, 0x5E, 0x1D, 0x12, 0x38, 0xE4,  // /_.^..8.
            /* 0748 */  0x08, 0xD1, 0xE3, 0xF2, 0x08, 0x31, 0xE7, 0x23,  // .....1.#
            /* 0750 */  0xCC, 0x10, 0xC1, 0x75, 0x16, 0x00, 0xC7, 0x10,  // ...u....
            /* 0758 */  0x81, 0xCF, 0x01, 0x07, 0xF6, 0xFF, 0xFF, 0xC2,  // ........
            /* 0760 */  0xC2, 0x2E, 0x4D, 0x7C, 0xA0, 0x3E, 0xE0, 0x00,  // ..M|.>..
            /* 0768 */  0x0E, 0xAE, 0x69, 0xB8, 0x03, 0x0E, 0x38, 0xCE,  // ..i...8.
            /* 0770 */  0x02, 0xEC, 0x70, 0x03, 0x4B, 0xA1, 0x4D, 0x9F,  // ..p.K.M.
            /* 0778 */  0x1A, 0x8D, 0x5A, 0x35, 0x28, 0x53, 0xA3, 0x4C,  // ..Z5(S.L
            /* 0780 */  0x83, 0x5A, 0x7D, 0x2A, 0x35, 0x66, 0xEC, 0xAC,  // .Z}*5f..
            /* 0788 */  0xF2, 0x28, 0xAC, 0x47, 0x84, 0x46, 0x65, 0x11,  // .(.G.Fe.
            /* 0790 */  0x8F, 0x02, 0x81, 0x38, 0x32, 0x08, 0x8D, 0x44,  // ...82..D
            /* 0798 */  0x21, 0x10, 0x0B, 0x7F, 0x24, 0x08, 0xC4, 0xC2,  // !...$...
            /* 07A0 */  0x1E, 0x55, 0x02, 0xB1, 0xA8, 0xE7, 0x9C, 0x40,  // .U.....@
            /* 07A8 */  0x1C, 0x63, 0x15, 0x02, 0x27, 0x26, 0xC0, 0x29,  // .c..'&.)
            /* 07B0 */  0x08, 0x0D, 0xA6, 0xE2, 0xA0, 0x42, 0x9F, 0x6A,  // .....B.j
            /* 07B8 */  0x02, 0x71, 0x18, 0x10, 0x2A, 0xFD, 0xAF, 0x27,  // .q..*..'
            /* 07C0 */  0x10, 0x0B, 0xF4, 0x01, 0x48, 0x1F, 0x04, 0x02,  // ....H...
            /* 07C8 */  0x71, 0x04, 0x25, 0xA3, 0xA6, 0x0F, 0x09, 0x81,  // q.%.....
            /* 07D0 */  0x38, 0x2E, 0x08, 0x0D, 0xF5, 0x7C, 0x10, 0x20,  // 8....|.
            /* 07D8 */  0xB1, 0x02, 0xC2, 0x82, 0x7B, 0x01, 0x61, 0xB2,  // ....{.a.
            /* 07E0 */  0x1F, 0x04, 0x02, 0xB1, 0x48, 0x33, 0x20, 0x4C,  // ....H3 L
            /* 07E8 */  0xCA, 0xAB, 0x4F, 0x80, 0x04, 0x84, 0xCA, 0xB5,  // ..O.....
            /* 07F0 */  0x03, 0xC2, 0xC2, 0x82, 0xD0, 0x68, 0x7A, 0x40,  // .....hz@
            /* 07F8 */  0x58, 0x00, 0x3F, 0x80, 0xF4, 0x15, 0x21, 0x10,  // X.?...!.
            /* 0800 */  0x87, 0x54, 0x04, 0xC2, 0x24, 0x3A, 0x02, 0x61,  // .T..$:.a
            /* 0808 */  0x29, 0x25, 0xFD, 0xFF, 0x21, 0x1A, 0x19, 0xA2,  // )%..!...
            /* 0810 */  0x41, 0x04, 0xE4, 0xA4, 0x96, 0x80, 0x58, 0x6E,  // A.....Xn
            /* 0818 */  0x10, 0x01, 0x39, 0x9C, 0x27, 0x20, 0x96, 0x14,  // ..9.' ..
            /* 0820 */  0x44, 0x40, 0x0E, 0xF8, 0xD2, 0x10, 0x90, 0xE3,  // D@......
            /* 0828 */  0x82, 0x08, 0xC8, 0xA9, 0x54, 0x01, 0xB1, 0x88,  // ....T...
            /* 0830 */  0x20, 0x02, 0x72, 0x32, 0x57, 0x40, 0x2C, 0x27,  //  .r2W@,'
            /* 0838 */  0x88, 0x0E, 0x01, 0xE4, 0x11, 0x14, 0x88, 0xE4,  // ........
            /* 0840 */  0x03, 0x11, 0x90, 0x63, 0xBD, 0x1C, 0x02, 0x91,  // ...c....
            /* 0848 */  0x90, 0x20, 0x02, 0x72, 0xA2, 0x37, 0x86, 0x80,  // . .r.7..
            /* 0850 */  0x1C, 0x0F, 0x44, 0x83, 0x20, 0x5F, 0xA1, 0x40,  // ..D. _.@
            /* 0858 */  0x24, 0x23, 0x88, 0x80, 0xC8, 0xFB, 0x28, 0x08,  // $#....(.
            /* 0860 */  0xD1, 0xF4, 0xAB, 0x13, 0x88, 0x53, 0x83, 0xD0,  // .....S..
            /* 0868 */  0x64, 0xDF, 0xA2, 0x20, 0xE4, 0xFF, 0x0F         // d.. ...
        })
        Name (ZOBF, Buffer (0x1060){})
        Name (_WDG, Buffer (0x3C)
        {
            /* 0000 */  0x34, 0xF0, 0xB7, 0x5F, 0x63, 0x2C, 0xE9, 0x45,  // 4.._c,.E
            /* 0008 */  0xBE, 0x91, 0x3D, 0x44, 0xE2, 0xC7, 0x07, 0xE4,  // ..=D....
            /* 0010 */  0x50, 0x56, 0x01, 0x02, 0x79, 0x42, 0xF2, 0x95,  // PV..yB..
            /* 0018 */  0x7B, 0x4D, 0x34, 0x43, 0x93, 0x87, 0xAC, 0xCD,  // {M4C....
            /* 0020 */  0xC6, 0x7E, 0xF6, 0x1C, 0x81, 0x00, 0x01, 0x08,  // .~......
            /* 0028 */  0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,  // !...f...
            /* 0030 */  0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,  // ......).
            /* 0038 */  0x5A, 0x5A, 0x01, 0x00                           // ZZ..
        })
        Method (WVPI, 3, Serialized)
        {
            CreateDWordField (Arg2, Zero, FSNI)
            CreateDWordField (Arg2, 0x04, FCOM)
            CreateDWordField (Arg2, 0x08, FCMT)
            CreateDWordField (Arg2, 0x0C, FDAS)
            Local0 = Zero
            RTCD = 0x03
            Local1 = Package (0x02)
                {
                    Zero,
                    Zero
                }
            If ((FDAS > 0x1060))
            {
                RTCD = 0x05
                Local1 [Zero] = One
            }
            Else
            {
                Name (PVSZ, Package (0x05)
                {
                    Zero,
                    0x04,
                    0x80,
                    0x0400,
                    0x1000
                })
                Local0 = Zero
                If (((Arg1 >= One) && (Arg1 <= 0x05)))
                {
                    Local0 = DerefOf (PVSZ [(Arg1 - One)])
                }

                DASO = Local0
                SNIN = FSNI /* \_SB_.WMIV.WVPI.FSNI */
                COMD = FCOM /* \_SB_.WMIV.WVPI.FCOM */
                CMTP = FCMT /* \_SB_.WMIV.WVPI.FCMT */
                DASI = FDAS /* \_SB_.WMIV.WVPI.FDAS */
                If ((FDAS > Zero))
                {
                    CreateField (Arg2, 0x80, (FDAS * 0x08), FDAI)
                    PVWB = FDAI /* \_SB_.WMIV.WVPI.FDAI */
                }

                Local1 [One] = Local0
            }

            Return (Local1)
        }

        Method (HVWA, 0, Serialized)
        {
            Local2 = HVWC (COMD, CMTP, DASI, PVWB)
            Local0 = DerefOf (Local2 [Zero])
            If (((Local0 == 0x03) || (Local0 == 0x04)))
            {
                Local2 = HVWP (COMD, CMTP, DASI, PVWB)
            }

            Return (Local2)
        }

        Method (WVPO, 2, Serialized)
        {
            Local1 = Buffer ((0x08 + Arg0)){}
            CreateDWordField (Local1, Zero, FSNO)
            CreateDWordField (Local1, 0x04, FRTC)
            If ((ObjectType (Arg1) == 0x04))
            {
                FRTC = DerefOf (Arg1 [Zero])
                Local0 = Zero
                If ((SizeOf (Arg1) == 0x02))
                {
                    Local2 = DerefOf (Arg1 [One])
                    Local0 = SizeOf (Local2)
                }
            }
            Else
            {
                FRTC = RTCD /* \RTCD */
                Local0 = DASO /* \DASO */
            }

            If ((Local0 > Arg0))
            {
                FRTC = 0x05
            }
            ElseIf (((Local0 > Zero) && (Local0 <= 0x1060)))
            {
                CreateField (Local1, 0x40, (Local0 * 0x08), FDAO)
                If ((ObjectType (Arg1) == 0x04))
                {
                    FDAO = Local2
                }
                Else
                {
                    Local2 = PVWB /* \PVWB */
                    CreateField (Local2, Zero, (Local0 * 0x08), FDAI)
                    FDAO = FDAI /* \_SB_.WMIV.WVPO.FDAI */
                }
            }

            If ((Zero == (FRTC & 0xFFFF)))
            {
                FSNO = 0x53534150
            }
            Else
            {
                FSNO = 0x4C494146
            }

            Return (Local1)
        }

        Method (WVCM, 0, Serialized)
        {
            SNIN = Zero
            COMD = Zero
            CMTP = Zero
            DASI = Zero
            DASO = Zero
            PVWB = ZOBF /* \_SB_.WMIV.ZOBF */
            PVWS = Zero
            RTCD = Zero
        }

        Method (WMPV, 3, Serialized)
        {
            Local4 = WVPI (Arg0, Arg1, Arg2)
            Local0 = DerefOf (Local4 [Zero])
            Local3 = DerefOf (Local4 [One])
            If ((Local0 == Zero))
            {
                PVWS = 0x03
                GSWS (0x80F3)
                If ((PVWS == 0x03))
                {
                    Local2 = HVWA ()
                }
                ElseIf ((PVWS == 0x05))
                {
                    Local6 = HVWA ()
                    If ((0x00010000 != DerefOf (Local6 [Zero])))
                    {
                        Local2 = Local6
                    }
                }
                Else
                {
                    Local5 = Zero
                    While (((PVWS == 0x04) && (Local5 < 0x8000)))
                    {
                        Sleep (0x19)
                        PVWS = 0x03
                        GSWS (0x80F3)
                        Local5++
                    }
                }
            }

            Local1 = WVPO (Local3, Local2)
            If ((Local0 == Zero))
            {
                WVCM ()
            }

            Return (Local1)
        }

        Name (VEI1, Zero)
        Name (VED1, Zero)
        Name (VEI2, Zero)
        Name (VED2, Zero)
        Name (VEVI, Zero)
        Mutex (VEMX, 0x00)
        Method (_WED, 1, Serialized)  // _Wxx: Wake Event, xx=0x00-0xFF
        {
            Local0 = Buffer (0x08)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                }
            CreateDWordField (Local0, Zero, EVID)
            CreateDWordField (Local0, 0x04, EVDA)
            EVID = VEI1 /* \_SB_.WMIV.VEI1 */
            EVDA = VED1 /* \_SB_.WMIV.VED1 */
            Acquire (VEMX, 0xFFFF)
            If ((VEI2 != Zero))
            {
                VEI1 = VEI2 /* \_SB_.WMIV.VEI2 */
                VED1 = VED2 /* \_SB_.WMIV.VED2 */
                VEI2 = Zero
                VED2 = Zero
                If ((VEVI == Zero))
                {
                    VEVI = One
                    Notify (WMIV, 0x81) // Information Change
                }
            }
            Else
            {
                VEI1 = Zero
                VED1 = Zero
            }

            Release (VEMX)
            Return (Local0)
        }

        Method (GVWE, 2, Serialized)
        {
            Acquire (VEMX, 0xFFFF)
            If ((VEI1 == Zero))
            {
                VEI1 = Arg0
                VED1 = Arg1
            }
            Else
            {
                VEI2 = Arg0
                VED2 = Arg1
            }

            Release (VEMX)
            Notify (WMIV, 0x81) // Information Change
        }
    }

    OperationRegion (HPCF, SystemMemory, 0x7EF86000, 0x0000003A)
    Field (HPCF, AnyAcc, Lock, Preserve)
    {
        SPPB,   8,
        PPPB,   8,
        ILUX,   8,
        NFCS,   8,
        USWE,   8,
        EAX,    32,
        EBX,    32,
        ECX,    32,
        EDX,    32,
        REFS,   32,
        SSCI,   8,
        WOLE,   8,
        WMIF,   8,
        WMIT,   8,
        WMIH,   8,
        DFUE,   8,
        TPLE,   8,
        THDA,   16,
        TPSA,   16,
        SMAE,   8,
        PFKB,   8,
        CABS,   8,
        IWRS,   8,
        ISCM,   8,
        CAIO,   16,
        CAIR,   16,
        CBIO,   16,
        CBIR,   16,
        CCIO,   16,
        CCIR,   16,
        CDIO,   16,
        CDIR,   16,
        LRES,   8
    }

    Name (SS1, One)
    Name (SS2, Zero)
    Name (SS3, One)
    Name (SS4, One)
    OperationRegion (GNVS, SystemMemory, 0x7EF8A000, 0x00000147)
    Field (GNVS, AnyAcc, NoLock, Preserve)
    {
        DAS1,   8,
        DAS3,   8,
        TNBH,   8,
        TCP0,   8,
        TCP1,   8,
        ATNB,   8,
        PCP0,   8,
        PCP1,   8,
        PWMN,   8,
        LPTY,   8,
        M92D,   8,
        WKPM,   8,
        ALST,   8,
        AFUC,   8,
        EXUS,   8,
        AIRC,   8,
        WLSH,   8,
        TSSS,   8,
        ODZC,   8,
        PCBA,   32,
        PCBL,   32,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        BRTL,   8,
        TLST,   8,
        IGDS,   8,
        LCDA,   16,
        CSTE,   16,
        NSTE,   16,
        CADL,   16,
        PADL,   16,
        LIDS,   8,
        PWRS,   8,
        BVAL,   32,
        ADDL,   16,
        BCMD,   8,
        SBFN,   8,
        DID,    32,
        INFO,   2048,
        TOML,   8,
        TOMH,   8,
        CEBP,   8,
        C0LS,   8,
        C1LS,   8,
        C0HS,   8,
        C1HS,   8,
        ROMS,   32,
        MUXF,   8,
        PDDN,   8,
        CPUF,   8
    }

    Scope (_SB)
    {
        Name (PR00, Package (0x2B)
        {
            Package (0x04)
            {
                0x0011FFFF,
                Zero,
                LNKE,
                Zero
            },

            Package (0x04)
            {
                0x0012FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0012FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0013FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0013FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0010FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0010FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0014FFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0014FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0014FFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0014FFFF,
                0x03,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0015FFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0015FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0015FFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0015FFFF,
                0x03,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0016FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0016FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0001FFFF,
                Zero,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0001FFFF,
                One,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0002FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0002FFFF,
                One,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0002FFFF,
                0x02,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0002FFFF,
                0x03,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0003FFFF,
                Zero,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0003FFFF,
                One,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0003FFFF,
                0x02,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0003FFFF,
                0x03,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x03,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x02,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x03,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0006FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0006FFFF,
                One,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0006FFFF,
                0x02,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0006FFFF,
                0x03,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0007FFFF,
                Zero,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0x0007FFFF,
                One,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0x0007FFFF,
                0x02,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0x0007FFFF,
                0x03,
                LNKC,
                Zero
            }
        })
        Name (AR00, Package (0x2D)
        {
            Package (0x04)
            {
                0x0011FFFF,
                Zero,
                Zero,
                0x14
            },

            Package (0x04)
            {
                0x0012FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0012FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0013FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0013FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0010FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0010FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0014FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0014FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0014FFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0014FFFF,
                0x03,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0015FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0015FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0015FFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0015FFFF,
                0x03,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0016FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0016FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0001FFFF,
                Zero,
                Zero,
                0x1A
            },

            Package (0x04)
            {
                0x0001FFFF,
                One,
                Zero,
                0x1B
            },

            Package (0x04)
            {
                0x0001FFFF,
                0x02,
                Zero,
                0x18
            },

            Package (0x04)
            {
                0x0001FFFF,
                0x03,
                Zero,
                0x19
            },

            Package (0x04)
            {
                0x0002FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0002FFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0002FFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0002FFFF,
                0x03,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0003FFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0003FFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0003FFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0003FFFF,
                0x03,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0004FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0004FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x03,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x02,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x03,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0006FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0006FFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0006FFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0006FFFF,
                0x03,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0007FFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0007FFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0007FFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0007FFFF,
                0x03,
                Zero,
                0x12
            }
        })
        Name (AR11, Package (0x2D)
        {
            Package (0x04)
            {
                0x0011FFFF,
                Zero,
                Zero,
                0x14
            },

            Package (0x04)
            {
                0x0012FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0012FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0013FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0013FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0010FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0010FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0014FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0014FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0014FFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0014FFFF,
                0x03,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0015FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0015FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0015FFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0015FFFF,
                0x03,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0016FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0016FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0001FFFF,
                Zero,
                Zero,
                0x1A
            },

            Package (0x04)
            {
                0x0001FFFF,
                One,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0001FFFF,
                0x02,
                Zero,
                0x18
            },

            Package (0x04)
            {
                0x0001FFFF,
                0x03,
                Zero,
                0x19
            },

            Package (0x04)
            {
                0x0002FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0002FFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0002FFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0002FFFF,
                0x03,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0003FFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0003FFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0003FFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0003FFFF,
                0x03,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0004FFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0004FFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x03,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x02,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x03,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0006FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0006FFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0006FFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0006FFFF,
                0x03,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0007FFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0x0007FFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0x0007FFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0x0007FFFF,
                0x03,
                Zero,
                0x12
            }
        })
        Name (PR01, Package (0x02)
        {
            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                LNKD,
                Zero
            }
        })
        Name (AR01, Package (0x02)
        {
            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                Zero,
                0x13
            }
        })
        Name (PR02, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKB,
                Zero
            }
        })
        Name (AR02, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x11
            }
        })
        Name (PR03, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKC,
                Zero
            }
        })
        Name (AR03, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x12
            }
        })
        Name (PR04, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKD,
                Zero
            }
        })
        Name (AR04, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x13
            }
        })
        Name (PR05, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKA,
                Zero
            }
        })
        Name (AR05, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x10
            }
        })
        Name (PR06, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKB,
                Zero
            }
        })
        Name (AR06, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x11
            }
        })
        Name (PR07, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKC,
                Zero
            }
        })
        Name (AR07, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x12
            }
        })
        Name (PR09, Package (0x08)
        {
            Package (0x04)
            {
                0x0004FFFF,
                Zero,
                LNKF,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                One,
                LNKG,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x02,
                LNKH,
                Zero
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x03,
                LNKE,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                LNKE,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                LNKF,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x02,
                LNKG,
                Zero
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x03,
                LNKH,
                Zero
            }
        })
        Name (AR09, Package (0x08)
        {
            Package (0x04)
            {
                0x0004FFFF,
                Zero,
                Zero,
                0x15
            },

            Package (0x04)
            {
                0x0004FFFF,
                One,
                Zero,
                0x16
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x02,
                Zero,
                0x17
            },

            Package (0x04)
            {
                0x0004FFFF,
                0x03,
                Zero,
                0x14
            },

            Package (0x04)
            {
                0x0005FFFF,
                Zero,
                Zero,
                0x14
            },

            Package (0x04)
            {
                0x0005FFFF,
                One,
                Zero,
                0x15
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x02,
                Zero,
                0x16
            },

            Package (0x04)
            {
                0x0005FFFF,
                0x03,
                Zero,
                0x17
            }
        })
        Name (PR0A, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKD,
                Zero
            }
        })
        Name (AR0A, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x13
            }
        })
        Name (PR0B, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKA,
                Zero
            }
        })
        Name (AR0B, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x10
            }
        })
        Name (PR0C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKB,
                Zero
            }
        })
        Name (AR0C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x11
            }
        })
        Name (PR0D, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKC,
                Zero
            }
        })
        Name (AR0D, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x12
            }
        })
        Name (PR30, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKD,
                Zero
            }
        })
        Name (AR30, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x18
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x19
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x1A
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x1B
            }
        })
        Name (PR32, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKD,
                Zero
            }
        })
        Name (AR32, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x20
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x21
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x22
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x23
            }
        })
        Name (PR12, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKD,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKB,
                Zero
            }
        })
        Name (AR12, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x13
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x11
            }
        })
        Name (PR14, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                LNKA,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                LNKB,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                LNKC,
                Zero
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                LNKD,
                Zero
            }
        })
        Name (AR14, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF,
                Zero,
                Zero,
                0x10
            },

            Package (0x04)
            {
                0xFFFF,
                One,
                Zero,
                0x11
            },

            Package (0x04)
            {
                0xFFFF,
                0x02,
                Zero,
                0x12
            },

            Package (0x04)
            {
                0xFFFF,
                0x03,
                Zero,
                0x13
            }
        })
        Method (DSPI, 0, NotSerialized)
        {
            INTA (0x1F)
            INTB (0x1F)
            INTC (0x1F)
            INTD (0x1F)
            Local1 = PD64 /* \PD64 */
            PIRE = 0x1F
            PIRF = 0x1F
            PIRG = 0x1F
            PIRH = 0x1F
        }

        Method (BSMI, 1, NotSerialized)
        {
            APMD = Arg0
            APMC = 0xBE
            Stall (0xFF)
        }

        Method (S80H, 1, NotSerialized)
        {
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
        }

        Method (GSMI, 1, NotSerialized)
        {
            APMD = Arg0
            APMC = 0xE4
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
        }

        Method (ALIC, 2, NotSerialized)
        {
            If ((Arg0 == 0x07))
            {
                If ((Arg1 == Zero))
                {
                    ^PCI0.SMBS.O053 = Zero
                    ^PCI0.SMBS.E053 = Zero
                }
                Else
                {
                    ^PCI0.SMBS.O053 = One
                    ^PCI0.SMBS.E053 = Zero
                }
            }

            If ((Arg0 == 0x04))
            {
                If ((Arg1 == Zero))
                {
                    ^PCI0.SMBS.O025 = Zero
                    ^PCI0.SMBS.E025 = Zero
                }
                Else
                {
                    ^PCI0.SMBS.O025 = One
                    ^PCI0.SMBS.E025 = Zero
                }
            }

            If ((Arg0 == 0x05))
            {
                If ((Arg1 == Zero))
                {
                    ^PCI0.SMBS.O000 = Zero
                    ^PCI0.SMBS.E000 = Zero
                }
                Else
                {
                    ^PCI0.SMBS.O000 = One
                    ^PCI0.SMBS.E000 = Zero
                }
            }

            If ((Arg0 == 0x06))
            {
                If ((Arg1 == Zero))
                {
                    ^PCI0.SMBS.O027 = Zero
                    ^PCI0.SMBS.E027 = Zero
                }
                Else
                {
                    ^PCI0.SMBS.O027 = One
                    ^PCI0.SMBS.E027 = Zero
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            OperationRegion (SCTH, PCI_Config, 0x7A, One)
            Field (SCTH, ByteAcc, NoLock, Preserve)
            {
                RSMF,   1
            }

            OperationRegion (NBMS, PCI_Config, 0x60, 0x08)
            Field (NBMS, DWordAcc, NoLock, Preserve)
            {
                MIDX,   32,
                MIDR,   32
            }

            Mutex (NBMM, 0x00)
            Method (NBMR, 1, NotSerialized)
            {
                Acquire (NBMM, 0xFFFF)
                Local0 = (Arg0 & 0x7F)
                MIDX = Local0
                Local0 = MIDR /* \_SB_.PCI0.MIDR */
                MIDX = 0x7F
                Release (NBMM)
                Return (Local0)
            }

            Method (NBMW, 2, NotSerialized)
            {
                Acquire (NBMM, 0xFFFF)
                Local0 = (Arg0 & 0x7F)
                Local0 |= 0x80
                MIDX = Local0
                MIDR = Arg1
                MIDX = Local0 &= 0x7F
                Release (NBMM)
            }

            OperationRegion (NBXP, PCI_Config, 0xE0, 0x08)
            Field (NBXP, DWordAcc, NoLock, Preserve)
            {
                NBXI,   32,
                NBXD,   32
            }

            Mutex (NBXM, 0x00)
            Method (NBXR, 1, NotSerialized)
            {
                Acquire (NBXM, 0xFFFF)
                NBXI = Arg0
                Local0 = NBXD /* \_SB_.PCI0.NBXD */
                NBXI = Zero
                Release (NBXM)
                Return (Local0)
            }

            Method (NBXW, 2, NotSerialized)
            {
                Acquire (NBXM, 0xFFFF)
                NBXI = Arg0
                NBXD = Arg1
                NBXI = Zero
                Release (NBXM)
            }

            Method (XPTR, 2, NotSerialized)
            {
                If (((Arg0 < 0x02) && (Arg0 > 0x07)))
                {
                    Return (Zero)
                }
                Else
                {
                    If ((Arg0 < 0x04))
                    {
                        Local1 = (Arg0 - 0x02)
                        Local0 = 0x01310800
                    }
                    Else
                    {
                        Local1 = (Arg0 - 0x04)
                        Local0 = 0x01300900
                    }

                    Local0 += (Local1 << 0x08)
                    Local0 <<= Local1
                    NBXW (Local0, Arg1)
                    Return (Ones)
                }
            }

            Method (XPLP, 2, NotSerialized)
            {
            }

            Method (XPLL, 2, NotSerialized)
            {
            }

            Name (_UID, One)  // _UID: Unique ID
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Name (AMHP, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x1D
                    If (~(CDW1 & One))
                    {
                        If ((CTRL & One)){}
                        If ((CTRL & 0x10)){}
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Method (TOM, 0, NotSerialized)
            {
                Local0 = (TOML * 0x00010000)
                Local1 = (TOMH * 0x01000000)
                Local0 += Local1
                Return (Local0)
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, SubDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    0x00,, )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    0x00,, , TypeStatic, DenseTranslation)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x80000000,         // Range Minimum
                    0xF7FFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x78000000,         // Length
                    0x00,, _Y00, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFC000000,         // Range Minimum
                    0xFED3FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x02D40000,         // Length
                    0x00,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFED45000,         // Range Minimum
                    0xFFFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x012BB000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
            })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (CRES, \_SB.PCI0._Y00._MIN, BTMN)  // _MIN: Minimum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y00._MAX, BTMX)  // _MAX: Maximum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y00._LEN, BTLN)  // _LEN: Length
                CreateDWordField (CRES, \_SB.PCI0._Y01._MIN, BTN1)  // _MIN: Minimum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y01._MAX, BTX1)  // _MAX: Maximum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y01._LEN, BTL1)  // _LEN: Length
                BTMN = TOM ()
                BTMX = (PCBA - One)
                BTLN = (PCBA - BTMN) /* \_SB_.PCI0._CRS.BTMN */
                BTN1 = (PCBL + One)
                BTL1 = (BTX1 - BTN1) /* \_SB_.PCI0._CRS.BTN1 */
                BTL1 += One
                Return (CRES) /* \_SB_.PCI0.CRES */
            }

            Method (XCMP, 2, NotSerialized)
            {
                If ((0x10 != SizeOf (Arg0)))
                {
                    Return (Zero)
                }

                If ((0x10 != SizeOf (Arg1)))
                {
                    Return (Zero)
                }

                Local0 = Zero
                While ((Local0 < 0x10))
                {
                    If ((DerefOf (Arg0 [Local0]) != DerefOf (Arg1 [Local0]
                        )))
                    {
                        Return (Zero)
                    }

                    Local0++
                }

                Return (One)
            }

            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    If ((CPUF == 0x61))
                    {
                        Return (AR11) /* \_SB_.AR11 */
                    }
                    Else
                    {
                        Return (AR00) /* \_SB_.AR00 */
                    }
                }

                Return (PR00) /* \_SB_.PR00 */
            }

            Device (VGA)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }

            Device (PB21)
            {
                Method (_ADR, 0, NotSerialized)  // _ADR: Address
                {
                    If ((CPUF == 0x61))
                    {
                        Return (0x00020000)
                    }
                    ElseIf ((CPUF == 0x63))
                    {
                        Return (0x00020001)
                    }
                    Else
                    {
                        Return (0x00020001)
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If ((CPUF == 0x61))
                        {
                            Return (AR12) /* \_SB_.AR12 */
                        }
                        ElseIf ((CPUF == 0x63))
                        {
                            Return (AR30) /* \_SB_.AR30 */
                        }
                        Else
                        {
                            Return (AR30) /* \_SB_.AR30 */
                        }
                    }

                    If ((CPUF == 0x61))
                    {
                        Return (PR12) /* \_SB_.PR12 */
                    }
                    ElseIf ((CPUF == 0x63))
                    {
                        Return (PR30) /* \_SB_.PR30 */
                    }
                    Else
                    {
                        Return (PR30) /* \_SB_.PR30 */
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x16, 0x04))
                }

                Device (PEDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x16, 0x04))
                    }

                    Name (WRDX, Package (0x03)
                    {
                        Zero,
                        Package (0x02)
                        {
                            0x80000000,
                            0x8000
                        },

                        Package (0x02)
                        {
                            0x80000000,
                            0x8000
                        }
                    })
                    Method (WRDD, 0, Serialized)
                    {
                        Name (WRDX, Package (0x02)
                        {
                            Zero,
                            Package (0x02)
                            {
                                0x07,
                                0x4510
                            }
                        })
                        If ((IWRS == One))
                        {
                            DerefOf (WRDX [One]) [One] = 0x4944
                        }

                        Return (WRDX) /* \_SB_.PCI0.PB21.PEDV.WRDD.WRDX */
                    }
                }
            }

            Device (PB31)
            {
                Method (_ADR, 0, NotSerialized)  // _ADR: Address
                {
                    If ((CPUF == 0x61))
                    {
                        Return (0x00040000)
                    }
                    ElseIf ((CPUF == 0x63))
                    {
                        Return (0x00030001)
                    }
                    Else
                    {
                        Return (0x00030001)
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If ((CPUF == 0x61))
                        {
                            Return (AR14) /* \_SB_.AR14 */
                        }
                        ElseIf ((CPUF == 0x63))
                        {
                            Return (AR32) /* \_SB_.AR32 */
                        }
                        Else
                        {
                            Return (AR32) /* \_SB_.AR32 */
                        }
                    }

                    If ((CPUF == 0x61))
                    {
                        Return (PR14) /* \_SB_.PR14 */
                    }
                    ElseIf ((CPUF == 0x63))
                    {
                        Return (PR32) /* \_SB_.PR32 */
                    }
                    Else
                    {
                        Return (PR32) /* \_SB_.PR32 */
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x16, 0x04))
                }

                Device (PEDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x16, 0x04))
                    }

                    Name (WRDX, Package (0x03)
                    {
                        Zero,
                        Package (0x02)
                        {
                            0x80000000,
                            0x8000
                        },

                        Package (0x02)
                        {
                            0x80000000,
                            0x8000
                        }
                    })
                    Method (WRDD, 0, Serialized)
                    {
                        Name (WRDX, Package (0x02)
                        {
                            Zero,
                            Package (0x02)
                            {
                                0x07,
                                0x4510
                            }
                        })
                        If ((IWRS == One))
                        {
                            DerefOf (WRDX [One]) [One] = 0x4944
                        }

                        Return (WRDX) /* \_SB_.PCI0.PB31.PEDV.WRDD.WRDX */
                    }
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x00140003)  // _ADR: Address
                Mutex (PSMX, 0x00)
                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (((HPAD & 0x03) == 0x03))
                        {
                            Return (BUF0) /* \_SB_.PCI0.LPCB.RTC_.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.LPCB.RTC_.BUF1 */
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800") /* Microsoft Sound System Compatible Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (((HPAD & 0x03) == 0x03))
                        {
                            Return (BUF0) /* \_SB_.PCI0.LPCB.TMR_.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.LPCB.TMR_.BUF1 */
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0xD0,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D6,             // Range Minimum
                            0x04D6,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0680,             // Range Minimum
                            0x0680,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x077A,             // Range Minimum
                            0x077A,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C00,             // Range Minimum
                            0x0C00,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0C14,             // Range Minimum
                            0x0C14,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C50,             // Range Minimum
                            0x0C50,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0C6C,             // Range Minimum
                            0x0C6C,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C6F,             // Range Minimum
                            0x0C6F,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0CD0,             // Range Minimum
                            0x0CD0,             // Range Maximum
                            0x01,               // Alignment
                            0x0C,               // Length
                            )
                        IO (Decode16,
                            0x0840,             // Range Minimum
                            0x0840,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
                    Name (MSRC, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFF00000,         // Address Base
                            0x00100000,         // Address Length
                            _Y02)
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (MSRC, \_SB.PCI0.LPCB.MEM._Y02._LEN, PSIZ)  // _LEN: Length
                        CreateDWordField (MSRC, \_SB.PCI0.LPCB.MEM._Y02._BAS, PBAS)  // _BAS: Base Address
                        PSIZ = ROMS /* \ROMS */
                        Local0 = (ROMS - One)
                        PBAS = (0xFFFFFFFF - Local0)
                        Return (MSRC) /* \_SB_.PCI0.LPCB.MEM_.MSRC */
                    }
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (_GPE, 0x08)  // _GPE: General Purpose Events
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Mutex (ECMX, 0x00)
                    Name (ECRG, Zero)
                    Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                    {
                        If ((Arg0 == 0x03))
                        {
                            ECRG = Arg1
                        }
                    }

                    OperationRegion (SSRM, EmbeddedControl, 0x50, 0x0A)
                    Field (SSRM, ByteAcc, NoLock, Preserve)
                    {
                        FBCM,   8,
                        FBGI,   8,
                        FBAE,   8,
                        FBCB,   8,
                        FBW1,   8,
                        FBW2,   8,
                        Offset (0x07),
                        FBID,   8,
                        FUAE,   8,
                        FRPS,   8
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP030B"))  // _CID: Compatible ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            FixedIO (
                                0x0060,             // Address
                                0x01,               // Length
                                )
                            FixedIO (
                                0x0064,             // Address
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {1}
                        }
                        EndDependentFn ()
                    })
                    Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                    {
                        KBFG = Arg0
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x16, 0x03))
                    }
                }

                Device (PS2M)
                {
                    Method (_HID, 0, NotSerialized) { Return ("PNP0F13") }

                    Name (_CID, Package (0x03)  // _CID: Compatible ID
                    {
                        EisaId ("SYN0100"),
                        EisaId ("SYN0002"),
                        EisaId ("PNP0F13") /* PS/2 Mouse */
                    })

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQNoFlags ()
                            {12}
                    })

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IRQNoFlags ()
                                {12}
                        }
                        EndDependentFn ()
                    })

                    Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                    {
                        MSFG = Arg0
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x16, 0x03))
                    }
                }

                Scope (\)
                {
                    Name (KBFG, One)
                    Name (MSFG, One)
                }

                OperationRegion (LPC0, PCI_Config, 0x44, 0x08)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    LLPE,   6,
                    CALE,   8,
                        ,   1,
                    CBLE,   3
                }

                Name (CDC, Package (0x08)
                {
                    0x03F8,
                    0x02F8,
                    0x0220,
                    0x0228,
                    0x0238,
                    0x02E8,
                    0x0338,
                    0x03E8
                })
                Name (LPD, Package (0x03)
                {
                    0x0378,
                    0x0278,
                    0x03BC
                })
                Method (DCS, 3, NotSerialized)
                {
                    Local1 = Zero
                    Local0 = Match (Arg0, MEQ, Arg1, MTR, Zero, Zero)
                    If ((Local0 != Ones))
                    {
                        Local2 = (One << Arg2)
                        Local2--
                        Local1 = (Local2 << (Local0 * Arg2))
                    }

                    Return (Local1)
                }

                Method (DPD, 2, Serialized)
                {
                    Local7 = (Arg0 & 0x0F)
                    If (((Arg0 & 0xF0) == Zero))
                    {
                        If ((Local7 == One))
                        {
                            LLPE = Zero
                        }
                        ElseIf ((Local7 == 0x02))
                        {
                            Local1 = ~DCS (CDC, Arg1, One)
                            CALE &= Local1
                        }
                        Else
                        {
                        }
                    }
                    Else
                    {
                        DPD2 (Arg0)
                    }
                }

                Method (EPD, 2, Serialized)
                {
                    Local7 = (Arg0 & 0x0F)
                    If (((Arg0 & 0xF0) == Zero))
                    {
                        If ((Local7 == One))
                        {
                            LLPE |= DCS (LPD, Arg1, 0x02)
                        }
                        ElseIf ((Local7 == 0x02))
                        {
                            CALE |= DCS (CDC, Arg1, One)
                        }
                        Else
                        {
                        }
                    }
                    Else
                    {
                        EPD2 (Arg0, Arg1)
                    }
                }

                Method (CFGL, 4, Serialized)
                {
                    If ((Arg1 == Zero))
                    {
                        DPD (Arg0, Arg1)
                    }
                    Else
                    {
                        EPD (Arg0, Arg1)
                    }
                }

                Name (CPRS, ResourceTemplate ()
                {
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03F8,             // Range Minimum
                            0x03F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {4}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x02F8,             // Range Minimum
                            0x02F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03E8,             // Range Minimum
                            0x03E8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {4}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x02E8,             // Range Minimum
                            0x02E8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3}
                    }
                    StartDependentFn (0x02, 0x00)
                    {
                        IO (Decode16,
                            0x03F8,             // Range Minimum
                            0x03F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,5,7,10}
                    }
                    StartDependentFn (0x02, 0x00)
                    {
                        IO (Decode16,
                            0x02F8,             // Range Minimum
                            0x02F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {4,5,7,10}
                    }
                    StartDependentFn (0x02, 0x00)
                    {
                        IO (Decode16,
                            0x03E8,             // Range Minimum
                            0x03E8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,5,7,10}
                    }
                    StartDependentFn (0x02, 0x00)
                    {
                        IO (Decode16,
                            0x02E8,             // Range Minimum
                            0x02E8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {4,5,7,10}
                    }
                    EndDependentFn ()
                })
                Name (LPRS, ResourceTemplate ()
                {
                    StartDependentFn (0x00, 0x00)
                    {
                        IO (Decode16,
                            0x0378,             // Range Minimum
                            0x0378,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0778,             // Range Minimum
                            0x0778,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {5,7,10,11,14,15}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {1,2,3}
                    }
                    StartDependentFn (0x00, 0x00)
                    {
                        IO (Decode16,
                            0x0278,             // Range Minimum
                            0x0278,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0678,             // Range Minimum
                            0x0678,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {5,7,10,11,14,15}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {1,2,3}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03BC,             // Range Minimum
                            0x03BC,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x07BC,             // Range Minimum
                            0x07BC,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {5,7,10,11,14,15}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {1,2,3}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0378,             // Range Minimum
                            0x0378,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0778,             // Range Minimum
                            0x0778,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {5,7,10,11,14,15}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0278,             // Range Minimum
                            0x0278,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0678,             // Range Minimum
                            0x0678,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {5,7,10,11,14,15}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03BC,             // Range Minimum
                            0x03BC,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x07BC,             // Range Minimum
                            0x07BC,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {5,7,10,11,14,15}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0378,             // Range Minimum
                            0x0378,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0778,             // Range Minimum
                            0x0778,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0278,             // Range Minimum
                            0x0278,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0678,             // Range Minimum
                            0x0678,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03BC,             // Range Minimum
                            0x03BC,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x07BC,             // Range Minimum
                            0x07BC,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IRQNoFlags ()
                            {}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    }
                    EndDependentFn ()
                })
                Device (SIO1)
                {
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (SCFA, 0x2E)
                    Scope (\_SB)
                    {
                        Device (WMIS)
                        {
                            Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
                            Name (_UID, 0x03)  // _UID: Unique ID
                            Name (_WDG, Buffer (0x50)
                            {
                                /* 0000 */  0x35, 0x64, 0x1F, 0x8F, 0x42, 0x9F, 0xC8, 0x42,  // 5d..B..B
                                /* 0008 */  0xBA, 0xDC, 0x0E, 0x94, 0x24, 0xF2, 0x0C, 0x9A,  // ....$...
                                /* 0010 */  0x41, 0x45, 0x06, 0x00, 0x18, 0x43, 0x81, 0x2B,  // AE...C.+
                                /* 0018 */  0xE8, 0x4B, 0x07, 0x47, 0x9D, 0x84, 0xA1, 0x90,  // .K.G....
                                /* 0020 */  0xA8, 0x59, 0xB5, 0xD0, 0xA0, 0x00, 0x01, 0x08,  // .Y......
                                /* 0028 */  0x2D, 0x7C, 0x22, 0x41, 0xE1, 0x80, 0x3F, 0x42,  // -|"A..?B
                                /* 0030 */  0x8B, 0x8E, 0x87, 0xE3, 0x27, 0x55, 0xA0, 0xEB,  // ....'U..
                                /* 0038 */  0x42, 0x43, 0x08, 0x00, 0x21, 0x12, 0x90, 0x05,  // BC..!...
                                /* 0040 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f.......
                                /* 0048 */  0xC9, 0x06, 0x29, 0x10, 0x5A, 0x5A, 0x01, 0x00   // ..).ZZ..
                            })
                            Name (SEN1, Package (0x06)
                            {
                                Package (0x0F)
                                {
                                    "CPU Fan Speed",
                                    "Reports CPU fan speed",
                                    0x0C,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Stalled",
                                    "Not Present",
                                    "",
                                    "",
                                    0x13,
                                    Zero,
                                    Zero,
                                    Zero
                                },

                                Package (0x0F)
                                {
                                    "Front Chassis Fan Speed",
                                    "Reports front chassis fan speed",
                                    0x0C,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Stalled",
                                    "Not Present",
                                    "",
                                    "",
                                    0x13,
                                    Zero,
                                    Zero,
                                    Zero
                                },

                                Package (0x0F)
                                {
                                    "Rear Chassis Fan Speed",
                                    "Reports rear chassis fan speed",
                                    0x0C,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Stalled",
                                    "Not Present",
                                    "",
                                    "",
                                    0x13,
                                    Zero,
                                    Zero,
                                    Zero
                                },

                                Package (0x0F)
                                {
                                    "Power Supply Fan Speed",
                                    "Reports power supply fan speed",
                                    0x0C,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Stalled",
                                    "Not Present",
                                    "",
                                    "",
                                    0x13,
                                    Zero,
                                    Zero,
                                    Zero
                                },

                                Package (0x0F)
                                {
                                    "CPU Temperature",
                                    "Reports CPU temperature",
                                    0x02,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Caution",
                                    "Critical",
                                    "Not Present",
                                    "",
                                    0x02,
                                    Zero,
                                    Zero,
                                    Zero
                                },

                                Package (0x0F)
                                {
                                    "Chassis Temperature",
                                    "Reports chassis temperature",
                                    0x02,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Caution",
                                    "Critical",
                                    "Not Present",
                                    "",
                                    0x02,
                                    Zero,
                                    Zero,
                                    Zero
                                }
                            })
                            Name (UNKN, Package (0x01)
                            {
                                Package (0x0F)
                                {
                                    "Unknown Sensor",
                                    "Sensor Index not valid",
                                    0x02,
                                    "",
                                    Zero,
                                    0x04,
                                    "Normal",
                                    "Caution",
                                    "Critical",
                                    "Not Present",
                                    "",
                                    0x02,
                                    Zero,
                                    Zero,
                                    Zero
                                }
                            })
                            Method (WQAE, 1, Serialized)
                            {
                                If ((Arg0 < 0x06))
                                {
                                    REGZ ()
                                    ECX = Arg0
                                    SSWP = 0x5E
                                    If ((EDX == Zero))
                                    {
                                        DerefOf (SEN1 [Arg0]) [0x0A] = "Normal"
                                        DerefOf (SEN1 [Arg0]) [0x04] = 0x02
                                    }

                                    If ((EDX == One))
                                    {
                                        DerefOf (SEN1 [Arg0]) [0x0A] = "Caution"
                                        DerefOf (SEN1 [Arg0]) [0x04] = 0x03
                                    }

                                    If ((EDX == 0x02))
                                    {
                                        DerefOf (SEN1 [Arg0]) [0x0A] = "Critical"
                                        DerefOf (SEN1 [Arg0]) [0x04] = 0x05
                                    }

                                    If ((EDX == 0x03))
                                    {
                                        DerefOf (SEN1 [Arg0]) [0x0A] = "Not Present"
                                        DerefOf (SEN1 [Arg0]) [0x04] = 0x0C
                                    }

                                    If ((Arg0 < 0x04))
                                    {
                                        DerefOf (SEN1 [Arg0]) [0x0D] = EAX /* \EAX_ */
                                        If ((EDX == Zero))
                                        {
                                            If ((EAX <= 0xC8))
                                            {
                                                DerefOf (SEN1 [Arg0]) [0x0A] = "Stalled"
                                                DerefOf (SEN1 [Arg0]) [0x04] = 0x0A
                                            }
                                        }
                                    }
                                    Else
                                    {
                                        DerefOf (SEN1 [Arg0]) [0x0D] = EAX /* \EAX_ */
                                    }

                                    REGZ ()
                                    Return (DerefOf (SEN1 [Arg0]))
                                }

                                REGZ ()
                                Return (DerefOf (UNKN [One]))
                            }

                            Name (EVNT, Package (0x08)
                            {
                                Package (0x05)
                                {
                                    "CPU Fan Stall",
                                    "CPU Fan Speed",
                                    0x03,
                                    0x19,
                                    0x05
                                },

                                Package (0x05)
                                {
                                    "Front Chassis Fan Stall",
                                    "Front Chassis Fan Speed",
                                    0x03,
                                    0x19,
                                    0x05
                                },

                                Package (0x05)
                                {
                                    "Rear Chassis Fan Stall",
                                    "Rear Chassis Fan Speed",
                                    0x03,
                                    0x19,
                                    0x05
                                },

                                Package (0x05)
                                {
                                    "Power Supply Fan Stall",
                                    "Power Supply Speed",
                                    0x03,
                                    0x19,
                                    0x05
                                },

                                Package (0x05)
                                {
                                    "Thermal Caution",
                                    "CPU Thermal Index",
                                    0x03,
                                    0x0A,
                                    0x04
                                },

                                Package (0x05)
                                {
                                    "Thermal Critical",
                                    "CPU Thermal Index",
                                    0x03,
                                    0x19,
                                    0x05
                                },

                                Package (0x05)
                                {
                                    "Hood Intrusion",
                                    "The computer cover has been removed",
                                    0x03,
                                    Zero,
                                    One
                                },

                                Package (0x05)
                                {
                                    "USB Type-C Event",
                                    "A USB Type-C event has occurred",
                                    One,
                                    0x05,
                                    0x02
                                }
                            })
                            Method (_WED, 1, Serialized)  // _Wxx: Wake Event, xx=0x00-0xFF
                            {
                                If (WMIT)
                                {
                                    WMIT = Zero
                                    If ((EBX == One))
                                    {
                                        Return (DerefOf (EVNT [0x04]))
                                    }

                                    If ((EBX == 0x02))
                                    {
                                        Return (DerefOf (EVNT [0x05]))
                                    }
                                }

                                If (WMIF)
                                {
                                    WMIF = Zero
                                    Return (DerefOf (EVNT [EAX]))
                                }

                                If (WMIH)
                                {
                                    WMIH = Zero
                                    Return (DerefOf (EVNT [0x06]))
                                }

                                If (SMAE)
                                {
                                    SMAE = Zero
                                    Return (DerefOf (EVNT [0x07]))
                                }

                                REGZ ()
                            }

                            Name (PEVT, Package (0x07)
                            {
                                "",
                                "",
                                "root\\wmi",
                                "HPBIOS_BIOSEvent",
                                Zero,
                                Zero,
                                Zero
                            })
                            Method (WQBC, 1, Serialized)
                            {
                                PEVT [Zero] = DerefOf (DerefOf (EVNT [Arg0]) [
                                    Zero])
                                PEVT [One] = DerefOf (DerefOf (EVNT [Arg0]) [
                                    One])
                                PEVT [0x04] = DerefOf (DerefOf (EVNT [Arg0]) [
                                    0x02])
                                PEVT [0x05] = DerefOf (DerefOf (EVNT [Arg0]) [
                                    0x03])
                                PEVT [0x06] = DerefOf (DerefOf (EVNT [Arg0]) [
                                    0x04])
                                PEVT [0x07] = DerefOf (DerefOf (EVNT [Arg0]) [
                                    0x04])
                                Return (PEVT) /* \_SB_.WMIS.PEVT */
                            }

                            Method (REGZ, 0, Serialized)
                            {
                                EAX = Zero
                                ECX = Zero
                                EDX = Zero
                                EBX = Zero
                            }
                        }
                    }

                    Name (HPID, Package (0x03)
                    {
                        One,
                        0x02,
                        0x04
                    })
                    Name (LDID, Package (0x03)
                    {
                        One,
                        0x03,
                        0x02
                    })
                    Name (SDID, Package (0x03)
                    {
                        One,
                        0x02,
                        0x03
                    })
                    Name (_HID, EisaId ("PNP0A06") /* Generic Container Device */)  // _HID: Hardware ID
                    OperationRegion (SOCG, SystemIO, SCFA, 0x02)
                    Field (SOCG, ByteAcc, NoLock, Preserve)
                    {
                        SIOI,   8,
                        SIOD,   8
                    }

                    IndexField (SIOI, SIOD, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x07),
                        LDN,    8,
                        Offset (0x20),
                        SID,    8,
                        Offset (0x27),
                        SRID,   8,
                        Offset (0x30),
                        ACTV,   1,
                        Offset (0x60),
                        BA0H,   8,
                        BA0L,   8,
                        BA1H,   8,
                        BA1L,   8,
                        Offset (0x70),
                        IRQN,   4,
                        Offset (0x74),
                        DMA0,   3,
                        Offset (0x75),
                        DMA1,   3,
                        Offset (0xF0),
                            ,   5,
                        PMOD,   3
                    }

                    Mutex (SIOM, 0x00)
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Local0 = Zero
                        If ((SID == 0x1E))
                        {
                            Local0 = 0x0F
                        }

                        Return (Local0)
                    }

                    Method (ULDN, 1, Serialized)
                    {
                        Local0 = 0xFFFF
                        Local1 = Match (HPID, MEQ, Arg0, MTR, Zero, Zero)
                        If ((Local0 != Ones))
                        {
                            If (CABS)
                            {
                                Local0 = DerefOf (SDID [Local1])
                                LDN = Local0
                            }
                            Else
                            {
                                Local0 = DerefOf (LDID [Local1])
                                LDN = Local0
                            }
                        }

                        Return (Local0)
                    }

                    Method (GETS, 1, NotSerialized)
                    {
                        Acquire (SIOM, 0xFFFF)
                        Local0 = 0x000FFFFF
                        If ((ULDN (Arg0) != 0xFFFF))
                        {
                            Local0 = Zero
                            If (ACTV)
                            {
                                Local1 = BA0L /* \_SB_.PCI0.LPCB.SIO1.BA0L */
                                Local2 = BA0H /* \_SB_.PCI0.LPCB.SIO1.BA0H */
                                Local0 = (Local1 | (Local2 << 0x08))
                            }
                        }

                        Release (SIOM)
                        Return (Local0)
                    }

                    Method (GETR, 1, NotSerialized)
                    {
                        Name (GRES, Package (0x03)
                        {
                            Zero,
                            Zero,
                            Zero
                        })
                        Acquire (SIOM, 0xFFFF)
                        If ((ULDN (Arg0) != 0xFFFF))
                        {
                            Local0 = BA0L /* \_SB_.PCI0.LPCB.SIO1.BA0L */
                            Local1 = BA0H /* \_SB_.PCI0.LPCB.SIO1.BA0H */
                            GRES [Zero] = ((Local1 << 0x08) | Local0)
                            Local1 = Zero
                            Local0 = IRQN /* \_SB_.PCI0.LPCB.SIO1.IRQN */
                            If ((Local0 > Zero))
                            {
                                Local1 = (One << Local0)
                            }

                            GRES [One] = Local1
                            Local1 = Zero
                            Local0 = DMA0 /* \_SB_.PCI0.LPCB.SIO1.DMA0 */
                            If (((Local0 > Zero) && (Local0 < 0x04)))
                            {
                                Local1 = (One << Local0)
                            }

                            GRES [0x02] = Local1
                        }

                        Release (SIOM)
                        Return (GRES) /* \_SB_.PCI0.LPCB.SIO1.GETR.GRES */
                    }

                    Method (SETR, 4, NotSerialized)
                    {
                        Acquire (SIOM, 0xFFFF)
                        If ((ULDN (Arg0) != 0xFFFF))
                        {
                            ACTV = Zero
                            BA0L = (Arg1 & 0xFF)
                            Local0 = (Arg1 >> 0x08)
                            BA0H = (Local0 & 0xFF)
                            Local0 = Zero
                            FindSetRightBit (Arg2, Local1)
                            If (((Local1 > One) && (Local1 < 0x11)))
                            {
                                Local0 = (Local1 - One)
                            }

                            IRQN = Local0
                            Local0 = 0x04
                            FindSetRightBit (Arg3, Local1)
                            If (((Local1 > One) && (Local1 < 0x05)))
                            {
                                Local0 = (Local1 - One)
                            }

                            DMA0 = Local0
                            If ((Arg1 != Zero))
                            {
                                ACTV = One
                            }
                        }

                        Release (SIOM)
                    }

                    Method (GLPM, 0, NotSerialized)
                    {
                        Acquire (SIOM, 0xFFFF)
                        LDN = One
                        Local0 = PMOD /* \_SB_.PCI0.LPCB.SIO1.PMOD */
                        Release (SIOM)
                        If ((Local0 > 0x03))
                        {
                            Local0 = 0x03
                        }
                        ElseIf ((Local0 == 0x03))
                        {
                            Local0 = 0x02
                        }

                        Return (Local0)
                    }

                    Name (SSCI, 0x0A46)
                    OperationRegion (FSCR, SystemIO, SSCI, One)
                    Field (FSCR, ByteAcc, NoLock, Preserve)
                    {
                        FPME,   1
                    }

                    Method (SIOH, 0, NotSerialized)
                    {
                        If (WMIF)
                        {
                            Notify (WMIS, 0xA0) // Device-Specific
                        }

                        If (WMIT)
                        {
                            Notify (WMIS, 0xA0) // Device-Specific
                        }

                        If (WMIH)
                        {
                            Notify (WMIS, 0xA0) // Device-Specific
                        }

                        If (SMAE)
                        {
                            Notify (WMIS, 0xA0) // Device-Specific
                            ^^^^WMIV.GVWE (0x00020001, Zero)
                        }
                    }

                    Method (SODS, 1, Serialized)
                    {
                        Local0 = Zero
                        Local2 = SFG1 /* \SFG1 */
                        If ((_UID == 0x10))
                        {
                            Local2 = SFG2 /* \SFG2 */
                        }

                        If ((Local2 & Arg0))
                        {
                            Local1 = GETS ((Arg0 & 0x0F))
                            If ((Local1 == Zero))
                            {
                                Local0 = 0x0D
                            }
                            ElseIf ((Local1 <= 0xFFFF))
                            {
                                Local0 = 0x0F
                            }
                        }

                        Return (Local0)
                    }

                    Method (DSOD, 1, Serialized)
                    {
                        Local7 = (Arg0 & 0x0F)
                        If (GETS (Local7))
                        {
                            Local0 = GETR (Local7)
                            Local1 = DerefOf (Local0 [Zero])
                            Local2 = DerefOf (Local0 [One])
                            Local3 = DerefOf (Local0 [0x02])
                            CFGL (Arg0, Zero, Local2, Local3)
                            SETR (Local7, Zero, Zero, Zero)
                        }
                    }

                    Device (COM1)
                    {
                        Method (_UID, 0, NotSerialized)  // _UID: Unique ID
                        {
                            Return ((^^_UID + 0x02))
                        }

                        Method (_DDN, 0, NotSerialized)  // _DDN: DOS Device Name
                        {
                            If ((^^_UID == Zero))
                            {
                                Return ("COM1")
                            }
                            Else
                            {
                                Return ("COM3")
                            }
                        }

                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            If ((LRES == Zero))
                            {
                                Return (CPRS) /* \_SB_.PCI0.LPCB.CPRS */
                            }
                            Else
                            {
                                Name (PRE1, ResourceTemplate ()
                                {
                                    StartDependentFnNoPri ()
                                    {
                                        IO (Decode16,
                                            0x0000,             // Range Minimum
                                            0x0000,             // Range Maximum
                                            0x01,               // Alignment
                                            0x08,               // Length
                                            _Y03)
                                        IRQNoFlags (_Y04)
                                            {0}
                                    }
                                    EndDependentFn ()
                                })
                                CreateWordField (PRE1, \_SB.PCI0.LPCB.SIO1.COM1._PRS._Y03._MIN, MIN1)  // _MIN: Minimum Base Address
                                CreateWordField (PRE1, \_SB.PCI0.LPCB.SIO1.COM1._PRS._Y03._MAX, MAX1)  // _MAX: Maximum Base Address
                                CreateWordField (PRE1, \_SB.PCI0.LPCB.SIO1.COM1._PRS._Y04._INT, IRQ0)  // _INT: Interrupts
                                If ((^^_UID == Zero))
                                {
                                    MIN1 = CAIO /* \CAIO */
                                    MAX1 = CAIO /* \CAIO */
                                    IRQ0 = (One << CAIR) /* \CAIR */
                                }
                                Else
                                {
                                    MIN1 = CCIO /* \CCIO */
                                    MAX1 = CCIO /* \CCIO */
                                    IRQ0 = (One << CCIR) /* \CCIR */
                                }

                                Return (PRE1) /* \_SB_.PCI0.LPCB.SIO1.COM1._PRS.PRE1 */
                            }
                        }

                        Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                        Name (_CID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _CID: Compatible ID
                        Name (RCOD, Zero)
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Local0 = Zero
                            If (CNPS ())
                            {
                                If (!RCOD)
                                {
                                    Local0 = SODS (_UID ())
                                }
                                Else
                                {
                                    Local0 = 0x0D
                                }
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            Local1 = One
                            If (Local1)
                            {
                                DSOD (_UID ())
                            }
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x09, IRQ0)
                            If ((SODS (_UID ()) & One))
                            {
                                _DIS ()
                                CFGL (_UID (), MIN1, IRQ0, Zero)
                                SETR ((_UID () & 0x0F), MIN1, IRQ0, Zero)
                            }

                            RCOD = Zero
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0000,             // Range Minimum
                                    0x0000,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y05)
                                IRQNoFlags (_Y06)
                                    {0}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.COM1._CRS._Y05._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.COM1._CRS._Y05._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.COM1._CRS._Y06._INT, IRQ0)  // _INT: Interrupts
                            If (RCOD)
                            {
                                Local0 = 0x0D
                            }
                            Else
                            {
                                Local0 = SODS (_UID ())
                            }

                            If ((Local0 == 0x0F))
                            {
                                Local1 = GETR ((_UID () & 0x0F))
                                MIN1 = DerefOf (Local1 [Zero])
                                MAX1 = MIN1 /* \_SB_.PCI0.LPCB.SIO1.COM1._CRS.MIN1 */
                                IRQ0 = DerefOf (Local1 [One])
                            }

                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO1.COM1._CRS.CRES */
                        }
                    }

                    Device (COM2)
                    {
                        Method (_UID, 0, NotSerialized)  // _UID: Unique ID
                        {
                            Return ((^^_UID + 0x04))
                        }

                        Method (_DDN, 0, NotSerialized)  // _DDN: DOS Device Name
                        {
                            If ((^^_UID == Zero))
                            {
                                Return ("COM2")
                            }
                            Else
                            {
                                Return ("COM4")
                            }
                        }

                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            If ((LRES == Zero))
                            {
                                Return (CPRS) /* \_SB_.PCI0.LPCB.CPRS */
                            }
                            Else
                            {
                                Name (PRE2, ResourceTemplate ()
                                {
                                    StartDependentFnNoPri ()
                                    {
                                        IO (Decode16,
                                            0x0000,             // Range Minimum
                                            0x0000,             // Range Maximum
                                            0x01,               // Alignment
                                            0x08,               // Length
                                            _Y07)
                                        IRQNoFlags (_Y08)
                                            {0}
                                    }
                                    EndDependentFn ()
                                })
                                CreateWordField (PRE2, \_SB.PCI0.LPCB.SIO1.COM2._PRS._Y07._MIN, MIN1)  // _MIN: Minimum Base Address
                                CreateWordField (PRE2, \_SB.PCI0.LPCB.SIO1.COM2._PRS._Y07._MAX, MAX1)  // _MAX: Maximum Base Address
                                CreateWordField (PRE2, \_SB.PCI0.LPCB.SIO1.COM2._PRS._Y08._INT, IRQ0)  // _INT: Interrupts
                                If ((^^_UID == Zero))
                                {
                                    MIN1 = CBIO /* \CBIO */
                                    MAX1 = CBIO /* \CBIO */
                                    IRQ0 = (One << CBIR) /* \CBIR */
                                }
                                Else
                                {
                                    MIN1 = CDIO /* \CDIO */
                                    MAX1 = CDIO /* \CDIO */
                                    IRQ0 = (One << CDIR) /* \CDIR */
                                }

                                Return (PRE2) /* \_SB_.PCI0.LPCB.SIO1.COM2._PRS.PRE2 */
                            }
                        }

                        Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                        Name (_CID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _CID: Compatible ID
                        Name (RCOD, Zero)
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Local0 = Zero
                            If (CNPS ())
                            {
                                If (!RCOD)
                                {
                                    Local0 = SODS (_UID ())
                                }
                                Else
                                {
                                    Local0 = 0x0D
                                }
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            Local1 = One
                            If (Local1)
                            {
                                DSOD (_UID ())
                            }
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x09, IRQ0)
                            If ((SODS (_UID ()) & One))
                            {
                                _DIS ()
                                CFGL (_UID (), MIN1, IRQ0, Zero)
                                SETR ((_UID () & 0x0F), MIN1, IRQ0, Zero)
                            }

                            RCOD = Zero
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0000,             // Range Minimum
                                    0x0000,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y09)
                                IRQNoFlags (_Y0A)
                                    {0}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.COM2._CRS._Y09._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.COM2._CRS._Y09._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.COM2._CRS._Y0A._INT, IRQ0)  // _INT: Interrupts
                            If (RCOD)
                            {
                                Local0 = 0x0D
                            }
                            Else
                            {
                                Local0 = SODS (_UID ())
                            }

                            If ((Local0 == 0x0F))
                            {
                                Local1 = GETR ((_UID () & 0x0F))
                                MIN1 = DerefOf (Local1 [Zero])
                                MAX1 = MIN1 /* \_SB_.PCI0.LPCB.SIO1.COM2._CRS.MIN1 */
                                IRQ0 = DerefOf (Local1 [One])
                            }

                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO1.COM2._CRS.CRES */
                        }
                    }

                    Device (LPT1)
                    {
                        Method (_UID, 0, NotSerialized)  // _UID: Unique ID
                        {
                            Return ((^^_UID + One))
                        }

                        Method (_DDN, 0, NotSerialized)  // _DDN: DOS Device Name
                        {
                            If ((^^_UID == Zero))
                            {
                                Return ("LPT1")
                            }
                            Else
                            {
                                Return ("LPT2")
                            }
                        }

                        Name (LPM, 0xFF)
                        Method (_HID, 0, Serialized)  // _HID: Hardware ID
                        {
                            If ((LPM == 0xFF))
                            {
                                LPM = GLPM ()
                            }

                            If ((LPM == 0x03))
                            {
                                Local0 = 0x0104D041
                            }
                            Else
                            {
                                Local0 = 0x0004D041
                            }

                            Return (Local0)
                        }

                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            Return (LPRS) /* \_SB_.PCI0.LPCB.LPRS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Local0 = Zero
                            If (CNPS ())
                            {
                                Local0 = SODS (_UID ())
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            DSOD (_UID ())
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x11, IRQ0)
                            CreateWordField (Arg0, 0x14, DMA0)
                            If ((SODS (_UID ()) & One))
                            {
                                _DIS ()
                                CFGL (_UID (), MIN1, IRQ0, DMA0)
                                SETR (One, MIN1, IRQ0, DMA0)
                            }
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0000,             // Range Minimum
                                    0x0000,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y0B)
                                IO (Decode16,
                                    0x0000,             // Range Minimum
                                    0x0000,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    _Y0C)
                                IRQNoFlags (_Y0D)
                                    {0}
                                DMA (Compatibility, NotBusMaster, Transfer8, _Y0E)
                                    {0}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0B._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0B._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0B._LEN, LEN1)  // _LEN: Length
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0C._MIN, MIN2)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0C._MAX, MAX2)  // _MAX: Maximum Base Address
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0C._LEN, LEN2)  // _LEN: Length
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0D._INT, IRQ0)  // _INT: Interrupts
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO1.LPT1._CRS._Y0E._DMA, DMA0)  // _DMA: Direct Memory Access
                            If ((SODS (_UID ()) == 0x0F))
                            {
                                Local1 = GETR (One)
                                MIN1 = DerefOf (Local1 [Zero])
                                MAX1 = MIN1 /* \_SB_.PCI0.LPCB.SIO1.LPT1._CRS.MIN1 */
                                If ((MIN1 == 0x03BC))
                                {
                                    LEN1 = 0x03
                                }

                                MIN2 = (MIN1 + 0x0400)
                                MAX2 = MIN2 /* \_SB_.PCI0.LPCB.SIO1.LPT1._CRS.MIN2 */
                                IRQ0 = DerefOf (Local1 [One])
                                DMA0 = DerefOf (Local1 [0x02])
                            }

                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO1.LPT1._CRS.CRES */
                        }
                    }

                    Method (COM1.CNPS, 0, NotSerialized)
                    {
                        Return (((SPPB & One) == One))
                    }

                    Method (COM2.CNPS, 0, NotSerialized)
                    {
                        Return (((SPPB & 0x02) == 0x02))
                    }

                    Method (LPT1.CNPS, 0, NotSerialized)
                    {
                        Return (((PPPB & One) == One))
                    }

                    Mutex (MUT0, 0x00)
                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (MUT0, 0x0FFF)
                        SLDN = Arg0
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Release (MUT0)
                    }

                    OperationRegion (IOID, SystemIO, SCFA, 0x02)
                    Field (IOID, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8,
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x07),
                        SLDN,   8,
                        Offset (0x21),
                        SCF1,   8,
                        SCF2,   8,
                        SCF3,   8,
                        SCF4,   8,
                        SCF5,   8,
                        SCF6,   8,
                        Offset (0x29),
                        CKCF,   8,
                        Offset (0x30),
                        ACTR,   8,
                        Offset (0x60),
                        IOAH,   8,
                        IOAL,   8,
                        IOH2,   8,
                        IOL2,   8,
                        Offset (0x70),
                        INTR,   8,
                        Offset (0x74),
                        DMCH,   8,
                        Offset (0xE0),
                        RGE0,   8,
                        RGE1,   8,
                        RGE2,   8,
                        RGE3,   8,
                        RGE4,   8,
                        RGE5,   8,
                        RGE6,   8,
                        RGE7,   8,
                        RGE8,   8,
                        RGE9,   8,
                        Offset (0xF0),
                        OPT0,   8,
                        OPT1,   8,
                        OPT2,   8,
                        OPT3,   8,
                        OPT4,   8,
                        OPT5,   8,
                        OPT6,   8,
                        OPT7,   8,
                        OPT8,   8,
                        OPT9,   8
                    }

                    OperationRegion (RNTR, SystemIO, 0x0A10, 0x10)
                    Field (RNTR, ByteAcc, NoLock, Preserve)
                    {
                        GPES,   8,
                        GPEE,   8,
                        Offset (0x08),
                        GPS0,   8,
                        GPS1,   8,
                        GPS2,   8,
                        GPS3,   8,
                        GPE0,   8,
                        GPE1,   8,
                        GPE2,   8,
                        GPE3,   8
                    }

                    OperationRegion (SWCR, SystemIO, 0x0A00, 0x10)
                    Field (SWCR, ByteAcc, NoLock, Preserve)
                    {
                        LEDC,   8,
                        SWCC,   8,
                        Offset (0x04),
                        KBWK,   8
                    }
                }

                Method (EPD2, 2, Serialized)
                {
                }

                Method (DPD2, 1, Serialized)
                {
                }

                Name (PMFG, Zero)
                OperationRegion (KPS2, SystemIO, 0x60, 0x05)
                Field (KPS2, ByteAcc, NoLock, Preserve)
                {
                    KBDD,   8,
                    Offset (0x02),
                    Offset (0x03),
                    Offset (0x04),
                    KBDS,   1,
                    Offset (0x05)
                }

                Method (SIOS, 1, NotSerialized)
                {
                    ^SIO1.ENFG (0x04)
                    If ((0x05 != Arg0))
                    {
                        If (KBFG)
                        {
                            ^SIO1.GPE2 |= 0xE8
                            ^SIO1.KBWK |= 0x40
                        }
                        Else
                        {
                            ^SIO1.GPE2 &= 0xFFFFFFFFFFFFFF17
                        }

                        If (MSFG)
                        {
                            ^SIO1.GPE2 |= 0x10
                        }
                        Else
                        {
                            ^SIO1.GPE2 &= 0xFFFFFFFFFFFFFFEF
                        }

                        ^SIO1.GPS2 = ^SIO1.GPS2 /* \_SB_.PCI0.LPCB.SIO1.GPS2 */
                        ^SIO1.GPES = ^SIO1.GPES /* \_SB_.PCI0.LPCB.SIO1.GPES */
                        ^SIO1.GPEE = One
                    }

                    ^SIO1.GPS0 = ^SIO1.GPS0 /* \_SB_.PCI0.LPCB.SIO1.GPS0 */
                    ^SIO1.GPS1 = ^SIO1.GPS1 /* \_SB_.PCI0.LPCB.SIO1.GPS1 */
                    ^SIO1.GPE0 = 0x10
                    ^SIO1.GPE1 = 0x20
                    ^SIO1.EXFG ()
                }

                Method (SIOW, 1, NotSerialized)
                {
                    ^SIO1.ENFG (0x04)
                    PMFG = ^SIO1.GPS2 /* \_SB_.PCI0.LPCB.SIO1.GPS2 */
                    ^SIO1.GPS0 = ^SIO1.GPS0 /* \_SB_.PCI0.LPCB.SIO1.GPS0 */
                    ^SIO1.GPS1 = ^SIO1.GPS1 /* \_SB_.PCI0.LPCB.SIO1.GPS1 */
                    ^SIO1.GPS2 = ^SIO1.GPS2 /* \_SB_.PCI0.LPCB.SIO1.GPS2 */
                    ^SIO1.GPES = ^SIO1.GPES /* \_SB_.PCI0.LPCB.SIO1.GPES */
                    ^SIO1.GPEE = Zero
                    ^SIO1.GPE0 = Zero
                    ^SIO1.GPE1 = Zero
                    ^SIO1.EXFG ()
                }
            }
        }

        Device (HTAM)
        {
            Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadOnly,
                        0xFED40000,         // Address Base
                        0x00005000,         // Address Length
                        )
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (CondRefOf (\_SB.TPM._STA))
                {
                    Local0 = Zero
                }
                Else
                {
                    Local0 = 0x0F
                }

                Return (Local0)
            }
        }
    }



    OperationRegion (PSMI, SystemIO, 0xB0, 0x02)
    Field (PSMI, ByteAcc, NoLock, Preserve)
    {
        APMC,   8,
        APMD,   8
    }

    OperationRegion (SIOI, SystemIO, 0x0900, 0x05)
    Field (SIOI, ByteAcc, NoLock, Preserve)
    {
        Offset (0x04),
        FANS,   8
    }

    Name (PICM, Zero)
    Name (GPIC, Zero)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        PICM = Arg0
        GPIC = Arg0
        If (PICM)
        {
            \_SB.DSPI ()
            \_SB.PCI0.NAPE ()
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        SWAK (Arg0)
        \_SB.AWAK (Arg0)
        If ((Arg0 == One))
        {
            IO80 = 0xE1
            \_SB.S80H (0xE1)
            \_SB.PCI0.P2P.PR4B = 0xF1
        }

        If ((Arg0 == 0x03))
        {
            IO80 = 0xE3
            \_SB.S80H (0xE3)
            FANS = One
            CHKH ()
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        If ((Arg0 == 0x04))
        {
            IO80 = 0xE4
            \_SB.S80H (0xE4)
            \_SB.PCI0._INI ()
            Notify (\_SB.PWRB, 0x02) // Device Wake
            Notify (\_SB.PCI0.PB7, Zero) // Bus Check
        }

        If ((GTOS () == 0x06))
        {
            Acquire (\_SB.PCI0.LPCB.PSMX, 0xFFFF)
            SBFN = One
            BCMD = 0x8A
            \_SB.BSMI (Zero)
            Release (\_SB.PCI0.LPCB.PSMX)
        }

        If ((Arg0 == 0x05))
        {
            IO80 = 0xE5
        }

        Return (Zero)
    }

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        SPTS (Arg0)
        If ((Arg0 == One))
        {
            IO80 = 0x51
            \_SB.S80H (0x51)
        }

        If ((Arg0 == 0x03))
        {
            IO80 = 0x53
            \_SB.S80H (0x53)
            \_SB.PCI0.LPCB.SIOS (Arg0)
            \_SB.PCI0.SMBS.SLPS = One
        }

        If ((Arg0 == 0x04))
        {
            IO80 = 0x54
            \_SB.S80H (0x54)
            \_SB.PCI0.SMBS.SLPS = One
            RSTU = One
        }

        If ((Arg0 == 0x05))
        {
            IO80 = 0x55
            \_SB.S80H (0x55)
        }

        \_SB.APTS (Arg0)
    }

    Scope (_SB.PCI0)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If ((GPIC == Zero)){}
            Else
            {
                DSPI ()
                NAPE ()
            }

            CHKH ()
        }
    }

    Scope (_PR)
    {
        Processor (C000, 0x00, 0x00000410, 0x06){}
        Processor (C001, 0x01, 0x00000410, 0x06){}
        Processor (C002, 0x02, 0x00000410, 0x06){}
        Processor (C003, 0x03, 0x00000410, 0x06){}
    }

    Scope (_SB.PCI0)
    {
        Device (MEMR)
        {
            Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
            Name (MEM1, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0F)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    _Y10)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    _Y11)
            })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y0F._BAS, MB01)  // _BAS: Base Address
                CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y0F._LEN, ML01)  // _LEN: Length
                CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y10._BAS, MB02)  // _BAS: Base Address
                CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y10._LEN, ML02)  // _LEN: Length
                CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y11._BAS, MB03)  // _BAS: Base Address
                CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y11._LEN, ML03)  // _LEN: Length
                If (GPIC)
                {
                    MB01 = 0xFEC00000
                    MB02 = 0xFEE00000
                    MB03 = 0xFEC20000
                    ML01 = 0x1000
                    ML02 = 0x1000
                    ML03 = 0x1000
                }

                Return (MEM1) /* \_SB_.PCI0.MEMR.MEM1 */
            }
        }

        OperationRegion (NAPC, PCI_Config, 0xF8, 0x08)
        Field (NAPC, DWordAcc, NoLock, Preserve)
        {
            NAPX,   32,
            NAPD,   32
        }

        Mutex (NAPM, 0x00)
        Method (NAPE, 0, NotSerialized)
        {
            Acquire (NAPM, 0xFFFF)
            NAPX = Zero
            Local0 = NAPD /* \_SB_.PCI0.NAPD */
            Local0 &= 0xFFFFFFEF
            NAPD = Local0
            Release (NAPM)
        }
    }

    OperationRegion (DBG0, SystemIO, 0x80, One)
    Field (DBG0, ByteAcc, NoLock, Preserve)
    {
        IO80,   8
    }

    OperationRegion (DBG1, SystemIO, 0x80, 0x02)
    Field (DBG1, WordAcc, NoLock, Preserve)
    {
        P80H,   16
    }

    OperationRegion (ACMS, SystemIO, 0x72, 0x02)
    Field (ACMS, ByteAcc, NoLock, Preserve)
    {
        INDX,   8,
        DATA,   8
    }

    OperationRegion (PMRG, SystemIO, 0x0CD6, 0x02)
    Field (PMRG, ByteAcc, NoLock, Preserve)
    {
        PMRI,   8,
        PMRD,   8
    }

    IndexField (PMRI, PMRD, ByteAcc, NoLock, Preserve)
    {
        Offset (0x24),
        MMSO,   32,
        Offset (0x50),
        HPAD,   32,
        Offset (0x60),
        P1EB,   16,
        Offset (0xC8),
            ,   2,
        SPRE,   1,
        TPDE,   1,
        Offset (0xF0),
            ,   3,
        RSTU,   1
    }

    OperationRegion (GSMM, SystemMemory, MMSO, 0x1000)
    Field (GSMM, AnyAcc, NoLock, Preserve)
    {
        Offset (0x132),
            ,   7,
        GP51,   1,
        Offset (0x136),
            ,   7,
        GP55,   1,
        Offset (0x13A),
            ,   7,
        GP59,   1,
        Offset (0x13F),
            ,   7,
        GP64,   1,
        Offset (0x160),
            ,   7,
        GE01,   1,
        Offset (0x16A),
            ,   7,
        GE11,   1,
            ,   7,
        GE12,   1,
        Offset (0x16E),
            ,   7,
        BATS,   1,
        Offset (0x1FF),
            ,   1,
        G01S,   1,
        Offset (0x203),
            ,   1,
        G01E,   1,
        Offset (0x207),
            ,   1,
        TR01,   1,
        Offset (0x20B),
            ,   1,
        TL01,   1,
        Offset (0x20D),
            ,   7,
        ACIR,   1,
        Offset (0x287),
            ,   1,
        CLPS,   1,
        Offset (0x298),
            ,   7,
        G15A,   1,
        Offset (0x2AF),
            ,   2,
        SLPS,   2,
        Offset (0x376),
        EPNM,   1,
        DPPF,   1,
        Offset (0x3BA),
            ,   6,
        PWDE,   1,
        Offset (0x3BD),
            ,   5,
        ALLS,   1,
        Offset (0x3DE),
        BLNK,   2,
        Offset (0x3EF),
        PHYD,   1,
        Offset (0xE80),
            ,   2,
        ECES,   1
    }

    OperationRegion (P1E0, SystemIO, P1EB, 0x04)
    Field (P1E0, ByteAcc, NoLock, Preserve)
    {
            ,   14,
        PEWS,   1,
        WSTA,   1,
            ,   14,
        PEWD,   1
    }

    OperationRegion (IOCC, SystemIO, 0x0400, 0x80)
    Field (IOCC, ByteAcc, NoLock, Preserve)
    {
        Offset (0x01),
            ,   2,
        RTCS,   1
    }

    Name (PRWP, Package (0x02)
    {
        Zero,
        Zero
    })
    Method (GPRW, 2, NotSerialized)
    {
        PRWP [Zero] = Arg0
        PRWP [One] = Arg1
        If (((DAS3 == Zero) && (DAS1 == Zero)))
        {
            If ((Arg1 <= 0x03))
            {
                PRWP [One] = Zero
            }
        }
        Else
        {
            If (((DAS3 == Zero) && (Arg1 == 0x03)))
            {
                PRWP [One] = One
            }

            If (((DAS1 == Zero) && (Arg1 == One)))
            {
                PRWP [One] = Zero
            }
        }

        Return (PRWP) /* \PRWP */
    }

    Method (SPTS, 1, NotSerialized)
    {
        If ((Arg0 == 0x03))
        {
            RSTU = Zero
        }

        CLPS = One
        SLPS = One
        PEWS = PEWS /* \PEWS */
    }

    Method (SWAK, 1, NotSerialized)
    {
        If ((Arg0 == 0x03))
        {
            RSTU = One
        }

        PEWS = PEWS /* \PEWS */
        PWDE = One
        PEWD = Zero
    }

    Method (CHKH, 0, NotSerialized)
    {
    }

    OperationRegion (ABIO, SystemIO, 0x0CD8, 0x08)
    Field (ABIO, DWordAcc, NoLock, Preserve)
    {
        INAB,   32,
        DAAB,   32
    }

    Method (RDAB, 1, NotSerialized)
    {
        INAB = Arg0
        Return (DAAB) /* \DAAB */
    }

    Method (WTAB, 2, NotSerialized)
    {
        INAB = Arg0
        DAAB = Arg1
    }

    Method (RWAB, 3, NotSerialized)
    {
        Local0 = (RDAB (Arg0) & Arg1)
        Local1 = (Local0 | Arg2)
        WTAB (Arg0, Local1)
    }

    Method (CABR, 3, NotSerialized)
    {
        Local0 = (Arg0 << 0x05)
        Local1 = (Local0 + Arg1)
        Local2 = (Local1 << 0x18)
        Local3 = (Local2 + Arg2)
        Return (Local3)
    }

    OperationRegion (PEBA, SystemMemory, 0xE0000000, 0x02000000)
    Field (PEBA, AnyAcc, NoLock, Preserve)
    {
        Offset (0xA807A),
        PMS0,   1,
        Offset (0xA8088),
        TLS0,   4,
        Offset (0xA907A),
        PMS1,   1,
        Offset (0xA9088),
        TLS1,   4,
        Offset (0xAA07A),
        PMS2,   1,
        Offset (0xAA088),
        TLS2,   4,
        Offset (0xAB07A),
        PMS3,   1,
        Offset (0xAB088),
        TLS3,   4
    }

    OperationRegion (PIRQ, SystemIO, 0x0C00, 0x02)
    Field (PIRQ, ByteAcc, NoLock, Preserve)
    {
        PIDX,   8,
        PDAT,   8
    }

    IndexField (PIDX, PDAT, ByteAcc, NoLock, Preserve)
    {
        PIRA,   8,
        PIRB,   8,
        PIRC,   8,
        PIRD,   8,
        PIRE,   8,
        PIRF,   8,
        PIRG,   8,
        PIRH,   8,
        Offset (0x10),
        PIRS,   8,
        Offset (0x13),
        HDAD,   8,
        Offset (0x15),
        GEC,    8,
        Offset (0x30),
        USB1,   8,
        USB2,   8,
        USB3,   8,
        USB4,   8,
        USB5,   8,
        USB6,   8,
        USB7,   8,
        Offset (0x40),
        IDE,    8,
        SATA,   8,
        Offset (0x50),
        GPP0,   8,
        GPP1,   8,
        GPP2,   8,
        GPP3,   8
    }

    OperationRegion (KBDD, SystemIO, 0x64, One)
    Field (KBDD, ByteAcc, NoLock, Preserve)
    {
        PD64,   8
    }

    Method (INTA, 1, NotSerialized)
    {
        PIRA = Arg0
        If (PICM)
        {
            HDAD = Arg0
            GEC = Arg0
            GPP0 = Arg0
            GPP0 = Arg0
        }
    }

    Method (INTB, 1, NotSerialized)
    {
        PIRB = Arg0
        If (PICM)
        {
            USB2 = Arg0
            USB4 = Arg0
            USB6 = Arg0
            GPP1 = Arg0
            IDE = Arg0
        }
    }

    Method (INTC, 1, NotSerialized)
    {
        PIRC = Arg0
        If (PICM)
        {
            USB1 = Arg0
            USB3 = Arg0
            USB5 = Arg0
            USB7 = Arg0
            GPP2 = Arg0
        }
    }

    Method (INTD, 1, NotSerialized)
    {
        PIRD = Arg0
        If (PICM)
        {
            SATA = Arg0
            GPP3 = Arg0
        }
    }

    Name (PRS1, ResourceTemplate ()
    {
        IRQ (Level, ActiveLow, Shared, )
            {3,4,5,7,10,11,12,14,15}
    })
    Name (BUFA, ResourceTemplate ()
    {
        IRQ (Level, ActiveLow, Shared, )
            {15}
    })
    Name (IPRA, ResourceTemplate ()
    {
        IRQ (Level, ActiveLow, Shared, )
            {5,10,11}
    })
    Name (IPRB, ResourceTemplate ()
    {
        IRQ (Level, ActiveLow, Shared, )
            {5,10,11}
    })
    Name (IPRC, ResourceTemplate ()
    {
        IRQ (Level, ActiveLow, Shared, )
            {5,10,11}
    })
    Name (IPRD, ResourceTemplate ()
    {
        IRQ (Level, ActiveLow, Shared, )
            {5,10,11}
    })
    Device (LNKA)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, One)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized)
        {
            If (LOr(LEqual(PIRA, Zero), LEqual(PIRA, 0x1F)))
            {
                Return (Zero)
            }
            Return (0x0B)
        }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            INTA (0x1F)
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRA) /* \PIRA */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRA = Local0
        }
    }

    Device (LNKB)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x02)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRB, Zero), LEqual(PIRB, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            INTB (0x1F)
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRB) /* \PIRB */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRB = Local0
        }
    }

    Device (LNKC)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x03)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRC, Zero), LEqual(PIRC, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            INTC (0x1F)
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRC) /* \PIRC */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRC = Local0
        }
    }

    Device (LNKD)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x04)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRD, Zero), LEqual(PIRD, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            INTD (0x1F)
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRD) /* \PIRD */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRD = Local0
        }
    }

    Device (LNKE)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x05)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRE, Zero), LEqual(PIRE, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            PIRE = 0x1F
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRE) /* \PIRE */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRE = Local0
        }
    }

    Device (LNKF)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x06)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRF, Zero), LEqual(PIRF, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            PIRF = 0x1F
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRF) /* \PIRF */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRF = Local0
        }
    }

    Device (LNKG)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x07)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRG, Zero), LEqual(PIRG, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            PIRG = 0x1F
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRG) /* \PIRG */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRG = Local0
        }
    }

    Device (LNKH)
    {
        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
        Name (_UID, 0x08)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized) { If (LOr(LEqual(PIRH, Zero), LEqual(PIRH, 0x1F))) { Return (Zero) } Return (0x0B) }

        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
        {
            Return (PRS1) /* \PRS1 */
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
            PIRH = 0x1F
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateWordField (BUFA, One, IRQX)
            IRQX = (One << PIRH) /* \PIRH */
            Return (BUFA) /* \BUFA */
        }

        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
        {
            CreateWordField (Arg0, One, IRA)
            FindSetRightBit (IRA, Local0)
            Local0--
            PIRH = Local0
        }
    }

    Scope (_SB.PCI0)
    {
        Device (OHC0)
        {
            Name (_ADR, 0x00120000)  // _ADR: Address
            OperationRegion (UBCS, PCI_Config, 0xC4, 0x04)
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (USBW (0x18, 0x03))
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Device (RHUB)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC0.RHUB.PRT1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.OHC0.RHUB.PRT1._PLD.PLDP */
                    }
                }

                Device (PRT2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC0.RHUB.PRT2._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.OHC0.RHUB.PRT2._PLD.PLDP */
                    }
                }

                Device (PRT3)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0xFF,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC0.RHUB.PRT3._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (UPLD, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // 0.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (UPLD) /* \_SB_.PCI0.OHC0.RHUB.PRT3._PLD.UPLD */
                    }
                }

                Device (PRT5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC0.RHUB.PRT5._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x02, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.OHC0.RHUB.PRT5._PLD.PLDP */
                    }
                }
            }
        }

        Device (EHC0)
        {
            Name (_ADR, 0x00120002)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        0x03
                    }
                Local0 [Zero] = 0x18
                If ((PFKB == One))
                {
                    Local0 [One] = 0x05
                }

                Return (Local0)
            }

            Device (RHUB)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC0.RHUB.PRT1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.EHC0.RHUB.PRT1._PLD.PLDP */
                    }
                }

                Device (PRT2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC0.RHUB.PRT2._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.EHC0.RHUB.PRT2._PLD.PLDP */
                    }
                }

                Device (PRT3)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0xFF,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC0.RHUB.PRT3._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (UPLD, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // 0.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (UPLD) /* \_SB_.PCI0.EHC0.RHUB.PRT3._PLD.UPLD */
                    }
                }

                Device (PRT5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC0.RHUB.PRT5._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x02, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.EHC0.RHUB.PRT5._PLD.PLDP */
                    }
                }
            }
        }

        Device (OHC1)
        {
            Name (_ADR, 0x00130000)  // _ADR: Address
            OperationRegion (UBCS, PCI_Config, 0xC4, 0x04)
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (USBW (0x18, 0x03))
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Device (RHUB)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC1.RHUB.PRT1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x03, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.OHC1.RHUB.PRT1._PLD.PLDP */
                    }
                }

                Device (PRT4)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC1.RHUB.PRT4._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x61, 0x0D, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.OHC1.RHUB.PRT4._PLD.PLDP */
                    }
                }

                Device (PRT5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.OHC1.RHUB.PRT5._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x61, 0x0D, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.OHC1.RHUB.PRT5._PLD.PLDP */
                    }
                }
            }
        }

        Device (EHC1)
        {
            Name (_ADR, 0x00130002)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        0x03
                    }
                Local0 [Zero] = 0x18
                If ((PFKB == One))
                {
                    Local0 [One] = 0x05
                }

                Return (Local0)
            }

            Device (RHUB)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC1.RHUB.PRT1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x80, 0x03, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.EHC1.RHUB.PRT1._PLD.PLDP */
                    }
                }

                Device (PRT4)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC1.RHUB.PRT4._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x61, 0x0D, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.EHC1.RHUB.PRT4._PLD.PLDP */
                    }
                }

                Device (PRT5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            Zero,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.EHC1.RHUB.PRT5._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x69, 0x0D, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.EHC1.RHUB.PRT5._PLD.PLDP */
                    }
                }
            }
        }

        Device (OHC2)
        {
            Name (_ADR, 0x00140005)  // _ADR: Address
            OperationRegion (UBCS, PCI_Config, 0xC4, 0x04)
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (USBW (0x18, 0x03))
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }
        }

        Device (XHC0)
        {
            Name (_ADR, 0x00100000)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        0x03
                    }
                Local0 [Zero] = 0x18
                Return (Local0)
            }

            Device (RHUB)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (SSP1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC0.RHUB.SSP1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x69, 0x0D, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC0.RHUB.SSP1._PLD.PLDP */
                    }
                }

                Device (SSP2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC0.RHUB.SSP2._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x69, 0x0D, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC0.RHUB.SSP2._PLD.PLDP */
                    }
                }

                Device (HSP1)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC0.RHUB.HSP1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x69, 0x0D, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC0.RHUB.HSP1._PLD.PLDP */
                    }
                }

                Device (HSP2)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC0.RHUB.HSP2._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x69, 0x0D, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00,  // i.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC0.RHUB.HSP2._PLD.PLDP */
                    }
                }
            }
        }

        Device (XHC1)
        {
            Name (_ADR, 0x00100001)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Local0 = Package (0x02)
                    {
                        Zero,
                        0x03
                    }
                Local0 [Zero] = 0x18
                Return (Local0)
            }

            Device (RHUB)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (SSP1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC1.RHUB.SSP1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x61, 0x0D, 0x80, 0x06, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC1.RHUB.SSP1._PLD.PLDP */
                    }
                }

                Device (SSP2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC1.RHUB.SSP2._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x61, 0x0D, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC1.RHUB.SSP2._PLD.PLDP */
                    }
                }

                Device (HSP1)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC1.RHUB.HSP1._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x61, 0x0D, 0x80, 0x06, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC1.RHUB.HSP1._PLD.PLDP */
                    }
                }

                Device (HSP2)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (UPCP, Package (0x04)
                        {
                            0xFF,
                            0x03,
                            Zero,
                            Zero
                        })
                        Return (UPCP) /* \_SB_.PCI0.XHC1.RHUB.HSP2._UPC.UPCP */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDP, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x02, 0xC6, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,  // ..r.....
                                /* 0008 */  0x61, 0x0D, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00,  // a.......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDP) /* \_SB_.PCI0.XHC1.RHUB.HSP2._PLD.PLDP */
                    }
                }
            }
        }

        Device (HDEF)
        {
            Name (_ADR, 0x00140002)  // _ADR: Address
            OperationRegion (PCI, PCI_Config, Zero, 0x0100)
            Field (PCI, AnyAcc, NoLock, Preserve)
            {
                Offset (0x42),
                DNSP,   1,
                DNSO,   1,
                ENSR,   1
            }
        }

        Device (PEGP)
        {
            Name (_ADR, 0x00020000)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR02) /* \_SB_.AR02 */
                }

                Return (PR02) /* \_SB_.PR02 */
            }

            OperationRegion (XPEX, SystemMemory, 0xE0010100, 0x0100)
            Field (XPEX, DWordAcc, NoLock, Preserve)
            {
                Offset (0x28),
                VC0S,   32
            }

            OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
            Field (XPCB, AnyAcc, NoLock, Preserve)
            {
                Offset (0x10),
                LKCN,   16,
                LKST,   16,
                Offset (0x18),
                    ,   3,
                PDC8,   1,
                    ,   2,
                PDS8,   1,
                Offset (0x19),
                HPC8,   1,
                Offset (0x1A),
                    ,   3,
                PDC2,   1,
                    ,   2,
                PDS2,   1,
                Offset (0x1B),
                HPCS,   1,
                Offset (0x20),
                Offset (0x22),
                PMES,   1
            }

            OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
            Field (XPRI, ByteAcc, NoLock, Preserve)
            {
                XPIR,   32,
                XPID,   32
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                Offset (0x18),
                SBUS,   32
            }

            Method (XPDL, 0, NotSerialized)
            {
                If ((VC0S & 0x00020000))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Mutex (XPPM, 0x00)
            Method (XPRD, 1, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                Local0 = XPID /* \_SB_.PCI0.PEGP.XPID */
                XPIR = Zero
                Release (XPPM)
                Return (Local0)
            }

            Method (XPWR, 2, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                XPID = Arg1
                XPIR = Zero
                Release (XPPM)
            }

            Method (XPRT, 0, NotSerialized)
            {
                Local0 = XPRD (0xA2)
                Local0 &= 0xFFFFFFFFFFFFFFF8
                Local1 = (Local0 >> 0x04)
                Local1 &= 0x07
                Local0 |= Local1
                Local0 |= 0x0100
                XPWR (0xA2, Local0)
            }

            Method (XPR2, 0, NotSerialized)
            {
                Local0 = LKCN /* \_SB_.PCI0.PEGP.LKCN */
                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                Local0 |= 0x20
                LKCN = Local0
                Local1 = 0x64
                Local2 = One
                While ((Local1 && Local2))
                {
                    Sleep (One)
                    Local3 = LKST /* \_SB_.PCI0.PEGP.LKST */
                    If ((Local3 & 0x0800))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local2 = Zero
                    }
                }

                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                If (!Local2)
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.PEGP._ADR */
                Local1 = (Local0 >> 0x10)
                Local1 = (Local1 << 0x03)
                Local2 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            Method (XPPR, 1, NotSerialized)
            {
                Name (HPOK, Zero)
                HPOK = Zero
                Local0 = (XPPB () << 0x03)
                If (Arg0)
                {
                    XPLL (Local0, One)
                    XPLP (Local0, One)
                    Sleep (0xC8)
                    XPTR (Local0, One)
                    Local5 = 0x0F
                    While ((!HPOK && (Local5 > Zero)))
                    {
                        PDC2 = One
                        Local1 = 0x28
                        While ((!HPOK && (Local1 > Zero)))
                        {
                            Local2 = XPRD (0xA5)
                            If (((Local2 & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If (((Local2 & 0xFF) >= 0x04))
                            {
                                HPOK = One
                            }

                            Local1--
                        }

                        If (HPOK)
                        {
                            Local2 = (XPRD (0xA5) & 0xFF)
                            Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                            If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                            {
                                HPOK = Zero
                            }
                        }

                        If (HPOK)
                        {
                            Local1 = 0x07D0
                            HPOK = Zero
                            While ((!HPOK && Local1))
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                If ((Local2 == 0x07))
                                {
                                    Local1 = One
                                    Local4 = XPDL ()
                                    If (Local4)
                                    {
                                        XPRT ()
                                        Local5--
                                    }
                                }

                                If ((Local2 == 0x10))
                                {
                                    HPOK = One
                                }

                                Sleep (One)
                                Local1--
                            }
                        }
                    }
                }

                If (HPOK)
                {
                    XPTR (Local0, Zero)
                    XPLP (Local0, Zero)
                    XPLL (Local0, Zero)
                }

                Return (Ones)
            }

            Device (DGFX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x50)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    Offset (0x2C),
                    SVID,   32,
                    Offset (0x4C),
                    SMID,   32
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }
            }

            Device (HDAU)
            {
                Name (_ADR, One)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x50)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    Offset (0x2C),
                    SVID,   32,
                    Offset (0x4C),
                    SMID,   32
                }
            }
        }

        Device (PB3)
        {
            Name (_ADR, 0x00030000)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR03) /* \_SB_.AR03 */
                }

                Return (PR03) /* \_SB_.PR03 */
            }

            OperationRegion (XPEX, SystemMemory, 0xE0018100, 0x0100)
            Field (XPEX, DWordAcc, NoLock, Preserve)
            {
                Offset (0x28),
                VC0S,   32
            }

            OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
            Field (XPCB, AnyAcc, NoLock, Preserve)
            {
                Offset (0x10),
                LKCN,   16,
                LKST,   16,
                Offset (0x18),
                    ,   3,
                PDC8,   1,
                    ,   2,
                PDS8,   1,
                Offset (0x19),
                HPC8,   1,
                Offset (0x1A),
                    ,   3,
                PDC2,   1,
                    ,   2,
                PDS2,   1,
                Offset (0x1B),
                HPCS,   1,
                Offset (0x20),
                Offset (0x22),
                PMES,   1
            }

            OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
            Field (XPRI, ByteAcc, NoLock, Preserve)
            {
                XPIR,   32,
                XPID,   32
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                Offset (0x18),
                SBUS,   32
            }

            Method (XPDL, 0, NotSerialized)
            {
                If ((VC0S & 0x00020000))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Mutex (XPPM, 0x00)
            Method (XPRD, 1, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                Local0 = XPID /* \_SB_.PCI0.PB3_.XPID */
                XPIR = Zero
                Release (XPPM)
                Return (Local0)
            }

            Method (XPWR, 2, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                XPID = Arg1
                XPIR = Zero
                Release (XPPM)
            }

            Method (XPRT, 0, NotSerialized)
            {
                Local0 = XPRD (0xA2)
                Local0 &= 0xFFFFFFFFFFFFFFF8
                Local1 = (Local0 >> 0x04)
                Local1 &= 0x07
                Local0 |= Local1
                Local0 |= 0x0100
                XPWR (0xA2, Local0)
            }

            Method (XPR2, 0, NotSerialized)
            {
                Local0 = LKCN /* \_SB_.PCI0.PB3_.LKCN */
                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                Local0 |= 0x20
                LKCN = Local0
                Local1 = 0x64
                Local2 = One
                While ((Local1 && Local2))
                {
                    Sleep (One)
                    Local3 = LKST /* \_SB_.PCI0.PB3_.LKST */
                    If ((Local3 & 0x0800))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local2 = Zero
                    }
                }

                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                If (!Local2)
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.PB3_._ADR */
                Local1 = (Local0 >> 0x10)
                Local1 = (Local1 << 0x03)
                Local2 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            Method (XPPR, 1, NotSerialized)
            {
                Name (HPOK, Zero)
                HPOK = Zero
                Local0 = (XPPB () << 0x03)
                If (Arg0)
                {
                    XPLL (Local0, One)
                    XPLP (Local0, One)
                    Sleep (0xC8)
                    XPTR (Local0, One)
                    Local5 = 0x0F
                    While ((!HPOK && (Local5 > Zero)))
                    {
                        PDC2 = One
                        Local1 = 0x28
                        While ((!HPOK && (Local1 > Zero)))
                        {
                            Local2 = XPRD (0xA5)
                            If (((Local2 & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If (((Local2 & 0xFF) >= 0x04))
                            {
                                HPOK = One
                            }

                            Local1--
                        }

                        If (HPOK)
                        {
                            Local2 = (XPRD (0xA5) & 0xFF)
                            Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                            If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                            {
                                HPOK = Zero
                            }
                        }

                        If (HPOK)
                        {
                            Local1 = 0x07D0
                            HPOK = Zero
                            While ((!HPOK && Local1))
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                If ((Local2 == 0x07))
                                {
                                    Local1 = One
                                    Local4 = XPDL ()
                                    If (Local4)
                                    {
                                        XPRT ()
                                        Local5--
                                    }
                                }

                                If ((Local2 == 0x10))
                                {
                                    HPOK = One
                                }

                                Sleep (One)
                                Local1--
                            }
                        }
                    }
                }

                If (HPOK)
                {
                    XPTR (Local0, Zero)
                    XPLP (Local0, Zero)
                    XPLL (Local0, Zero)
                }

                Return (Ones)
            }
        }

        Device (PB4)
        {
            Name (_ADR, 0x00040000)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR04) /* \_SB_.AR04 */
                }

                Return (PR04) /* \_SB_.PR04 */
            }

            OperationRegion (XPEX, SystemMemory, 0xE0020100, 0x0100)
            Field (XPEX, DWordAcc, NoLock, Preserve)
            {
                Offset (0x28),
                VC0S,   32
            }

            OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
            Field (XPCB, AnyAcc, NoLock, Preserve)
            {
                Offset (0x10),
                LKCN,   16,
                LKST,   16,
                Offset (0x18),
                    ,   3,
                PDC8,   1,
                    ,   2,
                PDS8,   1,
                Offset (0x19),
                HPC8,   1,
                Offset (0x1A),
                    ,   3,
                PDC2,   1,
                    ,   2,
                PDS2,   1,
                Offset (0x1B),
                HPCS,   1,
                Offset (0x20),
                Offset (0x22),
                PMES,   1
            }

            OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
            Field (XPRI, ByteAcc, NoLock, Preserve)
            {
                XPIR,   32,
                XPID,   32
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                Offset (0x18),
                SBUS,   32
            }

            Method (XPDL, 0, NotSerialized)
            {
                If ((VC0S & 0x00020000))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Mutex (XPPM, 0x00)
            Method (XPRD, 1, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                Local0 = XPID /* \_SB_.PCI0.PB4_.XPID */
                XPIR = Zero
                Release (XPPM)
                Return (Local0)
            }

            Method (XPWR, 2, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                XPID = Arg1
                XPIR = Zero
                Release (XPPM)
            }

            Method (XPRT, 0, NotSerialized)
            {
                Local0 = XPRD (0xA2)
                Local0 &= 0xFFFFFFFFFFFFFFF8
                Local1 = (Local0 >> 0x04)
                Local1 &= 0x07
                Local0 |= Local1
                Local0 |= 0x0100
                XPWR (0xA2, Local0)
            }

            Method (XPR2, 0, NotSerialized)
            {
                Local0 = LKCN /* \_SB_.PCI0.PB4_.LKCN */
                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                Local0 |= 0x20
                LKCN = Local0
                Local1 = 0x64
                Local2 = One
                While ((Local1 && Local2))
                {
                    Sleep (One)
                    Local3 = LKST /* \_SB_.PCI0.PB4_.LKST */
                    If ((Local3 & 0x0800))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local2 = Zero
                    }
                }

                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                If (!Local2)
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.PB4_._ADR */
                Local1 = (Local0 >> 0x10)
                Local1 = (Local1 << 0x03)
                Local2 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            Method (XPPR, 1, NotSerialized)
            {
                Name (HPOK, Zero)
                HPOK = Zero
                Local0 = (XPPB () << 0x03)
                If (Arg0)
                {
                    XPLL (Local0, One)
                    XPLP (Local0, One)
                    Sleep (0xC8)
                    XPTR (Local0, One)
                    Local5 = 0x0F
                    While ((!HPOK && (Local5 > Zero)))
                    {
                        PDC2 = One
                        Local1 = 0x28
                        While ((!HPOK && (Local1 > Zero)))
                        {
                            Local2 = XPRD (0xA5)
                            If (((Local2 & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If (((Local2 & 0xFF) >= 0x04))
                            {
                                HPOK = One
                            }

                            Local1--
                        }

                        If (HPOK)
                        {
                            Local2 = (XPRD (0xA5) & 0xFF)
                            Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                            If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                            {
                                HPOK = Zero
                            }
                        }

                        If (HPOK)
                        {
                            Local1 = 0x07D0
                            HPOK = Zero
                            While ((!HPOK && Local1))
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                If ((Local2 == 0x07))
                                {
                                    Local1 = One
                                    Local4 = XPDL ()
                                    If (Local4)
                                    {
                                        XPRT ()
                                        Local5--
                                    }
                                }

                                If ((Local2 == 0x10))
                                {
                                    HPOK = One
                                }

                                Sleep (One)
                                Local1--
                            }
                        }
                    }
                }

                If (HPOK)
                {
                    XPTR (Local0, Zero)
                    XPLP (Local0, Zero)
                    XPLL (Local0, Zero)
                }

                Return (Ones)
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }
            }
        }

        Device (PB5)
        {
            Name (_ADR, 0x00050000)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR05) /* \_SB_.AR05 */
                }

                Return (PR05) /* \_SB_.PR05 */
            }

            OperationRegion (XPEX, SystemMemory, 0xE0028100, 0x0100)
            Field (XPEX, DWordAcc, NoLock, Preserve)
            {
                Offset (0x28),
                VC0S,   32
            }

            OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
            Field (XPCB, AnyAcc, NoLock, Preserve)
            {
                Offset (0x10),
                LKCN,   16,
                LKST,   16,
                Offset (0x18),
                    ,   3,
                PDC8,   1,
                    ,   2,
                PDS8,   1,
                Offset (0x19),
                HPC8,   1,
                Offset (0x1A),
                    ,   3,
                PDC2,   1,
                    ,   2,
                PDS2,   1,
                Offset (0x1B),
                HPCS,   1,
                Offset (0x20),
                Offset (0x22),
                PMES,   1
            }

            OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
            Field (XPRI, ByteAcc, NoLock, Preserve)
            {
                XPIR,   32,
                XPID,   32
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                Offset (0x18),
                SBUS,   32
            }

            Method (XPDL, 0, NotSerialized)
            {
                If ((VC0S & 0x00020000))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Mutex (XPPM, 0x00)
            Method (XPRD, 1, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                Local0 = XPID /* \_SB_.PCI0.PB5_.XPID */
                XPIR = Zero
                Release (XPPM)
                Return (Local0)
            }

            Method (XPWR, 2, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                XPID = Arg1
                XPIR = Zero
                Release (XPPM)
            }

            Method (XPRT, 0, NotSerialized)
            {
                Local0 = XPRD (0xA2)
                Local0 &= 0xFFFFFFFFFFFFFFF8
                Local1 = (Local0 >> 0x04)
                Local1 &= 0x07
                Local0 |= Local1
                Local0 |= 0x0100
                XPWR (0xA2, Local0)
            }

            Method (XPR2, 0, NotSerialized)
            {
                Local0 = LKCN /* \_SB_.PCI0.PB5_.LKCN */
                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                Local0 |= 0x20
                LKCN = Local0
                Local1 = 0x64
                Local2 = One
                While ((Local1 && Local2))
                {
                    Sleep (One)
                    Local3 = LKST /* \_SB_.PCI0.PB5_.LKST */
                    If ((Local3 & 0x0800))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local2 = Zero
                    }
                }

                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                If (!Local2)
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.PB5_._ADR */
                Local1 = (Local0 >> 0x10)
                Local1 = (Local1 << 0x03)
                Local2 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            Method (XPPR, 1, NotSerialized)
            {
                Name (HPOK, Zero)
                HPOK = Zero
                Local0 = (XPPB () << 0x03)
                If (Arg0)
                {
                    XPLL (Local0, One)
                    XPLP (Local0, One)
                    Sleep (0xC8)
                    XPTR (Local0, One)
                    Local5 = 0x0F
                    While ((!HPOK && (Local5 > Zero)))
                    {
                        PDC2 = One
                        Local1 = 0x28
                        While ((!HPOK && (Local1 > Zero)))
                        {
                            Local2 = XPRD (0xA5)
                            If (((Local2 & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If (((Local2 & 0xFF) >= 0x04))
                            {
                                HPOK = One
                            }

                            Local1--
                        }

                        If (HPOK)
                        {
                            Local2 = (XPRD (0xA5) & 0xFF)
                            Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                            If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                            {
                                HPOK = Zero
                            }
                        }

                        If (HPOK)
                        {
                            Local1 = 0x07D0
                            HPOK = Zero
                            While ((!HPOK && Local1))
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                If ((Local2 == 0x07))
                                {
                                    Local1 = One
                                    Local4 = XPDL ()
                                    If (Local4)
                                    {
                                        XPRT ()
                                        Local5--
                                    }
                                }

                                If ((Local2 == 0x10))
                                {
                                    HPOK = One
                                }

                                Sleep (One)
                                Local1--
                            }
                        }
                    }
                }

                If (HPOK)
                {
                    XPTR (Local0, Zero)
                    XPLP (Local0, Zero)
                    XPLL (Local0, Zero)
                }

                Return (Ones)
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }
            }
        }

        Device (PB6)
        {
            Name (_ADR, 0x00060000)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR06) /* \_SB_.AR06 */
                }

                Return (PR06) /* \_SB_.PR06 */
            }

            OperationRegion (XPEX, SystemMemory, 0xE1030100, 0x0100)
            Field (XPEX, DWordAcc, NoLock, Preserve)
            {
                Offset (0x28),
                VC0S,   32
            }

            OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
            Field (XPCB, AnyAcc, NoLock, Preserve)
            {
                Offset (0x10),
                LKCN,   16,
                LKST,   16,
                Offset (0x18),
                    ,   3,
                PDC8,   1,
                    ,   2,
                PDS8,   1,
                Offset (0x19),
                HPC8,   1,
                Offset (0x1A),
                    ,   3,
                PDC2,   1,
                    ,   2,
                PDS2,   1,
                Offset (0x1B),
                HPCS,   1,
                Offset (0x20),
                Offset (0x22),
                PMES,   1
            }

            OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
            Field (XPRI, ByteAcc, NoLock, Preserve)
            {
                XPIR,   32,
                XPID,   32
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                Offset (0x18),
                SBUS,   32
            }

            Method (XPDL, 0, NotSerialized)
            {
                If ((VC0S & 0x00020000))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Mutex (XPPM, 0x00)
            Method (XPRD, 1, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                Local0 = XPID /* \_SB_.PCI0.PB6_.XPID */
                XPIR = Zero
                Release (XPPM)
                Return (Local0)
            }

            Method (XPWR, 2, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                XPID = Arg1
                XPIR = Zero
                Release (XPPM)
            }

            Method (XPRT, 0, NotSerialized)
            {
                Local0 = XPRD (0xA2)
                Local0 &= 0xFFFFFFFFFFFFFFF8
                Local1 = (Local0 >> 0x04)
                Local1 &= 0x07
                Local0 |= Local1
                Local0 |= 0x0100
                XPWR (0xA2, Local0)
            }

            Method (XPR2, 0, NotSerialized)
            {
                Local0 = LKCN /* \_SB_.PCI0.PB6_.LKCN */
                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                Local0 |= 0x20
                LKCN = Local0
                Local1 = 0x64
                Local2 = One
                While ((Local1 && Local2))
                {
                    Sleep (One)
                    Local3 = LKST /* \_SB_.PCI0.PB6_.LKST */
                    If ((Local3 & 0x0800))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local2 = Zero
                    }
                }

                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                If (!Local2)
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.PB6_._ADR */
                Local1 = (Local0 >> 0x10)
                Local1 = (Local1 << 0x03)
                Local2 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            Method (XPPR, 1, NotSerialized)
            {
                Name (HPOK, Zero)
                HPOK = Zero
                Local0 = (XPPB () << 0x03)
                If (Arg0)
                {
                    XPLL (Local0, One)
                    XPLP (Local0, One)
                    Sleep (0xC8)
                    XPTR (Local0, One)
                    Local5 = 0x0F
                    While ((!HPOK && (Local5 > Zero)))
                    {
                        PDC2 = One
                        Local1 = 0x28
                        While ((!HPOK && (Local1 > Zero)))
                        {
                            Local2 = XPRD (0xA5)
                            If (((Local2 & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If (((Local2 & 0xFF) >= 0x04))
                            {
                                HPOK = One
                            }

                            Local1--
                        }

                        If (HPOK)
                        {
                            Local2 = (XPRD (0xA5) & 0xFF)
                            Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                            If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                            {
                                HPOK = Zero
                            }
                        }

                        If (HPOK)
                        {
                            Local1 = 0x07D0
                            HPOK = Zero
                            While ((!HPOK && Local1))
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                If ((Local2 == 0x07))
                                {
                                    Local1 = One
                                    Local4 = XPDL ()
                                    If (Local4)
                                    {
                                        XPRT ()
                                        Local5--
                                    }
                                }

                                If ((Local2 == 0x10))
                                {
                                    HPOK = One
                                }

                                Sleep (One)
                                Local1--
                            }
                        }
                    }
                }

                If (HPOK)
                {
                    XPTR (Local0, Zero)
                    XPLP (Local0, Zero)
                    XPLL (Local0, Zero)
                }

                Return (Ones)
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0xFF)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32,
                    Offset (0xCA),
                    RGCA,   8,
                    DISF,   8,
                    FIFO,   8
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x09)
                }
            }

            Device (XPD3)
            {
                Name (_ADR, 0x03)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0xFF)
                Field (PCFG, ByteAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32,
                    Offset (0xAC),
                    VDID,   32,
                    Offset (0xE1),
                    MISC,   8,
                    Offset (0xFD),
                    PLLM,   8
                }
            }
        }

        Device (PB7)
        {
            Name (_ADR, 0x00070000)  // _ADR: Address
            Name (PR07, Package (0x04)
            {
                Package (0x04)
                {
                    0xFFFF,
                    Zero,
                    LNKD,
                    Zero
                },

                Package (0x04)
                {
                    0xFFFF,
                    One,
                    LNKA,
                    Zero
                },

                Package (0x04)
                {
                    0xFFFF,
                    0x02,
                    LNKB,
                    Zero
                },

                Package (0x04)
                {
                    0xFFFF,
                    0x03,
                    LNKC,
                    Zero
                }
            })
            Name (AR07, Package (0x04)
            {
                Package (0x04)
                {
                    0xFFFF,
                    Zero,
                    Zero,
                    0x13
                },

                Package (0x04)
                {
                    0xFFFF,
                    One,
                    Zero,
                    0x10
                },

                Package (0x04)
                {
                    0xFFFF,
                    0x02,
                    Zero,
                    0x11
                },

                Package (0x04)
                {
                    0xFFFF,
                    0x03,
                    Zero,
                    0x12
                }
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR07) /* \_SB_.PCI0.PB7_.AR07 */
                }

                Return (PR07) /* \_SB_.PCI0.PB7_.PR07 */
            }

            OperationRegion (XPEX, SystemMemory, 0xE0038100, 0x0100)
            Field (XPEX, DWordAcc, NoLock, Preserve)
            {
                Offset (0x28),
                VC0S,   32
            }

            OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
            Field (XPCB, AnyAcc, NoLock, Preserve)
            {
                Offset (0x10),
                LKCN,   16,
                LKST,   16,
                Offset (0x18),
                    ,   3,
                PDC8,   1,
                    ,   2,
                PDS8,   1,
                Offset (0x19),
                HPC8,   1,
                Offset (0x1A),
                    ,   3,
                PDC2,   1,
                    ,   2,
                PDS2,   1,
                Offset (0x1B),
                HPCS,   1,
                Offset (0x20),
                Offset (0x22),
                PMES,   1
            }

            OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
            Field (XPRI, ByteAcc, NoLock, Preserve)
            {
                XPIR,   32,
                XPID,   32
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                Offset (0x18),
                SBUS,   32
            }

            Method (XPDL, 0, NotSerialized)
            {
                If ((VC0S & 0x00020000))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Mutex (XPPM, 0x00)
            Method (XPRD, 1, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                Local0 = XPID /* \_SB_.PCI0.PB7_.XPID */
                XPIR = Zero
                Release (XPPM)
                Return (Local0)
            }

            Method (XPWR, 2, NotSerialized)
            {
                Acquire (XPPM, 0xFFFF)
                XPIR = Arg0
                XPID = Arg1
                XPIR = Zero
                Release (XPPM)
            }

            Method (XPRT, 0, NotSerialized)
            {
                Local0 = XPRD (0xA2)
                Local0 &= 0xFFFFFFFFFFFFFFF8
                Local1 = (Local0 >> 0x04)
                Local1 &= 0x07
                Local0 |= Local1
                Local0 |= 0x0100
                XPWR (0xA2, Local0)
            }

            Method (XPR2, 0, NotSerialized)
            {
                Local0 = LKCN /* \_SB_.PCI0.PB7_.LKCN */
                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                Local0 |= 0x20
                LKCN = Local0
                Local1 = 0x64
                Local2 = One
                While ((Local1 && Local2))
                {
                    Sleep (One)
                    Local3 = LKST /* \_SB_.PCI0.PB7_.LKST */
                    If ((Local3 & 0x0800))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local2 = Zero
                    }
                }

                Local0 &= 0xFFFFFFFFFFFFFFDF
                LKCN = Local0
                If (!Local2)
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.PB7_._ADR */
                Local1 = (Local0 >> 0x10)
                Local1 = (Local1 << 0x03)
                Local2 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            Method (XPPR, 1, NotSerialized)
            {
                Name (HPOK, Zero)
                HPOK = Zero
                Local0 = (XPPB () << 0x03)
                If (Arg0)
                {
                    XPLL (Local0, One)
                    XPLP (Local0, One)
                    Sleep (0xC8)
                    XPTR (Local0, One)
                    Local5 = 0x0F
                    While ((!HPOK && (Local5 > Zero)))
                    {
                        PDC2 = One
                        Local1 = 0x28
                        While ((!HPOK && (Local1 > Zero)))
                        {
                            Local2 = XPRD (0xA5)
                            If (((Local2 & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                            {
                                Local1 = One
                            }

                            If (((Local2 & 0xFF) >= 0x04))
                            {
                                HPOK = One
                            }

                            Local1--
                        }

                        If (HPOK)
                        {
                            Local2 = (XPRD (0xA5) & 0xFF)
                            Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                            If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                            {
                                HPOK = Zero
                            }
                        }

                        If (HPOK)
                        {
                            Local1 = 0x07D0
                            HPOK = Zero
                            While ((!HPOK && Local1))
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                If ((Local2 == 0x07))
                                {
                                    Local1 = One
                                    Local4 = XPDL ()
                                    If (Local4)
                                    {
                                        XPRT ()
                                        Local5--
                                    }
                                }

                                If ((Local2 == 0x10))
                                {
                                    HPOK = One
                                }

                                Sleep (One)
                                Local1--
                            }
                        }
                    }
                }

                If (HPOK)
                {
                    XPTR (Local0, Zero)
                    XPLP (Local0, Zero)
                    XPLL (Local0, Zero)
                }

                Return (Ones)
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }
            }
        }

        Device (SPB0)
        {
            Name (_ADR, 0x00150000)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0A) /* \_SB_.AR0A */
                }

                Return (PR0A) /* \_SB_.PR0A */
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.SPB0._ADR */
                Local1 = (Local0 >> 0x10)
                Local2 = (Local1 << 0x03)
                Local1 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                PCMS,   32,
                Offset (0x18),
                SBUS,   32
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x16, 0x05))
                }

                Name (WRDX, Package (0x03)
                {
                    Zero,
                    Package (0x02)
                    {
                        0x80000000,
                        0x8000
                    },

                    Package (0x02)
                    {
                        0x80000000,
                        0x8000
                    }
                })
                Method (WRDD, 0, Serialized)
                {
                    Name (WRDX, Package (0x02)
                    {
                        Zero,
                        Package (0x02)
                        {
                            0x07,
                            0x4510
                        }
                    })
                    If ((IWRS == One))
                    {
                        DerefOf (WRDX [One]) [One] = 0x4944
                    }

                    Return (WRDX) /* \_SB_.PCI0.SPB0.XPDV.WRDD.WRDX */
                }
            }
        }

        Device (SPB1)
        {
            Name (_ADR, 0x00150001)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0B) /* \_SB_.AR0B */
                }

                Return (PR0B) /* \_SB_.PR0B */
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.SPB1._ADR */
                Local1 = (Local0 >> 0x10)
                Local2 = (Local1 << 0x03)
                Local1 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                PCMS,   32,
                Offset (0x18),
                SBUS,   32
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x16, 0x04))
                }

                Name (WRDX, Package (0x03)
                {
                    Zero,
                    Package (0x02)
                    {
                        0x80000000,
                        0x8000
                    },

                    Package (0x02)
                    {
                        0x80000000,
                        0x8000
                    }
                })
                Method (WRDD, 0, Serialized)
                {
                    Name (WRDX, Package (0x02)
                    {
                        Zero,
                        Package (0x02)
                        {
                            0x07,
                            0x4510
                        }
                    })
                    If ((IWRS == One))
                    {
                        DerefOf (WRDX [One]) [One] = 0x4944
                    }

                    Return (WRDX) /* \_SB_.PCI0.SPB1.XPDV.WRDD.WRDX */
                }
            }
        }

        Device (SPB2)
        {
            Name (_ADR, 0x00150002)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0C) /* \_SB_.AR0C */
                }

                Return (PR0C) /* \_SB_.PR0C */
            }

            Method (XPPB, 0, NotSerialized)
            {
                Local0 = _ADR /* \_SB_.PCI0.SPB2._ADR */
                Local1 = (Local0 >> 0x10)
                Local2 = (Local1 << 0x03)
                Local1 = (Local0 & 0x0F)
                Local3 = (Local1 | Local2)
                Return (Local3)
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                PCMS,   32,
                Offset (0x18),
                SBUS,   32
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x16, 0x04))
                }

                Name (WRDX, Package (0x03)
                {
                    Zero,
                    Package (0x02)
                    {
                        0x80000000,
                        0x8000
                    },

                    Package (0x02)
                    {
                        0x80000000,
                        0x8000
                    }
                })
                Method (WRDD, 0, Serialized)
                {
                    Name (WRDX, Package (0x02)
                    {
                        Zero,
                        Package (0x02)
                        {
                            0x07,
                            0x4510
                        }
                    })
                    If ((IWRS == One))
                    {
                        DerefOf (WRDX [One]) [One] = 0x4944
                    }

                    Return (WRDX) /* \_SB_.PCI0.SPB2.XPDV.WRDD.WRDX */
                }
            }
        }

        Device (SPB3)
        {
            Name (_ADR, 0x00150003)  // _ADR: Address
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0D) /* \_SB_.AR0D */
                }

                Return (PR0D) /* \_SB_.PR0D */
            }

            OperationRegion (PCFG, PCI_Config, Zero, 0x20)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                DVID,   32,
                PCMS,   32,
                Offset (0x18),
                SBUS,   32
            }

            Device (XPDV)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32,
                    PCMS,   32
                }
            }
        }

        Device (SATA)
        {
            Name (_ADR, 0x00110000)  // _ADR: Address
            Name (B5EN, Zero)
            Name (BA_5, Zero)
            Name (SBAR, 0xD0951000)
            OperationRegion (SATX, PCI_Config, Zero, 0x44)
            Field (SATX, AnyAcc, NoLock, Preserve)
            {
                VIDI,   32,
                Offset (0x0A),
                STCL,   16,
                Offset (0x24),
                BA05,   32,
                Offset (0x40),
                WTEN,   1,
                Offset (0x42),
                DIS0,   1,
                DIS1,   1,
                DIS2,   1,
                DIS3,   1,
                DIS4,   1,
                DIS5,   1
            }

            Field (SATX, AnyAcc, NoLock, Preserve)
            {
                Offset (0x42),
                DISP,   6
            }

            Method (GBAA, 0, Serialized)
            {
                BA_5 = BA05 /* \_SB_.PCI0.SATA.BA05 */
                If (((BA_5 == 0xFFFFFFFF) || (STCL != 0x0101)))
                {
                    B5EN = Zero
                    Return (SBAR) /* \_SB_.PCI0.SATA.SBAR */
                }
                Else
                {
                    B5EN = One
                    Return (BA_5) /* \_SB_.PCI0.SATA.BA_5 */
                }
            }

            OperationRegion (BAR5, SystemMemory, GBAA (), 0x1000)
            Field (BAR5, AnyAcc, NoLock, Preserve)
            {
                NOPT,   5,
                Offset (0x0C),
                PTI0,   1,
                PTI1,   1,
                PTI2,   1,
                PTI3,   1,
                PTI4,   1,
                PTI5,   1,
                PTI6,   1,
                PTI7,   1,
                Offset (0x118),
                CST0,   1,
                Offset (0x120),
                    ,   7,
                BSY0,   1,
                Offset (0x128),
                DET0,   4,
                Offset (0x129),
                IPM0,   4,
                Offset (0x12C),
                DDI0,   4,
                Offset (0x198),
                CST1,   1,
                Offset (0x1A0),
                    ,   7,
                BSY1,   1,
                Offset (0x1A8),
                DET1,   4,
                Offset (0x1A9),
                IPM1,   4,
                Offset (0x1AC),
                DDI1,   4,
                Offset (0x218),
                CST2,   1,
                Offset (0x220),
                    ,   7,
                BSY2,   1,
                Offset (0x228),
                DET2,   4,
                Offset (0x229),
                IPM2,   4,
                Offset (0x22C),
                DDI2,   4,
                Offset (0x298),
                CST3,   1,
                Offset (0x2A0),
                    ,   7,
                BSY3,   1,
                Offset (0x2A8),
                DET3,   4,
                Offset (0x2A9),
                IPM3,   4,
                Offset (0x2AC),
                DDI3,   4,
                Offset (0x318),
                CST4,   1,
                Offset (0x320),
                    ,   7,
                BSY4,   1,
                Offset (0x328),
                DET4,   4,
                Offset (0x329),
                IPM4,   4,
                Offset (0x32C),
                DDI4,   4,
                Offset (0x398),
                CST5,   1,
                Offset (0x3A0),
                    ,   7,
                BSY5,   1,
                Offset (0x3A8),
                DET5,   4,
                Offset (0x3A9),
                IPM5,   4,
                Offset (0x3AC),
                DDI5,   4
            }

            Field (BAR5, AnyAcc, NoLock, Preserve)
            {
                Offset (0x0C),
                PTI,    6
            }

            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                GBAA ()
            }

            Method (ENP, 2, NotSerialized)
            {
                If ((Arg0 == Zero))
                {
                    DIS0 = ~Arg1
                }
                ElseIf ((Arg0 == One))
                {
                    DIS1 = ~Arg1
                }
                ElseIf ((Arg0 == 0x02))
                {
                    DIS2 = ~Arg1
                }
                ElseIf ((Arg0 == 0x03))
                {
                    DIS3 = ~Arg1
                }
                ElseIf ((Arg0 == 0x04))
                {
                    DIS4 = ~Arg1
                }
                ElseIf ((Arg0 == 0x05))
                {
                    DIS5 = ~Arg1
                }

                WTEN = One
                If ((Arg0 == Zero))
                {
                    PTI0 = Arg1
                }
                ElseIf ((Arg0 == One))
                {
                    PTI1 = Arg1
                }
                ElseIf ((Arg0 == 0x02))
                {
                    PTI2 = Arg1
                }
                ElseIf ((Arg0 == 0x03))
                {
                    PTI3 = Arg1
                }
                ElseIf ((Arg0 == 0x04))
                {
                    PTI4 = Arg1
                }
                ElseIf ((Arg0 == 0x05))
                {
                    PTI5 = Arg1
                }

                If ((DISP == 0x3F))
                {
                    PTI0 = One
                }
                ElseIf ((DIS0 && ((DISP & 0x3E) ^ 0x3E)))
                {
                    PTI0 = Zero
                }

                Local0 = PTI /* \_SB_.PCI0.SATA.PTI_ */
                Local1 = Zero
                While (Local0)
                {
                    If ((Local0 & One))
                    {
                        Local1++
                    }

                    Local0 >>= One
                }

                NOPT = Local1--
                WTEN = Zero
            }

            Device (PRT0)
            {
                Name (_ADR, 0xFFFF)  // _ADR: Address
                Name (IDAS, 0xFF)
                Name (IDDC, 0xFF)
                Method (_SDD, 1, Serialized)  // _SDD: Set Device Data
                {
                    CreateByteField (Arg0, 0x0100, BFAS)
                    ToInteger (BFAS, IDAS) /* \_SB_.PCI0.SATA.PRT0.IDAS */
                    CreateByteField (Arg0, 0xA7, BFDC)
                    ToInteger (BFDC, IDDC) /* \_SB_.PCI0.SATA.PRT0.IDDC */
                    Return (Zero)
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If ((((IDAS & One) == One) && ((IDDC & 0x08
                        ) == 0x08)))
                    {
                        Return (Buffer (0x0E)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5, 0xC1,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1               // ......
                        })
                    }

                    If (((IDAS & One) == One))
                    {
                        Return (Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5         // .......
                        })
                    }

                    If (((IDDC & 0x08) == 0x08))
                    {
                        Return (Buffer (0x07)
                        {
                             0xC1, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1         // .......
                        })
                    }

                    Return (Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x0001FFFF)  // _ADR: Address
                Name (IDAS, 0xFF)
                Name (IDDC, 0xFF)
                Method (_SDD, 1, Serialized)  // _SDD: Set Device Data
                {
                    CreateByteField (Arg0, 0x0100, BFAS)
                    ToInteger (BFAS, IDAS) /* \_SB_.PCI0.SATA.PRT1.IDAS */
                    CreateByteField (Arg0, 0xA7, BFDC)
                    ToInteger (BFDC, IDDC) /* \_SB_.PCI0.SATA.PRT1.IDDC */
                    Return (Zero)
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If ((((IDAS & One) == One) && ((IDDC & 0x08
                        ) == 0x08)))
                    {
                        Return (Buffer (0x0E)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5, 0xC1,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1               // ......
                        })
                    }

                    If (((IDAS & One) == One))
                    {
                        Return (Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5         // .......
                        })
                    }

                    If (((IDDC & 0x08) == 0x08))
                    {
                        Return (Buffer (0x07)
                        {
                             0xC1, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1         // .......
                        })
                    }

                    Return (Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                }
            }

            Device (PRT2)
            {
                Name (_ADR, 0x0002FFFF)  // _ADR: Address
                Name (IDAS, 0xFF)
                Name (IDDC, 0xFF)
                Method (_SDD, 1, Serialized)  // _SDD: Set Device Data
                {
                    CreateByteField (Arg0, 0x0100, BFAS)
                    ToInteger (BFAS, IDAS) /* \_SB_.PCI0.SATA.PRT2.IDAS */
                    CreateByteField (Arg0, 0xA7, BFDC)
                    ToInteger (BFDC, IDDC) /* \_SB_.PCI0.SATA.PRT2.IDDC */
                    Return (Zero)
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If ((((IDAS & One) == One) && ((IDDC & 0x08
                        ) == 0x08)))
                    {
                        Return (Buffer (0x0E)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5, 0xC1,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1               // ......
                        })
                    }

                    If (((IDAS & One) == One))
                    {
                        Return (Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5         // .......
                        })
                    }

                    If (((IDDC & 0x08) == 0x08))
                    {
                        Return (Buffer (0x07)
                        {
                             0xC1, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1         // .......
                        })
                    }

                    Return (Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                }
            }

            Device (PRT3)
            {
                Name (_ADR, 0x0003FFFF)  // _ADR: Address
                Name (IDAS, 0xFF)
                Name (IDDC, 0xFF)
                Method (_SDD, 1, Serialized)  // _SDD: Set Device Data
                {
                    CreateByteField (Arg0, 0x0100, BFAS)
                    ToInteger (BFAS, IDAS) /* \_SB_.PCI0.SATA.PRT3.IDAS */
                    CreateByteField (Arg0, 0xA7, BFDC)
                    ToInteger (BFDC, IDDC) /* \_SB_.PCI0.SATA.PRT3.IDDC */
                    Return (Zero)
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If ((((IDAS & One) == One) && ((IDDC & 0x08
                        ) == 0x08)))
                    {
                        Return (Buffer (0x0E)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5, 0xC1,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1               // ......
                        })
                    }

                    If (((IDAS & One) == One))
                    {
                        Return (Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5         // .......
                        })
                    }

                    If (((IDDC & 0x08) == 0x08))
                    {
                        Return (Buffer (0x07)
                        {
                             0xC1, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1         // .......
                        })
                    }

                    Return (Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                }
            }

            Device (PRT4)
            {
                Name (_ADR, 0x0004FFFF)  // _ADR: Address
                Name (IDAS, 0xFF)
                Name (IDDC, 0xFF)
                Method (_SDD, 1, Serialized)  // _SDD: Set Device Data
                {
                    CreateByteField (Arg0, 0x0100, BFAS)
                    ToInteger (BFAS, IDAS) /* \_SB_.PCI0.SATA.PRT4.IDAS */
                    CreateByteField (Arg0, 0xA7, BFDC)
                    ToInteger (BFDC, IDDC) /* \_SB_.PCI0.SATA.PRT4.IDDC */
                    Return (Zero)
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If ((((IDAS & One) == One) && ((IDDC & 0x08
                        ) == 0x08)))
                    {
                        Return (Buffer (0x0E)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5, 0xC1,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1               // ......
                        })
                    }

                    If (((IDAS & One) == One))
                    {
                        Return (Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5         // .......
                        })
                    }

                    If (((IDDC & 0x08) == 0x08))
                    {
                        Return (Buffer (0x07)
                        {
                             0xC1, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1         // .......
                        })
                    }

                    Return (Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                }
            }

            Device (PRT5)
            {
                Name (_ADR, 0x0005FFFF)  // _ADR: Address
                Name (IDAS, 0xFF)
                Name (IDDC, 0xFF)
                Method (_SDD, 1, Serialized)  // _SDD: Set Device Data
                {
                    CreateByteField (Arg0, 0x0100, BFAS)
                    ToInteger (BFAS, IDAS) /* \_SB_.PCI0.SATA.PRT5.IDAS */
                    CreateByteField (Arg0, 0xA7, BFDC)
                    ToInteger (BFDC, IDDC) /* \_SB_.PCI0.SATA.PRT5.IDDC */
                    Return (Zero)
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If ((((IDAS & One) == One) && ((IDDC & 0x08
                        ) == 0x08)))
                    {
                        Return (Buffer (0x0E)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5, 0xC1,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1               // ......
                        })
                    }

                    If (((IDAS & One) == One))
                    {
                        Return (Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xF5         // .......
                        })
                    }

                    If (((IDDC & 0x08) == 0x08))
                    {
                        Return (Buffer (0x07)
                        {
                             0xC1, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xB1         // .......
                        })
                    }

                    Return (Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                }
            }
        }

        Device (IDE)
        {
            Name (_ADR, 0x00140001)  // _ADR: Address
            Name (UDMT, Package (0x08)
            {
                0x78,
                0x5A,
                0x3C,
                0x2D,
                0x1E,
                0x14,
                Zero,
                Zero
            })
            Name (PIOT, Package (0x06)
            {
                0x0258,
                0x0186,
                0x010E,
                0xB4,
                0x78,
                Zero
            })
            Name (PITR, Package (0x06)
            {
                0x99,
                0x47,
                0x34,
                0x22,
                0x20,
                0x99
            })
            Name (MDMT, Package (0x04)
            {
                0x01E0,
                0x96,
                0x78,
                Zero
            })
            Name (MDTR, Package (0x04)
            {
                0x77,
                0x21,
                0x20,
                0xFF
            })
            OperationRegion (IDE, PCI_Config, 0x40, 0x20)
            Field (IDE, WordAcc, NoLock, Preserve)
            {
                PPIT,   16,
                SPIT,   16,
                PMDT,   16,
                SMDT,   16,
                PPIC,   8,
                SPIC,   8,
                PPIM,   8,
                SPIM,   8,
                Offset (0x14),
                PUDC,   2,
                SUDC,   2,
                Offset (0x16),
                PUDM,   8,
                SUDM,   8
            }

            Method (GETT, 1, NotSerialized)
            {
                Local0 = (Arg0 & 0x0F)
                Local1 = (Arg0 >> 0x04)
                Return ((0x1E * ((Local0 + One) + (Local1 + One)
                    )))
            }

            Method (GTM, 1, NotSerialized)
            {
                CreateByteField (Arg0, Zero, PIT1)
                CreateByteField (Arg0, One, PIT0)
                CreateByteField (Arg0, 0x02, MDT1)
                CreateByteField (Arg0, 0x03, MDT0)
                CreateByteField (Arg0, 0x04, PICX)
                CreateByteField (Arg0, 0x05, UDCX)
                CreateByteField (Arg0, 0x06, UDMX)
                Name (BUF, Buffer (0x14)
                {
                    /* 0000 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                    /* 0008 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                    /* 0010 */  0x00, 0x00, 0x00, 0x00                           // ....
                })
                CreateDWordField (BUF, Zero, PIO0)
                CreateDWordField (BUF, 0x04, DMA0)
                CreateDWordField (BUF, 0x08, PIO1)
                CreateDWordField (BUF, 0x0C, DMA1)
                CreateDWordField (BUF, 0x10, FLAG)
                If ((PICX & One))
                {
                    Return (BUF) /* \_SB_.PCI0.IDE_.GTM_.BUF_ */
                }

                PIO0 = GETT (PIT0)
                PIO1 = GETT (PIT1)
                If ((UDCX & One))
                {
                    FLAG |= One
                    DMA0 = DerefOf (UDMT [(UDMX & 0x0F)])
                }
                ElseIf ((MDT0 != 0xFF))
                {
                    DMA0 = GETT (MDT0)
                }

                If ((UDCX & 0x02))
                {
                    FLAG |= 0x04
                    DMA1 = DerefOf (UDMT [(UDMX >> 0x04)])
                }
                ElseIf ((MDT1 != 0xFF))
                {
                    DMA1 = GETT (MDT1)
                }

                FLAG |= 0x1A
                Return (BUF) /* \_SB_.PCI0.IDE_.GTM_.BUF_ */
            }

            Method (STM, 3, NotSerialized)
            {
                CreateDWordField (Arg0, Zero, PIO0)
                CreateDWordField (Arg0, 0x04, DMA0)
                CreateDWordField (Arg0, 0x08, PIO1)
                CreateDWordField (Arg0, 0x0C, DMA1)
                CreateDWordField (Arg0, 0x10, FLAG)
                Name (BUF, Buffer (0x07)
                {
                     0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         // .......
                })
                CreateByteField (BUF, Zero, PIT1)
                CreateByteField (BUF, One, PIT0)
                CreateByteField (BUF, 0x02, MDT1)
                CreateByteField (BUF, 0x03, MDT0)
                CreateByteField (BUF, 0x04, PIMX)
                CreateByteField (BUF, 0x05, UDCX)
                CreateByteField (BUF, 0x06, UDMX)
                Local0 = Match (PIOT, MLE, PIO0, MTR, Zero, Zero)
                Local0 %= 0x05
                Local1 = Match (PIOT, MLE, PIO1, MTR, Zero, Zero)
                Local1 %= 0x05
                PIMX = ((Local1 << 0x04) | Local0)
                PIT0 = DerefOf (PITR [Local0])
                PIT1 = DerefOf (PITR [Local1])
                If ((FLAG & One))
                {
                    Local0 = Match (UDMT, MLE, DMA0, MTR, Zero, Zero)
                    Local0 %= 0x06
                    UDMX |= Local0
                    UDCX |= One
                }
                ElseIf ((DMA0 != 0xFFFFFFFF))
                {
                    Local0 = Match (MDMT, MLE, DMA0, MTR, Zero, Zero)
                    MDT0 = DerefOf (MDTR [Local0])
                }

                If ((FLAG & 0x04))
                {
                    Local0 = Match (UDMT, MLE, DMA1, MTR, Zero, Zero)
                    Local0 %= 0x06
                    UDMX |= (Local0 << 0x04)
                    UDCX |= 0x02
                }
                ElseIf ((DMA1 != 0xFFFFFFFF))
                {
                    Local0 = Match (MDMT, MLE, DMA1, MTR, Zero, Zero)
                    MDT1 = DerefOf (MDTR [Local0])
                }

                Return (BUF) /* \_SB_.PCI0.IDE_.STM_.BUF_ */
            }

            Method (GTF, 2, NotSerialized)
            {
                CreateByteField (Arg1, Zero, MDT1)
                CreateByteField (Arg1, One, MDT0)
                CreateByteField (Arg1, 0x02, PIMX)
                CreateByteField (Arg1, 0x03, UDCX)
                CreateByteField (Arg1, 0x04, UDMX)
                If ((Arg0 == 0xA0))
                {
                    Local0 = (PIMX & 0x0F)
                    Local1 = MDT0 /* \_SB_.PCI0.IDE_.GTF_.MDT0 */
                    Local2 = (UDCX & One)
                    Local3 = (UDMX & 0x0F)
                }
                Else
                {
                    Local0 = (PIMX >> 0x04)
                    Local1 = MDT1 /* \_SB_.PCI0.IDE_.GTF_.MDT1 */
                    Local2 = (UDCX & 0x02)
                    Local3 = (UDMX >> 0x04)
                }

                Name (BUF, Buffer (0x0E)
                {
                    /* 0000 */  0x03, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF, 0x03,  // ........
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF               // ......
                })
                CreateByteField (BUF, One, PMOD)
                CreateByteField (BUF, 0x08, DMOD)
                CreateByteField (BUF, 0x05, CMDA)
                CreateByteField (BUF, 0x0C, CMDB)
                CMDA = Arg0
                CMDB = Arg0
                PMOD = (Local0 | 0x08)
                If (Local2)
                {
                    DMOD = (Local3 | 0x40)
                }
                ElseIf ((Local1 != 0xFF))
                {
                    Local4 = Match (MDMT, MLE, GETT (Local1), MTR, Zero, Zero)
                    If ((Local4 < 0x03))
                    {
                        DMOD = (0x20 | Local4)
                    }
                }

                Return (BUF) /* \_SB_.PCI0.IDE_.GTF_.BUF_ */
            }

            Device (PRID)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                {
                    Name (BUF, Buffer (0x07)
                    {
                         0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         // .......
                    })
                    CreateWordField (BUF, Zero, VPIT)
                    CreateWordField (BUF, 0x02, VMDT)
                    CreateByteField (BUF, 0x04, VPIC)
                    CreateByteField (BUF, 0x05, VUDC)
                    CreateByteField (BUF, 0x06, VUDM)
                    VPIT = PPIT /* \_SB_.PCI0.IDE_.PPIT */
                    VMDT = PMDT /* \_SB_.PCI0.IDE_.PMDT */
                    VPIC = PPIC /* \_SB_.PCI0.IDE_.PPIC */
                    VUDC = PUDC /* \_SB_.PCI0.IDE_.PUDC */
                    VUDM = PUDM /* \_SB_.PCI0.IDE_.PUDM */
                    Return (GTM (BUF))
                }

                Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                {
                    Name (BUF, Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                    CreateWordField (BUF, Zero, VPIT)
                    CreateWordField (BUF, 0x02, VMDT)
                    CreateByteField (BUF, 0x04, VPIM)
                    CreateByteField (BUF, 0x05, VUDC)
                    CreateByteField (BUF, 0x06, VUDM)
                    BUF = STM (Arg0, Arg1, Arg2)
                    PPIT = VPIT /* \_SB_.PCI0.IDE_.PRID._STM.VPIT */
                    PMDT = VMDT /* \_SB_.PCI0.IDE_.PRID._STM.VMDT */
                    PPIM = VPIM /* \_SB_.PCI0.IDE_.PRID._STM.VPIM */
                    PUDC = VUDC /* \_SB_.PCI0.IDE_.PRID._STM.VUDC */
                    PUDM = VUDM /* \_SB_.PCI0.IDE_.PRID._STM.VUDM */
                }

                Device (P_D0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Name (BUF, Buffer (0x05)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                        })
                        CreateWordField (BUF, Zero, VMDT)
                        CreateByteField (BUF, 0x02, VPIM)
                        CreateByteField (BUF, 0x03, VUDC)
                        CreateByteField (BUF, 0x04, VUDM)
                        VMDT = PMDT /* \_SB_.PCI0.IDE_.PMDT */
                        VPIM = PPIM /* \_SB_.PCI0.IDE_.PPIM */
                        VUDC = PUDC /* \_SB_.PCI0.IDE_.PUDC */
                        VUDM = PUDM /* \_SB_.PCI0.IDE_.PUDM */
                        Return (GTF (0xA0, BUF))
                    }
                }

                Device (P_D1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Name (BUF, Buffer (0x05)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                        })
                        CreateWordField (BUF, Zero, VMDT)
                        CreateByteField (BUF, 0x02, VPIM)
                        CreateByteField (BUF, 0x03, VUDC)
                        CreateByteField (BUF, 0x04, VUDM)
                        VMDT = PMDT /* \_SB_.PCI0.IDE_.PMDT */
                        VPIM = PPIM /* \_SB_.PCI0.IDE_.PPIM */
                        VUDC = PUDC /* \_SB_.PCI0.IDE_.PUDC */
                        VUDM = PUDM /* \_SB_.PCI0.IDE_.PUDM */
                        Return (GTF (0xB0, BUF))
                    }
                }
            }

            Device (SECD)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                {
                    Name (BUF, Buffer (0x07)
                    {
                         0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         // .......
                    })
                    CreateWordField (BUF, Zero, VPIT)
                    CreateWordField (BUF, 0x02, VMDT)
                    CreateByteField (BUF, 0x04, VPIC)
                    CreateByteField (BUF, 0x05, VUDC)
                    CreateByteField (BUF, 0x06, VUDM)
                    VPIT = SPIT /* \_SB_.PCI0.IDE_.SPIT */
                    VMDT = SMDT /* \_SB_.PCI0.IDE_.SMDT */
                    VPIC = SPIC /* \_SB_.PCI0.IDE_.SPIC */
                    VUDC = SUDC /* \_SB_.PCI0.IDE_.SUDC */
                    VUDM = SUDM /* \_SB_.PCI0.IDE_.SUDM */
                    Return (GTM (BUF))
                }

                Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                {
                    Name (BUF, Buffer (0x07)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                    })
                    CreateWordField (BUF, Zero, VPIT)
                    CreateWordField (BUF, 0x02, VMDT)
                    CreateByteField (BUF, 0x04, VPIM)
                    CreateByteField (BUF, 0x05, VUDC)
                    CreateByteField (BUF, 0x06, VUDM)
                    BUF = STM (Arg0, Arg1, Arg2)
                    SPIT = VPIT /* \_SB_.PCI0.IDE_.SECD._STM.VPIT */
                    SMDT = VMDT /* \_SB_.PCI0.IDE_.SECD._STM.VMDT */
                    SPIM = VPIM /* \_SB_.PCI0.IDE_.SECD._STM.VPIM */
                    SUDC = VUDC /* \_SB_.PCI0.IDE_.SECD._STM.VUDC */
                    SUDM = VUDM /* \_SB_.PCI0.IDE_.SECD._STM.VUDM */
                }

                Device (S_D0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Name (BUF, Buffer (0x05)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                        })
                        CreateWordField (BUF, Zero, VMDT)
                        CreateByteField (BUF, 0x02, VPIM)
                        CreateByteField (BUF, 0x03, VUDC)
                        CreateByteField (BUF, 0x04, VUDM)
                        VMDT = SMDT /* \_SB_.PCI0.IDE_.SMDT */
                        VPIM = SPIM /* \_SB_.PCI0.IDE_.SPIM */
                        VUDC = SUDC /* \_SB_.PCI0.IDE_.SUDC */
                        VUDM = SUDM /* \_SB_.PCI0.IDE_.SUDM */
                        Return (GTF (0xA0, BUF))
                    }
                }

                Device (S_D1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Name (BUF, Buffer (0x05)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                        })
                        CreateWordField (BUF, Zero, VMDT)
                        CreateByteField (BUF, 0x02, VPIM)
                        CreateByteField (BUF, 0x03, VUDC)
                        CreateByteField (BUF, 0x04, VUDM)
                        VMDT = SMDT /* \_SB_.PCI0.IDE_.SMDT */
                        VPIM = SPIM /* \_SB_.PCI0.IDE_.SPIM */
                        VUDC = SUDC /* \_SB_.PCI0.IDE_.SUDC */
                        VUDM = SUDM /* \_SB_.PCI0.IDE_.SUDM */
                        Return (GTF (0xB0, BUF))
                    }
                }
            }
        }

        Device (SMBS)
        {
            Name (_ADR, 0x00140000)  // _ADR: Address
            OperationRegion (IRQF, PCI_Config, Zero, 0x0100)
            Field (IRQF, AnyAcc, NoLock, Preserve)
            {
                Offset (0x08),
                RVID,   8
            }

            OperationRegion (ERMM, SystemMemory, 0xFED80000, 0x1000)
            Field (ERMM, AnyAcc, NoLock, Preserve)
            {
                Offset (0x100),
                    ,   5,
                E000,   1,
                O000,   1,
                I000,   1,
                    ,   5,
                E001,   1,
                O001,   1,
                I001,   1,
                Offset (0x106),
                    ,   5,
                E006,   1,
                O006,   1,
                I006,   1,
                    ,   5,
                E007,   1,
                O007,   1,
                I007,   1,
                Offset (0x10B),
                    ,   5,
                E011,   1,
                O011,   1,
                I011,   1,
                    ,   5,
                E012,   1,
                O012,   1,
                I012,   1,
                    ,   5,
                E013,   1,
                O013,   1,
                I013,   1,
                    ,   5,
                E014,   1,
                O014,   1,
                I014,   1,
                    ,   5,
                E015,   1,
                O015,   1,
                I015,   1,
                    ,   5,
                E016,   1,
                O016,   1,
                I016,   1,
                Offset (0x114),
                    ,   5,
                E020,   1,
                O020,   1,
                I020,   1,
                    ,   5,
                E021,   1,
                O021,   1,
                I021,   1,
                    ,   5,
                E022,   1,
                O022,   1,
                I022,   1,
                    ,   5,
                E023,   1,
                O023,   1,
                I023,   1,
                    ,   5,
                E024,   1,
                O024,   1,
                I024,   1,
                    ,   5,
                E025,   1,
                O025,   1,
                I025,   1,
                Offset (0x11B),
                    ,   5,
                E027,   1,
                O027,   1,
                I027,   1,
                    ,   5,
                E028,   1,
                O028,   1,
                I028,   1,
                Offset (0x120),
                    ,   5,
                E032,   1,
                O032,   1,
                I032,   1,
                Offset (0x123),
                    ,   5,
                E035,   1,
                O035,   1,
                I035,   1,
                Offset (0x129),
                    ,   1,
                H041,   1,
                S041,   1,
                U041,   1,
                D041,   1,
                E041,   1,
                O041,   1,
                I041,   1,
                Offset (0x12C),
                    ,   5,
                E044,   1,
                O044,   1,
                I044,   1,
                    ,   5,
                E045,   1,
                O045,   1,
                I045,   1,
                    ,   1,
                H046,   1,
                S046,   1,
                U046,   1,
                D046,   1,
                E046,   1,
                O046,   1,
                I046,   1,
                Offset (0x133),
                    ,   5,
                E051,   1,
                O051,   1,
                I051,   1,
                Offset (0x135),
                    ,   5,
                E053,   1,
                O053,   1,
                I053,   1,
                Offset (0x137),
                    ,   5,
                E055,   1,
                O055,   1,
                I055,   1,
                Offset (0x139),
                    ,   5,
                E057,   1,
                O057,   1,
                I057,   1,
                    ,   5,
                E058,   1,
                O058,   1,
                I058,   1,
                    ,   5,
                E059,   1,
                O059,   1,
                I059,   1,
                Offset (0x13D),
                    ,   1,
                H061,   1,
                S061,   1,
                U061,   1,
                D061,   1,
                E061,   1,
                O061,   1,
                I061,   1,
                    ,   1,
                H062,   1,
                S062,   1,
                U062,   1,
                D062,   1,
                E062,   1,
                O062,   1,
                I062,   1,
                    ,   1,
                H063,   1,
                S063,   1,
                U063,   1,
                D063,   1,
                E063,   1,
                O063,   1,
                I063,   1,
                    ,   1,
                H064,   1,
                S064,   1,
                U064,   1,
                D064,   1,
                E064,   1,
                O064,   1,
                I064,   1,
                Offset (0x142),
                    ,   5,
                E066,   1,
                O066,   1,
                I066,   1,
                Offset (0x160),
                    ,   7,
                GE00,   1,
                    ,   7,
                GE01,   1,
                    ,   7,
                GE02,   1,
                    ,   7,
                GE03,   1,
                    ,   7,
                GE04,   1,
                    ,   7,
                GE05,   1,
                    ,   7,
                GE06,   1,
                    ,   7,
                GE07,   1,
                    ,   7,
                GE08,   1,
                    ,   7,
                GE09,   1,
                    ,   7,
                GE10,   1,
                    ,   7,
                GE11,   1,
                    ,   7,
                GE12,   1,
                    ,   7,
                GE13,   1,
                    ,   7,
                GE14,   1,
                    ,   7,
                GE15,   1,
                    ,   7,
                GE16,   1,
                    ,   7,
                GE17,   1,
                    ,   7,
                GE18,   1,
                    ,   7,
                GE19,   1,
                    ,   7,
                GE20,   1,
                    ,   7,
                GE21,   1,
                    ,   7,
                GE22,   1,
                    ,   7,
                GE23,   1,
                Offset (0x1A6),
                    ,   5,
                E166,   1,
                O166,   1,
                I166,   1,
                Offset (0x1AA),
                    ,   5,
                E170,   1,
                O170,   1,
                I170,   1,
                    ,   5,
                E171,   1,
                O171,   1,
                I171,   1,
                Offset (0x1AF),
                    ,   5,
                E175,   1,
                O175,   1,
                I175,   1,
                    ,   5,
                E176,   1,
                O176,   1,
                I176,   1,
                    ,   5,
                E177,   1,
                O177,   1,
                I177,   1,
                    ,   5,
                E178,   1,
                O178,   1,
                I178,   1,
                    ,   5,
                E179,   1,
                O179,   1,
                I179,   1,
                    ,   5,
                E180,   1,
                O180,   1,
                I180,   1,
                    ,   5,
                E181,   1,
                O181,   1,
                I181,   1,
                    ,   5,
                E182,   1,
                O182,   1,
                I182,   1,
                Offset (0x1B8),
                    ,   3,
                U184,   1,
                D184,   1,
                E184,   1,
                O184,   1,
                I184,   1,
                Offset (0x1BF),
                    ,   5,
                E191,   1,
                O191,   1,
                I191,   1,
                    ,   5,
                E192,   1,
                O192,   1,
                I192,   1,
                Offset (0x1C5),
                    ,   5,
                E197,   1,
                O197,   1,
                I197,   1,
                Offset (0x1C7),
                    ,   5,
                E199,   1,
                O199,   1,
                I199,   1,
                    ,   5,
                E200,   1,
                O200,   1,
                I200,   1,
                Offset (0x200),
                    ,   1,
                G01S,   1,
                    ,   3,
                G05S,   1,
                    ,   8,
                G14S,   1,
                G15S,   1,
                G16S,   1,
                    ,   5,
                G22S,   1,
                G23S,   1,
                Offset (0x204),
                    ,   1,
                G01E,   1,
                    ,   3,
                G05E,   1,
                    ,   8,
                G14E,   1,
                G15E,   1,
                G16E,   1,
                    ,   5,
                G22E,   1,
                G23E,   1,
                Offset (0x208),
                GT00,   1,
                GT01,   1,
                GT02,   1,
                GT03,   1,
                GT04,   1,
                GT05,   1,
                GT06,   1,
                GT07,   1,
                GT08,   1,
                GT09,   1,
                GT10,   1,
                GT11,   1,
                GT12,   1,
                GT13,   1,
                GT14,   1,
                GT15,   1,
                GT16,   1,
                GT17,   1,
                GT18,   1,
                GT19,   1,
                GT20,   1,
                GT21,   1,
                GT22,   1,
                GT23,   1,
                Offset (0x20C),
                    ,   1,
                G01L,   1,
                    ,   3,
                G05L,   1,
                    ,   9,
                G15L,   1,
                G16L,   1,
                    ,   5,
                G22L,   1,
                G23L,   1,
                Offset (0x218),
                    ,   23,
                SE23,   1,
                Offset (0x21C),
                    ,   23,
                SD23,   1,
                Offset (0x288),
                    ,   1,
                CLPS,   1,
                Offset (0x299),
                    ,   7,
                G15A,   1,
                Offset (0x2B0),
                    ,   2,
                SLPS,   2,
                Offset (0x32C),
                SM0E,   1,
                Offset (0x32E),
                    ,   1,
                SM0S,   2,
                Offset (0x362),
                    ,   6,
                MT3A,   1,
                Offset (0x377),
                EPNM,   1,
                DPPF,   1,
                Offset (0x3BB),
                    ,   6,
                PWDE,   1,
                Offset (0x3BE),
                    ,   5,
                ALLS,   1,
                Offset (0x3C8),
                    ,   2,
                TFTE,   1,
                Offset (0x3DF),
                BLNK,   2,
                Offset (0x3F0),
                PHYD,   1,
                Offset (0x400),
                F0CT,   8,
                F0MS,   8,
                F0FQ,   8,
                F0LD,   8,
                F0MD,   8,
                F0MP,   8,
                LT0L,   8,
                LT0H,   8,
                MT0L,   8,
                MT0H,   8,
                HT0L,   8,
                HT0H,   8,
                LRG0,   8,
                LHC0,   8,
                Offset (0x410),
                F1CT,   8,
                F1MS,   8,
                F1FQ,   8,
                F1LD,   8,
                F1MD,   8,
                F1MP,   8,
                LT1L,   8,
                LT1H,   8,
                MT1L,   8,
                MT1H,   8,
                HT1L,   8,
                HT1H,   8,
                LRG1,   8,
                LHC1,   8,
                Offset (0x420),
                F2CT,   8,
                F2MS,   8,
                F2FQ,   8,
                F2LD,   8,
                F2MD,   8,
                F2MP,   8,
                LT2L,   8,
                LT2H,   8,
                MT2L,   8,
                MT2H,   8,
                HT2L,   8,
                HT2H,   8,
                LRG2,   8,
                LHC2,   8,
                Offset (0x430),
                F3CT,   8,
                F3MS,   8,
                F3FQ,   8,
                F3LD,   8,
                F3MD,   8,
                F3MP,   8,
                LT3L,   8,
                LT3H,   8,
                MT3L,   8,
                MT3H,   8,
                HT3L,   8,
                HT3H,   8,
                LRG3,   8,
                LHC3,   8,
                Offset (0x700),
                SEC,    8,
                Offset (0x702),
                MIN,    8,
                Offset (0xD07),
                MX07,   8,
                Offset (0xD0F),
                MX15,   8,
                MX16,   8,
                Offset (0xD15),
                MX21,   8,
                MX22,   8,
                MX23,   8,
                Offset (0xD1B),
                MX27,   8,
                MX28,   8,
                Offset (0xD20),
                MX32,   8,
                Offset (0xD2C),
                MX44,   8,
                Offset (0xD33),
                MX51,   8,
                Offset (0xD35),
                MX53,   8,
                Offset (0xD39),
                MX57,   8,
                MX58,   8,
                MX59,   8,
                Offset (0xD42),
                MX66,   8,
                Offset (0xD66),
                M102,   8,
                Offset (0xD6E),
                M110,   8,
                Offset (0xDAA),
                M170,   8,
                Offset (0xDAF),
                M175,   8,
                M176,   8,
                M177,   8,
                Offset (0xDB4),
                M180,   8,
                Offset (0xDB6),
                M182,   8,
                Offset (0xDC5),
                M197,   8,
                Offset (0xDC8),
                M200,   8,
                Offset (0xE00),
                MS00,   8,
                MS01,   8,
                MS02,   8,
                MS03,   8,
                MS04,   8,
                Offset (0xE40),
                MS40,   8,
                Offset (0xE81),
                    ,   2,
                ECES,   1
            }

            OperationRegion (ERM1, SystemMemory, MMSO, 0x1000)
            Field (ERM1, AnyAcc, NoLock, Preserve)
            {
                Offset (0x100),
                    ,   5,
                P01E,   1,
                P01O,   1,
                P01I,   1,
                Offset (0x105),
                    ,   5,
                P06E,   1,
                P06O,   1,
                P06I,   1,
                    ,   5,
                P07E,   1,
                P07O,   1,
                P07I,   1,
                Offset (0x10A),
                    ,   5,
                P0BE,   1,
                P0BO,   1,
                P0BI,   1,
                    ,   5,
                P0CE,   1,
                P0CO,   1,
                P0CI,   1,
                    ,   5,
                P0DE,   1,
                P0DO,   1,
                P0DI,   1,
                    ,   5,
                P0EE,   1,
                P0EO,   1,
                P0EI,   1,
                    ,   5,
                P0FE,   1,
                P0FO,   1,
                P0FI,   1,
                    ,   5,
                P10E,   1,
                P10O,   1,
                P10I,   1,
                Offset (0x113),
                    ,   5,
                P14E,   1,
                P14O,   1,
                P14I,   1,
                    ,   5,
                P15E,   1,
                P15O,   1,
                P15I,   1,
                Offset (0x11A),
                    ,   5,
                P1BE,   1,
                P1BO,   1,
                P1BI,   1,
                Offset (0x11F),
                    ,   5,
                P20E,   1,
                P20O,   1,
                P20I,   1,
                    ,   5,
                P21E,   1,
                P21O,   1,
                P21I,   1,
                    ,   5,
                P22E,   1,
                P22O,   1,
                P22I,   1,
                    ,   5,
                P23E,   1,
                P23O,   1,
                P23I,   1,
                Offset (0x128),
                    ,   5,
                P29E,   1,
                P29O,   1,
                P29I,   1,
                Offset (0x12B),
                    ,   5,
                P2CE,   1,
                P2CO,   1,
                P2CI,   1,
                    ,   5,
                P2DE,   1,
                P2DO,   1,
                P2DI,   1,
                PO2E,   8,
                Offset (0x132),
                    ,   5,
                P33E,   1,
                P33O,   1,
                P33I,   1,
                Offset (0x134),
                    ,   5,
                P35E,   1,
                P35O,   1,
                P35I,   1,
                Offset (0x136),
                    ,   5,
                P37E,   1,
                P37O,   1,
                P37I,   1,
                Offset (0x138),
                    ,   5,
                P39E,   1,
                P39O,   1,
                P39I,   1,
                Offset (0x13A),
                    ,   5,
                P3BE,   1,
                P3BO,   1,
                P3BI,   1,
                Offset (0x13C),
                PO3D,   8,
                PO3E,   8,
                PO3F,   8,
                PO40,   8,
                Offset (0x164),
                    ,   7,
                Offset (0x165),
                    ,   5,
                P66E,   1,
                P66O,   1,
                P66I,   1,
                Offset (0x16A),
                Offset (0x16B),
                    ,   5,
                P6CE,   1,
                P6CO,   1,
                P6CI,   1,
                Offset (0x16E),
                    ,   7,
                Offset (0x16F),
                    ,   7,
                Offset (0x170),
                Offset (0x174),
                Offset (0x175),
                    ,   7,
                Offset (0x176),
                Offset (0x1A5),
                POA6,   8,
                Offset (0x1A9),
                    ,   5,
                PAAE,   1,
                PAAO,   1,
                PAAI,   1,
                Offset (0x1AE),
                    ,   5,
                PAFE,   1,
                PAFO,   1,
                PAFI,   1,
                    ,   5,
                PB0E,   1,
                PB0O,   1,
                PB0I,   1,
                    ,   5,
                PB1E,   1,
                PB1O,   1,
                PB1I,   1,
                    ,   5,
                PB2E,   1,
                PB2O,   1,
                PB2I,   1,
                    ,   5,
                PB3E,   1,
                PB3O,   1,
                PB3I,   1,
                    ,   5,
                PB4E,   1,
                PB4O,   1,
                PB4I,   1,
                    ,   5,
                PB5E,   1,
                PB5O,   1,
                PB5I,   1,
                    ,   5,
                PB6E,   1,
                PB6O,   1,
                PB6I,   1,
                Offset (0x1C6),
                    ,   5,
                PC7E,   1,
                PC7O,   1,
                PC7I,   1,
                    ,   5,
                PC8E,   1,
                PC8O,   1,
                PC8I,   1,
                Offset (0x207),
                    ,   1,
                    ,   1,
                    ,   3,
                    ,   1,
                    ,   9,
                Offset (0x209),
                    ,   1,
                    ,   5,
                    ,   1,
                    ,   3,
                E26C,   1,
                Offset (0xD00),
                MX01,   8,
                Offset (0xD1F),
                Offset (0xD20),
                MX33,   8,
                MX34,   8,
                Offset (0xD28),
                MX41,   8,
                Offset (0xDA9),
                Offset (0xDB3),
                Offset (0xDB4),
                M181,   8,
                Offset (0xDB6),
                Offset (0xDC6),
                M199,   8,
                Offset (0xDFF)
            }

            OperationRegion (SMBO, SystemIO, 0x0B00, 0x07)
            Field (SMBO, ByteAcc, NoLock, Preserve)
            {
                HSSS,   8,
                SLSS,   8,
                HSCT,   8,
                HSCD,   8,
                XMSL,   8,
                HSD0,   8,
                HSD1,   8
            }
        }

        Device (HPET)
        {
            Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (((HPAD & 0x03) == 0x03))
                {
                    If ((GOSI >= 0x06))
                    {
                        Return (0x0F)
                    }

                    HPAD = (HPAD & 0xFFFFFFE0)
                    Return (One)
                }

                Return (One)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    IRQNoFlags ()
                        {0}
                    IRQNoFlags ()
                        {8}
                    Memory32Fixed (ReadOnly,
                        0xFED00000,         // Address Base
                        0x00000400,         // Address Length
                        _Y12)
                })
                CreateDWordField (BUF0, \_SB.PCI0.HPET._CRS._Y12._BAS, HPEB)  // _BAS: Base Address
                Local0 = HPAD /* \HPAD */
                HPEB = (Local0 & 0xFFFFFC00)
                Return (BUF0) /* \_SB_.PCI0.HPET._CRS.BUF0 */
            }
        }

        Device (GEC)
        {
            Name (_ADR, 0x00140006)  // _ADR: Address
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x1A,
                0x04
            })
        }

        Device (P2P)
        {
            Name (_ADR, 0x00140004)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                If ((WKPM == One))
                {
                    Return (GPRW (0x04, 0x05))
                }
                Else
                {
                    Return (GPRW (0x04, Zero))
                }
            }

            OperationRegion (PCPC, PCI_Config, Zero, 0xFF)
            Field (PCPC, ByteAcc, NoLock, Preserve)
            {
                Offset (0x04),
                PCMD,   8,
                Offset (0x1C),
                IOW1,   8,
                IOW2,   8,
                Offset (0x48),
                PR48,   8,
                PR49,   8,
                PR4A,   8,
                PR4B,   8
            }
        }
    }

    Scope (\)
    {
        Field (GSMM, AnyAcc, NoLock, Preserve)
        {
            Offset (0x289),
                ,   3,
            APMS,   1,
            Offset (0x29B),
                ,   7,
            APME,   1,
            Offset (0x2B2),
                ,   6,
            SWSE,   2
        }

        Field (PSMI, WordAcc, Lock, Preserve)
        {
            SSWP,   16
        }

        Method (GSWS, 1, NotSerialized)
        {
            While (APMS)
            {
                Stall (One)
            }

            While ((APME != Zero))
            {
                APME = Zero
            }

            While ((SWSE != One))
            {
                SWSE = One
            }

            SSWP = Arg0
            Stall (0x32)
            While (APMS)
            {
                Stall (One)
            }
        }
    }

    Scope (_SB)
    {
        Mutex (MSMI, 0x00)
        Method (SSMI, 5, NotSerialized)
        {
            Acquire (MSMI, 0xFFFF)
            If (Arg4)
            {
                Acquire (_GL, 0xFFFF)
            }

            EAX = (Arg0 << 0x10)
            EBX = Arg1
            ECX = Arg2
            EDX = Arg3
            REFS = Zero
            GSWS (Arg0)
            Local0 = REFS /* \REFS */
            If (Arg4)
            {
                Release (_GL)
            }

            Release (MSMI)
            Return (Local0)
        }
    }

    Scope (_GPE)
    {
        Method (_L1C, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L08, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Name (CALB, Buffer (0x05){})
        Name (XX05, Buffer (0x05){})
        Method (_L05, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L18, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L09, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L10, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L0D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
        }

        Method (_L16, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        Method (_L17, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            If ((\_SB.PCI0.SMBS.GT23 == Zero))
            {
                If ((\_SB.PCI0.SMBS.G23L == One))
                {
                    \_SB.PCI0.SMBS.SD23 = One
                    \_SB.PCI0.SMBS.SE23 = Zero
                }
            }

            \_SB.PCI0.LPCB.SIO1.SIOH ()
        }
    }

    Method (USBW, 2, Serialized)
    {
        Local0 = Package (0x02)
            {
                Zero,
                Zero
            }
        Local0 [Zero] = Arg0
        If ((USWE == One))
        {
            Local0 [One] = Arg1
        }

        Return (Local0)
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero,
        Zero,
        Zero,
        Zero
    })
    If (SS1)
    {
        If ((DAS1 == One))
        {
            Name (_S1, Package (0x04)  // _S1_: S1 System State
            {
                One,
                One,
                Zero,
                Zero
            })
        }
    }

    If (SS3)
    {
        If ((DAS3 == One))
        {
            Name (_S3, Package (0x04)  // _S3_: S3 System State
            {
                0x03,
                0x03,
                Zero,
                Zero
            })
        }
    }

    If (SS4)
    {
        Name (_S4, Package (0x04)  // _S4_: S4 System State
        {
            0x04,
            0x04,
            Zero,
            Zero
        })
    }

    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x05,
        0x05,
        Zero,
        Zero
    })
}
