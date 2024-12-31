pub const device_name = "STM32F103";
pub const device_revision = "1.1";
pub const device_description = "STM32F103";

pub const cpu = struct {
    pub const name = "CM3";
    pub const revision = "r1p1";
    pub const endian = "little";
    pub const mpu_present = false;
    pub const fpu_present = false;
    pub const vendor_systick_config = false;
    pub const nvic_prio_bits = 4;
};

/// Flexible static memory controller
pub const FSMC = struct {
    pub const base_address = 0xa0000000;
    /// BCR1
    pub const BCR1_struct = packed struct {
        /// MBKEN [0:0]
        /// MBKEN
        MBKEN: u1 = 0,
        /// MUXEN [1:1]
        /// MUXEN
        MUXEN: u1 = 0,
        /// MTYP [2:3]
        /// MTYP
        MTYP: u2 = 0,
        /// MWID [4:5]
        /// MWID
        MWID: u2 = 1,
        /// FACCEN [6:6]
        /// FACCEN
        FACCEN: u1 = 1,
        /// unused [7:7]
        _unused7: u1 = 1,
        /// BURSTEN [8:8]
        /// BURSTEN
        BURSTEN: u1 = 0,
        /// WAITPOL [9:9]
        /// WAITPOL
        WAITPOL: u1 = 0,
        /// unused [10:10]
        _unused10: u1 = 0,
        /// WAITCFG [11:11]
        /// WAITCFG
        WAITCFG: u1 = 0,
        /// WREN [12:12]
        /// WREN
        WREN: u1 = 1,
        /// WAITEN [13:13]
        /// WAITEN
        WAITEN: u1 = 1,
        /// EXTMOD [14:14]
        /// EXTMOD
        EXTMOD: u1 = 0,
        /// ASYNCWAIT [15:15]
        /// ASYNCWAIT
        ASYNCWAIT: u1 = 0,
        /// unused [16:18]
        _unused16: u3 = 0,
        /// CBURSTRW [19:19]
        /// CBURSTRW
        CBURSTRW: u1 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// SRAM/NOR-Flash chip-select control register
    pub const BCR1: *volatile BCR1_struct = @ptrFromInt(base_address + 0x0);

    /// BTR1
    pub const BTR1_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// BUSTURN [16:19]
        /// BUSTURN
        BUSTURN: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 3,
        /// unused [30:31]
        _unused30: u2 = 3,
    };
    /// SRAM/NOR-Flash chip-select timing register
    pub const BTR1: *volatile BTR1_struct = @ptrFromInt(base_address + 0x4);

    /// BCR2
    pub const BCR2_struct = packed struct {
        /// MBKEN [0:0]
        /// MBKEN
        MBKEN: u1 = 0,
        /// MUXEN [1:1]
        /// MUXEN
        MUXEN: u1 = 0,
        /// MTYP [2:3]
        /// MTYP
        MTYP: u2 = 0,
        /// MWID [4:5]
        /// MWID
        MWID: u2 = 1,
        /// FACCEN [6:6]
        /// FACCEN
        FACCEN: u1 = 1,
        /// unused [7:7]
        _unused7: u1 = 1,
        /// BURSTEN [8:8]
        /// BURSTEN
        BURSTEN: u1 = 0,
        /// WAITPOL [9:9]
        /// WAITPOL
        WAITPOL: u1 = 0,
        /// WRAPMOD [10:10]
        /// WRAPMOD
        WRAPMOD: u1 = 0,
        /// WAITCFG [11:11]
        /// WAITCFG
        WAITCFG: u1 = 0,
        /// WREN [12:12]
        /// WREN
        WREN: u1 = 1,
        /// WAITEN [13:13]
        /// WAITEN
        WAITEN: u1 = 1,
        /// EXTMOD [14:14]
        /// EXTMOD
        EXTMOD: u1 = 0,
        /// ASYNCWAIT [15:15]
        /// ASYNCWAIT
        ASYNCWAIT: u1 = 0,
        /// unused [16:18]
        _unused16: u3 = 0,
        /// CBURSTRW [19:19]
        /// CBURSTRW
        CBURSTRW: u1 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// SRAM/NOR-Flash chip-select control register
    pub const BCR2: *volatile BCR2_struct = @ptrFromInt(base_address + 0x8);

    /// BTR2
    pub const BTR2_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// BUSTURN [16:19]
        /// BUSTURN
        BUSTURN: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 3,
        /// unused [30:31]
        _unused30: u2 = 3,
    };
    /// SRAM/NOR-Flash chip-select timing register
    pub const BTR2: *volatile BTR2_struct = @ptrFromInt(base_address + 0xc);

    /// BCR3
    pub const BCR3_struct = packed struct {
        /// MBKEN [0:0]
        /// MBKEN
        MBKEN: u1 = 0,
        /// MUXEN [1:1]
        /// MUXEN
        MUXEN: u1 = 0,
        /// MTYP [2:3]
        /// MTYP
        MTYP: u2 = 0,
        /// MWID [4:5]
        /// MWID
        MWID: u2 = 1,
        /// FACCEN [6:6]
        /// FACCEN
        FACCEN: u1 = 1,
        /// unused [7:7]
        _unused7: u1 = 1,
        /// BURSTEN [8:8]
        /// BURSTEN
        BURSTEN: u1 = 0,
        /// WAITPOL [9:9]
        /// WAITPOL
        WAITPOL: u1 = 0,
        /// WRAPMOD [10:10]
        /// WRAPMOD
        WRAPMOD: u1 = 0,
        /// WAITCFG [11:11]
        /// WAITCFG
        WAITCFG: u1 = 0,
        /// WREN [12:12]
        /// WREN
        WREN: u1 = 1,
        /// WAITEN [13:13]
        /// WAITEN
        WAITEN: u1 = 1,
        /// EXTMOD [14:14]
        /// EXTMOD
        EXTMOD: u1 = 0,
        /// ASYNCWAIT [15:15]
        /// ASYNCWAIT
        ASYNCWAIT: u1 = 0,
        /// unused [16:18]
        _unused16: u3 = 0,
        /// CBURSTRW [19:19]
        /// CBURSTRW
        CBURSTRW: u1 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// SRAM/NOR-Flash chip-select control register
    pub const BCR3: *volatile BCR3_struct = @ptrFromInt(base_address + 0x10);

    /// BTR3
    pub const BTR3_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// BUSTURN [16:19]
        /// BUSTURN
        BUSTURN: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 3,
        /// unused [30:31]
        _unused30: u2 = 3,
    };
    /// SRAM/NOR-Flash chip-select timing register
    pub const BTR3: *volatile BTR3_struct = @ptrFromInt(base_address + 0x14);

    /// BCR4
    pub const BCR4_struct = packed struct {
        /// MBKEN [0:0]
        /// MBKEN
        MBKEN: u1 = 0,
        /// MUXEN [1:1]
        /// MUXEN
        MUXEN: u1 = 0,
        /// MTYP [2:3]
        /// MTYP
        MTYP: u2 = 0,
        /// MWID [4:5]
        /// MWID
        MWID: u2 = 1,
        /// FACCEN [6:6]
        /// FACCEN
        FACCEN: u1 = 1,
        /// unused [7:7]
        _unused7: u1 = 1,
        /// BURSTEN [8:8]
        /// BURSTEN
        BURSTEN: u1 = 0,
        /// WAITPOL [9:9]
        /// WAITPOL
        WAITPOL: u1 = 0,
        /// WRAPMOD [10:10]
        /// WRAPMOD
        WRAPMOD: u1 = 0,
        /// WAITCFG [11:11]
        /// WAITCFG
        WAITCFG: u1 = 0,
        /// WREN [12:12]
        /// WREN
        WREN: u1 = 1,
        /// WAITEN [13:13]
        /// WAITEN
        WAITEN: u1 = 1,
        /// EXTMOD [14:14]
        /// EXTMOD
        EXTMOD: u1 = 0,
        /// ASYNCWAIT [15:15]
        /// ASYNCWAIT
        ASYNCWAIT: u1 = 0,
        /// unused [16:18]
        _unused16: u3 = 0,
        /// CBURSTRW [19:19]
        /// CBURSTRW
        CBURSTRW: u1 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// SRAM/NOR-Flash chip-select control register
    pub const BCR4: *volatile BCR4_struct = @ptrFromInt(base_address + 0x18);

    /// BTR4
    pub const BTR4_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// BUSTURN [16:19]
        /// BUSTURN
        BUSTURN: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 3,
        /// unused [30:31]
        _unused30: u2 = 3,
    };
    /// SRAM/NOR-Flash chip-select timing register
    pub const BTR4: *volatile BTR4_struct = @ptrFromInt(base_address + 0x1c);

    /// PCR2
    pub const PCR2_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// PWAITEN [1:1]
        /// PWAITEN
        PWAITEN: u1 = 0,
        /// PBKEN [2:2]
        /// PBKEN
        PBKEN: u1 = 0,
        /// PTYP [3:3]
        /// PTYP
        PTYP: u1 = 1,
        /// PWID [4:5]
        /// PWID
        PWID: u2 = 1,
        /// ECCEN [6:6]
        /// ECCEN
        ECCEN: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// TCLR [9:12]
        /// TCLR
        TCLR: u4 = 0,
        /// TAR [13:16]
        /// TAR
        TAR: u4 = 0,
        /// ECCPS [17:19]
        /// ECCPS
        ECCPS: u3 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// PC Card/NAND Flash control register
    pub const PCR2: *volatile PCR2_struct = @ptrFromInt(base_address + 0x60);

    /// SR2
    pub const SR2_struct = packed struct {
        /// IRS [0:0]
        /// IRS
        IRS: u1 = 0,
        /// ILS [1:1]
        /// ILS
        ILS: u1 = 0,
        /// IFS [2:2]
        /// IFS
        IFS: u1 = 0,
        /// IREN [3:3]
        /// IREN
        IREN: u1 = 0,
        /// ILEN [4:4]
        /// ILEN
        ILEN: u1 = 0,
        /// IFEN [5:5]
        /// IFEN
        IFEN: u1 = 0,
        /// FEMPT [6:6]
        /// FEMPT
        FEMPT: u1 = 1,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// FIFO status and interrupt register
    pub const SR2: *volatile SR2_struct = @ptrFromInt(base_address + 0x64);

    /// PMEM2
    pub const PMEM2_struct = packed struct {
        /// MEMSETx [0:7]
        /// MEMSETx
        MEMSETx: u8 = 252,
        /// MEMWAITx [8:15]
        /// MEMWAITx
        MEMWAITx: u8 = 252,
        /// MEMHOLDx [16:23]
        /// MEMHOLDx
        MEMHOLDx: u8 = 252,
        /// MEMHIZx [24:31]
        /// MEMHIZx
        MEMHIZx: u8 = 252,
    };
    /// Common memory space timing register
    pub const PMEM2: *volatile PMEM2_struct = @ptrFromInt(base_address + 0x68);

    /// PATT2
    pub const PATT2_struct = packed struct {
        /// ATTSETx [0:7]
        /// Attribute memory x setup
        ATTSETx: u8 = 252,
        /// ATTWAITx [8:15]
        /// Attribute memory x wait
        ATTWAITx: u8 = 252,
        /// ATTHOLDx [16:23]
        /// Attribute memory x hold
        ATTHOLDx: u8 = 252,
        /// ATTHIZx [24:31]
        /// Attribute memory x databus HiZ
        ATTHIZx: u8 = 252,
    };
    /// Attribute memory space timing register
    pub const PATT2: *volatile PATT2_struct = @ptrFromInt(base_address + 0x6c);

    /// ECCR2
    pub const ECCR2_struct = packed struct {
        /// ECCx [0:31]
        /// ECC result
        ECCx: u32 = 0,
    };
    /// ECC result register 2
    pub const ECCR2: *volatile ECCR2_struct = @ptrFromInt(base_address + 0x74);

    /// PCR3
    pub const PCR3_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// PWAITEN [1:1]
        /// PWAITEN
        PWAITEN: u1 = 0,
        /// PBKEN [2:2]
        /// PBKEN
        PBKEN: u1 = 0,
        /// PTYP [3:3]
        /// PTYP
        PTYP: u1 = 1,
        /// PWID [4:5]
        /// PWID
        PWID: u2 = 1,
        /// ECCEN [6:6]
        /// ECCEN
        ECCEN: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// TCLR [9:12]
        /// TCLR
        TCLR: u4 = 0,
        /// TAR [13:16]
        /// TAR
        TAR: u4 = 0,
        /// ECCPS [17:19]
        /// ECCPS
        ECCPS: u3 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// PC Card/NAND Flash control register
    pub const PCR3: *volatile PCR3_struct = @ptrFromInt(base_address + 0x80);

    /// SR3
    pub const SR3_struct = packed struct {
        /// IRS [0:0]
        /// IRS
        IRS: u1 = 0,
        /// ILS [1:1]
        /// ILS
        ILS: u1 = 0,
        /// IFS [2:2]
        /// IFS
        IFS: u1 = 0,
        /// IREN [3:3]
        /// IREN
        IREN: u1 = 0,
        /// ILEN [4:4]
        /// ILEN
        ILEN: u1 = 0,
        /// IFEN [5:5]
        /// IFEN
        IFEN: u1 = 0,
        /// FEMPT [6:6]
        /// FEMPT
        FEMPT: u1 = 1,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// FIFO status and interrupt register
    pub const SR3: *volatile SR3_struct = @ptrFromInt(base_address + 0x84);

    /// PMEM3
    pub const PMEM3_struct = packed struct {
        /// MEMSETx [0:7]
        /// MEMSETx
        MEMSETx: u8 = 252,
        /// MEMWAITx [8:15]
        /// MEMWAITx
        MEMWAITx: u8 = 252,
        /// MEMHOLDx [16:23]
        /// MEMHOLDx
        MEMHOLDx: u8 = 252,
        /// MEMHIZx [24:31]
        /// MEMHIZx
        MEMHIZx: u8 = 252,
    };
    /// Common memory space timing register
    pub const PMEM3: *volatile PMEM3_struct = @ptrFromInt(base_address + 0x88);

    /// PATT3
    pub const PATT3_struct = packed struct {
        /// ATTSETx [0:7]
        /// ATTSETx
        ATTSETx: u8 = 252,
        /// ATTWAITx [8:15]
        /// ATTWAITx
        ATTWAITx: u8 = 252,
        /// ATTHOLDx [16:23]
        /// ATTHOLDx
        ATTHOLDx: u8 = 252,
        /// ATTHIZx [24:31]
        /// ATTHIZx
        ATTHIZx: u8 = 252,
    };
    /// Attribute memory space timing register
    pub const PATT3: *volatile PATT3_struct = @ptrFromInt(base_address + 0x8c);

    /// ECCR3
    pub const ECCR3_struct = packed struct {
        /// ECCx [0:31]
        /// ECCx
        ECCx: u32 = 0,
    };
    /// ECC result register 3
    pub const ECCR3: *volatile ECCR3_struct = @ptrFromInt(base_address + 0x94);

    /// PCR4
    pub const PCR4_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// PWAITEN [1:1]
        /// PWAITEN
        PWAITEN: u1 = 0,
        /// PBKEN [2:2]
        /// PBKEN
        PBKEN: u1 = 0,
        /// PTYP [3:3]
        /// PTYP
        PTYP: u1 = 1,
        /// PWID [4:5]
        /// PWID
        PWID: u2 = 1,
        /// ECCEN [6:6]
        /// ECCEN
        ECCEN: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// TCLR [9:12]
        /// TCLR
        TCLR: u4 = 0,
        /// TAR [13:16]
        /// TAR
        TAR: u4 = 0,
        /// ECCPS [17:19]
        /// ECCPS
        ECCPS: u3 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// PC Card/NAND Flash control register
    pub const PCR4: *volatile PCR4_struct = @ptrFromInt(base_address + 0xa0);

    /// SR4
    pub const SR4_struct = packed struct {
        /// IRS [0:0]
        /// IRS
        IRS: u1 = 0,
        /// ILS [1:1]
        /// ILS
        ILS: u1 = 0,
        /// IFS [2:2]
        /// IFS
        IFS: u1 = 0,
        /// IREN [3:3]
        /// IREN
        IREN: u1 = 0,
        /// ILEN [4:4]
        /// ILEN
        ILEN: u1 = 0,
        /// IFEN [5:5]
        /// IFEN
        IFEN: u1 = 0,
        /// FEMPT [6:6]
        /// FEMPT
        FEMPT: u1 = 1,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// FIFO status and interrupt register
    pub const SR4: *volatile SR4_struct = @ptrFromInt(base_address + 0xa4);

    /// PMEM4
    pub const PMEM4_struct = packed struct {
        /// MEMSETx [0:7]
        /// MEMSETx
        MEMSETx: u8 = 252,
        /// MEMWAITx [8:15]
        /// MEMWAITx
        MEMWAITx: u8 = 252,
        /// MEMHOLDx [16:23]
        /// MEMHOLDx
        MEMHOLDx: u8 = 252,
        /// MEMHIZx [24:31]
        /// MEMHIZx
        MEMHIZx: u8 = 252,
    };
    /// Common memory space timing register
    pub const PMEM4: *volatile PMEM4_struct = @ptrFromInt(base_address + 0xa8);

    /// PATT4
    pub const PATT4_struct = packed struct {
        /// ATTSETx [0:7]
        /// ATTSETx
        ATTSETx: u8 = 252,
        /// ATTWAITx [8:15]
        /// ATTWAITx
        ATTWAITx: u8 = 252,
        /// ATTHOLDx [16:23]
        /// ATTHOLDx
        ATTHOLDx: u8 = 252,
        /// ATTHIZx [24:31]
        /// ATTHIZx
        ATTHIZx: u8 = 252,
    };
    /// Attribute memory space timing register
    pub const PATT4: *volatile PATT4_struct = @ptrFromInt(base_address + 0xac);

    /// PIO4
    pub const PIO4_struct = packed struct {
        /// IOSETx [0:7]
        /// IOSETx
        IOSETx: u8 = 252,
        /// IOWAITx [8:15]
        /// IOWAITx
        IOWAITx: u8 = 252,
        /// IOHOLDx [16:23]
        /// IOHOLDx
        IOHOLDx: u8 = 252,
        /// IOHIZx [24:31]
        /// IOHIZx
        IOHIZx: u8 = 252,
    };
    /// I/O space timing register 4
    pub const PIO4: *volatile PIO4_struct = @ptrFromInt(base_address + 0xb0);

    /// BWTR1
    pub const BWTR1_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// unused [16:19]
        _unused16: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// SRAM/NOR-Flash write timing registers
    pub const BWTR1: *volatile BWTR1_struct = @ptrFromInt(base_address + 0x104);

    /// BWTR2
    pub const BWTR2_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// unused [16:19]
        _unused16: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// SRAM/NOR-Flash write timing registers
    pub const BWTR2: *volatile BWTR2_struct = @ptrFromInt(base_address + 0x10c);

    /// BWTR3
    pub const BWTR3_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// unused [16:19]
        _unused16: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// SRAM/NOR-Flash write timing registers
    pub const BWTR3: *volatile BWTR3_struct = @ptrFromInt(base_address + 0x114);

    /// BWTR4
    pub const BWTR4_struct = packed struct {
        /// ADDSET [0:3]
        /// ADDSET
        ADDSET: u4 = 15,
        /// ADDHLD [4:7]
        /// ADDHLD
        ADDHLD: u4 = 15,
        /// DATAST [8:15]
        /// DATAST
        DATAST: u8 = 255,
        /// unused [16:19]
        _unused16: u4 = 15,
        /// CLKDIV [20:23]
        /// CLKDIV
        CLKDIV: u4 = 15,
        /// DATLAT [24:27]
        /// DATLAT
        DATLAT: u4 = 15,
        /// ACCMOD [28:29]
        /// ACCMOD
        ACCMOD: u2 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// SRAM/NOR-Flash write timing registers
    pub const BWTR4: *volatile BWTR4_struct = @ptrFromInt(base_address + 0x11c);
};

/// Power control
pub const PWR = struct {
    pub const base_address = 0x40007000;
    /// CR
    pub const CR_struct = packed struct {
        /// LPDS [0:0]
        /// Low Power Deep Sleep
        LPDS: u1 = 0,
        /// PDDS [1:1]
        /// Power Down Deep Sleep
        PDDS: u1 = 0,
        /// CWUF [2:2]
        /// Clear Wake-up Flag
        CWUF: u1 = 0,
        /// CSBF [3:3]
        /// Clear STANDBY Flag
        CSBF: u1 = 0,
        /// PVDE [4:4]
        /// Power Voltage Detector
        PVDE: u1 = 0,
        /// PLS [5:7]
        /// PVD Level Selection
        PLS: u3 = 0,
        /// DBP [8:8]
        /// Disable Backup Domain write
        DBP: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Power control register
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x0);

    /// CSR
    pub const CSR_struct = packed struct {
        /// WUF [0:0]
        /// Wake-Up Flag
        WUF: u1 = 0,
        /// SBF [1:1]
        /// STANDBY Flag
        SBF: u1 = 0,
        /// PVDO [2:2]
        /// PVD Output
        PVDO: u1 = 0,
        /// unused [3:7]
        _unused3: u5 = 0,
        /// EWUP [8:8]
        /// Enable WKUP pin
        EWUP: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Power control register
    pub const CSR: *volatile CSR_struct = @ptrFromInt(base_address + 0x4);
};

/// Reset and clock control
pub const RCC = struct {
    pub const base_address = 0x40021000;
    /// CR
    pub const CR_struct = packed struct {
        /// HSION [0:0]
        /// Internal High Speed clock
        HSION: u1 = 1,
        /// HSIRDY [1:1]
        /// Internal High Speed clock ready
        HSIRDY: u1 = 1,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// HSITRIM [3:7]
        /// Internal High Speed clock
        HSITRIM: u5 = 16,
        /// HSICAL [8:15]
        /// Internal High Speed clock
        HSICAL: u8 = 0,
        /// HSEON [16:16]
        /// External High Speed clock
        HSEON: u1 = 0,
        /// HSERDY [17:17]
        /// External High Speed clock ready
        HSERDY: u1 = 0,
        /// HSEBYP [18:18]
        /// External High Speed clock
        HSEBYP: u1 = 0,
        /// CSSON [19:19]
        /// Clock Security System
        CSSON: u1 = 0,
        /// unused [20:23]
        _unused20: u4 = 0,
        /// PLLON [24:24]
        /// PLL enable
        PLLON: u1 = 0,
        /// PLLRDY [25:25]
        /// PLL clock ready flag
        PLLRDY: u1 = 0,
        /// unused [26:31]
        _unused26: u6 = 0,
    };
    /// Clock control register
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x0);

    /// CFGR
    pub const CFGR_struct = packed struct {
        /// SW [0:1]
        /// System clock Switch
        SW: u2 = 0,
        /// SWS [2:3]
        /// System Clock Switch Status
        SWS: u2 = 0,
        /// HPRE [4:7]
        /// AHB prescaler
        HPRE: u4 = 0,
        /// PPRE1 [8:10]
        /// APB Low speed prescaler
        PPRE1: u3 = 0,
        /// PPRE2 [11:13]
        /// APB High speed prescaler
        PPRE2: u3 = 0,
        /// ADCPRE [14:15]
        /// ADC prescaler
        ADCPRE: u2 = 0,
        /// PLLSRC [16:16]
        /// PLL entry clock source
        PLLSRC: u1 = 0,
        /// PLLXTPRE [17:17]
        /// HSE divider for PLL entry
        PLLXTPRE: u1 = 0,
        /// PLLMUL [18:21]
        /// PLL Multiplication Factor
        PLLMUL: u4 = 0,
        /// OTGFSPRE [22:22]
        /// USB OTG FS prescaler
        OTGFSPRE: u1 = 0,
        /// unused [23:23]
        _unused23: u1 = 0,
        /// MCO [24:26]
        /// Microcontroller clock
        MCO: u3 = 0,
        /// unused [27:31]
        _unused27: u5 = 0,
    };
    /// Clock configuration register
    pub const CFGR: *volatile CFGR_struct = @ptrFromInt(base_address + 0x4);

    /// CIR
    pub const CIR_struct = packed struct {
        /// LSIRDYF [0:0]
        /// LSI Ready Interrupt flag
        LSIRDYF: u1 = 0,
        /// LSERDYF [1:1]
        /// LSE Ready Interrupt flag
        LSERDYF: u1 = 0,
        /// HSIRDYF [2:2]
        /// HSI Ready Interrupt flag
        HSIRDYF: u1 = 0,
        /// HSERDYF [3:3]
        /// HSE Ready Interrupt flag
        HSERDYF: u1 = 0,
        /// PLLRDYF [4:4]
        /// PLL Ready Interrupt flag
        PLLRDYF: u1 = 0,
        /// unused [5:6]
        _unused5: u2 = 0,
        /// CSSF [7:7]
        /// Clock Security System Interrupt
        CSSF: u1 = 0,
        /// LSIRDYIE [8:8]
        /// LSI Ready Interrupt Enable
        LSIRDYIE: u1 = 0,
        /// LSERDYIE [9:9]
        /// LSE Ready Interrupt Enable
        LSERDYIE: u1 = 0,
        /// HSIRDYIE [10:10]
        /// HSI Ready Interrupt Enable
        HSIRDYIE: u1 = 0,
        /// HSERDYIE [11:11]
        /// HSE Ready Interrupt Enable
        HSERDYIE: u1 = 0,
        /// PLLRDYIE [12:12]
        /// PLL Ready Interrupt Enable
        PLLRDYIE: u1 = 0,
        /// unused [13:15]
        _unused13: u3 = 0,
        /// LSIRDYC [16:16]
        /// LSI Ready Interrupt Clear
        LSIRDYC: u1 = 0,
        /// LSERDYC [17:17]
        /// LSE Ready Interrupt Clear
        LSERDYC: u1 = 0,
        /// HSIRDYC [18:18]
        /// HSI Ready Interrupt Clear
        HSIRDYC: u1 = 0,
        /// HSERDYC [19:19]
        /// HSE Ready Interrupt Clear
        HSERDYC: u1 = 0,
        /// PLLRDYC [20:20]
        /// PLL Ready Interrupt Clear
        PLLRDYC: u1 = 0,
        /// unused [21:22]
        _unused21: u2 = 0,
        /// CSSC [23:23]
        /// Clock security system interrupt
        CSSC: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// Clock interrupt register
    pub const CIR: *volatile CIR_struct = @ptrFromInt(base_address + 0x8);

    /// APB2RSTR
    pub const APB2RSTR_struct = packed struct {
        /// AFIORST [0:0]
        /// Alternate function I/O
        AFIORST: u1 = 0,
        /// unused [1:1]
        _unused1: u1 = 0,
        /// IOPARST [2:2]
        /// IO port A reset
        IOPARST: u1 = 0,
        /// IOPBRST [3:3]
        /// IO port B reset
        IOPBRST: u1 = 0,
        /// IOPCRST [4:4]
        /// IO port C reset
        IOPCRST: u1 = 0,
        /// IOPDRST [5:5]
        /// IO port D reset
        IOPDRST: u1 = 0,
        /// IOPERST [6:6]
        /// IO port E reset
        IOPERST: u1 = 0,
        /// IOPFRST [7:7]
        /// IO port F reset
        IOPFRST: u1 = 0,
        /// IOPGRST [8:8]
        /// IO port G reset
        IOPGRST: u1 = 0,
        /// ADC1RST [9:9]
        /// ADC 1 interface reset
        ADC1RST: u1 = 0,
        /// ADC2RST [10:10]
        /// ADC 2 interface reset
        ADC2RST: u1 = 0,
        /// TIM1RST [11:11]
        /// TIM1 timer reset
        TIM1RST: u1 = 0,
        /// SPI1RST [12:12]
        /// SPI 1 reset
        SPI1RST: u1 = 0,
        /// TIM8RST [13:13]
        /// TIM8 timer reset
        TIM8RST: u1 = 0,
        /// USART1RST [14:14]
        /// USART1 reset
        USART1RST: u1 = 0,
        /// ADC3RST [15:15]
        /// ADC 3 interface reset
        ADC3RST: u1 = 0,
        /// unused [16:18]
        _unused16: u3 = 0,
        /// TIM9RST [19:19]
        /// TIM9 timer reset
        TIM9RST: u1 = 0,
        /// TIM10RST [20:20]
        /// TIM10 timer reset
        TIM10RST: u1 = 0,
        /// TIM11RST [21:21]
        /// TIM11 timer reset
        TIM11RST: u1 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// APB2 peripheral reset register
    pub const APB2RSTR: *volatile APB2RSTR_struct = @ptrFromInt(base_address + 0xc);

    /// APB1RSTR
    pub const APB1RSTR_struct = packed struct {
        /// TIM2RST [0:0]
        /// Timer 2 reset
        TIM2RST: u1 = 0,
        /// TIM3RST [1:1]
        /// Timer 3 reset
        TIM3RST: u1 = 0,
        /// TIM4RST [2:2]
        /// Timer 4 reset
        TIM4RST: u1 = 0,
        /// TIM5RST [3:3]
        /// Timer 5 reset
        TIM5RST: u1 = 0,
        /// TIM6RST [4:4]
        /// Timer 6 reset
        TIM6RST: u1 = 0,
        /// TIM7RST [5:5]
        /// Timer 7 reset
        TIM7RST: u1 = 0,
        /// TIM12RST [6:6]
        /// Timer 12 reset
        TIM12RST: u1 = 0,
        /// TIM13RST [7:7]
        /// Timer 13 reset
        TIM13RST: u1 = 0,
        /// TIM14RST [8:8]
        /// Timer 14 reset
        TIM14RST: u1 = 0,
        /// unused [9:10]
        _unused9: u2 = 0,
        /// WWDGRST [11:11]
        /// Window watchdog reset
        WWDGRST: u1 = 0,
        /// unused [12:13]
        _unused12: u2 = 0,
        /// SPI2RST [14:14]
        /// SPI2 reset
        SPI2RST: u1 = 0,
        /// SPI3RST [15:15]
        /// SPI3 reset
        SPI3RST: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// USART2RST [17:17]
        /// USART 2 reset
        USART2RST: u1 = 0,
        /// USART3RST [18:18]
        /// USART 3 reset
        USART3RST: u1 = 0,
        /// UART4RST [19:19]
        /// UART 4 reset
        UART4RST: u1 = 0,
        /// UART5RST [20:20]
        /// UART 5 reset
        UART5RST: u1 = 0,
        /// I2C1RST [21:21]
        /// I2C1 reset
        I2C1RST: u1 = 0,
        /// I2C2RST [22:22]
        /// I2C2 reset
        I2C2RST: u1 = 0,
        /// USBRST [23:23]
        /// USB reset
        USBRST: u1 = 0,
        /// unused [24:24]
        _unused24: u1 = 0,
        /// CANRST [25:25]
        /// CAN reset
        CANRST: u1 = 0,
        /// unused [26:26]
        _unused26: u1 = 0,
        /// BKPRST [27:27]
        /// Backup interface reset
        BKPRST: u1 = 0,
        /// PWRRST [28:28]
        /// Power interface reset
        PWRRST: u1 = 0,
        /// DACRST [29:29]
        /// DAC interface reset
        DACRST: u1 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// APB1 peripheral reset register
    pub const APB1RSTR: *volatile APB1RSTR_struct = @ptrFromInt(base_address + 0x10);

    /// AHBENR
    pub const AHBENR_struct = packed struct {
        /// DMA1EN [0:0]
        /// DMA1 clock enable
        DMA1EN: u1 = 0,
        /// DMA2EN [1:1]
        /// DMA2 clock enable
        DMA2EN: u1 = 0,
        /// SRAMEN [2:2]
        /// SRAM interface clock
        SRAMEN: u1 = 1,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// FLITFEN [4:4]
        /// FLITF clock enable
        FLITFEN: u1 = 1,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// CRCEN [6:6]
        /// CRC clock enable
        CRCEN: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// FSMCEN [8:8]
        /// FSMC clock enable
        FSMCEN: u1 = 0,
        /// unused [9:9]
        _unused9: u1 = 0,
        /// SDIOEN [10:10]
        /// SDIO clock enable
        SDIOEN: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// AHB Peripheral Clock enable register
    pub const AHBENR: *volatile AHBENR_struct = @ptrFromInt(base_address + 0x14);

    /// APB2ENR
    pub const APB2ENR_struct = packed struct {
        /// AFIOEN [0:0]
        /// Alternate function I/O clock
        AFIOEN: u1 = 0,
        /// unused [1:1]
        _unused1: u1 = 0,
        /// IOPAEN [2:2]
        /// I/O port A clock enable
        IOPAEN: u1 = 0,
        /// IOPBEN [3:3]
        /// I/O port B clock enable
        IOPBEN: u1 = 0,
        /// IOPCEN [4:4]
        /// I/O port C clock enable
        IOPCEN: u1 = 0,
        /// IOPDEN [5:5]
        /// I/O port D clock enable
        IOPDEN: u1 = 0,
        /// IOPEEN [6:6]
        /// I/O port E clock enable
        IOPEEN: u1 = 0,
        /// IOPFEN [7:7]
        /// I/O port F clock enable
        IOPFEN: u1 = 0,
        /// IOPGEN [8:8]
        /// I/O port G clock enable
        IOPGEN: u1 = 0,
        /// ADC1EN [9:9]
        /// ADC 1 interface clock
        ADC1EN: u1 = 0,
        /// ADC2EN [10:10]
        /// ADC 2 interface clock
        ADC2EN: u1 = 0,
        /// TIM1EN [11:11]
        /// TIM1 Timer clock enable
        TIM1EN: u1 = 0,
        /// SPI1EN [12:12]
        /// SPI 1 clock enable
        SPI1EN: u1 = 0,
        /// TIM8EN [13:13]
        /// TIM8 Timer clock enable
        TIM8EN: u1 = 0,
        /// USART1EN [14:14]
        /// USART1 clock enable
        USART1EN: u1 = 0,
        /// ADC3EN [15:15]
        /// ADC3 interface clock
        ADC3EN: u1 = 0,
        /// unused [16:18]
        _unused16: u3 = 0,
        /// TIM9EN [19:19]
        /// TIM9 Timer clock enable
        TIM9EN: u1 = 0,
        /// TIM10EN [20:20]
        /// TIM10 Timer clock enable
        TIM10EN: u1 = 0,
        /// TIM11EN [21:21]
        /// TIM11 Timer clock enable
        TIM11EN: u1 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// APB2 peripheral clock enable register
    pub const APB2ENR: *volatile APB2ENR_struct = @ptrFromInt(base_address + 0x18);

    /// APB1ENR
    pub const APB1ENR_struct = packed struct {
        /// TIM2EN [0:0]
        /// Timer 2 clock enable
        TIM2EN: u1 = 0,
        /// TIM3EN [1:1]
        /// Timer 3 clock enable
        TIM3EN: u1 = 0,
        /// TIM4EN [2:2]
        /// Timer 4 clock enable
        TIM4EN: u1 = 0,
        /// TIM5EN [3:3]
        /// Timer 5 clock enable
        TIM5EN: u1 = 0,
        /// TIM6EN [4:4]
        /// Timer 6 clock enable
        TIM6EN: u1 = 0,
        /// TIM7EN [5:5]
        /// Timer 7 clock enable
        TIM7EN: u1 = 0,
        /// TIM12EN [6:6]
        /// Timer 12 clock enable
        TIM12EN: u1 = 0,
        /// TIM13EN [7:7]
        /// Timer 13 clock enable
        TIM13EN: u1 = 0,
        /// TIM14EN [8:8]
        /// Timer 14 clock enable
        TIM14EN: u1 = 0,
        /// unused [9:10]
        _unused9: u2 = 0,
        /// WWDGEN [11:11]
        /// Window watchdog clock
        WWDGEN: u1 = 0,
        /// unused [12:13]
        _unused12: u2 = 0,
        /// SPI2EN [14:14]
        /// SPI 2 clock enable
        SPI2EN: u1 = 0,
        /// SPI3EN [15:15]
        /// SPI 3 clock enable
        SPI3EN: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// USART2EN [17:17]
        /// USART 2 clock enable
        USART2EN: u1 = 0,
        /// USART3EN [18:18]
        /// USART 3 clock enable
        USART3EN: u1 = 0,
        /// UART4EN [19:19]
        /// UART 4 clock enable
        UART4EN: u1 = 0,
        /// UART5EN [20:20]
        /// UART 5 clock enable
        UART5EN: u1 = 0,
        /// I2C1EN [21:21]
        /// I2C 1 clock enable
        I2C1EN: u1 = 0,
        /// I2C2EN [22:22]
        /// I2C 2 clock enable
        I2C2EN: u1 = 0,
        /// USBEN [23:23]
        /// USB clock enable
        USBEN: u1 = 0,
        /// unused [24:24]
        _unused24: u1 = 0,
        /// CANEN [25:25]
        /// CAN clock enable
        CANEN: u1 = 0,
        /// unused [26:26]
        _unused26: u1 = 0,
        /// BKPEN [27:27]
        /// Backup interface clock
        BKPEN: u1 = 0,
        /// PWREN [28:28]
        /// Power interface clock
        PWREN: u1 = 0,
        /// DACEN [29:29]
        /// DAC interface clock enable
        DACEN: u1 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// APB1 peripheral clock enable register
    pub const APB1ENR: *volatile APB1ENR_struct = @ptrFromInt(base_address + 0x1c);

    /// BDCR
    pub const BDCR_struct = packed struct {
        /// LSEON [0:0]
        /// External Low Speed oscillator
        LSEON: u1 = 0,
        /// LSERDY [1:1]
        /// External Low Speed oscillator
        LSERDY: u1 = 0,
        /// LSEBYP [2:2]
        /// External Low Speed oscillator
        LSEBYP: u1 = 0,
        /// unused [3:7]
        _unused3: u5 = 0,
        /// RTCSEL [8:9]
        /// RTC clock source selection
        RTCSEL: u2 = 0,
        /// unused [10:14]
        _unused10: u5 = 0,
        /// RTCEN [15:15]
        /// RTC clock enable
        RTCEN: u1 = 0,
        /// BDRST [16:16]
        /// Backup domain software
        BDRST: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Backup domain control register
    pub const BDCR: *volatile BDCR_struct = @ptrFromInt(base_address + 0x20);

    /// CSR
    pub const CSR_struct = packed struct {
        /// LSION [0:0]
        /// Internal low speed oscillator
        LSION: u1 = 0,
        /// LSIRDY [1:1]
        /// Internal low speed oscillator
        LSIRDY: u1 = 0,
        /// unused [2:23]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        /// RMVF [24:24]
        /// Remove reset flag
        RMVF: u1 = 0,
        /// unused [25:25]
        _unused25: u1 = 0,
        /// PINRSTF [26:26]
        /// PIN reset flag
        PINRSTF: u1 = 1,
        /// PORRSTF [27:27]
        /// POR/PDR reset flag
        PORRSTF: u1 = 1,
        /// SFTRSTF [28:28]
        /// Software reset flag
        SFTRSTF: u1 = 0,
        /// IWDGRSTF [29:29]
        /// Independent watchdog reset
        IWDGRSTF: u1 = 0,
        /// WWDGRSTF [30:30]
        /// Window watchdog reset flag
        WWDGRSTF: u1 = 0,
        /// LPWRRSTF [31:31]
        /// Low-power reset flag
        LPWRRSTF: u1 = 0,
    };
    /// Control/status register
    pub const CSR: *volatile CSR_struct = @ptrFromInt(base_address + 0x24);
};

/// General purpose I/O
pub const GPIOA = struct {
    pub const base_address = 0x40010800;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// General purpose I/O
pub const GPIOB = struct {
    pub const base_address = 0x40010c00;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// General purpose I/O
pub const GPIOC = struct {
    pub const base_address = 0x40011000;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// General purpose I/O
pub const GPIOD = struct {
    pub const base_address = 0x40011400;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// General purpose I/O
pub const GPIOE = struct {
    pub const base_address = 0x40011800;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// General purpose I/O
pub const GPIOF = struct {
    pub const base_address = 0x40011c00;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// General purpose I/O
pub const GPIOG = struct {
    pub const base_address = 0x40012000;
    /// CRL
    pub const CRL_struct = packed struct {
        /// MODE0 [0:1]
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// CNF0 [2:3]
        /// Port n.0 configuration
        CNF0: u2 = 1,
        /// MODE1 [4:5]
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// CNF1 [6:7]
        /// Port n.1 configuration
        CNF1: u2 = 1,
        /// MODE2 [8:9]
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// CNF2 [10:11]
        /// Port n.2 configuration
        CNF2: u2 = 1,
        /// MODE3 [12:13]
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// CNF3 [14:15]
        /// Port n.3 configuration
        CNF3: u2 = 1,
        /// MODE4 [16:17]
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// CNF4 [18:19]
        /// Port n.4 configuration
        CNF4: u2 = 1,
        /// MODE5 [20:21]
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// CNF5 [22:23]
        /// Port n.5 configuration
        CNF5: u2 = 1,
        /// MODE6 [24:25]
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// CNF6 [26:27]
        /// Port n.6 configuration
        CNF6: u2 = 1,
        /// MODE7 [28:29]
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// CNF7 [30:31]
        /// Port n.7 configuration
        CNF7: u2 = 1,
    };
    /// Port configuration register low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x0);

    /// CRH
    pub const CRH_struct = packed struct {
        /// MODE8 [0:1]
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// CNF8 [2:3]
        /// Port n.8 configuration
        CNF8: u2 = 1,
        /// MODE9 [4:5]
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// CNF9 [6:7]
        /// Port n.9 configuration
        CNF9: u2 = 1,
        /// MODE10 [8:9]
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// CNF10 [10:11]
        /// Port n.10 configuration
        CNF10: u2 = 1,
        /// MODE11 [12:13]
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// CNF11 [14:15]
        /// Port n.11 configuration
        CNF11: u2 = 1,
        /// MODE12 [16:17]
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// CNF12 [18:19]
        /// Port n.12 configuration
        CNF12: u2 = 1,
        /// MODE13 [20:21]
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// CNF13 [22:23]
        /// Port n.13 configuration
        CNF13: u2 = 1,
        /// MODE14 [24:25]
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// CNF14 [26:27]
        /// Port n.14 configuration
        CNF14: u2 = 1,
        /// MODE15 [28:29]
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// CNF15 [30:31]
        /// Port n.15 configuration
        CNF15: u2 = 1,
    };
    /// Port configuration register high
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x4);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR0 [0:0]
        /// Port input data
        IDR0: u1 = 0,
        /// IDR1 [1:1]
        /// Port input data
        IDR1: u1 = 0,
        /// IDR2 [2:2]
        /// Port input data
        IDR2: u1 = 0,
        /// IDR3 [3:3]
        /// Port input data
        IDR3: u1 = 0,
        /// IDR4 [4:4]
        /// Port input data
        IDR4: u1 = 0,
        /// IDR5 [5:5]
        /// Port input data
        IDR5: u1 = 0,
        /// IDR6 [6:6]
        /// Port input data
        IDR6: u1 = 0,
        /// IDR7 [7:7]
        /// Port input data
        IDR7: u1 = 0,
        /// IDR8 [8:8]
        /// Port input data
        IDR8: u1 = 0,
        /// IDR9 [9:9]
        /// Port input data
        IDR9: u1 = 0,
        /// IDR10 [10:10]
        /// Port input data
        IDR10: u1 = 0,
        /// IDR11 [11:11]
        /// Port input data
        IDR11: u1 = 0,
        /// IDR12 [12:12]
        /// Port input data
        IDR12: u1 = 0,
        /// IDR13 [13:13]
        /// Port input data
        IDR13: u1 = 0,
        /// IDR14 [14:14]
        /// Port input data
        IDR14: u1 = 0,
        /// IDR15 [15:15]
        /// Port input data
        IDR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port input data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x8);

    /// ODR
    pub const ODR_struct = packed struct {
        /// ODR0 [0:0]
        /// Port output data
        ODR0: u1 = 0,
        /// ODR1 [1:1]
        /// Port output data
        ODR1: u1 = 0,
        /// ODR2 [2:2]
        /// Port output data
        ODR2: u1 = 0,
        /// ODR3 [3:3]
        /// Port output data
        ODR3: u1 = 0,
        /// ODR4 [4:4]
        /// Port output data
        ODR4: u1 = 0,
        /// ODR5 [5:5]
        /// Port output data
        ODR5: u1 = 0,
        /// ODR6 [6:6]
        /// Port output data
        ODR6: u1 = 0,
        /// ODR7 [7:7]
        /// Port output data
        ODR7: u1 = 0,
        /// ODR8 [8:8]
        /// Port output data
        ODR8: u1 = 0,
        /// ODR9 [9:9]
        /// Port output data
        ODR9: u1 = 0,
        /// ODR10 [10:10]
        /// Port output data
        ODR10: u1 = 0,
        /// ODR11 [11:11]
        /// Port output data
        ODR11: u1 = 0,
        /// ODR12 [12:12]
        /// Port output data
        ODR12: u1 = 0,
        /// ODR13 [13:13]
        /// Port output data
        ODR13: u1 = 0,
        /// ODR14 [14:14]
        /// Port output data
        ODR14: u1 = 0,
        /// ODR15 [15:15]
        /// Port output data
        ODR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port output data register
    pub const ODR: *volatile ODR_struct = @ptrFromInt(base_address + 0xc);

    /// BSRR
    pub const BSRR_struct = packed struct {
        /// BS0 [0:0]
        /// Set bit 0
        BS0: u1 = 0,
        /// BS1 [1:1]
        /// Set bit 1
        BS1: u1 = 0,
        /// BS2 [2:2]
        /// Set bit 1
        BS2: u1 = 0,
        /// BS3 [3:3]
        /// Set bit 3
        BS3: u1 = 0,
        /// BS4 [4:4]
        /// Set bit 4
        BS4: u1 = 0,
        /// BS5 [5:5]
        /// Set bit 5
        BS5: u1 = 0,
        /// BS6 [6:6]
        /// Set bit 6
        BS6: u1 = 0,
        /// BS7 [7:7]
        /// Set bit 7
        BS7: u1 = 0,
        /// BS8 [8:8]
        /// Set bit 8
        BS8: u1 = 0,
        /// BS9 [9:9]
        /// Set bit 9
        BS9: u1 = 0,
        /// BS10 [10:10]
        /// Set bit 10
        BS10: u1 = 0,
        /// BS11 [11:11]
        /// Set bit 11
        BS11: u1 = 0,
        /// BS12 [12:12]
        /// Set bit 12
        BS12: u1 = 0,
        /// BS13 [13:13]
        /// Set bit 13
        BS13: u1 = 0,
        /// BS14 [14:14]
        /// Set bit 14
        BS14: u1 = 0,
        /// BS15 [15:15]
        /// Set bit 15
        BS15: u1 = 0,
        /// BR0 [16:16]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [17:17]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [18:18]
        /// Reset bit 2
        BR2: u1 = 0,
        /// BR3 [19:19]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [20:20]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [21:21]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [22:22]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [23:23]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [24:24]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [25:25]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [26:26]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [27:27]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [28:28]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [29:29]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [30:30]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [31:31]
        /// Reset bit 15
        BR15: u1 = 0,
    };
    /// Port bit set/reset register
    pub const BSRR: *volatile BSRR_struct = @ptrFromInt(base_address + 0x10);

    /// BRR
    pub const BRR_struct = packed struct {
        /// BR0 [0:0]
        /// Reset bit 0
        BR0: u1 = 0,
        /// BR1 [1:1]
        /// Reset bit 1
        BR1: u1 = 0,
        /// BR2 [2:2]
        /// Reset bit 1
        BR2: u1 = 0,
        /// BR3 [3:3]
        /// Reset bit 3
        BR3: u1 = 0,
        /// BR4 [4:4]
        /// Reset bit 4
        BR4: u1 = 0,
        /// BR5 [5:5]
        /// Reset bit 5
        BR5: u1 = 0,
        /// BR6 [6:6]
        /// Reset bit 6
        BR6: u1 = 0,
        /// BR7 [7:7]
        /// Reset bit 7
        BR7: u1 = 0,
        /// BR8 [8:8]
        /// Reset bit 8
        BR8: u1 = 0,
        /// BR9 [9:9]
        /// Reset bit 9
        BR9: u1 = 0,
        /// BR10 [10:10]
        /// Reset bit 10
        BR10: u1 = 0,
        /// BR11 [11:11]
        /// Reset bit 11
        BR11: u1 = 0,
        /// BR12 [12:12]
        /// Reset bit 12
        BR12: u1 = 0,
        /// BR13 [13:13]
        /// Reset bit 13
        BR13: u1 = 0,
        /// BR14 [14:14]
        /// Reset bit 14
        BR14: u1 = 0,
        /// BR15 [15:15]
        /// Reset bit 15
        BR15: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Port bit reset register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x14);

    /// LCKR
    pub const LCKR_struct = packed struct {
        /// LCK0 [0:0]
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// LCK1 [1:1]
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// LCK2 [2:2]
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// LCK3 [3:3]
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// LCK4 [4:4]
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// LCK5 [5:5]
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// LCK6 [6:6]
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// LCK7 [7:7]
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// LCK8 [8:8]
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// LCK9 [9:9]
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// LCK10 [10:10]
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// LCK11 [11:11]
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// LCK12 [12:12]
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// LCK13 [13:13]
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// LCK14 [14:14]
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// LCK15 [15:15]
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// LCKK [16:16]
        /// Lock key
        LCKK: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Port configuration lock
    pub const LCKR: *volatile LCKR_struct = @ptrFromInt(base_address + 0x18);
};

/// Alternate function I/O
pub const AFIO = struct {
    pub const base_address = 0x40010000;
    /// EVCR
    pub const EVCR_struct = packed struct {
        /// PIN [0:3]
        /// Pin selection
        PIN: u4 = 0,
        /// PORT [4:6]
        /// Port selection
        PORT: u3 = 0,
        /// EVOE [7:7]
        /// Event Output Enable
        EVOE: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Event Control Register
    pub const EVCR: *volatile EVCR_struct = @ptrFromInt(base_address + 0x0);

    /// MAPR
    pub const MAPR_struct = packed struct {
        /// SPI1_REMAP [0:0]
        /// SPI1 remapping
        SPI1_REMAP: u1 = 0,
        /// I2C1_REMAP [1:1]
        /// I2C1 remapping
        I2C1_REMAP: u1 = 0,
        /// USART1_REMAP [2:2]
        /// USART1 remapping
        USART1_REMAP: u1 = 0,
        /// USART2_REMAP [3:3]
        /// USART2 remapping
        USART2_REMAP: u1 = 0,
        /// USART3_REMAP [4:5]
        /// USART3 remapping
        USART3_REMAP: u2 = 0,
        /// TIM1_REMAP [6:7]
        /// TIM1 remapping
        TIM1_REMAP: u2 = 0,
        /// TIM2_REMAP [8:9]
        /// TIM2 remapping
        TIM2_REMAP: u2 = 0,
        /// TIM3_REMAP [10:11]
        /// TIM3 remapping
        TIM3_REMAP: u2 = 0,
        /// TIM4_REMAP [12:12]
        /// TIM4 remapping
        TIM4_REMAP: u1 = 0,
        /// CAN_REMAP [13:14]
        /// CAN1 remapping
        CAN_REMAP: u2 = 0,
        /// PD01_REMAP [15:15]
        /// Port D0/Port D1 mapping on
        PD01_REMAP: u1 = 0,
        /// TIM5CH4_IREMAP [16:16]
        /// Set and cleared by
        TIM5CH4_IREMAP: u1 = 0,
        /// ADC1_ETRGINJ_REMAP [17:17]
        /// ADC 1 External trigger injected
        ADC1_ETRGINJ_REMAP: u1 = 0,
        /// ADC1_ETRGREG_REMAP [18:18]
        /// ADC 1 external trigger regular
        ADC1_ETRGREG_REMAP: u1 = 0,
        /// ADC2_ETRGINJ_REMAP [19:19]
        /// ADC 2 external trigger injected
        ADC2_ETRGINJ_REMAP: u1 = 0,
        /// ADC2_ETRGREG_REMAP [20:20]
        /// ADC 2 external trigger regular
        ADC2_ETRGREG_REMAP: u1 = 0,
        /// unused [21:23]
        _unused21: u3 = 0,
        /// SWJ_CFG [24:26]
        /// Serial wire JTAG
        SWJ_CFG: u3 = 0,
        /// unused [27:31]
        _unused27: u5 = 0,
    };
    /// AF remap and debug I/O configuration
    pub const MAPR: *volatile MAPR_struct = @ptrFromInt(base_address + 0x4);

    /// EXTICR1
    pub const EXTICR1_struct = packed struct {
        /// EXTI0 [0:3]
        /// EXTI0 configuration
        EXTI0: u4 = 0,
        /// EXTI1 [4:7]
        /// EXTI1 configuration
        EXTI1: u4 = 0,
        /// EXTI2 [8:11]
        /// EXTI2 configuration
        EXTI2: u4 = 0,
        /// EXTI3 [12:15]
        /// EXTI3 configuration
        EXTI3: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// External interrupt configuration register 1
    pub const EXTICR1: *volatile EXTICR1_struct = @ptrFromInt(base_address + 0x8);

    /// EXTICR2
    pub const EXTICR2_struct = packed struct {
        /// EXTI4 [0:3]
        /// EXTI4 configuration
        EXTI4: u4 = 0,
        /// EXTI5 [4:7]
        /// EXTI5 configuration
        EXTI5: u4 = 0,
        /// EXTI6 [8:11]
        /// EXTI6 configuration
        EXTI6: u4 = 0,
        /// EXTI7 [12:15]
        /// EXTI7 configuration
        EXTI7: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// External interrupt configuration register 2
    pub const EXTICR2: *volatile EXTICR2_struct = @ptrFromInt(base_address + 0xc);

    /// EXTICR3
    pub const EXTICR3_struct = packed struct {
        /// EXTI8 [0:3]
        /// EXTI8 configuration
        EXTI8: u4 = 0,
        /// EXTI9 [4:7]
        /// EXTI9 configuration
        EXTI9: u4 = 0,
        /// EXTI10 [8:11]
        /// EXTI10 configuration
        EXTI10: u4 = 0,
        /// EXTI11 [12:15]
        /// EXTI11 configuration
        EXTI11: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// External interrupt configuration register 3
    pub const EXTICR3: *volatile EXTICR3_struct = @ptrFromInt(base_address + 0x10);

    /// EXTICR4
    pub const EXTICR4_struct = packed struct {
        /// EXTI12 [0:3]
        /// EXTI12 configuration
        EXTI12: u4 = 0,
        /// EXTI13 [4:7]
        /// EXTI13 configuration
        EXTI13: u4 = 0,
        /// EXTI14 [8:11]
        /// EXTI14 configuration
        EXTI14: u4 = 0,
        /// EXTI15 [12:15]
        /// EXTI15 configuration
        EXTI15: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// External interrupt configuration register 4
    pub const EXTICR4: *volatile EXTICR4_struct = @ptrFromInt(base_address + 0x14);

    /// MAPR2
    pub const MAPR2_struct = packed struct {
        /// unused [0:4]
        _unused0: u5 = 0,
        /// TIM9_REMAP [5:5]
        /// TIM9 remapping
        TIM9_REMAP: u1 = 0,
        /// TIM10_REMAP [6:6]
        /// TIM10 remapping
        TIM10_REMAP: u1 = 0,
        /// TIM11_REMAP [7:7]
        /// TIM11 remapping
        TIM11_REMAP: u1 = 0,
        /// TIM13_REMAP [8:8]
        /// TIM13 remapping
        TIM13_REMAP: u1 = 0,
        /// TIM14_REMAP [9:9]
        /// TIM14 remapping
        TIM14_REMAP: u1 = 0,
        /// FSMC_NADV [10:10]
        /// NADV connect/disconnect
        FSMC_NADV: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// AF remap and debug I/O configuration
    pub const MAPR2: *volatile MAPR2_struct = @ptrFromInt(base_address + 0x1c);
};

/// EXTI
pub const EXTI = struct {
    pub const base_address = 0x40010400;
    /// IMR
    pub const IMR_struct = packed struct {
        /// MR0 [0:0]
        /// Interrupt Mask on line 0
        MR0: u1 = 0,
        /// MR1 [1:1]
        /// Interrupt Mask on line 1
        MR1: u1 = 0,
        /// MR2 [2:2]
        /// Interrupt Mask on line 2
        MR2: u1 = 0,
        /// MR3 [3:3]
        /// Interrupt Mask on line 3
        MR3: u1 = 0,
        /// MR4 [4:4]
        /// Interrupt Mask on line 4
        MR4: u1 = 0,
        /// MR5 [5:5]
        /// Interrupt Mask on line 5
        MR5: u1 = 0,
        /// MR6 [6:6]
        /// Interrupt Mask on line 6
        MR6: u1 = 0,
        /// MR7 [7:7]
        /// Interrupt Mask on line 7
        MR7: u1 = 0,
        /// MR8 [8:8]
        /// Interrupt Mask on line 8
        MR8: u1 = 0,
        /// MR9 [9:9]
        /// Interrupt Mask on line 9
        MR9: u1 = 0,
        /// MR10 [10:10]
        /// Interrupt Mask on line 10
        MR10: u1 = 0,
        /// MR11 [11:11]
        /// Interrupt Mask on line 11
        MR11: u1 = 0,
        /// MR12 [12:12]
        /// Interrupt Mask on line 12
        MR12: u1 = 0,
        /// MR13 [13:13]
        /// Interrupt Mask on line 13
        MR13: u1 = 0,
        /// MR14 [14:14]
        /// Interrupt Mask on line 14
        MR14: u1 = 0,
        /// MR15 [15:15]
        /// Interrupt Mask on line 15
        MR15: u1 = 0,
        /// MR16 [16:16]
        /// Interrupt Mask on line 16
        MR16: u1 = 0,
        /// MR17 [17:17]
        /// Interrupt Mask on line 17
        MR17: u1 = 0,
        /// MR18 [18:18]
        /// Interrupt Mask on line 18
        MR18: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// Interrupt mask register
    pub const IMR: *volatile IMR_struct = @ptrFromInt(base_address + 0x0);

    /// EMR
    pub const EMR_struct = packed struct {
        /// MR0 [0:0]
        /// Event Mask on line 0
        MR0: u1 = 0,
        /// MR1 [1:1]
        /// Event Mask on line 1
        MR1: u1 = 0,
        /// MR2 [2:2]
        /// Event Mask on line 2
        MR2: u1 = 0,
        /// MR3 [3:3]
        /// Event Mask on line 3
        MR3: u1 = 0,
        /// MR4 [4:4]
        /// Event Mask on line 4
        MR4: u1 = 0,
        /// MR5 [5:5]
        /// Event Mask on line 5
        MR5: u1 = 0,
        /// MR6 [6:6]
        /// Event Mask on line 6
        MR6: u1 = 0,
        /// MR7 [7:7]
        /// Event Mask on line 7
        MR7: u1 = 0,
        /// MR8 [8:8]
        /// Event Mask on line 8
        MR8: u1 = 0,
        /// MR9 [9:9]
        /// Event Mask on line 9
        MR9: u1 = 0,
        /// MR10 [10:10]
        /// Event Mask on line 10
        MR10: u1 = 0,
        /// MR11 [11:11]
        /// Event Mask on line 11
        MR11: u1 = 0,
        /// MR12 [12:12]
        /// Event Mask on line 12
        MR12: u1 = 0,
        /// MR13 [13:13]
        /// Event Mask on line 13
        MR13: u1 = 0,
        /// MR14 [14:14]
        /// Event Mask on line 14
        MR14: u1 = 0,
        /// MR15 [15:15]
        /// Event Mask on line 15
        MR15: u1 = 0,
        /// MR16 [16:16]
        /// Event Mask on line 16
        MR16: u1 = 0,
        /// MR17 [17:17]
        /// Event Mask on line 17
        MR17: u1 = 0,
        /// MR18 [18:18]
        /// Event Mask on line 18
        MR18: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// Event mask register (EXTI_EMR)
    pub const EMR: *volatile EMR_struct = @ptrFromInt(base_address + 0x4);

    /// RTSR
    pub const RTSR_struct = packed struct {
        /// TR0 [0:0]
        /// Rising trigger event configuration of
        TR0: u1 = 0,
        /// TR1 [1:1]
        /// Rising trigger event configuration of
        TR1: u1 = 0,
        /// TR2 [2:2]
        /// Rising trigger event configuration of
        TR2: u1 = 0,
        /// TR3 [3:3]
        /// Rising trigger event configuration of
        TR3: u1 = 0,
        /// TR4 [4:4]
        /// Rising trigger event configuration of
        TR4: u1 = 0,
        /// TR5 [5:5]
        /// Rising trigger event configuration of
        TR5: u1 = 0,
        /// TR6 [6:6]
        /// Rising trigger event configuration of
        TR6: u1 = 0,
        /// TR7 [7:7]
        /// Rising trigger event configuration of
        TR7: u1 = 0,
        /// TR8 [8:8]
        /// Rising trigger event configuration of
        TR8: u1 = 0,
        /// TR9 [9:9]
        /// Rising trigger event configuration of
        TR9: u1 = 0,
        /// TR10 [10:10]
        /// Rising trigger event configuration of
        TR10: u1 = 0,
        /// TR11 [11:11]
        /// Rising trigger event configuration of
        TR11: u1 = 0,
        /// TR12 [12:12]
        /// Rising trigger event configuration of
        TR12: u1 = 0,
        /// TR13 [13:13]
        /// Rising trigger event configuration of
        TR13: u1 = 0,
        /// TR14 [14:14]
        /// Rising trigger event configuration of
        TR14: u1 = 0,
        /// TR15 [15:15]
        /// Rising trigger event configuration of
        TR15: u1 = 0,
        /// TR16 [16:16]
        /// Rising trigger event configuration of
        TR16: u1 = 0,
        /// TR17 [17:17]
        /// Rising trigger event configuration of
        TR17: u1 = 0,
        /// TR18 [18:18]
        /// Rising trigger event configuration of
        TR18: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// Rising Trigger selection register
    pub const RTSR: *volatile RTSR_struct = @ptrFromInt(base_address + 0x8);

    /// FTSR
    pub const FTSR_struct = packed struct {
        /// TR0 [0:0]
        /// Falling trigger event configuration of
        TR0: u1 = 0,
        /// TR1 [1:1]
        /// Falling trigger event configuration of
        TR1: u1 = 0,
        /// TR2 [2:2]
        /// Falling trigger event configuration of
        TR2: u1 = 0,
        /// TR3 [3:3]
        /// Falling trigger event configuration of
        TR3: u1 = 0,
        /// TR4 [4:4]
        /// Falling trigger event configuration of
        TR4: u1 = 0,
        /// TR5 [5:5]
        /// Falling trigger event configuration of
        TR5: u1 = 0,
        /// TR6 [6:6]
        /// Falling trigger event configuration of
        TR6: u1 = 0,
        /// TR7 [7:7]
        /// Falling trigger event configuration of
        TR7: u1 = 0,
        /// TR8 [8:8]
        /// Falling trigger event configuration of
        TR8: u1 = 0,
        /// TR9 [9:9]
        /// Falling trigger event configuration of
        TR9: u1 = 0,
        /// TR10 [10:10]
        /// Falling trigger event configuration of
        TR10: u1 = 0,
        /// TR11 [11:11]
        /// Falling trigger event configuration of
        TR11: u1 = 0,
        /// TR12 [12:12]
        /// Falling trigger event configuration of
        TR12: u1 = 0,
        /// TR13 [13:13]
        /// Falling trigger event configuration of
        TR13: u1 = 0,
        /// TR14 [14:14]
        /// Falling trigger event configuration of
        TR14: u1 = 0,
        /// TR15 [15:15]
        /// Falling trigger event configuration of
        TR15: u1 = 0,
        /// TR16 [16:16]
        /// Falling trigger event configuration of
        TR16: u1 = 0,
        /// TR17 [17:17]
        /// Falling trigger event configuration of
        TR17: u1 = 0,
        /// TR18 [18:18]
        /// Falling trigger event configuration of
        TR18: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// Falling Trigger selection register
    pub const FTSR: *volatile FTSR_struct = @ptrFromInt(base_address + 0xc);

    /// SWIER
    pub const SWIER_struct = packed struct {
        /// SWIER0 [0:0]
        /// Software Interrupt on line
        SWIER0: u1 = 0,
        /// SWIER1 [1:1]
        /// Software Interrupt on line
        SWIER1: u1 = 0,
        /// SWIER2 [2:2]
        /// Software Interrupt on line
        SWIER2: u1 = 0,
        /// SWIER3 [3:3]
        /// Software Interrupt on line
        SWIER3: u1 = 0,
        /// SWIER4 [4:4]
        /// Software Interrupt on line
        SWIER4: u1 = 0,
        /// SWIER5 [5:5]
        /// Software Interrupt on line
        SWIER5: u1 = 0,
        /// SWIER6 [6:6]
        /// Software Interrupt on line
        SWIER6: u1 = 0,
        /// SWIER7 [7:7]
        /// Software Interrupt on line
        SWIER7: u1 = 0,
        /// SWIER8 [8:8]
        /// Software Interrupt on line
        SWIER8: u1 = 0,
        /// SWIER9 [9:9]
        /// Software Interrupt on line
        SWIER9: u1 = 0,
        /// SWIER10 [10:10]
        /// Software Interrupt on line
        SWIER10: u1 = 0,
        /// SWIER11 [11:11]
        /// Software Interrupt on line
        SWIER11: u1 = 0,
        /// SWIER12 [12:12]
        /// Software Interrupt on line
        SWIER12: u1 = 0,
        /// SWIER13 [13:13]
        /// Software Interrupt on line
        SWIER13: u1 = 0,
        /// SWIER14 [14:14]
        /// Software Interrupt on line
        SWIER14: u1 = 0,
        /// SWIER15 [15:15]
        /// Software Interrupt on line
        SWIER15: u1 = 0,
        /// SWIER16 [16:16]
        /// Software Interrupt on line
        SWIER16: u1 = 0,
        /// SWIER17 [17:17]
        /// Software Interrupt on line
        SWIER17: u1 = 0,
        /// SWIER18 [18:18]
        /// Software Interrupt on line
        SWIER18: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// Software interrupt event register
    pub const SWIER: *volatile SWIER_struct = @ptrFromInt(base_address + 0x10);

    /// PR
    pub const PR_struct = packed struct {
        /// PR0 [0:0]
        /// Pending bit 0
        PR0: u1 = 0,
        /// PR1 [1:1]
        /// Pending bit 1
        PR1: u1 = 0,
        /// PR2 [2:2]
        /// Pending bit 2
        PR2: u1 = 0,
        /// PR3 [3:3]
        /// Pending bit 3
        PR3: u1 = 0,
        /// PR4 [4:4]
        /// Pending bit 4
        PR4: u1 = 0,
        /// PR5 [5:5]
        /// Pending bit 5
        PR5: u1 = 0,
        /// PR6 [6:6]
        /// Pending bit 6
        PR6: u1 = 0,
        /// PR7 [7:7]
        /// Pending bit 7
        PR7: u1 = 0,
        /// PR8 [8:8]
        /// Pending bit 8
        PR8: u1 = 0,
        /// PR9 [9:9]
        /// Pending bit 9
        PR9: u1 = 0,
        /// PR10 [10:10]
        /// Pending bit 10
        PR10: u1 = 0,
        /// PR11 [11:11]
        /// Pending bit 11
        PR11: u1 = 0,
        /// PR12 [12:12]
        /// Pending bit 12
        PR12: u1 = 0,
        /// PR13 [13:13]
        /// Pending bit 13
        PR13: u1 = 0,
        /// PR14 [14:14]
        /// Pending bit 14
        PR14: u1 = 0,
        /// PR15 [15:15]
        /// Pending bit 15
        PR15: u1 = 0,
        /// PR16 [16:16]
        /// Pending bit 16
        PR16: u1 = 0,
        /// PR17 [17:17]
        /// Pending bit 17
        PR17: u1 = 0,
        /// PR18 [18:18]
        /// Pending bit 18
        PR18: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// Pending register (EXTI_PR)
    pub const PR: *volatile PR_struct = @ptrFromInt(base_address + 0x14);
};

/// DMA controller
pub const DMA1 = struct {
    pub const base_address = 0x40020000;
    /// ISR
    pub const ISR_struct = packed struct {
        /// GIF1 [0:0]
        /// Channel 1 Global interrupt
        GIF1: u1 = 0,
        /// TCIF1 [1:1]
        /// Channel 1 Transfer Complete
        TCIF1: u1 = 0,
        /// HTIF1 [2:2]
        /// Channel 1 Half Transfer Complete
        HTIF1: u1 = 0,
        /// TEIF1 [3:3]
        /// Channel 1 Transfer Error
        TEIF1: u1 = 0,
        /// GIF2 [4:4]
        /// Channel 2 Global interrupt
        GIF2: u1 = 0,
        /// TCIF2 [5:5]
        /// Channel 2 Transfer Complete
        TCIF2: u1 = 0,
        /// HTIF2 [6:6]
        /// Channel 2 Half Transfer Complete
        HTIF2: u1 = 0,
        /// TEIF2 [7:7]
        /// Channel 2 Transfer Error
        TEIF2: u1 = 0,
        /// GIF3 [8:8]
        /// Channel 3 Global interrupt
        GIF3: u1 = 0,
        /// TCIF3 [9:9]
        /// Channel 3 Transfer Complete
        TCIF3: u1 = 0,
        /// HTIF3 [10:10]
        /// Channel 3 Half Transfer Complete
        HTIF3: u1 = 0,
        /// TEIF3 [11:11]
        /// Channel 3 Transfer Error
        TEIF3: u1 = 0,
        /// GIF4 [12:12]
        /// Channel 4 Global interrupt
        GIF4: u1 = 0,
        /// TCIF4 [13:13]
        /// Channel 4 Transfer Complete
        TCIF4: u1 = 0,
        /// HTIF4 [14:14]
        /// Channel 4 Half Transfer Complete
        HTIF4: u1 = 0,
        /// TEIF4 [15:15]
        /// Channel 4 Transfer Error
        TEIF4: u1 = 0,
        /// GIF5 [16:16]
        /// Channel 5 Global interrupt
        GIF5: u1 = 0,
        /// TCIF5 [17:17]
        /// Channel 5 Transfer Complete
        TCIF5: u1 = 0,
        /// HTIF5 [18:18]
        /// Channel 5 Half Transfer Complete
        HTIF5: u1 = 0,
        /// TEIF5 [19:19]
        /// Channel 5 Transfer Error
        TEIF5: u1 = 0,
        /// GIF6 [20:20]
        /// Channel 6 Global interrupt
        GIF6: u1 = 0,
        /// TCIF6 [21:21]
        /// Channel 6 Transfer Complete
        TCIF6: u1 = 0,
        /// HTIF6 [22:22]
        /// Channel 6 Half Transfer Complete
        HTIF6: u1 = 0,
        /// TEIF6 [23:23]
        /// Channel 6 Transfer Error
        TEIF6: u1 = 0,
        /// GIF7 [24:24]
        /// Channel 7 Global interrupt
        GIF7: u1 = 0,
        /// TCIF7 [25:25]
        /// Channel 7 Transfer Complete
        TCIF7: u1 = 0,
        /// HTIF7 [26:26]
        /// Channel 7 Half Transfer Complete
        HTIF7: u1 = 0,
        /// TEIF7 [27:27]
        /// Channel 7 Transfer Error
        TEIF7: u1 = 0,
        /// unused [28:31]
        _unused28: u4 = 0,
    };
    /// DMA interrupt status register
    pub const ISR: *volatile ISR_struct = @ptrFromInt(base_address + 0x0);

    /// IFCR
    pub const IFCR_struct = packed struct {
        /// CGIF1 [0:0]
        /// Channel 1 Global interrupt
        CGIF1: u1 = 0,
        /// CTCIF1 [1:1]
        /// Channel 1 Transfer Complete
        CTCIF1: u1 = 0,
        /// CHTIF1 [2:2]
        /// Channel 1 Half Transfer
        CHTIF1: u1 = 0,
        /// CTEIF1 [3:3]
        /// Channel 1 Transfer Error
        CTEIF1: u1 = 0,
        /// CGIF2 [4:4]
        /// Channel 2 Global interrupt
        CGIF2: u1 = 0,
        /// CTCIF2 [5:5]
        /// Channel 2 Transfer Complete
        CTCIF2: u1 = 0,
        /// CHTIF2 [6:6]
        /// Channel 2 Half Transfer
        CHTIF2: u1 = 0,
        /// CTEIF2 [7:7]
        /// Channel 2 Transfer Error
        CTEIF2: u1 = 0,
        /// CGIF3 [8:8]
        /// Channel 3 Global interrupt
        CGIF3: u1 = 0,
        /// CTCIF3 [9:9]
        /// Channel 3 Transfer Complete
        CTCIF3: u1 = 0,
        /// CHTIF3 [10:10]
        /// Channel 3 Half Transfer
        CHTIF3: u1 = 0,
        /// CTEIF3 [11:11]
        /// Channel 3 Transfer Error
        CTEIF3: u1 = 0,
        /// CGIF4 [12:12]
        /// Channel 4 Global interrupt
        CGIF4: u1 = 0,
        /// CTCIF4 [13:13]
        /// Channel 4 Transfer Complete
        CTCIF4: u1 = 0,
        /// CHTIF4 [14:14]
        /// Channel 4 Half Transfer
        CHTIF4: u1 = 0,
        /// CTEIF4 [15:15]
        /// Channel 4 Transfer Error
        CTEIF4: u1 = 0,
        /// CGIF5 [16:16]
        /// Channel 5 Global interrupt
        CGIF5: u1 = 0,
        /// CTCIF5 [17:17]
        /// Channel 5 Transfer Complete
        CTCIF5: u1 = 0,
        /// CHTIF5 [18:18]
        /// Channel 5 Half Transfer
        CHTIF5: u1 = 0,
        /// CTEIF5 [19:19]
        /// Channel 5 Transfer Error
        CTEIF5: u1 = 0,
        /// CGIF6 [20:20]
        /// Channel 6 Global interrupt
        CGIF6: u1 = 0,
        /// CTCIF6 [21:21]
        /// Channel 6 Transfer Complete
        CTCIF6: u1 = 0,
        /// CHTIF6 [22:22]
        /// Channel 6 Half Transfer
        CHTIF6: u1 = 0,
        /// CTEIF6 [23:23]
        /// Channel 6 Transfer Error
        CTEIF6: u1 = 0,
        /// CGIF7 [24:24]
        /// Channel 7 Global interrupt
        CGIF7: u1 = 0,
        /// CTCIF7 [25:25]
        /// Channel 7 Transfer Complete
        CTCIF7: u1 = 0,
        /// CHTIF7 [26:26]
        /// Channel 7 Half Transfer
        CHTIF7: u1 = 0,
        /// CTEIF7 [27:27]
        /// Channel 7 Transfer Error
        CTEIF7: u1 = 0,
        /// unused [28:31]
        _unused28: u4 = 0,
    };
    /// DMA interrupt flag clear register
    pub const IFCR: *volatile IFCR_struct = @ptrFromInt(base_address + 0x4);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x8);

    /// CNDTR1
    pub const CNDTR1_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 1 number of data
    pub const CNDTR1: *volatile CNDTR1_struct = @ptrFromInt(base_address + 0xc);

    /// CPAR1
    pub const CPAR1_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 1 peripheral address
    pub const CPAR1: *volatile CPAR1_struct = @ptrFromInt(base_address + 0x10);

    /// CMAR1
    pub const CMAR1_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 1 memory address
    pub const CMAR1: *volatile CMAR1_struct = @ptrFromInt(base_address + 0x14);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x1c);

    /// CNDTR2
    pub const CNDTR2_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 2 number of data
    pub const CNDTR2: *volatile CNDTR2_struct = @ptrFromInt(base_address + 0x20);

    /// CPAR2
    pub const CPAR2_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 2 peripheral address
    pub const CPAR2: *volatile CPAR2_struct = @ptrFromInt(base_address + 0x24);

    /// CMAR2
    pub const CMAR2_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 2 memory address
    pub const CMAR2: *volatile CMAR2_struct = @ptrFromInt(base_address + 0x28);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x30);

    /// CNDTR3
    pub const CNDTR3_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 3 number of data
    pub const CNDTR3: *volatile CNDTR3_struct = @ptrFromInt(base_address + 0x34);

    /// CPAR3
    pub const CPAR3_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 3 peripheral address
    pub const CPAR3: *volatile CPAR3_struct = @ptrFromInt(base_address + 0x38);

    /// CMAR3
    pub const CMAR3_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 3 memory address
    pub const CMAR3: *volatile CMAR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x44);

    /// CNDTR4
    pub const CNDTR4_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 4 number of data
    pub const CNDTR4: *volatile CNDTR4_struct = @ptrFromInt(base_address + 0x48);

    /// CPAR4
    pub const CPAR4_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 4 peripheral address
    pub const CPAR4: *volatile CPAR4_struct = @ptrFromInt(base_address + 0x4c);

    /// CMAR4
    pub const CMAR4_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 4 memory address
    pub const CMAR4: *volatile CMAR4_struct = @ptrFromInt(base_address + 0x50);

    /// CCR5
    pub const CCR5_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR5: *volatile CCR5_struct = @ptrFromInt(base_address + 0x58);

    /// CNDTR5
    pub const CNDTR5_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 5 number of data
    pub const CNDTR5: *volatile CNDTR5_struct = @ptrFromInt(base_address + 0x5c);

    /// CPAR5
    pub const CPAR5_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 5 peripheral address
    pub const CPAR5: *volatile CPAR5_struct = @ptrFromInt(base_address + 0x60);

    /// CMAR5
    pub const CMAR5_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 5 memory address
    pub const CMAR5: *volatile CMAR5_struct = @ptrFromInt(base_address + 0x64);

    /// CCR6
    pub const CCR6_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR6: *volatile CCR6_struct = @ptrFromInt(base_address + 0x6c);

    /// CNDTR6
    pub const CNDTR6_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 6 number of data
    pub const CNDTR6: *volatile CNDTR6_struct = @ptrFromInt(base_address + 0x70);

    /// CPAR6
    pub const CPAR6_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 6 peripheral address
    pub const CPAR6: *volatile CPAR6_struct = @ptrFromInt(base_address + 0x74);

    /// CMAR6
    pub const CMAR6_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 6 memory address
    pub const CMAR6: *volatile CMAR6_struct = @ptrFromInt(base_address + 0x78);

    /// CCR7
    pub const CCR7_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR7: *volatile CCR7_struct = @ptrFromInt(base_address + 0x80);

    /// CNDTR7
    pub const CNDTR7_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 7 number of data
    pub const CNDTR7: *volatile CNDTR7_struct = @ptrFromInt(base_address + 0x84);

    /// CPAR7
    pub const CPAR7_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 7 peripheral address
    pub const CPAR7: *volatile CPAR7_struct = @ptrFromInt(base_address + 0x88);

    /// CMAR7
    pub const CMAR7_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 7 memory address
    pub const CMAR7: *volatile CMAR7_struct = @ptrFromInt(base_address + 0x8c);
};

/// DMA controller
pub const DMA2 = struct {
    pub const base_address = 0x40020400;
    /// ISR
    pub const ISR_struct = packed struct {
        /// GIF1 [0:0]
        /// Channel 1 Global interrupt
        GIF1: u1 = 0,
        /// TCIF1 [1:1]
        /// Channel 1 Transfer Complete
        TCIF1: u1 = 0,
        /// HTIF1 [2:2]
        /// Channel 1 Half Transfer Complete
        HTIF1: u1 = 0,
        /// TEIF1 [3:3]
        /// Channel 1 Transfer Error
        TEIF1: u1 = 0,
        /// GIF2 [4:4]
        /// Channel 2 Global interrupt
        GIF2: u1 = 0,
        /// TCIF2 [5:5]
        /// Channel 2 Transfer Complete
        TCIF2: u1 = 0,
        /// HTIF2 [6:6]
        /// Channel 2 Half Transfer Complete
        HTIF2: u1 = 0,
        /// TEIF2 [7:7]
        /// Channel 2 Transfer Error
        TEIF2: u1 = 0,
        /// GIF3 [8:8]
        /// Channel 3 Global interrupt
        GIF3: u1 = 0,
        /// TCIF3 [9:9]
        /// Channel 3 Transfer Complete
        TCIF3: u1 = 0,
        /// HTIF3 [10:10]
        /// Channel 3 Half Transfer Complete
        HTIF3: u1 = 0,
        /// TEIF3 [11:11]
        /// Channel 3 Transfer Error
        TEIF3: u1 = 0,
        /// GIF4 [12:12]
        /// Channel 4 Global interrupt
        GIF4: u1 = 0,
        /// TCIF4 [13:13]
        /// Channel 4 Transfer Complete
        TCIF4: u1 = 0,
        /// HTIF4 [14:14]
        /// Channel 4 Half Transfer Complete
        HTIF4: u1 = 0,
        /// TEIF4 [15:15]
        /// Channel 4 Transfer Error
        TEIF4: u1 = 0,
        /// GIF5 [16:16]
        /// Channel 5 Global interrupt
        GIF5: u1 = 0,
        /// TCIF5 [17:17]
        /// Channel 5 Transfer Complete
        TCIF5: u1 = 0,
        /// HTIF5 [18:18]
        /// Channel 5 Half Transfer Complete
        HTIF5: u1 = 0,
        /// TEIF5 [19:19]
        /// Channel 5 Transfer Error
        TEIF5: u1 = 0,
        /// GIF6 [20:20]
        /// Channel 6 Global interrupt
        GIF6: u1 = 0,
        /// TCIF6 [21:21]
        /// Channel 6 Transfer Complete
        TCIF6: u1 = 0,
        /// HTIF6 [22:22]
        /// Channel 6 Half Transfer Complete
        HTIF6: u1 = 0,
        /// TEIF6 [23:23]
        /// Channel 6 Transfer Error
        TEIF6: u1 = 0,
        /// GIF7 [24:24]
        /// Channel 7 Global interrupt
        GIF7: u1 = 0,
        /// TCIF7 [25:25]
        /// Channel 7 Transfer Complete
        TCIF7: u1 = 0,
        /// HTIF7 [26:26]
        /// Channel 7 Half Transfer Complete
        HTIF7: u1 = 0,
        /// TEIF7 [27:27]
        /// Channel 7 Transfer Error
        TEIF7: u1 = 0,
        /// unused [28:31]
        _unused28: u4 = 0,
    };
    /// DMA interrupt status register
    pub const ISR: *volatile ISR_struct = @ptrFromInt(base_address + 0x0);

    /// IFCR
    pub const IFCR_struct = packed struct {
        /// CGIF1 [0:0]
        /// Channel 1 Global interrupt
        CGIF1: u1 = 0,
        /// CTCIF1 [1:1]
        /// Channel 1 Transfer Complete
        CTCIF1: u1 = 0,
        /// CHTIF1 [2:2]
        /// Channel 1 Half Transfer
        CHTIF1: u1 = 0,
        /// CTEIF1 [3:3]
        /// Channel 1 Transfer Error
        CTEIF1: u1 = 0,
        /// CGIF2 [4:4]
        /// Channel 2 Global interrupt
        CGIF2: u1 = 0,
        /// CTCIF2 [5:5]
        /// Channel 2 Transfer Complete
        CTCIF2: u1 = 0,
        /// CHTIF2 [6:6]
        /// Channel 2 Half Transfer
        CHTIF2: u1 = 0,
        /// CTEIF2 [7:7]
        /// Channel 2 Transfer Error
        CTEIF2: u1 = 0,
        /// CGIF3 [8:8]
        /// Channel 3 Global interrupt
        CGIF3: u1 = 0,
        /// CTCIF3 [9:9]
        /// Channel 3 Transfer Complete
        CTCIF3: u1 = 0,
        /// CHTIF3 [10:10]
        /// Channel 3 Half Transfer
        CHTIF3: u1 = 0,
        /// CTEIF3 [11:11]
        /// Channel 3 Transfer Error
        CTEIF3: u1 = 0,
        /// CGIF4 [12:12]
        /// Channel 4 Global interrupt
        CGIF4: u1 = 0,
        /// CTCIF4 [13:13]
        /// Channel 4 Transfer Complete
        CTCIF4: u1 = 0,
        /// CHTIF4 [14:14]
        /// Channel 4 Half Transfer
        CHTIF4: u1 = 0,
        /// CTEIF4 [15:15]
        /// Channel 4 Transfer Error
        CTEIF4: u1 = 0,
        /// CGIF5 [16:16]
        /// Channel 5 Global interrupt
        CGIF5: u1 = 0,
        /// CTCIF5 [17:17]
        /// Channel 5 Transfer Complete
        CTCIF5: u1 = 0,
        /// CHTIF5 [18:18]
        /// Channel 5 Half Transfer
        CHTIF5: u1 = 0,
        /// CTEIF5 [19:19]
        /// Channel 5 Transfer Error
        CTEIF5: u1 = 0,
        /// CGIF6 [20:20]
        /// Channel 6 Global interrupt
        CGIF6: u1 = 0,
        /// CTCIF6 [21:21]
        /// Channel 6 Transfer Complete
        CTCIF6: u1 = 0,
        /// CHTIF6 [22:22]
        /// Channel 6 Half Transfer
        CHTIF6: u1 = 0,
        /// CTEIF6 [23:23]
        /// Channel 6 Transfer Error
        CTEIF6: u1 = 0,
        /// CGIF7 [24:24]
        /// Channel 7 Global interrupt
        CGIF7: u1 = 0,
        /// CTCIF7 [25:25]
        /// Channel 7 Transfer Complete
        CTCIF7: u1 = 0,
        /// CHTIF7 [26:26]
        /// Channel 7 Half Transfer
        CHTIF7: u1 = 0,
        /// CTEIF7 [27:27]
        /// Channel 7 Transfer Error
        CTEIF7: u1 = 0,
        /// unused [28:31]
        _unused28: u4 = 0,
    };
    /// DMA interrupt flag clear register
    pub const IFCR: *volatile IFCR_struct = @ptrFromInt(base_address + 0x4);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x8);

    /// CNDTR1
    pub const CNDTR1_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 1 number of data
    pub const CNDTR1: *volatile CNDTR1_struct = @ptrFromInt(base_address + 0xc);

    /// CPAR1
    pub const CPAR1_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 1 peripheral address
    pub const CPAR1: *volatile CPAR1_struct = @ptrFromInt(base_address + 0x10);

    /// CMAR1
    pub const CMAR1_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 1 memory address
    pub const CMAR1: *volatile CMAR1_struct = @ptrFromInt(base_address + 0x14);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x1c);

    /// CNDTR2
    pub const CNDTR2_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 2 number of data
    pub const CNDTR2: *volatile CNDTR2_struct = @ptrFromInt(base_address + 0x20);

    /// CPAR2
    pub const CPAR2_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 2 peripheral address
    pub const CPAR2: *volatile CPAR2_struct = @ptrFromInt(base_address + 0x24);

    /// CMAR2
    pub const CMAR2_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 2 memory address
    pub const CMAR2: *volatile CMAR2_struct = @ptrFromInt(base_address + 0x28);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x30);

    /// CNDTR3
    pub const CNDTR3_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 3 number of data
    pub const CNDTR3: *volatile CNDTR3_struct = @ptrFromInt(base_address + 0x34);

    /// CPAR3
    pub const CPAR3_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 3 peripheral address
    pub const CPAR3: *volatile CPAR3_struct = @ptrFromInt(base_address + 0x38);

    /// CMAR3
    pub const CMAR3_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 3 memory address
    pub const CMAR3: *volatile CMAR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x44);

    /// CNDTR4
    pub const CNDTR4_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 4 number of data
    pub const CNDTR4: *volatile CNDTR4_struct = @ptrFromInt(base_address + 0x48);

    /// CPAR4
    pub const CPAR4_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 4 peripheral address
    pub const CPAR4: *volatile CPAR4_struct = @ptrFromInt(base_address + 0x4c);

    /// CMAR4
    pub const CMAR4_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 4 memory address
    pub const CMAR4: *volatile CMAR4_struct = @ptrFromInt(base_address + 0x50);

    /// CCR5
    pub const CCR5_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR5: *volatile CCR5_struct = @ptrFromInt(base_address + 0x58);

    /// CNDTR5
    pub const CNDTR5_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 5 number of data
    pub const CNDTR5: *volatile CNDTR5_struct = @ptrFromInt(base_address + 0x5c);

    /// CPAR5
    pub const CPAR5_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 5 peripheral address
    pub const CPAR5: *volatile CPAR5_struct = @ptrFromInt(base_address + 0x60);

    /// CMAR5
    pub const CMAR5_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 5 memory address
    pub const CMAR5: *volatile CMAR5_struct = @ptrFromInt(base_address + 0x64);

    /// CCR6
    pub const CCR6_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR6: *volatile CCR6_struct = @ptrFromInt(base_address + 0x6c);

    /// CNDTR6
    pub const CNDTR6_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 6 number of data
    pub const CNDTR6: *volatile CNDTR6_struct = @ptrFromInt(base_address + 0x70);

    /// CPAR6
    pub const CPAR6_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 6 peripheral address
    pub const CPAR6: *volatile CPAR6_struct = @ptrFromInt(base_address + 0x74);

    /// CMAR6
    pub const CMAR6_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 6 memory address
    pub const CMAR6: *volatile CMAR6_struct = @ptrFromInt(base_address + 0x78);

    /// CCR7
    pub const CCR7_struct = packed struct {
        /// EN [0:0]
        /// Channel enable
        EN: u1 = 0,
        /// TCIE [1:1]
        /// Transfer complete interrupt
        TCIE: u1 = 0,
        /// HTIE [2:2]
        /// Half Transfer interrupt
        HTIE: u1 = 0,
        /// TEIE [3:3]
        /// Transfer error interrupt
        TEIE: u1 = 0,
        /// DIR [4:4]
        /// Data transfer direction
        DIR: u1 = 0,
        /// CIRC [5:5]
        /// Circular mode
        CIRC: u1 = 0,
        /// PINC [6:6]
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// MINC [7:7]
        /// Memory increment mode
        MINC: u1 = 0,
        /// PSIZE [8:9]
        /// Peripheral size
        PSIZE: u2 = 0,
        /// MSIZE [10:11]
        /// Memory size
        MSIZE: u2 = 0,
        /// PL [12:13]
        /// Channel Priority level
        PL: u2 = 0,
        /// MEM2MEM [14:14]
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel configuration register
    pub const CCR7: *volatile CCR7_struct = @ptrFromInt(base_address + 0x80);

    /// CNDTR7
    pub const CNDTR7_struct = packed struct {
        /// NDT [0:15]
        /// Number of data to transfer
        NDT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA channel 7 number of data
    pub const CNDTR7: *volatile CNDTR7_struct = @ptrFromInt(base_address + 0x84);

    /// CPAR7
    pub const CPAR7_struct = packed struct {
        /// PA [0:31]
        /// Peripheral address
        PA: u32 = 0,
    };
    /// DMA channel 7 peripheral address
    pub const CPAR7: *volatile CPAR7_struct = @ptrFromInt(base_address + 0x88);

    /// CMAR7
    pub const CMAR7_struct = packed struct {
        /// MA [0:31]
        /// Memory address
        MA: u32 = 0,
    };
    /// DMA channel 7 memory address
    pub const CMAR7: *volatile CMAR7_struct = @ptrFromInt(base_address + 0x8c);
};

/// Secure digital input/output
pub const SDIO = struct {
    pub const base_address = 0x40018000;
    /// POWER
    pub const POWER_struct = packed struct {
        /// PWRCTRL [0:1]
        /// PWRCTRL
        PWRCTRL: u2 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Bits 1:0 = PWRCTRL: Power supply control
    pub const POWER: *volatile POWER_struct = @ptrFromInt(base_address + 0x0);

    /// CLKCR
    pub const CLKCR_struct = packed struct {
        /// CLKDIV [0:7]
        /// Clock divide factor
        CLKDIV: u8 = 0,
        /// CLKEN [8:8]
        /// Clock enable bit
        CLKEN: u1 = 0,
        /// PWRSAV [9:9]
        /// Power saving configuration
        PWRSAV: u1 = 0,
        /// BYPASS [10:10]
        /// Clock divider bypass enable
        BYPASS: u1 = 0,
        /// WIDBUS [11:12]
        /// Wide bus mode enable bit
        WIDBUS: u2 = 0,
        /// NEGEDGE [13:13]
        /// SDIO_CK dephasing selection
        NEGEDGE: u1 = 0,
        /// HWFC_EN [14:14]
        /// HW Flow Control enable
        HWFC_EN: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// SDI clock control register
    pub const CLKCR: *volatile CLKCR_struct = @ptrFromInt(base_address + 0x4);

    /// ARG
    pub const ARG_struct = packed struct {
        /// CMDARG [0:31]
        /// Command argument
        CMDARG: u32 = 0,
    };
    /// Bits 31:0 = : Command argument
    pub const ARG: *volatile ARG_struct = @ptrFromInt(base_address + 0x8);

    /// CMD
    pub const CMD_struct = packed struct {
        /// CMDINDEX [0:5]
        /// CMDINDEX
        CMDINDEX: u6 = 0,
        /// WAITRESP [6:7]
        /// WAITRESP
        WAITRESP: u2 = 0,
        /// WAITINT [8:8]
        /// WAITINT
        WAITINT: u1 = 0,
        /// WAITPEND [9:9]
        /// WAITPEND
        WAITPEND: u1 = 0,
        /// CPSMEN [10:10]
        /// CPSMEN
        CPSMEN: u1 = 0,
        /// SDIOSuspend [11:11]
        /// SDIOSuspend
        SDIOSuspend: u1 = 0,
        /// ENCMDcompl [12:12]
        /// ENCMDcompl
        ENCMDcompl: u1 = 0,
        /// nIEN [13:13]
        /// nIEN
        nIEN: u1 = 0,
        /// CE_ATACMD [14:14]
        /// CE_ATACMD
        CE_ATACMD: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// SDIO command register
    pub const CMD: *volatile CMD_struct = @ptrFromInt(base_address + 0xc);

    /// RESPCMD
    pub const RESPCMD_struct = packed struct {
        /// RESPCMD [0:5]
        /// RESPCMD
        RESPCMD: u6 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// SDIO command register
    pub const RESPCMD: *volatile RESPCMD_struct = @ptrFromInt(base_address + 0x10);

    /// RESPI1
    pub const RESPI1_struct = packed struct {
        /// CARDSTATUS1 [0:31]
        /// CARDSTATUS1
        CARDSTATUS1: u32 = 0,
    };
    /// Bits 31:0 = CARDSTATUS1
    pub const RESPI1: *volatile RESPI1_struct = @ptrFromInt(base_address + 0x14);

    /// RESP2
    pub const RESP2_struct = packed struct {
        /// CARDSTATUS2 [0:31]
        /// CARDSTATUS2
        CARDSTATUS2: u32 = 0,
    };
    /// Bits 31:0 = CARDSTATUS2
    pub const RESP2: *volatile RESP2_struct = @ptrFromInt(base_address + 0x18);

    /// RESP3
    pub const RESP3_struct = packed struct {
        /// CARDSTATUS3 [0:31]
        /// CARDSTATUS3
        CARDSTATUS3: u32 = 0,
    };
    /// Bits 31:0 = CARDSTATUS3
    pub const RESP3: *volatile RESP3_struct = @ptrFromInt(base_address + 0x1c);

    /// RESP4
    pub const RESP4_struct = packed struct {
        /// CARDSTATUS4 [0:31]
        /// CARDSTATUS4
        CARDSTATUS4: u32 = 0,
    };
    /// Bits 31:0 = CARDSTATUS4
    pub const RESP4: *volatile RESP4_struct = @ptrFromInt(base_address + 0x20);

    /// DTIMER
    pub const DTIMER_struct = packed struct {
        /// DATATIME [0:31]
        /// Data timeout period
        DATATIME: u32 = 0,
    };
    /// Bits 31:0 = DATATIME: Data timeout
    pub const DTIMER: *volatile DTIMER_struct = @ptrFromInt(base_address + 0x24);

    /// DLEN
    pub const DLEN_struct = packed struct {
        /// DATALENGTH [0:24]
        /// Data length value
        DATALENGTH: u25 = 0,
        /// unused [25:31]
        _unused25: u7 = 0,
    };
    /// Bits 24:0 = DATALENGTH: Data length
    pub const DLEN: *volatile DLEN_struct = @ptrFromInt(base_address + 0x28);

    /// DCTRL
    pub const DCTRL_struct = packed struct {
        /// DTEN [0:0]
        /// DTEN
        DTEN: u1 = 0,
        /// DTDIR [1:1]
        /// DTDIR
        DTDIR: u1 = 0,
        /// DTMODE [2:2]
        /// DTMODE
        DTMODE: u1 = 0,
        /// DMAEN [3:3]
        /// DMAEN
        DMAEN: u1 = 0,
        /// DBLOCKSIZE [4:7]
        /// DBLOCKSIZE
        DBLOCKSIZE: u4 = 0,
        /// PWSTART [8:8]
        /// PWSTART
        PWSTART: u1 = 0,
        /// PWSTOP [9:9]
        /// PWSTOP
        PWSTOP: u1 = 0,
        /// RWMOD [10:10]
        /// RWMOD
        RWMOD: u1 = 0,
        /// SDIOEN [11:11]
        /// SDIOEN
        SDIOEN: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// SDIO data control register
    pub const DCTRL: *volatile DCTRL_struct = @ptrFromInt(base_address + 0x2c);

    /// DCOUNT
    pub const DCOUNT_struct = packed struct {
        /// DATACOUNT [0:24]
        /// Data count value
        DATACOUNT: u25 = 0,
        /// unused [25:31]
        _unused25: u7 = 0,
    };
    /// Bits 24:0 = DATACOUNT: Data count
    pub const DCOUNT: *volatile DCOUNT_struct = @ptrFromInt(base_address + 0x30);

    /// STA
    pub const STA_struct = packed struct {
        /// CCRCFAIL [0:0]
        /// CCRCFAIL
        CCRCFAIL: u1 = 0,
        /// DCRCFAIL [1:1]
        /// DCRCFAIL
        DCRCFAIL: u1 = 0,
        /// CTIMEOUT [2:2]
        /// CTIMEOUT
        CTIMEOUT: u1 = 0,
        /// DTIMEOUT [3:3]
        /// DTIMEOUT
        DTIMEOUT: u1 = 0,
        /// TXUNDERR [4:4]
        /// TXUNDERR
        TXUNDERR: u1 = 0,
        /// RXOVERR [5:5]
        /// RXOVERR
        RXOVERR: u1 = 0,
        /// CMDREND [6:6]
        /// CMDREND
        CMDREND: u1 = 0,
        /// CMDSENT [7:7]
        /// CMDSENT
        CMDSENT: u1 = 0,
        /// DATAEND [8:8]
        /// DATAEND
        DATAEND: u1 = 0,
        /// STBITERR [9:9]
        /// STBITERR
        STBITERR: u1 = 0,
        /// DBCKEND [10:10]
        /// DBCKEND
        DBCKEND: u1 = 0,
        /// CMDACT [11:11]
        /// CMDACT
        CMDACT: u1 = 0,
        /// TXACT [12:12]
        /// TXACT
        TXACT: u1 = 0,
        /// RXACT [13:13]
        /// RXACT
        RXACT: u1 = 0,
        /// TXFIFOHE [14:14]
        /// TXFIFOHE
        TXFIFOHE: u1 = 0,
        /// RXFIFOHF [15:15]
        /// RXFIFOHF
        RXFIFOHF: u1 = 0,
        /// TXFIFOF [16:16]
        /// TXFIFOF
        TXFIFOF: u1 = 0,
        /// RXFIFOF [17:17]
        /// RXFIFOF
        RXFIFOF: u1 = 0,
        /// TXFIFOE [18:18]
        /// TXFIFOE
        TXFIFOE: u1 = 0,
        /// RXFIFOE [19:19]
        /// RXFIFOE
        RXFIFOE: u1 = 0,
        /// TXDAVL [20:20]
        /// TXDAVL
        TXDAVL: u1 = 0,
        /// RXDAVL [21:21]
        /// RXDAVL
        RXDAVL: u1 = 0,
        /// SDIOIT [22:22]
        /// SDIOIT
        SDIOIT: u1 = 0,
        /// CEATAEND [23:23]
        /// CEATAEND
        CEATAEND: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// SDIO status register
    pub const STA: *volatile STA_struct = @ptrFromInt(base_address + 0x34);

    /// ICR
    pub const ICR_struct = packed struct {
        /// CCRCFAILC [0:0]
        /// CCRCFAILC
        CCRCFAILC: u1 = 0,
        /// DCRCFAILC [1:1]
        /// DCRCFAILC
        DCRCFAILC: u1 = 0,
        /// CTIMEOUTC [2:2]
        /// CTIMEOUTC
        CTIMEOUTC: u1 = 0,
        /// DTIMEOUTC [3:3]
        /// DTIMEOUTC
        DTIMEOUTC: u1 = 0,
        /// TXUNDERRC [4:4]
        /// TXUNDERRC
        TXUNDERRC: u1 = 0,
        /// RXOVERRC [5:5]
        /// RXOVERRC
        RXOVERRC: u1 = 0,
        /// CMDRENDC [6:6]
        /// CMDRENDC
        CMDRENDC: u1 = 0,
        /// CMDSENTC [7:7]
        /// CMDSENTC
        CMDSENTC: u1 = 0,
        /// DATAENDC [8:8]
        /// DATAENDC
        DATAENDC: u1 = 0,
        /// STBITERRC [9:9]
        /// STBITERRC
        STBITERRC: u1 = 0,
        /// DBCKENDC [10:10]
        /// DBCKENDC
        DBCKENDC: u1 = 0,
        /// unused [11:21]
        _unused11: u5 = 0,
        _unused16: u6 = 0,
        /// SDIOITC [22:22]
        /// SDIOITC
        SDIOITC: u1 = 0,
        /// CEATAENDC [23:23]
        /// CEATAENDC
        CEATAENDC: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// SDIO interrupt clear register
    pub const ICR: *volatile ICR_struct = @ptrFromInt(base_address + 0x38);

    /// MASK
    pub const MASK_struct = packed struct {
        /// CCRCFAILIE [0:0]
        /// CCRCFAILIE
        CCRCFAILIE: u1 = 0,
        /// DCRCFAILIE [1:1]
        /// DCRCFAILIE
        DCRCFAILIE: u1 = 0,
        /// CTIMEOUTIE [2:2]
        /// CTIMEOUTIE
        CTIMEOUTIE: u1 = 0,
        /// DTIMEOUTIE [3:3]
        /// DTIMEOUTIE
        DTIMEOUTIE: u1 = 0,
        /// TXUNDERRIE [4:4]
        /// TXUNDERRIE
        TXUNDERRIE: u1 = 0,
        /// RXOVERRIE [5:5]
        /// RXOVERRIE
        RXOVERRIE: u1 = 0,
        /// CMDRENDIE [6:6]
        /// CMDRENDIE
        CMDRENDIE: u1 = 0,
        /// CMDSENTIE [7:7]
        /// CMDSENTIE
        CMDSENTIE: u1 = 0,
        /// DATAENDIE [8:8]
        /// DATAENDIE
        DATAENDIE: u1 = 0,
        /// STBITERRIE [9:9]
        /// STBITERRIE
        STBITERRIE: u1 = 0,
        /// DBACKENDIE [10:10]
        /// DBACKENDIE
        DBACKENDIE: u1 = 0,
        /// CMDACTIE [11:11]
        /// CMDACTIE
        CMDACTIE: u1 = 0,
        /// TXACTIE [12:12]
        /// TXACTIE
        TXACTIE: u1 = 0,
        /// RXACTIE [13:13]
        /// RXACTIE
        RXACTIE: u1 = 0,
        /// TXFIFOHEIE [14:14]
        /// TXFIFOHEIE
        TXFIFOHEIE: u1 = 0,
        /// RXFIFOHFIE [15:15]
        /// RXFIFOHFIE
        RXFIFOHFIE: u1 = 0,
        /// TXFIFOFIE [16:16]
        /// TXFIFOFIE
        TXFIFOFIE: u1 = 0,
        /// RXFIFOFIE [17:17]
        /// RXFIFOFIE
        RXFIFOFIE: u1 = 0,
        /// TXFIFOEIE [18:18]
        /// TXFIFOEIE
        TXFIFOEIE: u1 = 0,
        /// RXFIFOEIE [19:19]
        /// RXFIFOEIE
        RXFIFOEIE: u1 = 0,
        /// TXDAVLIE [20:20]
        /// TXDAVLIE
        TXDAVLIE: u1 = 0,
        /// RXDAVLIE [21:21]
        /// RXDAVLIE
        RXDAVLIE: u1 = 0,
        /// SDIOITIE [22:22]
        /// SDIOITIE
        SDIOITIE: u1 = 0,
        /// CEATENDIE [23:23]
        /// CEATENDIE
        CEATENDIE: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// SDIO mask register (SDIO_MASK)
    pub const MASK: *volatile MASK_struct = @ptrFromInt(base_address + 0x3c);

    /// FIFOCNT
    pub const FIFOCNT_struct = packed struct {
        /// FIF0COUNT [0:23]
        /// FIF0COUNT
        FIF0COUNT: u24 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// Bits 23:0 = FIFOCOUNT: Remaining number of
    pub const FIFOCNT: *volatile FIFOCNT_struct = @ptrFromInt(base_address + 0x48);

    /// FIFO
    pub const FIFO_struct = packed struct {
        /// FIFOData [0:31]
        /// FIFOData
        FIFOData: u32 = 0,
    };
    /// bits 31:0 = FIFOData: Receive and transmit
    pub const FIFO: *volatile FIFO_struct = @ptrFromInt(base_address + 0x80);
};

/// Real time clock
pub const RTC = struct {
    pub const base_address = 0x40002800;
    /// CRH
    pub const CRH_struct = packed struct {
        /// SECIE [0:0]
        /// Second interrupt Enable
        SECIE: u1 = 0,
        /// ALRIE [1:1]
        /// Alarm interrupt Enable
        ALRIE: u1 = 0,
        /// OWIE [2:2]
        /// Overflow interrupt Enable
        OWIE: u1 = 0,
        /// unused [3:31]
        _unused3: u5 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Control Register High
    pub const CRH: *volatile CRH_struct = @ptrFromInt(base_address + 0x0);

    /// CRL
    pub const CRL_struct = packed struct {
        /// SECF [0:0]
        /// Second Flag
        SECF: u1 = 0,
        /// ALRF [1:1]
        /// Alarm Flag
        ALRF: u1 = 0,
        /// OWF [2:2]
        /// Overflow Flag
        OWF: u1 = 0,
        /// RSF [3:3]
        /// Registers Synchronized
        RSF: u1 = 0,
        /// CNF [4:4]
        /// Configuration Flag
        CNF: u1 = 0,
        /// RTOFF [5:5]
        /// RTC operation OFF
        RTOFF: u1 = 1,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Control Register Low
    pub const CRL: *volatile CRL_struct = @ptrFromInt(base_address + 0x4);

    /// PRLH
    pub const PRLH_struct = packed struct {
        /// PRLH [0:3]
        /// RTC Prescaler Load Register
        PRLH: u4 = 0,
        /// unused [4:31]
        _unused4: u4 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Prescaler Load Register
    pub const PRLH: *volatile PRLH_struct = @ptrFromInt(base_address + 0x8);

    /// PRLL
    pub const PRLL_struct = packed struct {
        /// PRLL [0:15]
        /// RTC Prescaler Divider Register
        PRLL: u16 = 32768,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Prescaler Load Register
    pub const PRLL: *volatile PRLL_struct = @ptrFromInt(base_address + 0xc);

    /// DIVH
    pub const DIVH_struct = packed struct {
        /// DIVH [0:3]
        /// RTC prescaler divider register
        DIVH: u4 = 0,
        /// unused [4:31]
        _unused4: u4 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Prescaler Divider Register
    pub const DIVH: *volatile DIVH_struct = @ptrFromInt(base_address + 0x10);

    /// DIVL
    pub const DIVL_struct = packed struct {
        /// DIVL [0:15]
        /// RTC prescaler divider register
        DIVL: u16 = 32768,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Prescaler Divider Register
    pub const DIVL: *volatile DIVL_struct = @ptrFromInt(base_address + 0x14);

    /// CNTH
    pub const CNTH_struct = packed struct {
        /// CNTH [0:15]
        /// RTC counter register high
        CNTH: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Counter Register High
    pub const CNTH: *volatile CNTH_struct = @ptrFromInt(base_address + 0x18);

    /// CNTL
    pub const CNTL_struct = packed struct {
        /// CNTL [0:15]
        /// RTC counter register Low
        CNTL: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Counter Register Low
    pub const CNTL: *volatile CNTL_struct = @ptrFromInt(base_address + 0x1c);

    /// ALRH
    pub const ALRH_struct = packed struct {
        /// ALRH [0:15]
        /// RTC alarm register high
        ALRH: u16 = 65535,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Alarm Register High
    pub const ALRH: *volatile ALRH_struct = @ptrFromInt(base_address + 0x20);

    /// ALRL
    pub const ALRL_struct = packed struct {
        /// ALRL [0:15]
        /// RTC alarm register low
        ALRL: u16 = 65535,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC Alarm Register Low
    pub const ALRL: *volatile ALRL_struct = @ptrFromInt(base_address + 0x24);
};

/// Backup registers
pub const BKP = struct {
    pub const base_address = 0x40006c00;
    /// DR1
    pub const DR1_struct = packed struct {
        /// D1 [0:15]
        /// Backup data
        D1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR1: *volatile DR1_struct = @ptrFromInt(base_address + 0x0);

    /// DR2
    pub const DR2_struct = packed struct {
        /// D2 [0:15]
        /// Backup data
        D2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR2: *volatile DR2_struct = @ptrFromInt(base_address + 0x4);

    /// DR3
    pub const DR3_struct = packed struct {
        /// D3 [0:15]
        /// Backup data
        D3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR3: *volatile DR3_struct = @ptrFromInt(base_address + 0x8);

    /// DR4
    pub const DR4_struct = packed struct {
        /// D4 [0:15]
        /// Backup data
        D4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR4: *volatile DR4_struct = @ptrFromInt(base_address + 0xc);

    /// DR5
    pub const DR5_struct = packed struct {
        /// D5 [0:15]
        /// Backup data
        D5: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR5: *volatile DR5_struct = @ptrFromInt(base_address + 0x10);

    /// DR6
    pub const DR6_struct = packed struct {
        /// D6 [0:15]
        /// Backup data
        D6: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR6: *volatile DR6_struct = @ptrFromInt(base_address + 0x14);

    /// DR7
    pub const DR7_struct = packed struct {
        /// D7 [0:15]
        /// Backup data
        D7: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR7: *volatile DR7_struct = @ptrFromInt(base_address + 0x18);

    /// DR8
    pub const DR8_struct = packed struct {
        /// D8 [0:15]
        /// Backup data
        D8: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR8: *volatile DR8_struct = @ptrFromInt(base_address + 0x1c);

    /// DR9
    pub const DR9_struct = packed struct {
        /// D9 [0:15]
        /// Backup data
        D9: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR9: *volatile DR9_struct = @ptrFromInt(base_address + 0x20);

    /// DR10
    pub const DR10_struct = packed struct {
        /// D10 [0:15]
        /// Backup data
        D10: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR10: *volatile DR10_struct = @ptrFromInt(base_address + 0x24);

    /// DR11
    pub const DR11_struct = packed struct {
        /// DR11 [0:15]
        /// Backup data
        DR11: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR11: *volatile DR11_struct = @ptrFromInt(base_address + 0x3c);

    /// DR12
    pub const DR12_struct = packed struct {
        /// DR12 [0:15]
        /// Backup data
        DR12: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR12: *volatile DR12_struct = @ptrFromInt(base_address + 0x40);

    /// DR13
    pub const DR13_struct = packed struct {
        /// DR13 [0:15]
        /// Backup data
        DR13: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR13: *volatile DR13_struct = @ptrFromInt(base_address + 0x44);

    /// DR14
    pub const DR14_struct = packed struct {
        /// D14 [0:15]
        /// Backup data
        D14: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR14: *volatile DR14_struct = @ptrFromInt(base_address + 0x48);

    /// DR15
    pub const DR15_struct = packed struct {
        /// D15 [0:15]
        /// Backup data
        D15: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR15: *volatile DR15_struct = @ptrFromInt(base_address + 0x4c);

    /// DR16
    pub const DR16_struct = packed struct {
        /// D16 [0:15]
        /// Backup data
        D16: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR16: *volatile DR16_struct = @ptrFromInt(base_address + 0x50);

    /// DR17
    pub const DR17_struct = packed struct {
        /// D17 [0:15]
        /// Backup data
        D17: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR17: *volatile DR17_struct = @ptrFromInt(base_address + 0x54);

    /// DR18
    pub const DR18_struct = packed struct {
        /// D18 [0:15]
        /// Backup data
        D18: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR18: *volatile DR18_struct = @ptrFromInt(base_address + 0x58);

    /// DR19
    pub const DR19_struct = packed struct {
        /// D19 [0:15]
        /// Backup data
        D19: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR19: *volatile DR19_struct = @ptrFromInt(base_address + 0x5c);

    /// DR20
    pub const DR20_struct = packed struct {
        /// D20 [0:15]
        /// Backup data
        D20: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR20: *volatile DR20_struct = @ptrFromInt(base_address + 0x60);

    /// DR21
    pub const DR21_struct = packed struct {
        /// D21 [0:15]
        /// Backup data
        D21: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR21: *volatile DR21_struct = @ptrFromInt(base_address + 0x64);

    /// DR22
    pub const DR22_struct = packed struct {
        /// D22 [0:15]
        /// Backup data
        D22: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR22: *volatile DR22_struct = @ptrFromInt(base_address + 0x68);

    /// DR23
    pub const DR23_struct = packed struct {
        /// D23 [0:15]
        /// Backup data
        D23: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR23: *volatile DR23_struct = @ptrFromInt(base_address + 0x6c);

    /// DR24
    pub const DR24_struct = packed struct {
        /// D24 [0:15]
        /// Backup data
        D24: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR24: *volatile DR24_struct = @ptrFromInt(base_address + 0x70);

    /// DR25
    pub const DR25_struct = packed struct {
        /// D25 [0:15]
        /// Backup data
        D25: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR25: *volatile DR25_struct = @ptrFromInt(base_address + 0x74);

    /// DR26
    pub const DR26_struct = packed struct {
        /// D26 [0:15]
        /// Backup data
        D26: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR26: *volatile DR26_struct = @ptrFromInt(base_address + 0x78);

    /// DR27
    pub const DR27_struct = packed struct {
        /// D27 [0:15]
        /// Backup data
        D27: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR27: *volatile DR27_struct = @ptrFromInt(base_address + 0x7c);

    /// DR28
    pub const DR28_struct = packed struct {
        /// D28 [0:15]
        /// Backup data
        D28: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR28: *volatile DR28_struct = @ptrFromInt(base_address + 0x80);

    /// DR29
    pub const DR29_struct = packed struct {
        /// D29 [0:15]
        /// Backup data
        D29: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR29: *volatile DR29_struct = @ptrFromInt(base_address + 0x84);

    /// DR30
    pub const DR30_struct = packed struct {
        /// D30 [0:15]
        /// Backup data
        D30: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR30: *volatile DR30_struct = @ptrFromInt(base_address + 0x88);

    /// DR31
    pub const DR31_struct = packed struct {
        /// D31 [0:15]
        /// Backup data
        D31: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR31: *volatile DR31_struct = @ptrFromInt(base_address + 0x8c);

    /// DR32
    pub const DR32_struct = packed struct {
        /// D32 [0:15]
        /// Backup data
        D32: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR32: *volatile DR32_struct = @ptrFromInt(base_address + 0x90);

    /// DR33
    pub const DR33_struct = packed struct {
        /// D33 [0:15]
        /// Backup data
        D33: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR33: *volatile DR33_struct = @ptrFromInt(base_address + 0x94);

    /// DR34
    pub const DR34_struct = packed struct {
        /// D34 [0:15]
        /// Backup data
        D34: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR34: *volatile DR34_struct = @ptrFromInt(base_address + 0x98);

    /// DR35
    pub const DR35_struct = packed struct {
        /// D35 [0:15]
        /// Backup data
        D35: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR35: *volatile DR35_struct = @ptrFromInt(base_address + 0x9c);

    /// DR36
    pub const DR36_struct = packed struct {
        /// D36 [0:15]
        /// Backup data
        D36: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR36: *volatile DR36_struct = @ptrFromInt(base_address + 0xa0);

    /// DR37
    pub const DR37_struct = packed struct {
        /// D37 [0:15]
        /// Backup data
        D37: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR37: *volatile DR37_struct = @ptrFromInt(base_address + 0xa4);

    /// DR38
    pub const DR38_struct = packed struct {
        /// D38 [0:15]
        /// Backup data
        D38: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR38: *volatile DR38_struct = @ptrFromInt(base_address + 0xa8);

    /// DR39
    pub const DR39_struct = packed struct {
        /// D39 [0:15]
        /// Backup data
        D39: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR39: *volatile DR39_struct = @ptrFromInt(base_address + 0xac);

    /// DR40
    pub const DR40_struct = packed struct {
        /// D40 [0:15]
        /// Backup data
        D40: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR40: *volatile DR40_struct = @ptrFromInt(base_address + 0xb0);

    /// DR41
    pub const DR41_struct = packed struct {
        /// D41 [0:15]
        /// Backup data
        D41: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR41: *volatile DR41_struct = @ptrFromInt(base_address + 0xb4);

    /// DR42
    pub const DR42_struct = packed struct {
        /// D42 [0:15]
        /// Backup data
        D42: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup data register (BKP_DR)
    pub const DR42: *volatile DR42_struct = @ptrFromInt(base_address + 0xb8);

    /// RTCCR
    pub const RTCCR_struct = packed struct {
        /// CAL [0:6]
        /// Calibration value
        CAL: u7 = 0,
        /// CCO [7:7]
        /// Calibration Clock Output
        CCO: u1 = 0,
        /// ASOE [8:8]
        /// Alarm or second output
        ASOE: u1 = 0,
        /// ASOS [9:9]
        /// Alarm or second output
        ASOS: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RTC clock calibration register
    pub const RTCCR: *volatile RTCCR_struct = @ptrFromInt(base_address + 0x28);

    /// CR
    pub const CR_struct = packed struct {
        /// TPE [0:0]
        /// Tamper pin enable
        TPE: u1 = 0,
        /// TPAL [1:1]
        /// Tamper pin active level
        TPAL: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Backup control register
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x2c);

    /// CSR
    pub const CSR_struct = packed struct {
        /// CTE [0:0]
        /// Clear Tamper event
        CTE: u1 = 0,
        /// CTI [1:1]
        /// Clear Tamper Interrupt
        CTI: u1 = 0,
        /// TPIE [2:2]
        /// Tamper Pin interrupt
        TPIE: u1 = 0,
        /// unused [3:7]
        _unused3: u5 = 0,
        /// TEF [8:8]
        /// Tamper Event Flag
        TEF: u1 = 0,
        /// TIF [9:9]
        /// Tamper Interrupt Flag
        TIF: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// BKP_CSR control/status register
    pub const CSR: *volatile CSR_struct = @ptrFromInt(base_address + 0x30);
};

/// Independent watchdog
pub const IWDG = struct {
    pub const base_address = 0x40003000;
    /// KR
    pub const KR_struct = packed struct {
        /// KEY [0:15]
        /// Key value
        KEY: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Key register (IWDG_KR)
    pub const KR: *volatile KR_struct = @ptrFromInt(base_address + 0x0);

    /// PR
    pub const PR_struct = packed struct {
        /// PR [0:2]
        /// Prescaler divider
        PR: u3 = 0,
        /// unused [3:31]
        _unused3: u5 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Prescaler register (IWDG_PR)
    pub const PR: *volatile PR_struct = @ptrFromInt(base_address + 0x4);

    /// RLR
    pub const RLR_struct = packed struct {
        /// RL [0:11]
        /// Watchdog counter reload
        RL: u12 = 4095,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Reload register (IWDG_RLR)
    pub const RLR: *volatile RLR_struct = @ptrFromInt(base_address + 0x8);

    /// SR
    pub const SR_struct = packed struct {
        /// PVU [0:0]
        /// Watchdog prescaler value
        PVU: u1 = 0,
        /// RVU [1:1]
        /// Watchdog counter reload value
        RVU: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register (IWDG_SR)
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0xc);
};

/// Window watchdog
pub const WWDG = struct {
    pub const base_address = 0x40002c00;
    /// CR
    pub const CR_struct = packed struct {
        /// T [0:6]
        /// 7-bit counter (MSB to LSB)
        T: u7 = 127,
        /// WDGA [7:7]
        /// Activation bit
        WDGA: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register (WWDG_CR)
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x0);

    /// CFR
    pub const CFR_struct = packed struct {
        /// W [0:6]
        /// 7-bit window value
        W: u7 = 127,
        /// WDGTB [7:8]
        /// Timer Base
        WDGTB: u2 = 0,
        /// EWI [9:9]
        /// Early Wakeup Interrupt
        EWI: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Configuration register
    pub const CFR: *volatile CFR_struct = @ptrFromInt(base_address + 0x4);

    /// SR
    pub const SR_struct = packed struct {
        /// EWI [0:0]
        /// Early Wakeup Interrupt
        EWI: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register (WWDG_SR)
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x8);
};

/// Advanced timer
pub const TIM1 = struct {
    pub const base_address = 0x40012c00;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// DIR [4:4]
        /// Direction
        DIR: u1 = 0,
        /// CMS [5:6]
        /// Center-aligned mode
        CMS: u2 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// CCPC [0:0]
        /// Capture/compare preloaded
        CCPC: u1 = 0,
        /// unused [1:1]
        _unused1: u1 = 0,
        /// CCUS [2:2]
        /// Capture/compare control update
        CCUS: u1 = 0,
        /// CCDS [3:3]
        /// Capture/compare DMA
        CCDS: u1 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1S [7:7]
        /// TI1 selection
        TI1S: u1 = 0,
        /// OIS1 [8:8]
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// OIS1N [9:9]
        /// Output Idle state 1
        OIS1N: u1 = 0,
        /// OIS2 [10:10]
        /// Output Idle state 2
        OIS2: u1 = 0,
        /// OIS2N [11:11]
        /// Output Idle state 2
        OIS2N: u1 = 0,
        /// OIS3 [12:12]
        /// Output Idle state 3
        OIS3: u1 = 0,
        /// OIS3N [13:13]
        /// Output Idle state 3
        OIS3N: u1 = 0,
        /// OIS4 [14:14]
        /// Output Idle state 4
        OIS4: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// ETF [8:11]
        /// External trigger filter
        ETF: u4 = 0,
        /// ETPS [12:13]
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// ECE [14:14]
        /// External clock enable
        ECE: u1 = 0,
        /// ETP [15:15]
        /// External trigger polarity
        ETP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// CC3IE [3:3]
        /// Capture/Compare 3 interrupt
        CC3IE: u1 = 0,
        /// CC4IE [4:4]
        /// Capture/Compare 4 interrupt
        CC4IE: u1 = 0,
        /// COMIE [5:5]
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// BIE [7:7]
        /// Break interrupt enable
        BIE: u1 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// CC1DE [9:9]
        /// Capture/Compare 1 DMA request
        CC1DE: u1 = 0,
        /// CC2DE [10:10]
        /// Capture/Compare 2 DMA request
        CC2DE: u1 = 0,
        /// CC3DE [11:11]
        /// Capture/Compare 3 DMA request
        CC3DE: u1 = 0,
        /// CC4DE [12:12]
        /// Capture/Compare 4 DMA request
        CC4DE: u1 = 0,
        /// COMDE [13:13]
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// TDE [14:14]
        /// Trigger DMA request enable
        TDE: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// CC3IF [3:3]
        /// Capture/Compare 3 interrupt
        CC3IF: u1 = 0,
        /// CC4IF [4:4]
        /// Capture/Compare 4 interrupt
        CC4IF: u1 = 0,
        /// COMIF [5:5]
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// BIF [7:7]
        /// Break interrupt flag
        BIF: u1 = 0,
        /// unused [8:8]
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// CC3OF [11:11]
        /// Capture/Compare 3 overcapture
        CC3OF: u1 = 0,
        /// CC4OF [12:12]
        /// Capture/Compare 4 overcapture
        CC4OF: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// CC3G [3:3]
        /// Capture/compare 3
        CC3G: u1 = 0,
        /// CC4G [4:4]
        /// Capture/compare 4
        CC4G: u1 = 0,
        /// COMG [5:5]
        /// Capture/Compare control update
        COMG: u1 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// BG [7:7]
        /// Break generation
        BG: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output Compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// OC1CE [7:7]
        /// Output Compare 1 clear
        OC1CE: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output Compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output Compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// OC2CE [15:15]
        /// Output Compare 2 clear
        OC2CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// ICPCS [2:3]
        /// Input capture 1 prescaler
        ICPCS: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// IC2PCS [10:11]
        /// Input capture 2 prescaler
        IC2PCS: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR2_Output
    pub const CCMR2_Output_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// OC3FE [2:2]
        /// Output compare 3 fast
        OC3FE: u1 = 0,
        /// OC3PE [3:3]
        /// Output compare 3 preload
        OC3PE: u1 = 0,
        /// OC3M [4:6]
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// OC3CE [7:7]
        /// Output compare 3 clear
        OC3CE: u1 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// OC4FE [10:10]
        /// Output compare 4 fast
        OC4FE: u1 = 0,
        /// OC4PE [11:11]
        /// Output compare 4 preload
        OC4PE: u1 = 0,
        /// OC4M [12:14]
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// OC4CE [15:15]
        /// Output compare 4 clear
        OC4CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR2_Output: *volatile CCMR2_Output_struct = @ptrFromInt(base_address + 0x1c);

    /// CCMR2_Input
    pub const CCMR2_Input_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/compare 3
        CC3S: u2 = 0,
        /// IC3PSC [2:3]
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// IC3F [4:7]
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// IC4PSC [10:11]
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// IC4F [12:15]
        /// Input capture 4 filter
        IC4F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (input
    pub const CCMR2_Input: *volatile CCMR2_Input_struct = @ptrFromInt(base_address + 0x1c);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// CC1NE [2:2]
        /// Capture/Compare 1 complementary output
        CC1NE: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// CC2NE [6:6]
        /// Capture/Compare 2 complementary output
        CC2NE: u1 = 0,
        /// CC2NP [7:7]
        /// Capture/Compare 2 output
        CC2NP: u1 = 0,
        /// CC3E [8:8]
        /// Capture/Compare 3 output
        CC3E: u1 = 0,
        /// CC3P [9:9]
        /// Capture/Compare 3 output
        CC3P: u1 = 0,
        /// CC3NE [10:10]
        /// Capture/Compare 3 complementary output
        CC3NE: u1 = 0,
        /// CC3NP [11:11]
        /// Capture/Compare 3 output
        CC3NP: u1 = 0,
        /// CC4E [12:12]
        /// Capture/Compare 4 output
        CC4E: u1 = 0,
        /// CC4P [13:13]
        /// Capture/Compare 3 output
        CC4P: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// CCR3 [0:15]
        /// Capture/Compare value
        CCR3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 3
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// CCR4 [0:15]
        /// Capture/Compare value
        CCR4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 4
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x40);

    /// DCR
    pub const DCR_struct = packed struct {
        /// DBA [0:4]
        /// DMA base address
        DBA: u5 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// DBL [8:12]
        /// DMA burst length
        DBL: u5 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA control register
    pub const DCR: *volatile DCR_struct = @ptrFromInt(base_address + 0x48);

    /// DMAR
    pub const DMAR_struct = packed struct {
        /// DMAB [0:15]
        /// DMA register for burst
        DMAB: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA address for full transfer
    pub const DMAR: *volatile DMAR_struct = @ptrFromInt(base_address + 0x4c);

    /// RCR
    pub const RCR_struct = packed struct {
        /// REP [0:7]
        /// Repetition counter value
        REP: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// repetition counter register
    pub const RCR: *volatile RCR_struct = @ptrFromInt(base_address + 0x30);

    /// BDTR
    pub const BDTR_struct = packed struct {
        /// DTG [0:7]
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// LOCK [8:9]
        /// Lock configuration
        LOCK: u2 = 0,
        /// OSSI [10:10]
        /// Off-state selection for Idle
        OSSI: u1 = 0,
        /// OSSR [11:11]
        /// Off-state selection for Run
        OSSR: u1 = 0,
        /// BKE [12:12]
        /// Break enable
        BKE: u1 = 0,
        /// BKP [13:13]
        /// Break polarity
        BKP: u1 = 0,
        /// AOE [14:14]
        /// Automatic output enable
        AOE: u1 = 0,
        /// MOE [15:15]
        /// Main output enable
        MOE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// break and dead-time register
    pub const BDTR: *volatile BDTR_struct = @ptrFromInt(base_address + 0x44);
};

/// Advanced timer
pub const TIM8 = struct {
    pub const base_address = 0x40013400;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// DIR [4:4]
        /// Direction
        DIR: u1 = 0,
        /// CMS [5:6]
        /// Center-aligned mode
        CMS: u2 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// CCPC [0:0]
        /// Capture/compare preloaded
        CCPC: u1 = 0,
        /// unused [1:1]
        _unused1: u1 = 0,
        /// CCUS [2:2]
        /// Capture/compare control update
        CCUS: u1 = 0,
        /// CCDS [3:3]
        /// Capture/compare DMA
        CCDS: u1 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1S [7:7]
        /// TI1 selection
        TI1S: u1 = 0,
        /// OIS1 [8:8]
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// OIS1N [9:9]
        /// Output Idle state 1
        OIS1N: u1 = 0,
        /// OIS2 [10:10]
        /// Output Idle state 2
        OIS2: u1 = 0,
        /// OIS2N [11:11]
        /// Output Idle state 2
        OIS2N: u1 = 0,
        /// OIS3 [12:12]
        /// Output Idle state 3
        OIS3: u1 = 0,
        /// OIS3N [13:13]
        /// Output Idle state 3
        OIS3N: u1 = 0,
        /// OIS4 [14:14]
        /// Output Idle state 4
        OIS4: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// ETF [8:11]
        /// External trigger filter
        ETF: u4 = 0,
        /// ETPS [12:13]
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// ECE [14:14]
        /// External clock enable
        ECE: u1 = 0,
        /// ETP [15:15]
        /// External trigger polarity
        ETP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// CC3IE [3:3]
        /// Capture/Compare 3 interrupt
        CC3IE: u1 = 0,
        /// CC4IE [4:4]
        /// Capture/Compare 4 interrupt
        CC4IE: u1 = 0,
        /// COMIE [5:5]
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// BIE [7:7]
        /// Break interrupt enable
        BIE: u1 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// CC1DE [9:9]
        /// Capture/Compare 1 DMA request
        CC1DE: u1 = 0,
        /// CC2DE [10:10]
        /// Capture/Compare 2 DMA request
        CC2DE: u1 = 0,
        /// CC3DE [11:11]
        /// Capture/Compare 3 DMA request
        CC3DE: u1 = 0,
        /// CC4DE [12:12]
        /// Capture/Compare 4 DMA request
        CC4DE: u1 = 0,
        /// COMDE [13:13]
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// TDE [14:14]
        /// Trigger DMA request enable
        TDE: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// CC3IF [3:3]
        /// Capture/Compare 3 interrupt
        CC3IF: u1 = 0,
        /// CC4IF [4:4]
        /// Capture/Compare 4 interrupt
        CC4IF: u1 = 0,
        /// COMIF [5:5]
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// BIF [7:7]
        /// Break interrupt flag
        BIF: u1 = 0,
        /// unused [8:8]
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// CC3OF [11:11]
        /// Capture/Compare 3 overcapture
        CC3OF: u1 = 0,
        /// CC4OF [12:12]
        /// Capture/Compare 4 overcapture
        CC4OF: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// CC3G [3:3]
        /// Capture/compare 3
        CC3G: u1 = 0,
        /// CC4G [4:4]
        /// Capture/compare 4
        CC4G: u1 = 0,
        /// COMG [5:5]
        /// Capture/Compare control update
        COMG: u1 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// BG [7:7]
        /// Break generation
        BG: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output Compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// OC1CE [7:7]
        /// Output Compare 1 clear
        OC1CE: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output Compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output Compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// OC2CE [15:15]
        /// Output Compare 2 clear
        OC2CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// ICPCS [2:3]
        /// Input capture 1 prescaler
        ICPCS: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// IC2PCS [10:11]
        /// Input capture 2 prescaler
        IC2PCS: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR2_Output
    pub const CCMR2_Output_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// OC3FE [2:2]
        /// Output compare 3 fast
        OC3FE: u1 = 0,
        /// OC3PE [3:3]
        /// Output compare 3 preload
        OC3PE: u1 = 0,
        /// OC3M [4:6]
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// OC3CE [7:7]
        /// Output compare 3 clear
        OC3CE: u1 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// OC4FE [10:10]
        /// Output compare 4 fast
        OC4FE: u1 = 0,
        /// OC4PE [11:11]
        /// Output compare 4 preload
        OC4PE: u1 = 0,
        /// OC4M [12:14]
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// OC4CE [15:15]
        /// Output compare 4 clear
        OC4CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR2_Output: *volatile CCMR2_Output_struct = @ptrFromInt(base_address + 0x1c);

    /// CCMR2_Input
    pub const CCMR2_Input_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/compare 3
        CC3S: u2 = 0,
        /// IC3PSC [2:3]
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// IC3F [4:7]
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// IC4PSC [10:11]
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// IC4F [12:15]
        /// Input capture 4 filter
        IC4F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (input
    pub const CCMR2_Input: *volatile CCMR2_Input_struct = @ptrFromInt(base_address + 0x1c);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// CC1NE [2:2]
        /// Capture/Compare 1 complementary output
        CC1NE: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// CC2NE [6:6]
        /// Capture/Compare 2 complementary output
        CC2NE: u1 = 0,
        /// CC2NP [7:7]
        /// Capture/Compare 2 output
        CC2NP: u1 = 0,
        /// CC3E [8:8]
        /// Capture/Compare 3 output
        CC3E: u1 = 0,
        /// CC3P [9:9]
        /// Capture/Compare 3 output
        CC3P: u1 = 0,
        /// CC3NE [10:10]
        /// Capture/Compare 3 complementary output
        CC3NE: u1 = 0,
        /// CC3NP [11:11]
        /// Capture/Compare 3 output
        CC3NP: u1 = 0,
        /// CC4E [12:12]
        /// Capture/Compare 4 output
        CC4E: u1 = 0,
        /// CC4P [13:13]
        /// Capture/Compare 3 output
        CC4P: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// CCR3 [0:15]
        /// Capture/Compare value
        CCR3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 3
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// CCR4 [0:15]
        /// Capture/Compare value
        CCR4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 4
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x40);

    /// DCR
    pub const DCR_struct = packed struct {
        /// DBA [0:4]
        /// DMA base address
        DBA: u5 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// DBL [8:12]
        /// DMA burst length
        DBL: u5 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA control register
    pub const DCR: *volatile DCR_struct = @ptrFromInt(base_address + 0x48);

    /// DMAR
    pub const DMAR_struct = packed struct {
        /// DMAB [0:15]
        /// DMA register for burst
        DMAB: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA address for full transfer
    pub const DMAR: *volatile DMAR_struct = @ptrFromInt(base_address + 0x4c);

    /// RCR
    pub const RCR_struct = packed struct {
        /// REP [0:7]
        /// Repetition counter value
        REP: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// repetition counter register
    pub const RCR: *volatile RCR_struct = @ptrFromInt(base_address + 0x30);

    /// BDTR
    pub const BDTR_struct = packed struct {
        /// DTG [0:7]
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// LOCK [8:9]
        /// Lock configuration
        LOCK: u2 = 0,
        /// OSSI [10:10]
        /// Off-state selection for Idle
        OSSI: u1 = 0,
        /// OSSR [11:11]
        /// Off-state selection for Run
        OSSR: u1 = 0,
        /// BKE [12:12]
        /// Break enable
        BKE: u1 = 0,
        /// BKP [13:13]
        /// Break polarity
        BKP: u1 = 0,
        /// AOE [14:14]
        /// Automatic output enable
        AOE: u1 = 0,
        /// MOE [15:15]
        /// Main output enable
        MOE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// break and dead-time register
    pub const BDTR: *volatile BDTR_struct = @ptrFromInt(base_address + 0x44);
};

/// General purpose timer
pub const TIM2 = struct {
    pub const base_address = 0x40000000;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// DIR [4:4]
        /// Direction
        DIR: u1 = 0,
        /// CMS [5:6]
        /// Center-aligned mode
        CMS: u2 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// CCDS [3:3]
        /// Capture/compare DMA
        CCDS: u1 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1S [7:7]
        /// TI1 selection
        TI1S: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// ETF [8:11]
        /// External trigger filter
        ETF: u4 = 0,
        /// ETPS [12:13]
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// ECE [14:14]
        /// External clock enable
        ECE: u1 = 0,
        /// ETP [15:15]
        /// External trigger polarity
        ETP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// CC3IE [3:3]
        /// Capture/Compare 3 interrupt
        CC3IE: u1 = 0,
        /// CC4IE [4:4]
        /// Capture/Compare 4 interrupt
        CC4IE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// CC1DE [9:9]
        /// Capture/Compare 1 DMA request
        CC1DE: u1 = 0,
        /// CC2DE [10:10]
        /// Capture/Compare 2 DMA request
        CC2DE: u1 = 0,
        /// CC3DE [11:11]
        /// Capture/Compare 3 DMA request
        CC3DE: u1 = 0,
        /// CC4DE [12:12]
        /// Capture/Compare 4 DMA request
        CC4DE: u1 = 0,
        /// unused [13:13]
        _unused13: u1 = 0,
        /// TDE [14:14]
        /// Trigger DMA request enable
        TDE: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// CC3IF [3:3]
        /// Capture/Compare 3 interrupt
        CC3IF: u1 = 0,
        /// CC4IF [4:4]
        /// Capture/Compare 4 interrupt
        CC4IF: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// CC3OF [11:11]
        /// Capture/Compare 3 overcapture
        CC3OF: u1 = 0,
        /// CC4OF [12:12]
        /// Capture/Compare 4 overcapture
        CC4OF: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// CC3G [3:3]
        /// Capture/compare 3
        CC3G: u1 = 0,
        /// CC4G [4:4]
        /// Capture/compare 4
        CC4G: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// OC1CE [7:7]
        /// Output compare 1 clear
        OC1CE: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// OC2CE [15:15]
        /// Output compare 2 clear
        OC2CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/compare 2
        CC2S: u2 = 0,
        /// IC2PSC [10:11]
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR2_Output
    pub const CCMR2_Output_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// OC3FE [2:2]
        /// Output compare 3 fast
        OC3FE: u1 = 0,
        /// OC3PE [3:3]
        /// Output compare 3 preload
        OC3PE: u1 = 0,
        /// OC3M [4:6]
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// OC3CE [7:7]
        /// Output compare 3 clear
        OC3CE: u1 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// OC4FE [10:10]
        /// Output compare 4 fast
        OC4FE: u1 = 0,
        /// OC4PE [11:11]
        /// Output compare 4 preload
        OC4PE: u1 = 0,
        /// OC4M [12:14]
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// O24CE [15:15]
        /// Output compare 4 clear
        O24CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (output
    pub const CCMR2_Output: *volatile CCMR2_Output_struct = @ptrFromInt(base_address + 0x1c);

    /// CCMR2_Input
    pub const CCMR2_Input_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// IC3PSC [2:3]
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// IC3F [4:7]
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// IC4PSC [10:11]
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// IC4F [12:15]
        /// Input capture 4 filter
        IC4F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (input
    pub const CCMR2_Input: *volatile CCMR2_Input_struct = @ptrFromInt(base_address + 0x1c);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:3]
        _unused2: u2 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// CC3E [8:8]
        /// Capture/Compare 3 output
        CC3E: u1 = 0,
        /// CC3P [9:9]
        /// Capture/Compare 3 output
        CC3P: u1 = 0,
        /// unused [10:11]
        _unused10: u2 = 0,
        /// CC4E [12:12]
        /// Capture/Compare 4 output
        CC4E: u1 = 0,
        /// CC4P [13:13]
        /// Capture/Compare 3 output
        CC4P: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// CCR3 [0:15]
        /// Capture/Compare value
        CCR3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 3
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// CCR4 [0:15]
        /// Capture/Compare value
        CCR4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 4
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x40);

    /// DCR
    pub const DCR_struct = packed struct {
        /// DBA [0:4]
        /// DMA base address
        DBA: u5 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// DBL [8:12]
        /// DMA burst length
        DBL: u5 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA control register
    pub const DCR: *volatile DCR_struct = @ptrFromInt(base_address + 0x48);

    /// DMAR
    pub const DMAR_struct = packed struct {
        /// DMAB [0:15]
        /// DMA register for burst
        DMAB: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA address for full transfer
    pub const DMAR: *volatile DMAR_struct = @ptrFromInt(base_address + 0x4c);
};

/// General purpose timer
pub const TIM3 = struct {
    pub const base_address = 0x40000400;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// DIR [4:4]
        /// Direction
        DIR: u1 = 0,
        /// CMS [5:6]
        /// Center-aligned mode
        CMS: u2 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// CCDS [3:3]
        /// Capture/compare DMA
        CCDS: u1 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1S [7:7]
        /// TI1 selection
        TI1S: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// ETF [8:11]
        /// External trigger filter
        ETF: u4 = 0,
        /// ETPS [12:13]
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// ECE [14:14]
        /// External clock enable
        ECE: u1 = 0,
        /// ETP [15:15]
        /// External trigger polarity
        ETP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// CC3IE [3:3]
        /// Capture/Compare 3 interrupt
        CC3IE: u1 = 0,
        /// CC4IE [4:4]
        /// Capture/Compare 4 interrupt
        CC4IE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// CC1DE [9:9]
        /// Capture/Compare 1 DMA request
        CC1DE: u1 = 0,
        /// CC2DE [10:10]
        /// Capture/Compare 2 DMA request
        CC2DE: u1 = 0,
        /// CC3DE [11:11]
        /// Capture/Compare 3 DMA request
        CC3DE: u1 = 0,
        /// CC4DE [12:12]
        /// Capture/Compare 4 DMA request
        CC4DE: u1 = 0,
        /// unused [13:13]
        _unused13: u1 = 0,
        /// TDE [14:14]
        /// Trigger DMA request enable
        TDE: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// CC3IF [3:3]
        /// Capture/Compare 3 interrupt
        CC3IF: u1 = 0,
        /// CC4IF [4:4]
        /// Capture/Compare 4 interrupt
        CC4IF: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// CC3OF [11:11]
        /// Capture/Compare 3 overcapture
        CC3OF: u1 = 0,
        /// CC4OF [12:12]
        /// Capture/Compare 4 overcapture
        CC4OF: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// CC3G [3:3]
        /// Capture/compare 3
        CC3G: u1 = 0,
        /// CC4G [4:4]
        /// Capture/compare 4
        CC4G: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// OC1CE [7:7]
        /// Output compare 1 clear
        OC1CE: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// OC2CE [15:15]
        /// Output compare 2 clear
        OC2CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/compare 2
        CC2S: u2 = 0,
        /// IC2PSC [10:11]
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR2_Output
    pub const CCMR2_Output_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// OC3FE [2:2]
        /// Output compare 3 fast
        OC3FE: u1 = 0,
        /// OC3PE [3:3]
        /// Output compare 3 preload
        OC3PE: u1 = 0,
        /// OC3M [4:6]
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// OC3CE [7:7]
        /// Output compare 3 clear
        OC3CE: u1 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// OC4FE [10:10]
        /// Output compare 4 fast
        OC4FE: u1 = 0,
        /// OC4PE [11:11]
        /// Output compare 4 preload
        OC4PE: u1 = 0,
        /// OC4M [12:14]
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// O24CE [15:15]
        /// Output compare 4 clear
        O24CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (output
    pub const CCMR2_Output: *volatile CCMR2_Output_struct = @ptrFromInt(base_address + 0x1c);

    /// CCMR2_Input
    pub const CCMR2_Input_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// IC3PSC [2:3]
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// IC3F [4:7]
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// IC4PSC [10:11]
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// IC4F [12:15]
        /// Input capture 4 filter
        IC4F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (input
    pub const CCMR2_Input: *volatile CCMR2_Input_struct = @ptrFromInt(base_address + 0x1c);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:3]
        _unused2: u2 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// CC3E [8:8]
        /// Capture/Compare 3 output
        CC3E: u1 = 0,
        /// CC3P [9:9]
        /// Capture/Compare 3 output
        CC3P: u1 = 0,
        /// unused [10:11]
        _unused10: u2 = 0,
        /// CC4E [12:12]
        /// Capture/Compare 4 output
        CC4E: u1 = 0,
        /// CC4P [13:13]
        /// Capture/Compare 3 output
        CC4P: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// CCR3 [0:15]
        /// Capture/Compare value
        CCR3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 3
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// CCR4 [0:15]
        /// Capture/Compare value
        CCR4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 4
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x40);

    /// DCR
    pub const DCR_struct = packed struct {
        /// DBA [0:4]
        /// DMA base address
        DBA: u5 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// DBL [8:12]
        /// DMA burst length
        DBL: u5 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA control register
    pub const DCR: *volatile DCR_struct = @ptrFromInt(base_address + 0x48);

    /// DMAR
    pub const DMAR_struct = packed struct {
        /// DMAB [0:15]
        /// DMA register for burst
        DMAB: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA address for full transfer
    pub const DMAR: *volatile DMAR_struct = @ptrFromInt(base_address + 0x4c);
};

/// General purpose timer
pub const TIM4 = struct {
    pub const base_address = 0x40000800;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// DIR [4:4]
        /// Direction
        DIR: u1 = 0,
        /// CMS [5:6]
        /// Center-aligned mode
        CMS: u2 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// CCDS [3:3]
        /// Capture/compare DMA
        CCDS: u1 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1S [7:7]
        /// TI1 selection
        TI1S: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// ETF [8:11]
        /// External trigger filter
        ETF: u4 = 0,
        /// ETPS [12:13]
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// ECE [14:14]
        /// External clock enable
        ECE: u1 = 0,
        /// ETP [15:15]
        /// External trigger polarity
        ETP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// CC3IE [3:3]
        /// Capture/Compare 3 interrupt
        CC3IE: u1 = 0,
        /// CC4IE [4:4]
        /// Capture/Compare 4 interrupt
        CC4IE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// CC1DE [9:9]
        /// Capture/Compare 1 DMA request
        CC1DE: u1 = 0,
        /// CC2DE [10:10]
        /// Capture/Compare 2 DMA request
        CC2DE: u1 = 0,
        /// CC3DE [11:11]
        /// Capture/Compare 3 DMA request
        CC3DE: u1 = 0,
        /// CC4DE [12:12]
        /// Capture/Compare 4 DMA request
        CC4DE: u1 = 0,
        /// unused [13:13]
        _unused13: u1 = 0,
        /// TDE [14:14]
        /// Trigger DMA request enable
        TDE: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// CC3IF [3:3]
        /// Capture/Compare 3 interrupt
        CC3IF: u1 = 0,
        /// CC4IF [4:4]
        /// Capture/Compare 4 interrupt
        CC4IF: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// CC3OF [11:11]
        /// Capture/Compare 3 overcapture
        CC3OF: u1 = 0,
        /// CC4OF [12:12]
        /// Capture/Compare 4 overcapture
        CC4OF: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// CC3G [3:3]
        /// Capture/compare 3
        CC3G: u1 = 0,
        /// CC4G [4:4]
        /// Capture/compare 4
        CC4G: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// OC1CE [7:7]
        /// Output compare 1 clear
        OC1CE: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// OC2CE [15:15]
        /// Output compare 2 clear
        OC2CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/compare 2
        CC2S: u2 = 0,
        /// IC2PSC [10:11]
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR2_Output
    pub const CCMR2_Output_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// OC3FE [2:2]
        /// Output compare 3 fast
        OC3FE: u1 = 0,
        /// OC3PE [3:3]
        /// Output compare 3 preload
        OC3PE: u1 = 0,
        /// OC3M [4:6]
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// OC3CE [7:7]
        /// Output compare 3 clear
        OC3CE: u1 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// OC4FE [10:10]
        /// Output compare 4 fast
        OC4FE: u1 = 0,
        /// OC4PE [11:11]
        /// Output compare 4 preload
        OC4PE: u1 = 0,
        /// OC4M [12:14]
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// O24CE [15:15]
        /// Output compare 4 clear
        O24CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (output
    pub const CCMR2_Output: *volatile CCMR2_Output_struct = @ptrFromInt(base_address + 0x1c);

    /// CCMR2_Input
    pub const CCMR2_Input_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// IC3PSC [2:3]
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// IC3F [4:7]
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// IC4PSC [10:11]
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// IC4F [12:15]
        /// Input capture 4 filter
        IC4F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (input
    pub const CCMR2_Input: *volatile CCMR2_Input_struct = @ptrFromInt(base_address + 0x1c);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:3]
        _unused2: u2 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// CC3E [8:8]
        /// Capture/Compare 3 output
        CC3E: u1 = 0,
        /// CC3P [9:9]
        /// Capture/Compare 3 output
        CC3P: u1 = 0,
        /// unused [10:11]
        _unused10: u2 = 0,
        /// CC4E [12:12]
        /// Capture/Compare 4 output
        CC4E: u1 = 0,
        /// CC4P [13:13]
        /// Capture/Compare 3 output
        CC4P: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// CCR3 [0:15]
        /// Capture/Compare value
        CCR3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 3
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// CCR4 [0:15]
        /// Capture/Compare value
        CCR4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 4
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x40);

    /// DCR
    pub const DCR_struct = packed struct {
        /// DBA [0:4]
        /// DMA base address
        DBA: u5 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// DBL [8:12]
        /// DMA burst length
        DBL: u5 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA control register
    pub const DCR: *volatile DCR_struct = @ptrFromInt(base_address + 0x48);

    /// DMAR
    pub const DMAR_struct = packed struct {
        /// DMAB [0:15]
        /// DMA register for burst
        DMAB: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA address for full transfer
    pub const DMAR: *volatile DMAR_struct = @ptrFromInt(base_address + 0x4c);
};

/// General purpose timer
pub const TIM5 = struct {
    pub const base_address = 0x40000c00;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// DIR [4:4]
        /// Direction
        DIR: u1 = 0,
        /// CMS [5:6]
        /// Center-aligned mode
        CMS: u2 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// CCDS [3:3]
        /// Capture/compare DMA
        CCDS: u1 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1S [7:7]
        /// TI1 selection
        TI1S: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// ETF [8:11]
        /// External trigger filter
        ETF: u4 = 0,
        /// ETPS [12:13]
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// ECE [14:14]
        /// External clock enable
        ECE: u1 = 0,
        /// ETP [15:15]
        /// External trigger polarity
        ETP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// CC3IE [3:3]
        /// Capture/Compare 3 interrupt
        CC3IE: u1 = 0,
        /// CC4IE [4:4]
        /// Capture/Compare 4 interrupt
        CC4IE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// CC1DE [9:9]
        /// Capture/Compare 1 DMA request
        CC1DE: u1 = 0,
        /// CC2DE [10:10]
        /// Capture/Compare 2 DMA request
        CC2DE: u1 = 0,
        /// CC3DE [11:11]
        /// Capture/Compare 3 DMA request
        CC3DE: u1 = 0,
        /// CC4DE [12:12]
        /// Capture/Compare 4 DMA request
        CC4DE: u1 = 0,
        /// unused [13:13]
        _unused13: u1 = 0,
        /// TDE [14:14]
        /// Trigger DMA request enable
        TDE: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// CC3IF [3:3]
        /// Capture/Compare 3 interrupt
        CC3IF: u1 = 0,
        /// CC4IF [4:4]
        /// Capture/Compare 4 interrupt
        CC4IF: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// CC3OF [11:11]
        /// Capture/Compare 3 overcapture
        CC3OF: u1 = 0,
        /// CC4OF [12:12]
        /// Capture/Compare 4 overcapture
        CC4OF: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// CC3G [3:3]
        /// Capture/compare 3
        CC3G: u1 = 0,
        /// CC4G [4:4]
        /// Capture/compare 4
        CC4G: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// OC1CE [7:7]
        /// Output compare 1 clear
        OC1CE: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// OC2CE [15:15]
        /// Output compare 2 clear
        OC2CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/compare 2
        CC2S: u2 = 0,
        /// IC2PSC [10:11]
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR2_Output
    pub const CCMR2_Output_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// OC3FE [2:2]
        /// Output compare 3 fast
        OC3FE: u1 = 0,
        /// OC3PE [3:3]
        /// Output compare 3 preload
        OC3PE: u1 = 0,
        /// OC3M [4:6]
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// OC3CE [7:7]
        /// Output compare 3 clear
        OC3CE: u1 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// OC4FE [10:10]
        /// Output compare 4 fast
        OC4FE: u1 = 0,
        /// OC4PE [11:11]
        /// Output compare 4 preload
        OC4PE: u1 = 0,
        /// OC4M [12:14]
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// O24CE [15:15]
        /// Output compare 4 clear
        O24CE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (output
    pub const CCMR2_Output: *volatile CCMR2_Output_struct = @ptrFromInt(base_address + 0x1c);

    /// CCMR2_Input
    pub const CCMR2_Input_struct = packed struct {
        /// CC3S [0:1]
        /// Capture/Compare 3
        CC3S: u2 = 0,
        /// IC3PSC [2:3]
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// IC3F [4:7]
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// CC4S [8:9]
        /// Capture/Compare 4
        CC4S: u2 = 0,
        /// IC4PSC [10:11]
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// IC4F [12:15]
        /// Input capture 4 filter
        IC4F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 2 (input
    pub const CCMR2_Input: *volatile CCMR2_Input_struct = @ptrFromInt(base_address + 0x1c);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:3]
        _unused2: u2 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// CC3E [8:8]
        /// Capture/Compare 3 output
        CC3E: u1 = 0,
        /// CC3P [9:9]
        /// Capture/Compare 3 output
        CC3P: u1 = 0,
        /// unused [10:11]
        _unused10: u2 = 0,
        /// CC4E [12:12]
        /// Capture/Compare 4 output
        CC4E: u1 = 0,
        /// CC4P [13:13]
        /// Capture/Compare 3 output
        CC4P: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);

    /// CCR3
    pub const CCR3_struct = packed struct {
        /// CCR3 [0:15]
        /// Capture/Compare value
        CCR3: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 3
    pub const CCR3: *volatile CCR3_struct = @ptrFromInt(base_address + 0x3c);

    /// CCR4
    pub const CCR4_struct = packed struct {
        /// CCR4 [0:15]
        /// Capture/Compare value
        CCR4: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 4
    pub const CCR4: *volatile CCR4_struct = @ptrFromInt(base_address + 0x40);

    /// DCR
    pub const DCR_struct = packed struct {
        /// DBA [0:4]
        /// DMA base address
        DBA: u5 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// DBL [8:12]
        /// DMA burst length
        DBL: u5 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA control register
    pub const DCR: *volatile DCR_struct = @ptrFromInt(base_address + 0x48);

    /// DMAR
    pub const DMAR_struct = packed struct {
        /// DMAB [0:15]
        /// DMA register for burst
        DMAB: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA address for full transfer
    pub const DMAR: *volatile DMAR_struct = @ptrFromInt(base_address + 0x4c);
};

/// General purpose timer
pub const TIM9 = struct {
    pub const base_address = 0x40014c00;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output Compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output Compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output Compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// IC2PSC [10:11]
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// CC2NP [7:7]
        /// Capture/Compare 2 output
        CC2NP: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);
};

/// General purpose timer
pub const TIM12 = struct {
    pub const base_address = 0x40001800;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SMCR
    pub const SMCR_struct = packed struct {
        /// SMS [0:2]
        /// Slave mode selection
        SMS: u3 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// TS [4:6]
        /// Trigger selection
        TS: u3 = 0,
        /// MSM [7:7]
        /// Master/Slave mode
        MSM: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// slave mode control register
    pub const SMCR: *volatile SMCR_struct = @ptrFromInt(base_address + 0x8);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// CC2IE [2:2]
        /// Capture/Compare 2 interrupt
        CC2IE: u1 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// TIE [6:6]
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// CC2IF [2:2]
        /// Capture/Compare 2 interrupt
        CC2IF: u1 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// TIF [6:6]
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// CC2OF [10:10]
        /// Capture/compare 2 overcapture
        CC2OF: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// CC2G [2:2]
        /// Capture/compare 2
        CC2G: u1 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// TG [6:6]
        /// Trigger generation
        TG: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// OC1FE [2:2]
        /// Output Compare 1 fast
        OC1FE: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// OC2FE [10:10]
        /// Output Compare 2 fast
        OC2FE: u1 = 0,
        /// OC2PE [11:11]
        /// Output Compare 2 preload
        OC2PE: u1 = 0,
        /// OC2M [12:14]
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// CC2S [8:9]
        /// Capture/Compare 2
        CC2S: u2 = 0,
        /// IC2PSC [10:11]
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// IC2F [12:15]
        /// Input capture 2 filter
        IC2F: u4 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register 1 (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// CC2E [4:4]
        /// Capture/Compare 2 output
        CC2E: u1 = 0,
        /// CC2P [5:5]
        /// Capture/Compare 2 output
        CC2P: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// CC2NP [7:7]
        /// Capture/Compare 2 output
        CC2NP: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);

    /// CCR2
    pub const CCR2_struct = packed struct {
        /// CCR2 [0:15]
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 2
    pub const CCR2: *volatile CCR2_struct = @ptrFromInt(base_address + 0x38);
};

/// General purpose timer
pub const TIM10 = struct {
    pub const base_address = 0x40015000;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// unused [3:6]
        _unused3: u4 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// unused [2:8]
        _unused2: u6 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// unused [4:31]
        _unused4: u4 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);
};

/// General purpose timer
pub const TIM11 = struct {
    pub const base_address = 0x40015400;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// unused [3:6]
        _unused3: u4 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// unused [2:8]
        _unused2: u6 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// unused [4:31]
        _unused4: u4 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);
};

/// General purpose timer
pub const TIM13 = struct {
    pub const base_address = 0x40001c00;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// unused [3:6]
        _unused3: u4 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// unused [2:8]
        _unused2: u6 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// unused [4:31]
        _unused4: u4 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);
};

/// General purpose timer
pub const TIM14 = struct {
    pub const base_address = 0x40002000;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// unused [3:6]
        _unused3: u4 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// CKD [8:9]
        /// Clock division
        CKD: u2 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// CC1IE [1:1]
        /// Capture/Compare 1 interrupt
        CC1IE: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// CC1IF [1:1]
        /// Capture/compare 1 interrupt
        CC1IF: u1 = 0,
        /// unused [2:8]
        _unused2: u6 = 0,
        _unused8: u1 = 0,
        /// CC1OF [9:9]
        /// Capture/Compare 1 overcapture
        CC1OF: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// CC1G [1:1]
        /// Capture/compare 1
        CC1G: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CCMR1_Output
    pub const CCMR1_Output_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// OC1PE [3:3]
        /// Output Compare 1 preload
        OC1PE: u1 = 0,
        /// OC1M [4:6]
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (output
    pub const CCMR1_Output: *volatile CCMR1_Output_struct = @ptrFromInt(base_address + 0x18);

    /// CCMR1_Input
    pub const CCMR1_Input_struct = packed struct {
        /// CC1S [0:1]
        /// Capture/Compare 1
        CC1S: u2 = 0,
        /// IC1PSC [2:3]
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// IC1F [4:7]
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare mode register (input
    pub const CCMR1_Input: *volatile CCMR1_Input_struct = @ptrFromInt(base_address + 0x18);

    /// CCER
    pub const CCER_struct = packed struct {
        /// CC1E [0:0]
        /// Capture/Compare 1 output
        CC1E: u1 = 0,
        /// CC1P [1:1]
        /// Capture/Compare 1 output
        CC1P: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// CC1NP [3:3]
        /// Capture/Compare 1 output
        CC1NP: u1 = 0,
        /// unused [4:31]
        _unused4: u4 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare enable
    pub const CCER: *volatile CCER_struct = @ptrFromInt(base_address + 0x20);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);

    /// CCR1
    pub const CCR1_struct = packed struct {
        /// CCR1 [0:15]
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// capture/compare register 1
    pub const CCR1: *volatile CCR1_struct = @ptrFromInt(base_address + 0x34);
};

/// Basic timer
pub const TIM6 = struct {
    pub const base_address = 0x40001000;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// unused [1:7]
        _unused1: u7 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// Low counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Low Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);
};

/// Basic timer
pub const TIM7 = struct {
    pub const base_address = 0x40001400;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CEN [0:0]
        /// Counter enable
        CEN: u1 = 0,
        /// UDIS [1:1]
        /// Update disable
        UDIS: u1 = 0,
        /// URS [2:2]
        /// Update request source
        URS: u1 = 0,
        /// OPM [3:3]
        /// One-pulse mode
        OPM: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// ARPE [7:7]
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// MMS [4:6]
        /// Master mode selection
        MMS: u3 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// DIER
    pub const DIER_struct = packed struct {
        /// UIE [0:0]
        /// Update interrupt enable
        UIE: u1 = 0,
        /// unused [1:7]
        _unused1: u7 = 0,
        /// UDE [8:8]
        /// Update DMA request enable
        UDE: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DMA/Interrupt enable register
    pub const DIER: *volatile DIER_struct = @ptrFromInt(base_address + 0xc);

    /// SR
    pub const SR_struct = packed struct {
        /// UIF [0:0]
        /// Update interrupt flag
        UIF: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x10);

    /// EGR
    pub const EGR_struct = packed struct {
        /// UG [0:0]
        /// Update generation
        UG: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// event generation register
    pub const EGR: *volatile EGR_struct = @ptrFromInt(base_address + 0x14);

    /// CNT
    pub const CNT_struct = packed struct {
        /// CNT [0:15]
        /// Low counter value
        CNT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// counter
    pub const CNT: *volatile CNT_struct = @ptrFromInt(base_address + 0x24);

    /// PSC
    pub const PSC_struct = packed struct {
        /// PSC [0:15]
        /// Prescaler value
        PSC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// prescaler
    pub const PSC: *volatile PSC_struct = @ptrFromInt(base_address + 0x28);

    /// ARR
    pub const ARR_struct = packed struct {
        /// ARR [0:15]
        /// Low Auto-reload value
        ARR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// auto-reload register
    pub const ARR: *volatile ARR_struct = @ptrFromInt(base_address + 0x2c);
};

/// Inter integrated circuit
pub const I2C1 = struct {
    pub const base_address = 0x40005400;
    /// CR1
    pub const CR1_struct = packed struct {
        /// PE [0:0]
        /// Peripheral enable
        PE: u1 = 0,
        /// SMBUS [1:1]
        /// SMBus mode
        SMBUS: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// SMBTYPE [3:3]
        /// SMBus type
        SMBTYPE: u1 = 0,
        /// ENARP [4:4]
        /// ARP enable
        ENARP: u1 = 0,
        /// ENPEC [5:5]
        /// PEC enable
        ENPEC: u1 = 0,
        /// ENGC [6:6]
        /// General call enable
        ENGC: u1 = 0,
        /// NOSTRETCH [7:7]
        /// Clock stretching disable (Slave
        NOSTRETCH: u1 = 0,
        /// START [8:8]
        /// Start generation
        START: u1 = 0,
        /// STOP [9:9]
        /// Stop generation
        STOP: u1 = 0,
        /// ACK [10:10]
        /// Acknowledge enable
        ACK: u1 = 0,
        /// POS [11:11]
        /// Acknowledge/PEC Position (for data
        POS: u1 = 0,
        /// PEC [12:12]
        /// Packet error checking
        PEC: u1 = 0,
        /// ALERT [13:13]
        /// SMBus alert
        ALERT: u1 = 0,
        /// unused [14:14]
        _unused14: u1 = 0,
        /// SWRST [15:15]
        /// Software reset
        SWRST: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// FREQ [0:5]
        /// Peripheral clock frequency
        FREQ: u6 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// ITERREN [8:8]
        /// Error interrupt enable
        ITERREN: u1 = 0,
        /// ITEVTEN [9:9]
        /// Event interrupt enable
        ITEVTEN: u1 = 0,
        /// ITBUFEN [10:10]
        /// Buffer interrupt enable
        ITBUFEN: u1 = 0,
        /// DMAEN [11:11]
        /// DMA requests enable
        DMAEN: u1 = 0,
        /// LAST [12:12]
        /// DMA last transfer
        LAST: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// OAR1
    pub const OAR1_struct = packed struct {
        /// ADD0 [0:0]
        /// Interface address
        ADD0: u1 = 0,
        /// ADD7 [1:7]
        /// Interface address
        ADD7: u7 = 0,
        /// ADD10 [8:9]
        /// Interface address
        ADD10: u2 = 0,
        /// unused [10:14]
        _unused10: u5 = 0,
        /// ADDMODE [15:15]
        /// Addressing mode (slave
        ADDMODE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Own address register 1
    pub const OAR1: *volatile OAR1_struct = @ptrFromInt(base_address + 0x8);

    /// OAR2
    pub const OAR2_struct = packed struct {
        /// ENDUAL [0:0]
        /// Dual addressing mode
        ENDUAL: u1 = 0,
        /// ADD2 [1:7]
        /// Interface address
        ADD2: u7 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Own address register 2
    pub const OAR2: *volatile OAR2_struct = @ptrFromInt(base_address + 0xc);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:7]
        /// 8-bit data register
        DR: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x10);

    /// SR1
    pub const SR1_struct = packed struct {
        /// SB [0:0]
        /// Start bit (Master mode)
        SB: u1 = 0,
        /// ADDR [1:1]
        /// Address sent (master mode)/matched
        ADDR: u1 = 0,
        /// BTF [2:2]
        /// Byte transfer finished
        BTF: u1 = 0,
        /// ADD10 [3:3]
        /// 10-bit header sent (Master
        ADD10: u1 = 0,
        /// STOPF [4:4]
        /// Stop detection (slave
        STOPF: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// RxNE [6:6]
        /// Data register not empty
        RxNE: u1 = 0,
        /// TxE [7:7]
        /// Data register empty
        TxE: u1 = 0,
        /// BERR [8:8]
        /// Bus error
        BERR: u1 = 0,
        /// ARLO [9:9]
        /// Arbitration lost (master
        ARLO: u1 = 0,
        /// AF [10:10]
        /// Acknowledge failure
        AF: u1 = 0,
        /// OVR [11:11]
        /// Overrun/Underrun
        OVR: u1 = 0,
        /// PECERR [12:12]
        /// PEC Error in reception
        PECERR: u1 = 0,
        /// unused [13:13]
        _unused13: u1 = 0,
        /// TIMEOUT [14:14]
        /// Timeout or Tlow error
        TIMEOUT: u1 = 0,
        /// SMBALERT [15:15]
        /// SMBus alert
        SMBALERT: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register 1
    pub const SR1: *volatile SR1_struct = @ptrFromInt(base_address + 0x14);

    /// SR2
    pub const SR2_struct = packed struct {
        /// MSL [0:0]
        /// Master/slave
        MSL: u1 = 0,
        /// BUSY [1:1]
        /// Bus busy
        BUSY: u1 = 0,
        /// TRA [2:2]
        /// Transmitter/receiver
        TRA: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// GENCALL [4:4]
        /// General call address (Slave
        GENCALL: u1 = 0,
        /// SMBDEFAULT [5:5]
        /// SMBus device default address (Slave
        SMBDEFAULT: u1 = 0,
        /// SMBHOST [6:6]
        /// SMBus host header (Slave
        SMBHOST: u1 = 0,
        /// DUALF [7:7]
        /// Dual flag (Slave mode)
        DUALF: u1 = 0,
        /// PEC [8:15]
        /// acket error checking
        PEC: u8 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register 2
    pub const SR2: *volatile SR2_struct = @ptrFromInt(base_address + 0x18);

    /// CCR
    pub const CCR_struct = packed struct {
        /// CCR [0:11]
        /// Clock control register in Fast/Standard
        CCR: u12 = 0,
        /// unused [12:13]
        _unused12: u2 = 0,
        /// DUTY [14:14]
        /// Fast mode duty cycle
        DUTY: u1 = 0,
        /// F_S [15:15]
        /// I2C master mode selection
        F_S: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Clock control register
    pub const CCR: *volatile CCR_struct = @ptrFromInt(base_address + 0x1c);

    /// TRISE
    pub const TRISE_struct = packed struct {
        /// TRISE [0:5]
        /// Maximum rise time in Fast/Standard mode
        TRISE: u6 = 2,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// TRISE register
    pub const TRISE: *volatile TRISE_struct = @ptrFromInt(base_address + 0x20);
};

/// Inter integrated circuit
pub const I2C2 = struct {
    pub const base_address = 0x40005800;
    /// CR1
    pub const CR1_struct = packed struct {
        /// PE [0:0]
        /// Peripheral enable
        PE: u1 = 0,
        /// SMBUS [1:1]
        /// SMBus mode
        SMBUS: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// SMBTYPE [3:3]
        /// SMBus type
        SMBTYPE: u1 = 0,
        /// ENARP [4:4]
        /// ARP enable
        ENARP: u1 = 0,
        /// ENPEC [5:5]
        /// PEC enable
        ENPEC: u1 = 0,
        /// ENGC [6:6]
        /// General call enable
        ENGC: u1 = 0,
        /// NOSTRETCH [7:7]
        /// Clock stretching disable (Slave
        NOSTRETCH: u1 = 0,
        /// START [8:8]
        /// Start generation
        START: u1 = 0,
        /// STOP [9:9]
        /// Stop generation
        STOP: u1 = 0,
        /// ACK [10:10]
        /// Acknowledge enable
        ACK: u1 = 0,
        /// POS [11:11]
        /// Acknowledge/PEC Position (for data
        POS: u1 = 0,
        /// PEC [12:12]
        /// Packet error checking
        PEC: u1 = 0,
        /// ALERT [13:13]
        /// SMBus alert
        ALERT: u1 = 0,
        /// unused [14:14]
        _unused14: u1 = 0,
        /// SWRST [15:15]
        /// Software reset
        SWRST: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// FREQ [0:5]
        /// Peripheral clock frequency
        FREQ: u6 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// ITERREN [8:8]
        /// Error interrupt enable
        ITERREN: u1 = 0,
        /// ITEVTEN [9:9]
        /// Event interrupt enable
        ITEVTEN: u1 = 0,
        /// ITBUFEN [10:10]
        /// Buffer interrupt enable
        ITBUFEN: u1 = 0,
        /// DMAEN [11:11]
        /// DMA requests enable
        DMAEN: u1 = 0,
        /// LAST [12:12]
        /// DMA last transfer
        LAST: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// OAR1
    pub const OAR1_struct = packed struct {
        /// ADD0 [0:0]
        /// Interface address
        ADD0: u1 = 0,
        /// ADD7 [1:7]
        /// Interface address
        ADD7: u7 = 0,
        /// ADD10 [8:9]
        /// Interface address
        ADD10: u2 = 0,
        /// unused [10:14]
        _unused10: u5 = 0,
        /// ADDMODE [15:15]
        /// Addressing mode (slave
        ADDMODE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Own address register 1
    pub const OAR1: *volatile OAR1_struct = @ptrFromInt(base_address + 0x8);

    /// OAR2
    pub const OAR2_struct = packed struct {
        /// ENDUAL [0:0]
        /// Dual addressing mode
        ENDUAL: u1 = 0,
        /// ADD2 [1:7]
        /// Interface address
        ADD2: u7 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Own address register 2
    pub const OAR2: *volatile OAR2_struct = @ptrFromInt(base_address + 0xc);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:7]
        /// 8-bit data register
        DR: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x10);

    /// SR1
    pub const SR1_struct = packed struct {
        /// SB [0:0]
        /// Start bit (Master mode)
        SB: u1 = 0,
        /// ADDR [1:1]
        /// Address sent (master mode)/matched
        ADDR: u1 = 0,
        /// BTF [2:2]
        /// Byte transfer finished
        BTF: u1 = 0,
        /// ADD10 [3:3]
        /// 10-bit header sent (Master
        ADD10: u1 = 0,
        /// STOPF [4:4]
        /// Stop detection (slave
        STOPF: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// RxNE [6:6]
        /// Data register not empty
        RxNE: u1 = 0,
        /// TxE [7:7]
        /// Data register empty
        TxE: u1 = 0,
        /// BERR [8:8]
        /// Bus error
        BERR: u1 = 0,
        /// ARLO [9:9]
        /// Arbitration lost (master
        ARLO: u1 = 0,
        /// AF [10:10]
        /// Acknowledge failure
        AF: u1 = 0,
        /// OVR [11:11]
        /// Overrun/Underrun
        OVR: u1 = 0,
        /// PECERR [12:12]
        /// PEC Error in reception
        PECERR: u1 = 0,
        /// unused [13:13]
        _unused13: u1 = 0,
        /// TIMEOUT [14:14]
        /// Timeout or Tlow error
        TIMEOUT: u1 = 0,
        /// SMBALERT [15:15]
        /// SMBus alert
        SMBALERT: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register 1
    pub const SR1: *volatile SR1_struct = @ptrFromInt(base_address + 0x14);

    /// SR2
    pub const SR2_struct = packed struct {
        /// MSL [0:0]
        /// Master/slave
        MSL: u1 = 0,
        /// BUSY [1:1]
        /// Bus busy
        BUSY: u1 = 0,
        /// TRA [2:2]
        /// Transmitter/receiver
        TRA: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// GENCALL [4:4]
        /// General call address (Slave
        GENCALL: u1 = 0,
        /// SMBDEFAULT [5:5]
        /// SMBus device default address (Slave
        SMBDEFAULT: u1 = 0,
        /// SMBHOST [6:6]
        /// SMBus host header (Slave
        SMBHOST: u1 = 0,
        /// DUALF [7:7]
        /// Dual flag (Slave mode)
        DUALF: u1 = 0,
        /// PEC [8:15]
        /// acket error checking
        PEC: u8 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register 2
    pub const SR2: *volatile SR2_struct = @ptrFromInt(base_address + 0x18);

    /// CCR
    pub const CCR_struct = packed struct {
        /// CCR [0:11]
        /// Clock control register in Fast/Standard
        CCR: u12 = 0,
        /// unused [12:13]
        _unused12: u2 = 0,
        /// DUTY [14:14]
        /// Fast mode duty cycle
        DUTY: u1 = 0,
        /// F_S [15:15]
        /// I2C master mode selection
        F_S: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Clock control register
    pub const CCR: *volatile CCR_struct = @ptrFromInt(base_address + 0x1c);

    /// TRISE
    pub const TRISE_struct = packed struct {
        /// TRISE [0:5]
        /// Maximum rise time in Fast/Standard mode
        TRISE: u6 = 2,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// TRISE register
    pub const TRISE: *volatile TRISE_struct = @ptrFromInt(base_address + 0x20);
};

/// Serial peripheral interface
pub const SPI1 = struct {
    pub const base_address = 0x40013000;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CPHA [0:0]
        /// Clock phase
        CPHA: u1 = 0,
        /// CPOL [1:1]
        /// Clock polarity
        CPOL: u1 = 0,
        /// MSTR [2:2]
        /// Master selection
        MSTR: u1 = 0,
        /// BR [3:5]
        /// Baud rate control
        BR: u3 = 0,
        /// SPE [6:6]
        /// SPI enable
        SPE: u1 = 0,
        /// LSBFIRST [7:7]
        /// Frame format
        LSBFIRST: u1 = 0,
        /// SSI [8:8]
        /// Internal slave select
        SSI: u1 = 0,
        /// SSM [9:9]
        /// Software slave management
        SSM: u1 = 0,
        /// RXONLY [10:10]
        /// Receive only
        RXONLY: u1 = 0,
        /// DFF [11:11]
        /// Data frame format
        DFF: u1 = 0,
        /// CRCNEXT [12:12]
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// CRCEN [13:13]
        /// Hardware CRC calculation
        CRCEN: u1 = 0,
        /// BIDIOE [14:14]
        /// Output enable in bidirectional
        BIDIOE: u1 = 0,
        /// BIDIMODE [15:15]
        /// Bidirectional data mode
        BIDIMODE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// RXDMAEN [0:0]
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// TXDMAEN [1:1]
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SSOE [2:2]
        /// SS output enable
        SSOE: u1 = 0,
        /// unused [3:4]
        _unused3: u2 = 0,
        /// ERRIE [5:5]
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RXNEIE [6:6]
        /// RX buffer not empty interrupt
        RXNEIE: u1 = 0,
        /// TXEIE [7:7]
        /// Tx buffer empty interrupt
        TXEIE: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SR
    pub const SR_struct = packed struct {
        /// RXNE [0:0]
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// TXE [1:1]
        /// Transmit buffer empty
        TXE: u1 = 1,
        /// CHSIDE [2:2]
        /// Channel side
        CHSIDE: u1 = 0,
        /// UDR [3:3]
        /// Underrun flag
        UDR: u1 = 0,
        /// CRCERR [4:4]
        /// CRC error flag
        CRCERR: u1 = 0,
        /// MODF [5:5]
        /// Mode fault
        MODF: u1 = 0,
        /// OVR [6:6]
        /// Overrun flag
        OVR: u1 = 0,
        /// BSY [7:7]
        /// Busy flag
        BSY: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x8);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:15]
        /// Data register
        DR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0xc);

    /// CRCPR
    pub const CRCPR_struct = packed struct {
        /// CRCPOLY [0:15]
        /// CRC polynomial register
        CRCPOLY: u16 = 7,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CRC polynomial register
    pub const CRCPR: *volatile CRCPR_struct = @ptrFromInt(base_address + 0x10);

    /// RXCRCR
    pub const RXCRCR_struct = packed struct {
        /// RxCRC [0:15]
        /// Rx CRC register
        RxCRC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RX CRC register
    pub const RXCRCR: *volatile RXCRCR_struct = @ptrFromInt(base_address + 0x14);

    /// TXCRCR
    pub const TXCRCR_struct = packed struct {
        /// TxCRC [0:15]
        /// Tx CRC register
        TxCRC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// TX CRC register
    pub const TXCRCR: *volatile TXCRCR_struct = @ptrFromInt(base_address + 0x18);

    /// I2SCFGR
    pub const I2SCFGR_struct = packed struct {
        /// CHLEN [0:0]
        /// Channel length (number of bits per audio
        CHLEN: u1 = 0,
        /// DATLEN [1:2]
        /// Data length to be
        DATLEN: u2 = 0,
        /// CKPOL [3:3]
        /// Steady state clock
        CKPOL: u1 = 0,
        /// I2SSTD [4:5]
        /// I2S standard selection
        I2SSTD: u2 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// PCMSYNC [7:7]
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2SCFG [8:9]
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2SE [10:10]
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2SMOD [11:11]
        /// I2S mode selection
        I2SMOD: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// I2S configuration register
    pub const I2SCFGR: *volatile I2SCFGR_struct = @ptrFromInt(base_address + 0x1c);

    /// I2SPR
    pub const I2SPR_struct = packed struct {
        /// I2SDIV [0:7]
        /// I2S Linear prescaler
        I2SDIV: u8 = 16,
        /// ODD [8:8]
        /// Odd factor for the
        ODD: u1 = 0,
        /// MCKOE [9:9]
        /// Master clock output enable
        MCKOE: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// I2S prescaler register
    pub const I2SPR: *volatile I2SPR_struct = @ptrFromInt(base_address + 0x20);
};

/// Serial peripheral interface
pub const SPI2 = struct {
    pub const base_address = 0x40003800;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CPHA [0:0]
        /// Clock phase
        CPHA: u1 = 0,
        /// CPOL [1:1]
        /// Clock polarity
        CPOL: u1 = 0,
        /// MSTR [2:2]
        /// Master selection
        MSTR: u1 = 0,
        /// BR [3:5]
        /// Baud rate control
        BR: u3 = 0,
        /// SPE [6:6]
        /// SPI enable
        SPE: u1 = 0,
        /// LSBFIRST [7:7]
        /// Frame format
        LSBFIRST: u1 = 0,
        /// SSI [8:8]
        /// Internal slave select
        SSI: u1 = 0,
        /// SSM [9:9]
        /// Software slave management
        SSM: u1 = 0,
        /// RXONLY [10:10]
        /// Receive only
        RXONLY: u1 = 0,
        /// DFF [11:11]
        /// Data frame format
        DFF: u1 = 0,
        /// CRCNEXT [12:12]
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// CRCEN [13:13]
        /// Hardware CRC calculation
        CRCEN: u1 = 0,
        /// BIDIOE [14:14]
        /// Output enable in bidirectional
        BIDIOE: u1 = 0,
        /// BIDIMODE [15:15]
        /// Bidirectional data mode
        BIDIMODE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// RXDMAEN [0:0]
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// TXDMAEN [1:1]
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SSOE [2:2]
        /// SS output enable
        SSOE: u1 = 0,
        /// unused [3:4]
        _unused3: u2 = 0,
        /// ERRIE [5:5]
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RXNEIE [6:6]
        /// RX buffer not empty interrupt
        RXNEIE: u1 = 0,
        /// TXEIE [7:7]
        /// Tx buffer empty interrupt
        TXEIE: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SR
    pub const SR_struct = packed struct {
        /// RXNE [0:0]
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// TXE [1:1]
        /// Transmit buffer empty
        TXE: u1 = 1,
        /// CHSIDE [2:2]
        /// Channel side
        CHSIDE: u1 = 0,
        /// UDR [3:3]
        /// Underrun flag
        UDR: u1 = 0,
        /// CRCERR [4:4]
        /// CRC error flag
        CRCERR: u1 = 0,
        /// MODF [5:5]
        /// Mode fault
        MODF: u1 = 0,
        /// OVR [6:6]
        /// Overrun flag
        OVR: u1 = 0,
        /// BSY [7:7]
        /// Busy flag
        BSY: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x8);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:15]
        /// Data register
        DR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0xc);

    /// CRCPR
    pub const CRCPR_struct = packed struct {
        /// CRCPOLY [0:15]
        /// CRC polynomial register
        CRCPOLY: u16 = 7,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CRC polynomial register
    pub const CRCPR: *volatile CRCPR_struct = @ptrFromInt(base_address + 0x10);

    /// RXCRCR
    pub const RXCRCR_struct = packed struct {
        /// RxCRC [0:15]
        /// Rx CRC register
        RxCRC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RX CRC register
    pub const RXCRCR: *volatile RXCRCR_struct = @ptrFromInt(base_address + 0x14);

    /// TXCRCR
    pub const TXCRCR_struct = packed struct {
        /// TxCRC [0:15]
        /// Tx CRC register
        TxCRC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// TX CRC register
    pub const TXCRCR: *volatile TXCRCR_struct = @ptrFromInt(base_address + 0x18);

    /// I2SCFGR
    pub const I2SCFGR_struct = packed struct {
        /// CHLEN [0:0]
        /// Channel length (number of bits per audio
        CHLEN: u1 = 0,
        /// DATLEN [1:2]
        /// Data length to be
        DATLEN: u2 = 0,
        /// CKPOL [3:3]
        /// Steady state clock
        CKPOL: u1 = 0,
        /// I2SSTD [4:5]
        /// I2S standard selection
        I2SSTD: u2 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// PCMSYNC [7:7]
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2SCFG [8:9]
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2SE [10:10]
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2SMOD [11:11]
        /// I2S mode selection
        I2SMOD: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// I2S configuration register
    pub const I2SCFGR: *volatile I2SCFGR_struct = @ptrFromInt(base_address + 0x1c);

    /// I2SPR
    pub const I2SPR_struct = packed struct {
        /// I2SDIV [0:7]
        /// I2S Linear prescaler
        I2SDIV: u8 = 16,
        /// ODD [8:8]
        /// Odd factor for the
        ODD: u1 = 0,
        /// MCKOE [9:9]
        /// Master clock output enable
        MCKOE: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// I2S prescaler register
    pub const I2SPR: *volatile I2SPR_struct = @ptrFromInt(base_address + 0x20);
};

/// Serial peripheral interface
pub const SPI3 = struct {
    pub const base_address = 0x40003c00;
    /// CR1
    pub const CR1_struct = packed struct {
        /// CPHA [0:0]
        /// Clock phase
        CPHA: u1 = 0,
        /// CPOL [1:1]
        /// Clock polarity
        CPOL: u1 = 0,
        /// MSTR [2:2]
        /// Master selection
        MSTR: u1 = 0,
        /// BR [3:5]
        /// Baud rate control
        BR: u3 = 0,
        /// SPE [6:6]
        /// SPI enable
        SPE: u1 = 0,
        /// LSBFIRST [7:7]
        /// Frame format
        LSBFIRST: u1 = 0,
        /// SSI [8:8]
        /// Internal slave select
        SSI: u1 = 0,
        /// SSM [9:9]
        /// Software slave management
        SSM: u1 = 0,
        /// RXONLY [10:10]
        /// Receive only
        RXONLY: u1 = 0,
        /// DFF [11:11]
        /// Data frame format
        DFF: u1 = 0,
        /// CRCNEXT [12:12]
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// CRCEN [13:13]
        /// Hardware CRC calculation
        CRCEN: u1 = 0,
        /// BIDIOE [14:14]
        /// Output enable in bidirectional
        BIDIOE: u1 = 0,
        /// BIDIMODE [15:15]
        /// Bidirectional data mode
        BIDIMODE: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x0);

    /// CR2
    pub const CR2_struct = packed struct {
        /// RXDMAEN [0:0]
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// TXDMAEN [1:1]
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SSOE [2:2]
        /// SS output enable
        SSOE: u1 = 0,
        /// unused [3:4]
        _unused3: u2 = 0,
        /// ERRIE [5:5]
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RXNEIE [6:6]
        /// RX buffer not empty interrupt
        RXNEIE: u1 = 0,
        /// TXEIE [7:7]
        /// Tx buffer empty interrupt
        TXEIE: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x4);

    /// SR
    pub const SR_struct = packed struct {
        /// RXNE [0:0]
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// TXE [1:1]
        /// Transmit buffer empty
        TXE: u1 = 1,
        /// CHSIDE [2:2]
        /// Channel side
        CHSIDE: u1 = 0,
        /// UDR [3:3]
        /// Underrun flag
        UDR: u1 = 0,
        /// CRCERR [4:4]
        /// CRC error flag
        CRCERR: u1 = 0,
        /// MODF [5:5]
        /// Mode fault
        MODF: u1 = 0,
        /// OVR [6:6]
        /// Overrun flag
        OVR: u1 = 0,
        /// BSY [7:7]
        /// Busy flag
        BSY: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x8);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:15]
        /// Data register
        DR: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0xc);

    /// CRCPR
    pub const CRCPR_struct = packed struct {
        /// CRCPOLY [0:15]
        /// CRC polynomial register
        CRCPOLY: u16 = 7,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CRC polynomial register
    pub const CRCPR: *volatile CRCPR_struct = @ptrFromInt(base_address + 0x10);

    /// RXCRCR
    pub const RXCRCR_struct = packed struct {
        /// RxCRC [0:15]
        /// Rx CRC register
        RxCRC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// RX CRC register
    pub const RXCRCR: *volatile RXCRCR_struct = @ptrFromInt(base_address + 0x14);

    /// TXCRCR
    pub const TXCRCR_struct = packed struct {
        /// TxCRC [0:15]
        /// Tx CRC register
        TxCRC: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// TX CRC register
    pub const TXCRCR: *volatile TXCRCR_struct = @ptrFromInt(base_address + 0x18);

    /// I2SCFGR
    pub const I2SCFGR_struct = packed struct {
        /// CHLEN [0:0]
        /// Channel length (number of bits per audio
        CHLEN: u1 = 0,
        /// DATLEN [1:2]
        /// Data length to be
        DATLEN: u2 = 0,
        /// CKPOL [3:3]
        /// Steady state clock
        CKPOL: u1 = 0,
        /// I2SSTD [4:5]
        /// I2S standard selection
        I2SSTD: u2 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// PCMSYNC [7:7]
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2SCFG [8:9]
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2SE [10:10]
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2SMOD [11:11]
        /// I2S mode selection
        I2SMOD: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// I2S configuration register
    pub const I2SCFGR: *volatile I2SCFGR_struct = @ptrFromInt(base_address + 0x1c);

    /// I2SPR
    pub const I2SPR_struct = packed struct {
        /// I2SDIV [0:7]
        /// I2S Linear prescaler
        I2SDIV: u8 = 16,
        /// ODD [8:8]
        /// Odd factor for the
        ODD: u1 = 0,
        /// MCKOE [9:9]
        /// Master clock output enable
        MCKOE: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// I2S prescaler register
    pub const I2SPR: *volatile I2SPR_struct = @ptrFromInt(base_address + 0x20);
};

/// Universal synchronous asynchronous receiver
pub const USART1 = struct {
    pub const base_address = 0x40013800;
    /// SR
    pub const SR_struct = packed struct {
        /// PE [0:0]
        /// Parity error
        PE: u1 = 0,
        /// FE [1:1]
        /// Framing error
        FE: u1 = 0,
        /// NE [2:2]
        /// Noise error flag
        NE: u1 = 0,
        /// ORE [3:3]
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE [4:4]
        /// IDLE line detected
        IDLE: u1 = 0,
        /// RXNE [5:5]
        /// Read data register not
        RXNE: u1 = 0,
        /// TC [6:6]
        /// Transmission complete
        TC: u1 = 1,
        /// TXE [7:7]
        /// Transmit data register
        TXE: u1 = 1,
        /// LBD [8:8]
        /// LIN break detection flag
        LBD: u1 = 0,
        /// CTS [9:9]
        /// CTS flag
        CTS: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:8]
        /// Data value
        DR: u9 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4);

    /// BRR
    pub const BRR_struct = packed struct {
        /// DIV_Fraction [0:3]
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// DIV_Mantissa [4:15]
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Baud rate register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x8);

    /// CR1
    pub const CR1_struct = packed struct {
        /// SBK [0:0]
        /// Send break
        SBK: u1 = 0,
        /// RWU [1:1]
        /// Receiver wakeup
        RWU: u1 = 0,
        /// RE [2:2]
        /// Receiver enable
        RE: u1 = 0,
        /// TE [3:3]
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLEIE [4:4]
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNEIE [5:5]
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// TCIE [6:6]
        /// Transmission complete interrupt
        TCIE: u1 = 0,
        /// TXEIE [7:7]
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PEIE [8:8]
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// PS [9:9]
        /// Parity selection
        PS: u1 = 0,
        /// PCE [10:10]
        /// Parity control enable
        PCE: u1 = 0,
        /// WAKE [11:11]
        /// Wakeup method
        WAKE: u1 = 0,
        /// M [12:12]
        /// Word length
        M: u1 = 0,
        /// UE [13:13]
        /// USART enable
        UE: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0xc);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADD [0:3]
        /// Address of the USART node
        ADD: u4 = 0,
        /// unused [4:4]
        _unused4: u1 = 0,
        /// LBDL [5:5]
        /// lin break detection length
        LBDL: u1 = 0,
        /// LBDIE [6:6]
        /// LIN break detection interrupt
        LBDIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// LBCL [8:8]
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// CPHA [9:9]
        /// Clock phase
        CPHA: u1 = 0,
        /// CPOL [10:10]
        /// Clock polarity
        CPOL: u1 = 0,
        /// CLKEN [11:11]
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP [12:13]
        /// STOP bits
        STOP: u2 = 0,
        /// LINEN [14:14]
        /// LIN mode enable
        LINEN: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x10);

    /// CR3
    pub const CR3_struct = packed struct {
        /// EIE [0:0]
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IREN [1:1]
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IRLP [2:2]
        /// IrDA low-power
        IRLP: u1 = 0,
        /// HDSEL [3:3]
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// NACK [4:4]
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// SCEN [5:5]
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMAR [6:6]
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMAT [7:7]
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTSE [8:8]
        /// RTS enable
        RTSE: u1 = 0,
        /// CTSE [9:9]
        /// CTS enable
        CTSE: u1 = 0,
        /// CTSIE [10:10]
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 3
    pub const CR3: *volatile CR3_struct = @ptrFromInt(base_address + 0x14);

    /// GTPR
    pub const GTPR_struct = packed struct {
        /// PSC [0:7]
        /// Prescaler value
        PSC: u8 = 0,
        /// GT [8:15]
        /// Guard time value
        GT: u8 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Guard time and prescaler
    pub const GTPR: *volatile GTPR_struct = @ptrFromInt(base_address + 0x18);
};

/// Universal synchronous asynchronous receiver
pub const USART2 = struct {
    pub const base_address = 0x40004400;
    /// SR
    pub const SR_struct = packed struct {
        /// PE [0:0]
        /// Parity error
        PE: u1 = 0,
        /// FE [1:1]
        /// Framing error
        FE: u1 = 0,
        /// NE [2:2]
        /// Noise error flag
        NE: u1 = 0,
        /// ORE [3:3]
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE [4:4]
        /// IDLE line detected
        IDLE: u1 = 0,
        /// RXNE [5:5]
        /// Read data register not
        RXNE: u1 = 0,
        /// TC [6:6]
        /// Transmission complete
        TC: u1 = 1,
        /// TXE [7:7]
        /// Transmit data register
        TXE: u1 = 1,
        /// LBD [8:8]
        /// LIN break detection flag
        LBD: u1 = 0,
        /// CTS [9:9]
        /// CTS flag
        CTS: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:8]
        /// Data value
        DR: u9 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4);

    /// BRR
    pub const BRR_struct = packed struct {
        /// DIV_Fraction [0:3]
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// DIV_Mantissa [4:15]
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Baud rate register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x8);

    /// CR1
    pub const CR1_struct = packed struct {
        /// SBK [0:0]
        /// Send break
        SBK: u1 = 0,
        /// RWU [1:1]
        /// Receiver wakeup
        RWU: u1 = 0,
        /// RE [2:2]
        /// Receiver enable
        RE: u1 = 0,
        /// TE [3:3]
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLEIE [4:4]
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNEIE [5:5]
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// TCIE [6:6]
        /// Transmission complete interrupt
        TCIE: u1 = 0,
        /// TXEIE [7:7]
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PEIE [8:8]
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// PS [9:9]
        /// Parity selection
        PS: u1 = 0,
        /// PCE [10:10]
        /// Parity control enable
        PCE: u1 = 0,
        /// WAKE [11:11]
        /// Wakeup method
        WAKE: u1 = 0,
        /// M [12:12]
        /// Word length
        M: u1 = 0,
        /// UE [13:13]
        /// USART enable
        UE: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0xc);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADD [0:3]
        /// Address of the USART node
        ADD: u4 = 0,
        /// unused [4:4]
        _unused4: u1 = 0,
        /// LBDL [5:5]
        /// lin break detection length
        LBDL: u1 = 0,
        /// LBDIE [6:6]
        /// LIN break detection interrupt
        LBDIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// LBCL [8:8]
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// CPHA [9:9]
        /// Clock phase
        CPHA: u1 = 0,
        /// CPOL [10:10]
        /// Clock polarity
        CPOL: u1 = 0,
        /// CLKEN [11:11]
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP [12:13]
        /// STOP bits
        STOP: u2 = 0,
        /// LINEN [14:14]
        /// LIN mode enable
        LINEN: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x10);

    /// CR3
    pub const CR3_struct = packed struct {
        /// EIE [0:0]
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IREN [1:1]
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IRLP [2:2]
        /// IrDA low-power
        IRLP: u1 = 0,
        /// HDSEL [3:3]
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// NACK [4:4]
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// SCEN [5:5]
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMAR [6:6]
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMAT [7:7]
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTSE [8:8]
        /// RTS enable
        RTSE: u1 = 0,
        /// CTSE [9:9]
        /// CTS enable
        CTSE: u1 = 0,
        /// CTSIE [10:10]
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 3
    pub const CR3: *volatile CR3_struct = @ptrFromInt(base_address + 0x14);

    /// GTPR
    pub const GTPR_struct = packed struct {
        /// PSC [0:7]
        /// Prescaler value
        PSC: u8 = 0,
        /// GT [8:15]
        /// Guard time value
        GT: u8 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Guard time and prescaler
    pub const GTPR: *volatile GTPR_struct = @ptrFromInt(base_address + 0x18);
};

/// Universal synchronous asynchronous receiver
pub const USART3 = struct {
    pub const base_address = 0x40004800;
    /// SR
    pub const SR_struct = packed struct {
        /// PE [0:0]
        /// Parity error
        PE: u1 = 0,
        /// FE [1:1]
        /// Framing error
        FE: u1 = 0,
        /// NE [2:2]
        /// Noise error flag
        NE: u1 = 0,
        /// ORE [3:3]
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE [4:4]
        /// IDLE line detected
        IDLE: u1 = 0,
        /// RXNE [5:5]
        /// Read data register not
        RXNE: u1 = 0,
        /// TC [6:6]
        /// Transmission complete
        TC: u1 = 1,
        /// TXE [7:7]
        /// Transmit data register
        TXE: u1 = 1,
        /// LBD [8:8]
        /// LIN break detection flag
        LBD: u1 = 0,
        /// CTS [9:9]
        /// CTS flag
        CTS: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:8]
        /// Data value
        DR: u9 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4);

    /// BRR
    pub const BRR_struct = packed struct {
        /// DIV_Fraction [0:3]
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// DIV_Mantissa [4:15]
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Baud rate register
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x8);

    /// CR1
    pub const CR1_struct = packed struct {
        /// SBK [0:0]
        /// Send break
        SBK: u1 = 0,
        /// RWU [1:1]
        /// Receiver wakeup
        RWU: u1 = 0,
        /// RE [2:2]
        /// Receiver enable
        RE: u1 = 0,
        /// TE [3:3]
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLEIE [4:4]
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNEIE [5:5]
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// TCIE [6:6]
        /// Transmission complete interrupt
        TCIE: u1 = 0,
        /// TXEIE [7:7]
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PEIE [8:8]
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// PS [9:9]
        /// Parity selection
        PS: u1 = 0,
        /// PCE [10:10]
        /// Parity control enable
        PCE: u1 = 0,
        /// WAKE [11:11]
        /// Wakeup method
        WAKE: u1 = 0,
        /// M [12:12]
        /// Word length
        M: u1 = 0,
        /// UE [13:13]
        /// USART enable
        UE: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0xc);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADD [0:3]
        /// Address of the USART node
        ADD: u4 = 0,
        /// unused [4:4]
        _unused4: u1 = 0,
        /// LBDL [5:5]
        /// lin break detection length
        LBDL: u1 = 0,
        /// LBDIE [6:6]
        /// LIN break detection interrupt
        LBDIE: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// LBCL [8:8]
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// CPHA [9:9]
        /// Clock phase
        CPHA: u1 = 0,
        /// CPOL [10:10]
        /// Clock polarity
        CPOL: u1 = 0,
        /// CLKEN [11:11]
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP [12:13]
        /// STOP bits
        STOP: u2 = 0,
        /// LINEN [14:14]
        /// LIN mode enable
        LINEN: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x10);

    /// CR3
    pub const CR3_struct = packed struct {
        /// EIE [0:0]
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IREN [1:1]
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IRLP [2:2]
        /// IrDA low-power
        IRLP: u1 = 0,
        /// HDSEL [3:3]
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// NACK [4:4]
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// SCEN [5:5]
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMAR [6:6]
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMAT [7:7]
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTSE [8:8]
        /// RTS enable
        RTSE: u1 = 0,
        /// CTSE [9:9]
        /// CTS enable
        CTSE: u1 = 0,
        /// CTSIE [10:10]
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register 3
    pub const CR3: *volatile CR3_struct = @ptrFromInt(base_address + 0x14);

    /// GTPR
    pub const GTPR_struct = packed struct {
        /// PSC [0:7]
        /// Prescaler value
        PSC: u8 = 0,
        /// GT [8:15]
        /// Guard time value
        GT: u8 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Guard time and prescaler
    pub const GTPR: *volatile GTPR_struct = @ptrFromInt(base_address + 0x18);
};

/// Analog to digital converter
pub const ADC1 = struct {
    pub const base_address = 0x40012400;
    /// SR
    pub const SR_struct = packed struct {
        /// AWD [0:0]
        /// Analog watchdog flag
        AWD: u1 = 0,
        /// EOC [1:1]
        /// Regular channel end of
        EOC: u1 = 0,
        /// JEOC [2:2]
        /// Injected channel end of
        JEOC: u1 = 0,
        /// JSTRT [3:3]
        /// Injected channel start
        JSTRT: u1 = 0,
        /// STRT [4:4]
        /// Regular channel start flag
        STRT: u1 = 0,
        /// unused [5:31]
        _unused5: u3 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// CR1
    pub const CR1_struct = packed struct {
        /// AWDCH [0:4]
        /// Analog watchdog channel select
        AWDCH: u5 = 0,
        /// EOCIE [5:5]
        /// Interrupt enable for EOC
        EOCIE: u1 = 0,
        /// AWDIE [6:6]
        /// Analog watchdog interrupt
        AWDIE: u1 = 0,
        /// JEOCIE [7:7]
        /// Interrupt enable for injected
        JEOCIE: u1 = 0,
        /// SCAN [8:8]
        /// Scan mode
        SCAN: u1 = 0,
        /// AWDSGL [9:9]
        /// Enable the watchdog on a single channel
        AWDSGL: u1 = 0,
        /// JAUTO [10:10]
        /// Automatic injected group
        JAUTO: u1 = 0,
        /// DISCEN [11:11]
        /// Discontinuous mode on regular
        DISCEN: u1 = 0,
        /// JDISCEN [12:12]
        /// Discontinuous mode on injected
        JDISCEN: u1 = 0,
        /// DISCNUM [13:15]
        /// Discontinuous mode channel
        DISCNUM: u3 = 0,
        /// DUALMOD [16:19]
        /// Dual mode selection
        DUALMOD: u4 = 0,
        /// unused [20:21]
        _unused20: u2 = 0,
        /// JAWDEN [22:22]
        /// Analog watchdog enable on injected
        JAWDEN: u1 = 0,
        /// AWDEN [23:23]
        /// Analog watchdog enable on regular
        AWDEN: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x4);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADON [0:0]
        /// A/D converter ON / OFF
        ADON: u1 = 0,
        /// CONT [1:1]
        /// Continuous conversion
        CONT: u1 = 0,
        /// CAL [2:2]
        /// A/D calibration
        CAL: u1 = 0,
        /// RSTCAL [3:3]
        /// Reset calibration
        RSTCAL: u1 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// DMA [8:8]
        /// Direct memory access mode
        DMA: u1 = 0,
        /// unused [9:10]
        _unused9: u2 = 0,
        /// ALIGN [11:11]
        /// Data alignment
        ALIGN: u1 = 0,
        /// JEXTSEL [12:14]
        /// External event select for injected
        JEXTSEL: u3 = 0,
        /// JEXTTRIG [15:15]
        /// External trigger conversion mode for
        JEXTTRIG: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// EXTSEL [17:19]
        /// External event select for regular
        EXTSEL: u3 = 0,
        /// EXTTRIG [20:20]
        /// External trigger conversion mode for
        EXTTRIG: u1 = 0,
        /// JSWSTART [21:21]
        /// Start conversion of injected
        JSWSTART: u1 = 0,
        /// SWSTART [22:22]
        /// Start conversion of regular
        SWSTART: u1 = 0,
        /// TSVREFE [23:23]
        /// Temperature sensor and VREFINT
        TSVREFE: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x8);

    /// SMPR1
    pub const SMPR1_struct = packed struct {
        /// SMP10 [0:2]
        /// Channel 10 sample time
        SMP10: u3 = 0,
        /// SMP11 [3:5]
        /// Channel 11 sample time
        SMP11: u3 = 0,
        /// SMP12 [6:8]
        /// Channel 12 sample time
        SMP12: u3 = 0,
        /// SMP13 [9:11]
        /// Channel 13 sample time
        SMP13: u3 = 0,
        /// SMP14 [12:14]
        /// Channel 14 sample time
        SMP14: u3 = 0,
        /// SMP15 [15:17]
        /// Channel 15 sample time
        SMP15: u3 = 0,
        /// SMP16 [18:20]
        /// Channel 16 sample time
        SMP16: u3 = 0,
        /// SMP17 [21:23]
        /// Channel 17 sample time
        SMP17: u3 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// sample time register 1
    pub const SMPR1: *volatile SMPR1_struct = @ptrFromInt(base_address + 0xc);

    /// SMPR2
    pub const SMPR2_struct = packed struct {
        /// SMP0 [0:2]
        /// Channel 0 sample time
        SMP0: u3 = 0,
        /// SMP1 [3:5]
        /// Channel 1 sample time
        SMP1: u3 = 0,
        /// SMP2 [6:8]
        /// Channel 2 sample time
        SMP2: u3 = 0,
        /// SMP3 [9:11]
        /// Channel 3 sample time
        SMP3: u3 = 0,
        /// SMP4 [12:14]
        /// Channel 4 sample time
        SMP4: u3 = 0,
        /// SMP5 [15:17]
        /// Channel 5 sample time
        SMP5: u3 = 0,
        /// SMP6 [18:20]
        /// Channel 6 sample time
        SMP6: u3 = 0,
        /// SMP7 [21:23]
        /// Channel 7 sample time
        SMP7: u3 = 0,
        /// SMP8 [24:26]
        /// Channel 8 sample time
        SMP8: u3 = 0,
        /// SMP9 [27:29]
        /// Channel 9 sample time
        SMP9: u3 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// sample time register 2
    pub const SMPR2: *volatile SMPR2_struct = @ptrFromInt(base_address + 0x10);

    /// JOFR1
    pub const JOFR1_struct = packed struct {
        /// JOFFSET1 [0:11]
        /// Data offset for injected channel
        JOFFSET1: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR1: *volatile JOFR1_struct = @ptrFromInt(base_address + 0x14);

    /// JOFR2
    pub const JOFR2_struct = packed struct {
        /// JOFFSET2 [0:11]
        /// Data offset for injected channel
        JOFFSET2: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR2: *volatile JOFR2_struct = @ptrFromInt(base_address + 0x18);

    /// JOFR3
    pub const JOFR3_struct = packed struct {
        /// JOFFSET3 [0:11]
        /// Data offset for injected channel
        JOFFSET3: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR3: *volatile JOFR3_struct = @ptrFromInt(base_address + 0x1c);

    /// JOFR4
    pub const JOFR4_struct = packed struct {
        /// JOFFSET4 [0:11]
        /// Data offset for injected channel
        JOFFSET4: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR4: *volatile JOFR4_struct = @ptrFromInt(base_address + 0x20);

    /// HTR
    pub const HTR_struct = packed struct {
        /// HT [0:11]
        /// Analog watchdog higher
        HT: u12 = 4095,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// watchdog higher threshold
    pub const HTR: *volatile HTR_struct = @ptrFromInt(base_address + 0x24);

    /// LTR
    pub const LTR_struct = packed struct {
        /// LT [0:11]
        /// Analog watchdog lower
        LT: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// watchdog lower threshold
    pub const LTR: *volatile LTR_struct = @ptrFromInt(base_address + 0x28);

    /// SQR1
    pub const SQR1_struct = packed struct {
        /// SQ13 [0:4]
        /// 13th conversion in regular
        SQ13: u5 = 0,
        /// SQ14 [5:9]
        /// 14th conversion in regular
        SQ14: u5 = 0,
        /// SQ15 [10:14]
        /// 15th conversion in regular
        SQ15: u5 = 0,
        /// SQ16 [15:19]
        /// 16th conversion in regular
        SQ16: u5 = 0,
        /// L [20:23]
        /// Regular channel sequence
        L: u4 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// regular sequence register 1
    pub const SQR1: *volatile SQR1_struct = @ptrFromInt(base_address + 0x2c);

    /// SQR2
    pub const SQR2_struct = packed struct {
        /// SQ7 [0:4]
        /// 7th conversion in regular
        SQ7: u5 = 0,
        /// SQ8 [5:9]
        /// 8th conversion in regular
        SQ8: u5 = 0,
        /// SQ9 [10:14]
        /// 9th conversion in regular
        SQ9: u5 = 0,
        /// SQ10 [15:19]
        /// 10th conversion in regular
        SQ10: u5 = 0,
        /// SQ11 [20:24]
        /// 11th conversion in regular
        SQ11: u5 = 0,
        /// SQ12 [25:29]
        /// 12th conversion in regular
        SQ12: u5 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// regular sequence register 2
    pub const SQR2: *volatile SQR2_struct = @ptrFromInt(base_address + 0x30);

    /// SQR3
    pub const SQR3_struct = packed struct {
        /// SQ1 [0:4]
        /// 1st conversion in regular
        SQ1: u5 = 0,
        /// SQ2 [5:9]
        /// 2nd conversion in regular
        SQ2: u5 = 0,
        /// SQ3 [10:14]
        /// 3rd conversion in regular
        SQ3: u5 = 0,
        /// SQ4 [15:19]
        /// 4th conversion in regular
        SQ4: u5 = 0,
        /// SQ5 [20:24]
        /// 5th conversion in regular
        SQ5: u5 = 0,
        /// SQ6 [25:29]
        /// 6th conversion in regular
        SQ6: u5 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// regular sequence register 3
    pub const SQR3: *volatile SQR3_struct = @ptrFromInt(base_address + 0x34);

    /// JSQR
    pub const JSQR_struct = packed struct {
        /// JSQ1 [0:4]
        /// 1st conversion in injected
        JSQ1: u5 = 0,
        /// JSQ2 [5:9]
        /// 2nd conversion in injected
        JSQ2: u5 = 0,
        /// JSQ3 [10:14]
        /// 3rd conversion in injected
        JSQ3: u5 = 0,
        /// JSQ4 [15:19]
        /// 4th conversion in injected
        JSQ4: u5 = 0,
        /// JL [20:21]
        /// Injected sequence length
        JL: u2 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// injected sequence register
    pub const JSQR: *volatile JSQR_struct = @ptrFromInt(base_address + 0x38);

    /// JDR1
    pub const JDR1_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR1: *volatile JDR1_struct = @ptrFromInt(base_address + 0x3c);

    /// JDR2
    pub const JDR2_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR2: *volatile JDR2_struct = @ptrFromInt(base_address + 0x40);

    /// JDR3
    pub const JDR3_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR3: *volatile JDR3_struct = @ptrFromInt(base_address + 0x44);

    /// JDR4
    pub const JDR4_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR4: *volatile JDR4_struct = @ptrFromInt(base_address + 0x48);

    /// DR
    pub const DR_struct = packed struct {
        /// DATA [0:15]
        /// Regular data
        DATA: u16 = 0,
        /// ADC2DATA [16:31]
        /// ADC2 data
        ADC2DATA: u16 = 0,
    };
    /// regular data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4c);
};

/// Analog to digital converter
pub const ADC2 = struct {
    pub const base_address = 0x40012800;
    /// SR
    pub const SR_struct = packed struct {
        /// AWD [0:0]
        /// Analog watchdog flag
        AWD: u1 = 0,
        /// EOC [1:1]
        /// Regular channel end of
        EOC: u1 = 0,
        /// JEOC [2:2]
        /// Injected channel end of
        JEOC: u1 = 0,
        /// JSTRT [3:3]
        /// Injected channel start
        JSTRT: u1 = 0,
        /// STRT [4:4]
        /// Regular channel start flag
        STRT: u1 = 0,
        /// unused [5:31]
        _unused5: u3 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// CR1
    pub const CR1_struct = packed struct {
        /// AWDCH [0:4]
        /// Analog watchdog channel select
        AWDCH: u5 = 0,
        /// EOCIE [5:5]
        /// Interrupt enable for EOC
        EOCIE: u1 = 0,
        /// AWDIE [6:6]
        /// Analog watchdog interrupt
        AWDIE: u1 = 0,
        /// JEOCIE [7:7]
        /// Interrupt enable for injected
        JEOCIE: u1 = 0,
        /// SCAN [8:8]
        /// Scan mode
        SCAN: u1 = 0,
        /// AWDSGL [9:9]
        /// Enable the watchdog on a single channel
        AWDSGL: u1 = 0,
        /// JAUTO [10:10]
        /// Automatic injected group
        JAUTO: u1 = 0,
        /// DISCEN [11:11]
        /// Discontinuous mode on regular
        DISCEN: u1 = 0,
        /// JDISCEN [12:12]
        /// Discontinuous mode on injected
        JDISCEN: u1 = 0,
        /// DISCNUM [13:15]
        /// Discontinuous mode channel
        DISCNUM: u3 = 0,
        /// unused [16:21]
        _unused16: u6 = 0,
        /// JAWDEN [22:22]
        /// Analog watchdog enable on injected
        JAWDEN: u1 = 0,
        /// AWDEN [23:23]
        /// Analog watchdog enable on regular
        AWDEN: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x4);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADON [0:0]
        /// A/D converter ON / OFF
        ADON: u1 = 0,
        /// CONT [1:1]
        /// Continuous conversion
        CONT: u1 = 0,
        /// CAL [2:2]
        /// A/D calibration
        CAL: u1 = 0,
        /// RSTCAL [3:3]
        /// Reset calibration
        RSTCAL: u1 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// DMA [8:8]
        /// Direct memory access mode
        DMA: u1 = 0,
        /// unused [9:10]
        _unused9: u2 = 0,
        /// ALIGN [11:11]
        /// Data alignment
        ALIGN: u1 = 0,
        /// JEXTSEL [12:14]
        /// External event select for injected
        JEXTSEL: u3 = 0,
        /// JEXTTRIG [15:15]
        /// External trigger conversion mode for
        JEXTTRIG: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// EXTSEL [17:19]
        /// External event select for regular
        EXTSEL: u3 = 0,
        /// EXTTRIG [20:20]
        /// External trigger conversion mode for
        EXTTRIG: u1 = 0,
        /// JSWSTART [21:21]
        /// Start conversion of injected
        JSWSTART: u1 = 0,
        /// SWSTART [22:22]
        /// Start conversion of regular
        SWSTART: u1 = 0,
        /// TSVREFE [23:23]
        /// Temperature sensor and VREFINT
        TSVREFE: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x8);

    /// SMPR1
    pub const SMPR1_struct = packed struct {
        /// SMP10 [0:2]
        /// Channel 10 sample time
        SMP10: u3 = 0,
        /// SMP11 [3:5]
        /// Channel 11 sample time
        SMP11: u3 = 0,
        /// SMP12 [6:8]
        /// Channel 12 sample time
        SMP12: u3 = 0,
        /// SMP13 [9:11]
        /// Channel 13 sample time
        SMP13: u3 = 0,
        /// SMP14 [12:14]
        /// Channel 14 sample time
        SMP14: u3 = 0,
        /// SMP15 [15:17]
        /// Channel 15 sample time
        SMP15: u3 = 0,
        /// SMP16 [18:20]
        /// Channel 16 sample time
        SMP16: u3 = 0,
        /// SMP17 [21:23]
        /// Channel 17 sample time
        SMP17: u3 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// sample time register 1
    pub const SMPR1: *volatile SMPR1_struct = @ptrFromInt(base_address + 0xc);

    /// SMPR2
    pub const SMPR2_struct = packed struct {
        /// SMP0 [0:2]
        /// Channel 0 sample time
        SMP0: u3 = 0,
        /// SMP1 [3:5]
        /// Channel 1 sample time
        SMP1: u3 = 0,
        /// SMP2 [6:8]
        /// Channel 2 sample time
        SMP2: u3 = 0,
        /// SMP3 [9:11]
        /// Channel 3 sample time
        SMP3: u3 = 0,
        /// SMP4 [12:14]
        /// Channel 4 sample time
        SMP4: u3 = 0,
        /// SMP5 [15:17]
        /// Channel 5 sample time
        SMP5: u3 = 0,
        /// SMP6 [18:20]
        /// Channel 6 sample time
        SMP6: u3 = 0,
        /// SMP7 [21:23]
        /// Channel 7 sample time
        SMP7: u3 = 0,
        /// SMP8 [24:26]
        /// Channel 8 sample time
        SMP8: u3 = 0,
        /// SMP9 [27:29]
        /// Channel 9 sample time
        SMP9: u3 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// sample time register 2
    pub const SMPR2: *volatile SMPR2_struct = @ptrFromInt(base_address + 0x10);

    /// JOFR1
    pub const JOFR1_struct = packed struct {
        /// JOFFSET1 [0:11]
        /// Data offset for injected channel
        JOFFSET1: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR1: *volatile JOFR1_struct = @ptrFromInt(base_address + 0x14);

    /// JOFR2
    pub const JOFR2_struct = packed struct {
        /// JOFFSET2 [0:11]
        /// Data offset for injected channel
        JOFFSET2: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR2: *volatile JOFR2_struct = @ptrFromInt(base_address + 0x18);

    /// JOFR3
    pub const JOFR3_struct = packed struct {
        /// JOFFSET3 [0:11]
        /// Data offset for injected channel
        JOFFSET3: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR3: *volatile JOFR3_struct = @ptrFromInt(base_address + 0x1c);

    /// JOFR4
    pub const JOFR4_struct = packed struct {
        /// JOFFSET4 [0:11]
        /// Data offset for injected channel
        JOFFSET4: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR4: *volatile JOFR4_struct = @ptrFromInt(base_address + 0x20);

    /// HTR
    pub const HTR_struct = packed struct {
        /// HT [0:11]
        /// Analog watchdog higher
        HT: u12 = 4095,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// watchdog higher threshold
    pub const HTR: *volatile HTR_struct = @ptrFromInt(base_address + 0x24);

    /// LTR
    pub const LTR_struct = packed struct {
        /// LT [0:11]
        /// Analog watchdog lower
        LT: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// watchdog lower threshold
    pub const LTR: *volatile LTR_struct = @ptrFromInt(base_address + 0x28);

    /// SQR1
    pub const SQR1_struct = packed struct {
        /// SQ13 [0:4]
        /// 13th conversion in regular
        SQ13: u5 = 0,
        /// SQ14 [5:9]
        /// 14th conversion in regular
        SQ14: u5 = 0,
        /// SQ15 [10:14]
        /// 15th conversion in regular
        SQ15: u5 = 0,
        /// SQ16 [15:19]
        /// 16th conversion in regular
        SQ16: u5 = 0,
        /// L [20:23]
        /// Regular channel sequence
        L: u4 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// regular sequence register 1
    pub const SQR1: *volatile SQR1_struct = @ptrFromInt(base_address + 0x2c);

    /// SQR2
    pub const SQR2_struct = packed struct {
        /// SQ7 [0:4]
        /// 7th conversion in regular
        SQ7: u5 = 0,
        /// SQ8 [5:9]
        /// 8th conversion in regular
        SQ8: u5 = 0,
        /// SQ9 [10:14]
        /// 9th conversion in regular
        SQ9: u5 = 0,
        /// SQ10 [15:19]
        /// 10th conversion in regular
        SQ10: u5 = 0,
        /// SQ11 [20:24]
        /// 11th conversion in regular
        SQ11: u5 = 0,
        /// SQ12 [25:29]
        /// 12th conversion in regular
        SQ12: u5 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// regular sequence register 2
    pub const SQR2: *volatile SQR2_struct = @ptrFromInt(base_address + 0x30);

    /// SQR3
    pub const SQR3_struct = packed struct {
        /// SQ1 [0:4]
        /// 1st conversion in regular
        SQ1: u5 = 0,
        /// SQ2 [5:9]
        /// 2nd conversion in regular
        SQ2: u5 = 0,
        /// SQ3 [10:14]
        /// 3rd conversion in regular
        SQ3: u5 = 0,
        /// SQ4 [15:19]
        /// 4th conversion in regular
        SQ4: u5 = 0,
        /// SQ5 [20:24]
        /// 5th conversion in regular
        SQ5: u5 = 0,
        /// SQ6 [25:29]
        /// 6th conversion in regular
        SQ6: u5 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// regular sequence register 3
    pub const SQR3: *volatile SQR3_struct = @ptrFromInt(base_address + 0x34);

    /// JSQR
    pub const JSQR_struct = packed struct {
        /// JSQ1 [0:4]
        /// 1st conversion in injected
        JSQ1: u5 = 0,
        /// JSQ2 [5:9]
        /// 2nd conversion in injected
        JSQ2: u5 = 0,
        /// JSQ3 [10:14]
        /// 3rd conversion in injected
        JSQ3: u5 = 0,
        /// JSQ4 [15:19]
        /// 4th conversion in injected
        JSQ4: u5 = 0,
        /// JL [20:21]
        /// Injected sequence length
        JL: u2 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// injected sequence register
    pub const JSQR: *volatile JSQR_struct = @ptrFromInt(base_address + 0x38);

    /// JDR1
    pub const JDR1_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR1: *volatile JDR1_struct = @ptrFromInt(base_address + 0x3c);

    /// JDR2
    pub const JDR2_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR2: *volatile JDR2_struct = @ptrFromInt(base_address + 0x40);

    /// JDR3
    pub const JDR3_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR3: *volatile JDR3_struct = @ptrFromInt(base_address + 0x44);

    /// JDR4
    pub const JDR4_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR4: *volatile JDR4_struct = @ptrFromInt(base_address + 0x48);

    /// DR
    pub const DR_struct = packed struct {
        /// DATA [0:15]
        /// Regular data
        DATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// regular data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4c);
};

/// Analog to digital converter
pub const ADC3 = struct {
    pub const base_address = 0x40013c00;
    /// SR
    pub const SR_struct = packed struct {
        /// AWD [0:0]
        /// Analog watchdog flag
        AWD: u1 = 0,
        /// EOC [1:1]
        /// Regular channel end of
        EOC: u1 = 0,
        /// JEOC [2:2]
        /// Injected channel end of
        JEOC: u1 = 0,
        /// JSTRT [3:3]
        /// Injected channel start
        JSTRT: u1 = 0,
        /// STRT [4:4]
        /// Regular channel start flag
        STRT: u1 = 0,
        /// unused [5:31]
        _unused5: u3 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// CR1
    pub const CR1_struct = packed struct {
        /// AWDCH [0:4]
        /// Analog watchdog channel select
        AWDCH: u5 = 0,
        /// EOCIE [5:5]
        /// Interrupt enable for EOC
        EOCIE: u1 = 0,
        /// AWDIE [6:6]
        /// Analog watchdog interrupt
        AWDIE: u1 = 0,
        /// JEOCIE [7:7]
        /// Interrupt enable for injected
        JEOCIE: u1 = 0,
        /// SCAN [8:8]
        /// Scan mode
        SCAN: u1 = 0,
        /// AWDSGL [9:9]
        /// Enable the watchdog on a single channel
        AWDSGL: u1 = 0,
        /// JAUTO [10:10]
        /// Automatic injected group
        JAUTO: u1 = 0,
        /// DISCEN [11:11]
        /// Discontinuous mode on regular
        DISCEN: u1 = 0,
        /// JDISCEN [12:12]
        /// Discontinuous mode on injected
        JDISCEN: u1 = 0,
        /// DISCNUM [13:15]
        /// Discontinuous mode channel
        DISCNUM: u3 = 0,
        /// unused [16:21]
        _unused16: u6 = 0,
        /// JAWDEN [22:22]
        /// Analog watchdog enable on injected
        JAWDEN: u1 = 0,
        /// AWDEN [23:23]
        /// Analog watchdog enable on regular
        AWDEN: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// control register 1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0x4);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADON [0:0]
        /// A/D converter ON / OFF
        ADON: u1 = 0,
        /// CONT [1:1]
        /// Continuous conversion
        CONT: u1 = 0,
        /// CAL [2:2]
        /// A/D calibration
        CAL: u1 = 0,
        /// RSTCAL [3:3]
        /// Reset calibration
        RSTCAL: u1 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// DMA [8:8]
        /// Direct memory access mode
        DMA: u1 = 0,
        /// unused [9:10]
        _unused9: u2 = 0,
        /// ALIGN [11:11]
        /// Data alignment
        ALIGN: u1 = 0,
        /// JEXTSEL [12:14]
        /// External event select for injected
        JEXTSEL: u3 = 0,
        /// JEXTTRIG [15:15]
        /// External trigger conversion mode for
        JEXTTRIG: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// EXTSEL [17:19]
        /// External event select for regular
        EXTSEL: u3 = 0,
        /// EXTTRIG [20:20]
        /// External trigger conversion mode for
        EXTTRIG: u1 = 0,
        /// JSWSTART [21:21]
        /// Start conversion of injected
        JSWSTART: u1 = 0,
        /// SWSTART [22:22]
        /// Start conversion of regular
        SWSTART: u1 = 0,
        /// TSVREFE [23:23]
        /// Temperature sensor and VREFINT
        TSVREFE: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// control register 2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x8);

    /// SMPR1
    pub const SMPR1_struct = packed struct {
        /// SMP10 [0:2]
        /// Channel 10 sample time
        SMP10: u3 = 0,
        /// SMP11 [3:5]
        /// Channel 11 sample time
        SMP11: u3 = 0,
        /// SMP12 [6:8]
        /// Channel 12 sample time
        SMP12: u3 = 0,
        /// SMP13 [9:11]
        /// Channel 13 sample time
        SMP13: u3 = 0,
        /// SMP14 [12:14]
        /// Channel 14 sample time
        SMP14: u3 = 0,
        /// SMP15 [15:17]
        /// Channel 15 sample time
        SMP15: u3 = 0,
        /// SMP16 [18:20]
        /// Channel 16 sample time
        SMP16: u3 = 0,
        /// SMP17 [21:23]
        /// Channel 17 sample time
        SMP17: u3 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// sample time register 1
    pub const SMPR1: *volatile SMPR1_struct = @ptrFromInt(base_address + 0xc);

    /// SMPR2
    pub const SMPR2_struct = packed struct {
        /// SMP0 [0:2]
        /// Channel 0 sample time
        SMP0: u3 = 0,
        /// SMP1 [3:5]
        /// Channel 1 sample time
        SMP1: u3 = 0,
        /// SMP2 [6:8]
        /// Channel 2 sample time
        SMP2: u3 = 0,
        /// SMP3 [9:11]
        /// Channel 3 sample time
        SMP3: u3 = 0,
        /// SMP4 [12:14]
        /// Channel 4 sample time
        SMP4: u3 = 0,
        /// SMP5 [15:17]
        /// Channel 5 sample time
        SMP5: u3 = 0,
        /// SMP6 [18:20]
        /// Channel 6 sample time
        SMP6: u3 = 0,
        /// SMP7 [21:23]
        /// Channel 7 sample time
        SMP7: u3 = 0,
        /// SMP8 [24:26]
        /// Channel 8 sample time
        SMP8: u3 = 0,
        /// SMP9 [27:29]
        /// Channel 9 sample time
        SMP9: u3 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// sample time register 2
    pub const SMPR2: *volatile SMPR2_struct = @ptrFromInt(base_address + 0x10);

    /// JOFR1
    pub const JOFR1_struct = packed struct {
        /// JOFFSET1 [0:11]
        /// Data offset for injected channel
        JOFFSET1: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR1: *volatile JOFR1_struct = @ptrFromInt(base_address + 0x14);

    /// JOFR2
    pub const JOFR2_struct = packed struct {
        /// JOFFSET2 [0:11]
        /// Data offset for injected channel
        JOFFSET2: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR2: *volatile JOFR2_struct = @ptrFromInt(base_address + 0x18);

    /// JOFR3
    pub const JOFR3_struct = packed struct {
        /// JOFFSET3 [0:11]
        /// Data offset for injected channel
        JOFFSET3: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR3: *volatile JOFR3_struct = @ptrFromInt(base_address + 0x1c);

    /// JOFR4
    pub const JOFR4_struct = packed struct {
        /// JOFFSET4 [0:11]
        /// Data offset for injected channel
        JOFFSET4: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected channel data offset register
    pub const JOFR4: *volatile JOFR4_struct = @ptrFromInt(base_address + 0x20);

    /// HTR
    pub const HTR_struct = packed struct {
        /// HT [0:11]
        /// Analog watchdog higher
        HT: u12 = 4095,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// watchdog higher threshold
    pub const HTR: *volatile HTR_struct = @ptrFromInt(base_address + 0x24);

    /// LTR
    pub const LTR_struct = packed struct {
        /// LT [0:11]
        /// Analog watchdog lower
        LT: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// watchdog lower threshold
    pub const LTR: *volatile LTR_struct = @ptrFromInt(base_address + 0x28);

    /// SQR1
    pub const SQR1_struct = packed struct {
        /// SQ13 [0:4]
        /// 13th conversion in regular
        SQ13: u5 = 0,
        /// SQ14 [5:9]
        /// 14th conversion in regular
        SQ14: u5 = 0,
        /// SQ15 [10:14]
        /// 15th conversion in regular
        SQ15: u5 = 0,
        /// SQ16 [15:19]
        /// 16th conversion in regular
        SQ16: u5 = 0,
        /// L [20:23]
        /// Regular channel sequence
        L: u4 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// regular sequence register 1
    pub const SQR1: *volatile SQR1_struct = @ptrFromInt(base_address + 0x2c);

    /// SQR2
    pub const SQR2_struct = packed struct {
        /// SQ7 [0:4]
        /// 7th conversion in regular
        SQ7: u5 = 0,
        /// SQ8 [5:9]
        /// 8th conversion in regular
        SQ8: u5 = 0,
        /// SQ9 [10:14]
        /// 9th conversion in regular
        SQ9: u5 = 0,
        /// SQ10 [15:19]
        /// 10th conversion in regular
        SQ10: u5 = 0,
        /// SQ11 [20:24]
        /// 11th conversion in regular
        SQ11: u5 = 0,
        /// SQ12 [25:29]
        /// 12th conversion in regular
        SQ12: u5 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// regular sequence register 2
    pub const SQR2: *volatile SQR2_struct = @ptrFromInt(base_address + 0x30);

    /// SQR3
    pub const SQR3_struct = packed struct {
        /// SQ1 [0:4]
        /// 1st conversion in regular
        SQ1: u5 = 0,
        /// SQ2 [5:9]
        /// 2nd conversion in regular
        SQ2: u5 = 0,
        /// SQ3 [10:14]
        /// 3rd conversion in regular
        SQ3: u5 = 0,
        /// SQ4 [15:19]
        /// 4th conversion in regular
        SQ4: u5 = 0,
        /// SQ5 [20:24]
        /// 5th conversion in regular
        SQ5: u5 = 0,
        /// SQ6 [25:29]
        /// 6th conversion in regular
        SQ6: u5 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// regular sequence register 3
    pub const SQR3: *volatile SQR3_struct = @ptrFromInt(base_address + 0x34);

    /// JSQR
    pub const JSQR_struct = packed struct {
        /// JSQ1 [0:4]
        /// 1st conversion in injected
        JSQ1: u5 = 0,
        /// JSQ2 [5:9]
        /// 2nd conversion in injected
        JSQ2: u5 = 0,
        /// JSQ3 [10:14]
        /// 3rd conversion in injected
        JSQ3: u5 = 0,
        /// JSQ4 [15:19]
        /// 4th conversion in injected
        JSQ4: u5 = 0,
        /// JL [20:21]
        /// Injected sequence length
        JL: u2 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// injected sequence register
    pub const JSQR: *volatile JSQR_struct = @ptrFromInt(base_address + 0x38);

    /// JDR1
    pub const JDR1_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR1: *volatile JDR1_struct = @ptrFromInt(base_address + 0x3c);

    /// JDR2
    pub const JDR2_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR2: *volatile JDR2_struct = @ptrFromInt(base_address + 0x40);

    /// JDR3
    pub const JDR3_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR3: *volatile JDR3_struct = @ptrFromInt(base_address + 0x44);

    /// JDR4
    pub const JDR4_struct = packed struct {
        /// JDATA [0:15]
        /// Injected data
        JDATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// injected data register x
    pub const JDR4: *volatile JDR4_struct = @ptrFromInt(base_address + 0x48);

    /// DR
    pub const DR_struct = packed struct {
        /// DATA [0:15]
        /// Regular data
        DATA: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// regular data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4c);
};

/// Controller area network
pub const CAN1 = struct {
    pub const base_address = 0x40006400;
    /// CAN_MCR
    pub const CAN_MCR_struct = packed struct {
        /// INRQ [0:0]
        /// INRQ
        INRQ: u1 = 0,
        /// SLEEP [1:1]
        /// SLEEP
        SLEEP: u1 = 0,
        /// TXFP [2:2]
        /// TXFP
        TXFP: u1 = 0,
        /// RFLM [3:3]
        /// RFLM
        RFLM: u1 = 0,
        /// NART [4:4]
        /// NART
        NART: u1 = 0,
        /// AWUM [5:5]
        /// AWUM
        AWUM: u1 = 0,
        /// ABOM [6:6]
        /// ABOM
        ABOM: u1 = 0,
        /// TTCM [7:7]
        /// TTCM
        TTCM: u1 = 0,
        /// unused [8:14]
        _unused8: u7 = 0,
        /// RESET [15:15]
        /// RESET
        RESET: u1 = 0,
        /// DBF [16:16]
        /// DBF
        DBF: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_MCR
    pub const CAN_MCR: *volatile CAN_MCR_struct = @ptrFromInt(base_address + 0x0);

    /// CAN_MSR
    pub const CAN_MSR_struct = packed struct {
        /// INAK [0:0]
        /// INAK
        INAK: u1 = 0,
        /// SLAK [1:1]
        /// SLAK
        SLAK: u1 = 0,
        /// ERRI [2:2]
        /// ERRI
        ERRI: u1 = 0,
        /// WKUI [3:3]
        /// WKUI
        WKUI: u1 = 0,
        /// SLAKI [4:4]
        /// SLAKI
        SLAKI: u1 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// TXM [8:8]
        /// TXM
        TXM: u1 = 0,
        /// RXM [9:9]
        /// RXM
        RXM: u1 = 0,
        /// SAMP [10:10]
        /// SAMP
        SAMP: u1 = 0,
        /// RX [11:11]
        /// RX
        RX: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_MSR
    pub const CAN_MSR: *volatile CAN_MSR_struct = @ptrFromInt(base_address + 0x4);

    /// CAN_TSR
    pub const CAN_TSR_struct = packed struct {
        /// RQCP0 [0:0]
        /// RQCP0
        RQCP0: u1 = 0,
        /// TXOK0 [1:1]
        /// TXOK0
        TXOK0: u1 = 0,
        /// ALST0 [2:2]
        /// ALST0
        ALST0: u1 = 0,
        /// TERR0 [3:3]
        /// TERR0
        TERR0: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// ABRQ0 [7:7]
        /// ABRQ0
        ABRQ0: u1 = 0,
        /// RQCP1 [8:8]
        /// RQCP1
        RQCP1: u1 = 0,
        /// TXOK1 [9:9]
        /// TXOK1
        TXOK1: u1 = 0,
        /// ALST1 [10:10]
        /// ALST1
        ALST1: u1 = 0,
        /// TERR1 [11:11]
        /// TERR1
        TERR1: u1 = 0,
        /// unused [12:14]
        _unused12: u3 = 0,
        /// ABRQ1 [15:15]
        /// ABRQ1
        ABRQ1: u1 = 0,
        /// RQCP2 [16:16]
        /// RQCP2
        RQCP2: u1 = 0,
        /// TXOK2 [17:17]
        /// TXOK2
        TXOK2: u1 = 0,
        /// ALST2 [18:18]
        /// ALST2
        ALST2: u1 = 0,
        /// TERR2 [19:19]
        /// TERR2
        TERR2: u1 = 0,
        /// unused [20:22]
        _unused20: u3 = 0,
        /// ABRQ2 [23:23]
        /// ABRQ2
        ABRQ2: u1 = 0,
        /// CODE [24:25]
        /// CODE
        CODE: u2 = 0,
        /// TME0 [26:26]
        /// Lowest priority flag for mailbox
        TME0: u1 = 0,
        /// TME1 [27:27]
        /// Lowest priority flag for mailbox
        TME1: u1 = 0,
        /// TME2 [28:28]
        /// Lowest priority flag for mailbox
        TME2: u1 = 0,
        /// LOW0 [29:29]
        /// Lowest priority flag for mailbox
        LOW0: u1 = 0,
        /// LOW1 [30:30]
        /// Lowest priority flag for mailbox
        LOW1: u1 = 0,
        /// LOW2 [31:31]
        /// Lowest priority flag for mailbox
        LOW2: u1 = 0,
    };
    /// CAN_TSR
    pub const CAN_TSR: *volatile CAN_TSR_struct = @ptrFromInt(base_address + 0x8);

    /// CAN_RF0R
    pub const CAN_RF0R_struct = packed struct {
        /// FMP0 [0:1]
        /// FMP0
        FMP0: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// FULL0 [3:3]
        /// FULL0
        FULL0: u1 = 0,
        /// FOVR0 [4:4]
        /// FOVR0
        FOVR0: u1 = 0,
        /// RFOM0 [5:5]
        /// RFOM0
        RFOM0: u1 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_RF0R
    pub const CAN_RF0R: *volatile CAN_RF0R_struct = @ptrFromInt(base_address + 0xc);

    /// CAN_RF1R
    pub const CAN_RF1R_struct = packed struct {
        /// FMP1 [0:1]
        /// FMP1
        FMP1: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// FULL1 [3:3]
        /// FULL1
        FULL1: u1 = 0,
        /// FOVR1 [4:4]
        /// FOVR1
        FOVR1: u1 = 0,
        /// RFOM1 [5:5]
        /// RFOM1
        RFOM1: u1 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_RF1R
    pub const CAN_RF1R: *volatile CAN_RF1R_struct = @ptrFromInt(base_address + 0x10);

    /// CAN_IER
    pub const CAN_IER_struct = packed struct {
        /// TMEIE [0:0]
        /// TMEIE
        TMEIE: u1 = 0,
        /// FMPIE0 [1:1]
        /// FMPIE0
        FMPIE0: u1 = 0,
        /// FFIE0 [2:2]
        /// FFIE0
        FFIE0: u1 = 0,
        /// FOVIE0 [3:3]
        /// FOVIE0
        FOVIE0: u1 = 0,
        /// FMPIE1 [4:4]
        /// FMPIE1
        FMPIE1: u1 = 0,
        /// FFIE1 [5:5]
        /// FFIE1
        FFIE1: u1 = 0,
        /// FOVIE1 [6:6]
        /// FOVIE1
        FOVIE1: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// EWGIE [8:8]
        /// EWGIE
        EWGIE: u1 = 0,
        /// EPVIE [9:9]
        /// EPVIE
        EPVIE: u1 = 0,
        /// BOFIE [10:10]
        /// BOFIE
        BOFIE: u1 = 0,
        /// LECIE [11:11]
        /// LECIE
        LECIE: u1 = 0,
        /// unused [12:14]
        _unused12: u3 = 0,
        /// ERRIE [15:15]
        /// ERRIE
        ERRIE: u1 = 0,
        /// WKUIE [16:16]
        /// WKUIE
        WKUIE: u1 = 0,
        /// SLKIE [17:17]
        /// SLKIE
        SLKIE: u1 = 0,
        /// unused [18:31]
        _unused18: u6 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_IER
    pub const CAN_IER: *volatile CAN_IER_struct = @ptrFromInt(base_address + 0x14);

    /// CAN_ESR
    pub const CAN_ESR_struct = packed struct {
        /// EWGF [0:0]
        /// EWGF
        EWGF: u1 = 0,
        /// EPVF [1:1]
        /// EPVF
        EPVF: u1 = 0,
        /// BOFF [2:2]
        /// BOFF
        BOFF: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// LEC [4:6]
        /// LEC
        LEC: u3 = 0,
        /// unused [7:15]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        /// TEC [16:23]
        /// TEC
        TEC: u8 = 0,
        /// REC [24:31]
        /// REC
        REC: u8 = 0,
    };
    /// CAN_ESR
    pub const CAN_ESR: *volatile CAN_ESR_struct = @ptrFromInt(base_address + 0x18);

    /// CAN_BTR
    pub const CAN_BTR_struct = packed struct {
        /// BRP [0:9]
        /// BRP
        BRP: u10 = 0,
        /// unused [10:15]
        _unused10: u6 = 0,
        /// TS1 [16:19]
        /// TS1
        TS1: u4 = 0,
        /// TS2 [20:22]
        /// TS2
        TS2: u3 = 0,
        /// unused [23:23]
        _unused23: u1 = 0,
        /// SJW [24:25]
        /// SJW
        SJW: u2 = 0,
        /// unused [26:29]
        _unused26: u4 = 0,
        /// LBKM [30:30]
        /// LBKM
        LBKM: u1 = 0,
        /// SILM [31:31]
        /// SILM
        SILM: u1 = 0,
    };
    /// CAN_BTR
    pub const CAN_BTR: *volatile CAN_BTR_struct = @ptrFromInt(base_address + 0x1c);

    /// CAN_TI0R
    pub const CAN_TI0R_struct = packed struct {
        /// TXRQ [0:0]
        /// TXRQ
        TXRQ: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_TI0R
    pub const CAN_TI0R: *volatile CAN_TI0R_struct = @ptrFromInt(base_address + 0x180);

    /// CAN_TDT0R
    pub const CAN_TDT0R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// TGT [8:8]
        /// TGT
        TGT: u1 = 0,
        /// unused [9:15]
        _unused9: u7 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_TDT0R
    pub const CAN_TDT0R: *volatile CAN_TDT0R_struct = @ptrFromInt(base_address + 0x184);

    /// CAN_TDL0R
    pub const CAN_TDL0R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_TDL0R
    pub const CAN_TDL0R: *volatile CAN_TDL0R_struct = @ptrFromInt(base_address + 0x188);

    /// CAN_TDH0R
    pub const CAN_TDH0R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_TDH0R
    pub const CAN_TDH0R: *volatile CAN_TDH0R_struct = @ptrFromInt(base_address + 0x18c);

    /// CAN_TI1R
    pub const CAN_TI1R_struct = packed struct {
        /// TXRQ [0:0]
        /// TXRQ
        TXRQ: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_TI1R
    pub const CAN_TI1R: *volatile CAN_TI1R_struct = @ptrFromInt(base_address + 0x190);

    /// CAN_TDT1R
    pub const CAN_TDT1R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// TGT [8:8]
        /// TGT
        TGT: u1 = 0,
        /// unused [9:15]
        _unused9: u7 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_TDT1R
    pub const CAN_TDT1R: *volatile CAN_TDT1R_struct = @ptrFromInt(base_address + 0x194);

    /// CAN_TDL1R
    pub const CAN_TDL1R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_TDL1R
    pub const CAN_TDL1R: *volatile CAN_TDL1R_struct = @ptrFromInt(base_address + 0x198);

    /// CAN_TDH1R
    pub const CAN_TDH1R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_TDH1R
    pub const CAN_TDH1R: *volatile CAN_TDH1R_struct = @ptrFromInt(base_address + 0x19c);

    /// CAN_TI2R
    pub const CAN_TI2R_struct = packed struct {
        /// TXRQ [0:0]
        /// TXRQ
        TXRQ: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_TI2R
    pub const CAN_TI2R: *volatile CAN_TI2R_struct = @ptrFromInt(base_address + 0x1a0);

    /// CAN_TDT2R
    pub const CAN_TDT2R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// TGT [8:8]
        /// TGT
        TGT: u1 = 0,
        /// unused [9:15]
        _unused9: u7 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_TDT2R
    pub const CAN_TDT2R: *volatile CAN_TDT2R_struct = @ptrFromInt(base_address + 0x1a4);

    /// CAN_TDL2R
    pub const CAN_TDL2R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_TDL2R
    pub const CAN_TDL2R: *volatile CAN_TDL2R_struct = @ptrFromInt(base_address + 0x1a8);

    /// CAN_TDH2R
    pub const CAN_TDH2R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_TDH2R
    pub const CAN_TDH2R: *volatile CAN_TDH2R_struct = @ptrFromInt(base_address + 0x1ac);

    /// CAN_RI0R
    pub const CAN_RI0R_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_RI0R
    pub const CAN_RI0R: *volatile CAN_RI0R_struct = @ptrFromInt(base_address + 0x1b0);

    /// CAN_RDT0R
    pub const CAN_RDT0R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// FMI [8:15]
        /// FMI
        FMI: u8 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_RDT0R
    pub const CAN_RDT0R: *volatile CAN_RDT0R_struct = @ptrFromInt(base_address + 0x1b4);

    /// CAN_RDL0R
    pub const CAN_RDL0R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_RDL0R
    pub const CAN_RDL0R: *volatile CAN_RDL0R_struct = @ptrFromInt(base_address + 0x1b8);

    /// CAN_RDH0R
    pub const CAN_RDH0R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_RDH0R
    pub const CAN_RDH0R: *volatile CAN_RDH0R_struct = @ptrFromInt(base_address + 0x1bc);

    /// CAN_RI1R
    pub const CAN_RI1R_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_RI1R
    pub const CAN_RI1R: *volatile CAN_RI1R_struct = @ptrFromInt(base_address + 0x1c0);

    /// CAN_RDT1R
    pub const CAN_RDT1R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// FMI [8:15]
        /// FMI
        FMI: u8 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_RDT1R
    pub const CAN_RDT1R: *volatile CAN_RDT1R_struct = @ptrFromInt(base_address + 0x1c4);

    /// CAN_RDL1R
    pub const CAN_RDL1R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_RDL1R
    pub const CAN_RDL1R: *volatile CAN_RDL1R_struct = @ptrFromInt(base_address + 0x1c8);

    /// CAN_RDH1R
    pub const CAN_RDH1R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_RDH1R
    pub const CAN_RDH1R: *volatile CAN_RDH1R_struct = @ptrFromInt(base_address + 0x1cc);

    /// CAN_FMR
    pub const CAN_FMR_struct = packed struct {
        /// FINIT [0:0]
        /// FINIT
        FINIT: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FMR
    pub const CAN_FMR: *volatile CAN_FMR_struct = @ptrFromInt(base_address + 0x200);

    /// CAN_FM1R
    pub const CAN_FM1R_struct = packed struct {
        /// FBM0 [0:0]
        /// Filter mode
        FBM0: u1 = 0,
        /// FBM1 [1:1]
        /// Filter mode
        FBM1: u1 = 0,
        /// FBM2 [2:2]
        /// Filter mode
        FBM2: u1 = 0,
        /// FBM3 [3:3]
        /// Filter mode
        FBM3: u1 = 0,
        /// FBM4 [4:4]
        /// Filter mode
        FBM4: u1 = 0,
        /// FBM5 [5:5]
        /// Filter mode
        FBM5: u1 = 0,
        /// FBM6 [6:6]
        /// Filter mode
        FBM6: u1 = 0,
        /// FBM7 [7:7]
        /// Filter mode
        FBM7: u1 = 0,
        /// FBM8 [8:8]
        /// Filter mode
        FBM8: u1 = 0,
        /// FBM9 [9:9]
        /// Filter mode
        FBM9: u1 = 0,
        /// FBM10 [10:10]
        /// Filter mode
        FBM10: u1 = 0,
        /// FBM11 [11:11]
        /// Filter mode
        FBM11: u1 = 0,
        /// FBM12 [12:12]
        /// Filter mode
        FBM12: u1 = 0,
        /// FBM13 [13:13]
        /// Filter mode
        FBM13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FM1R
    pub const CAN_FM1R: *volatile CAN_FM1R_struct = @ptrFromInt(base_address + 0x204);

    /// CAN_FS1R
    pub const CAN_FS1R_struct = packed struct {
        /// FSC0 [0:0]
        /// Filter scale configuration
        FSC0: u1 = 0,
        /// FSC1 [1:1]
        /// Filter scale configuration
        FSC1: u1 = 0,
        /// FSC2 [2:2]
        /// Filter scale configuration
        FSC2: u1 = 0,
        /// FSC3 [3:3]
        /// Filter scale configuration
        FSC3: u1 = 0,
        /// FSC4 [4:4]
        /// Filter scale configuration
        FSC4: u1 = 0,
        /// FSC5 [5:5]
        /// Filter scale configuration
        FSC5: u1 = 0,
        /// FSC6 [6:6]
        /// Filter scale configuration
        FSC6: u1 = 0,
        /// FSC7 [7:7]
        /// Filter scale configuration
        FSC7: u1 = 0,
        /// FSC8 [8:8]
        /// Filter scale configuration
        FSC8: u1 = 0,
        /// FSC9 [9:9]
        /// Filter scale configuration
        FSC9: u1 = 0,
        /// FSC10 [10:10]
        /// Filter scale configuration
        FSC10: u1 = 0,
        /// FSC11 [11:11]
        /// Filter scale configuration
        FSC11: u1 = 0,
        /// FSC12 [12:12]
        /// Filter scale configuration
        FSC12: u1 = 0,
        /// FSC13 [13:13]
        /// Filter scale configuration
        FSC13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FS1R
    pub const CAN_FS1R: *volatile CAN_FS1R_struct = @ptrFromInt(base_address + 0x20c);

    /// CAN_FFA1R
    pub const CAN_FFA1R_struct = packed struct {
        /// FFA0 [0:0]
        /// Filter FIFO assignment for filter
        FFA0: u1 = 0,
        /// FFA1 [1:1]
        /// Filter FIFO assignment for filter
        FFA1: u1 = 0,
        /// FFA2 [2:2]
        /// Filter FIFO assignment for filter
        FFA2: u1 = 0,
        /// FFA3 [3:3]
        /// Filter FIFO assignment for filter
        FFA3: u1 = 0,
        /// FFA4 [4:4]
        /// Filter FIFO assignment for filter
        FFA4: u1 = 0,
        /// FFA5 [5:5]
        /// Filter FIFO assignment for filter
        FFA5: u1 = 0,
        /// FFA6 [6:6]
        /// Filter FIFO assignment for filter
        FFA6: u1 = 0,
        /// FFA7 [7:7]
        /// Filter FIFO assignment for filter
        FFA7: u1 = 0,
        /// FFA8 [8:8]
        /// Filter FIFO assignment for filter
        FFA8: u1 = 0,
        /// FFA9 [9:9]
        /// Filter FIFO assignment for filter
        FFA9: u1 = 0,
        /// FFA10 [10:10]
        /// Filter FIFO assignment for filter
        FFA10: u1 = 0,
        /// FFA11 [11:11]
        /// Filter FIFO assignment for filter
        FFA11: u1 = 0,
        /// FFA12 [12:12]
        /// Filter FIFO assignment for filter
        FFA12: u1 = 0,
        /// FFA13 [13:13]
        /// Filter FIFO assignment for filter
        FFA13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FFA1R
    pub const CAN_FFA1R: *volatile CAN_FFA1R_struct = @ptrFromInt(base_address + 0x214);

    /// CAN_FA1R
    pub const CAN_FA1R_struct = packed struct {
        /// FACT0 [0:0]
        /// Filter active
        FACT0: u1 = 0,
        /// FACT1 [1:1]
        /// Filter active
        FACT1: u1 = 0,
        /// FACT2 [2:2]
        /// Filter active
        FACT2: u1 = 0,
        /// FACT3 [3:3]
        /// Filter active
        FACT3: u1 = 0,
        /// FACT4 [4:4]
        /// Filter active
        FACT4: u1 = 0,
        /// FACT5 [5:5]
        /// Filter active
        FACT5: u1 = 0,
        /// FACT6 [6:6]
        /// Filter active
        FACT6: u1 = 0,
        /// FACT7 [7:7]
        /// Filter active
        FACT7: u1 = 0,
        /// FACT8 [8:8]
        /// Filter active
        FACT8: u1 = 0,
        /// FACT9 [9:9]
        /// Filter active
        FACT9: u1 = 0,
        /// FACT10 [10:10]
        /// Filter active
        FACT10: u1 = 0,
        /// FACT11 [11:11]
        /// Filter active
        FACT11: u1 = 0,
        /// FACT12 [12:12]
        /// Filter active
        FACT12: u1 = 0,
        /// FACT13 [13:13]
        /// Filter active
        FACT13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FA1R
    pub const CAN_FA1R: *volatile CAN_FA1R_struct = @ptrFromInt(base_address + 0x21c);

    /// F0R1
    pub const F0R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 0 register 1
    pub const F0R1: *volatile F0R1_struct = @ptrFromInt(base_address + 0x240);

    /// F0R2
    pub const F0R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 0 register 2
    pub const F0R2: *volatile F0R2_struct = @ptrFromInt(base_address + 0x244);

    /// F1R1
    pub const F1R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 1 register 1
    pub const F1R1: *volatile F1R1_struct = @ptrFromInt(base_address + 0x248);

    /// F1R2
    pub const F1R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 1 register 2
    pub const F1R2: *volatile F1R2_struct = @ptrFromInt(base_address + 0x24c);

    /// F2R1
    pub const F2R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 2 register 1
    pub const F2R1: *volatile F2R1_struct = @ptrFromInt(base_address + 0x250);

    /// F2R2
    pub const F2R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 2 register 2
    pub const F2R2: *volatile F2R2_struct = @ptrFromInt(base_address + 0x254);

    /// F3R1
    pub const F3R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 3 register 1
    pub const F3R1: *volatile F3R1_struct = @ptrFromInt(base_address + 0x258);

    /// F3R2
    pub const F3R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 3 register 2
    pub const F3R2: *volatile F3R2_struct = @ptrFromInt(base_address + 0x25c);

    /// F4R1
    pub const F4R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 4 register 1
    pub const F4R1: *volatile F4R1_struct = @ptrFromInt(base_address + 0x260);

    /// F4R2
    pub const F4R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 4 register 2
    pub const F4R2: *volatile F4R2_struct = @ptrFromInt(base_address + 0x264);

    /// F5R1
    pub const F5R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 5 register 1
    pub const F5R1: *volatile F5R1_struct = @ptrFromInt(base_address + 0x268);

    /// F5R2
    pub const F5R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 5 register 2
    pub const F5R2: *volatile F5R2_struct = @ptrFromInt(base_address + 0x26c);

    /// F6R1
    pub const F6R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 6 register 1
    pub const F6R1: *volatile F6R1_struct = @ptrFromInt(base_address + 0x270);

    /// F6R2
    pub const F6R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 6 register 2
    pub const F6R2: *volatile F6R2_struct = @ptrFromInt(base_address + 0x274);

    /// F7R1
    pub const F7R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 7 register 1
    pub const F7R1: *volatile F7R1_struct = @ptrFromInt(base_address + 0x278);

    /// F7R2
    pub const F7R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 7 register 2
    pub const F7R2: *volatile F7R2_struct = @ptrFromInt(base_address + 0x27c);

    /// F8R1
    pub const F8R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 8 register 1
    pub const F8R1: *volatile F8R1_struct = @ptrFromInt(base_address + 0x280);

    /// F8R2
    pub const F8R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 8 register 2
    pub const F8R2: *volatile F8R2_struct = @ptrFromInt(base_address + 0x284);

    /// F9R1
    pub const F9R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 9 register 1
    pub const F9R1: *volatile F9R1_struct = @ptrFromInt(base_address + 0x288);

    /// F9R2
    pub const F9R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 9 register 2
    pub const F9R2: *volatile F9R2_struct = @ptrFromInt(base_address + 0x28c);

    /// F10R1
    pub const F10R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 10 register 1
    pub const F10R1: *volatile F10R1_struct = @ptrFromInt(base_address + 0x290);

    /// F10R2
    pub const F10R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 10 register 2
    pub const F10R2: *volatile F10R2_struct = @ptrFromInt(base_address + 0x294);

    /// F11R1
    pub const F11R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 11 register 1
    pub const F11R1: *volatile F11R1_struct = @ptrFromInt(base_address + 0x298);

    /// F11R2
    pub const F11R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 11 register 2
    pub const F11R2: *volatile F11R2_struct = @ptrFromInt(base_address + 0x29c);

    /// F12R1
    pub const F12R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 4 register 1
    pub const F12R1: *volatile F12R1_struct = @ptrFromInt(base_address + 0x2a0);

    /// F12R2
    pub const F12R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 12 register 2
    pub const F12R2: *volatile F12R2_struct = @ptrFromInt(base_address + 0x2a4);

    /// F13R1
    pub const F13R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 13 register 1
    pub const F13R1: *volatile F13R1_struct = @ptrFromInt(base_address + 0x2a8);

    /// F13R2
    pub const F13R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 13 register 2
    pub const F13R2: *volatile F13R2_struct = @ptrFromInt(base_address + 0x2ac);
};

/// Controller area network
pub const CAN2 = struct {
    pub const base_address = 0x40006800;
    /// CAN_MCR
    pub const CAN_MCR_struct = packed struct {
        /// INRQ [0:0]
        /// INRQ
        INRQ: u1 = 0,
        /// SLEEP [1:1]
        /// SLEEP
        SLEEP: u1 = 0,
        /// TXFP [2:2]
        /// TXFP
        TXFP: u1 = 0,
        /// RFLM [3:3]
        /// RFLM
        RFLM: u1 = 0,
        /// NART [4:4]
        /// NART
        NART: u1 = 0,
        /// AWUM [5:5]
        /// AWUM
        AWUM: u1 = 0,
        /// ABOM [6:6]
        /// ABOM
        ABOM: u1 = 0,
        /// TTCM [7:7]
        /// TTCM
        TTCM: u1 = 0,
        /// unused [8:14]
        _unused8: u7 = 0,
        /// RESET [15:15]
        /// RESET
        RESET: u1 = 0,
        /// DBF [16:16]
        /// DBF
        DBF: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_MCR
    pub const CAN_MCR: *volatile CAN_MCR_struct = @ptrFromInt(base_address + 0x0);

    /// CAN_MSR
    pub const CAN_MSR_struct = packed struct {
        /// INAK [0:0]
        /// INAK
        INAK: u1 = 0,
        /// SLAK [1:1]
        /// SLAK
        SLAK: u1 = 0,
        /// ERRI [2:2]
        /// ERRI
        ERRI: u1 = 0,
        /// WKUI [3:3]
        /// WKUI
        WKUI: u1 = 0,
        /// SLAKI [4:4]
        /// SLAKI
        SLAKI: u1 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// TXM [8:8]
        /// TXM
        TXM: u1 = 0,
        /// RXM [9:9]
        /// RXM
        RXM: u1 = 0,
        /// SAMP [10:10]
        /// SAMP
        SAMP: u1 = 0,
        /// RX [11:11]
        /// RX
        RX: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_MSR
    pub const CAN_MSR: *volatile CAN_MSR_struct = @ptrFromInt(base_address + 0x4);

    /// CAN_TSR
    pub const CAN_TSR_struct = packed struct {
        /// RQCP0 [0:0]
        /// RQCP0
        RQCP0: u1 = 0,
        /// TXOK0 [1:1]
        /// TXOK0
        TXOK0: u1 = 0,
        /// ALST0 [2:2]
        /// ALST0
        ALST0: u1 = 0,
        /// TERR0 [3:3]
        /// TERR0
        TERR0: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// ABRQ0 [7:7]
        /// ABRQ0
        ABRQ0: u1 = 0,
        /// RQCP1 [8:8]
        /// RQCP1
        RQCP1: u1 = 0,
        /// TXOK1 [9:9]
        /// TXOK1
        TXOK1: u1 = 0,
        /// ALST1 [10:10]
        /// ALST1
        ALST1: u1 = 0,
        /// TERR1 [11:11]
        /// TERR1
        TERR1: u1 = 0,
        /// unused [12:14]
        _unused12: u3 = 0,
        /// ABRQ1 [15:15]
        /// ABRQ1
        ABRQ1: u1 = 0,
        /// RQCP2 [16:16]
        /// RQCP2
        RQCP2: u1 = 0,
        /// TXOK2 [17:17]
        /// TXOK2
        TXOK2: u1 = 0,
        /// ALST2 [18:18]
        /// ALST2
        ALST2: u1 = 0,
        /// TERR2 [19:19]
        /// TERR2
        TERR2: u1 = 0,
        /// unused [20:22]
        _unused20: u3 = 0,
        /// ABRQ2 [23:23]
        /// ABRQ2
        ABRQ2: u1 = 0,
        /// CODE [24:25]
        /// CODE
        CODE: u2 = 0,
        /// TME0 [26:26]
        /// Lowest priority flag for mailbox
        TME0: u1 = 0,
        /// TME1 [27:27]
        /// Lowest priority flag for mailbox
        TME1: u1 = 0,
        /// TME2 [28:28]
        /// Lowest priority flag for mailbox
        TME2: u1 = 0,
        /// LOW0 [29:29]
        /// Lowest priority flag for mailbox
        LOW0: u1 = 0,
        /// LOW1 [30:30]
        /// Lowest priority flag for mailbox
        LOW1: u1 = 0,
        /// LOW2 [31:31]
        /// Lowest priority flag for mailbox
        LOW2: u1 = 0,
    };
    /// CAN_TSR
    pub const CAN_TSR: *volatile CAN_TSR_struct = @ptrFromInt(base_address + 0x8);

    /// CAN_RF0R
    pub const CAN_RF0R_struct = packed struct {
        /// FMP0 [0:1]
        /// FMP0
        FMP0: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// FULL0 [3:3]
        /// FULL0
        FULL0: u1 = 0,
        /// FOVR0 [4:4]
        /// FOVR0
        FOVR0: u1 = 0,
        /// RFOM0 [5:5]
        /// RFOM0
        RFOM0: u1 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_RF0R
    pub const CAN_RF0R: *volatile CAN_RF0R_struct = @ptrFromInt(base_address + 0xc);

    /// CAN_RF1R
    pub const CAN_RF1R_struct = packed struct {
        /// FMP1 [0:1]
        /// FMP1
        FMP1: u2 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// FULL1 [3:3]
        /// FULL1
        FULL1: u1 = 0,
        /// FOVR1 [4:4]
        /// FOVR1
        FOVR1: u1 = 0,
        /// RFOM1 [5:5]
        /// RFOM1
        RFOM1: u1 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_RF1R
    pub const CAN_RF1R: *volatile CAN_RF1R_struct = @ptrFromInt(base_address + 0x10);

    /// CAN_IER
    pub const CAN_IER_struct = packed struct {
        /// TMEIE [0:0]
        /// TMEIE
        TMEIE: u1 = 0,
        /// FMPIE0 [1:1]
        /// FMPIE0
        FMPIE0: u1 = 0,
        /// FFIE0 [2:2]
        /// FFIE0
        FFIE0: u1 = 0,
        /// FOVIE0 [3:3]
        /// FOVIE0
        FOVIE0: u1 = 0,
        /// FMPIE1 [4:4]
        /// FMPIE1
        FMPIE1: u1 = 0,
        /// FFIE1 [5:5]
        /// FFIE1
        FFIE1: u1 = 0,
        /// FOVIE1 [6:6]
        /// FOVIE1
        FOVIE1: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// EWGIE [8:8]
        /// EWGIE
        EWGIE: u1 = 0,
        /// EPVIE [9:9]
        /// EPVIE
        EPVIE: u1 = 0,
        /// BOFIE [10:10]
        /// BOFIE
        BOFIE: u1 = 0,
        /// LECIE [11:11]
        /// LECIE
        LECIE: u1 = 0,
        /// unused [12:14]
        _unused12: u3 = 0,
        /// ERRIE [15:15]
        /// ERRIE
        ERRIE: u1 = 0,
        /// WKUIE [16:16]
        /// WKUIE
        WKUIE: u1 = 0,
        /// SLKIE [17:17]
        /// SLKIE
        SLKIE: u1 = 0,
        /// unused [18:31]
        _unused18: u6 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_IER
    pub const CAN_IER: *volatile CAN_IER_struct = @ptrFromInt(base_address + 0x14);

    /// CAN_ESR
    pub const CAN_ESR_struct = packed struct {
        /// EWGF [0:0]
        /// EWGF
        EWGF: u1 = 0,
        /// EPVF [1:1]
        /// EPVF
        EPVF: u1 = 0,
        /// BOFF [2:2]
        /// BOFF
        BOFF: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// LEC [4:6]
        /// LEC
        LEC: u3 = 0,
        /// unused [7:15]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        /// TEC [16:23]
        /// TEC
        TEC: u8 = 0,
        /// REC [24:31]
        /// REC
        REC: u8 = 0,
    };
    /// CAN_ESR
    pub const CAN_ESR: *volatile CAN_ESR_struct = @ptrFromInt(base_address + 0x18);

    /// CAN_BTR
    pub const CAN_BTR_struct = packed struct {
        /// BRP [0:9]
        /// BRP
        BRP: u10 = 0,
        /// unused [10:15]
        _unused10: u6 = 0,
        /// TS1 [16:19]
        /// TS1
        TS1: u4 = 0,
        /// TS2 [20:22]
        /// TS2
        TS2: u3 = 0,
        /// unused [23:23]
        _unused23: u1 = 0,
        /// SJW [24:25]
        /// SJW
        SJW: u2 = 0,
        /// unused [26:29]
        _unused26: u4 = 0,
        /// LBKM [30:30]
        /// LBKM
        LBKM: u1 = 0,
        /// SILM [31:31]
        /// SILM
        SILM: u1 = 0,
    };
    /// CAN_BTR
    pub const CAN_BTR: *volatile CAN_BTR_struct = @ptrFromInt(base_address + 0x1c);

    /// CAN_TI0R
    pub const CAN_TI0R_struct = packed struct {
        /// TXRQ [0:0]
        /// TXRQ
        TXRQ: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_TI0R
    pub const CAN_TI0R: *volatile CAN_TI0R_struct = @ptrFromInt(base_address + 0x180);

    /// CAN_TDT0R
    pub const CAN_TDT0R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// TGT [8:8]
        /// TGT
        TGT: u1 = 0,
        /// unused [9:15]
        _unused9: u7 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_TDT0R
    pub const CAN_TDT0R: *volatile CAN_TDT0R_struct = @ptrFromInt(base_address + 0x184);

    /// CAN_TDL0R
    pub const CAN_TDL0R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_TDL0R
    pub const CAN_TDL0R: *volatile CAN_TDL0R_struct = @ptrFromInt(base_address + 0x188);

    /// CAN_TDH0R
    pub const CAN_TDH0R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_TDH0R
    pub const CAN_TDH0R: *volatile CAN_TDH0R_struct = @ptrFromInt(base_address + 0x18c);

    /// CAN_TI1R
    pub const CAN_TI1R_struct = packed struct {
        /// TXRQ [0:0]
        /// TXRQ
        TXRQ: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_TI1R
    pub const CAN_TI1R: *volatile CAN_TI1R_struct = @ptrFromInt(base_address + 0x190);

    /// CAN_TDT1R
    pub const CAN_TDT1R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// TGT [8:8]
        /// TGT
        TGT: u1 = 0,
        /// unused [9:15]
        _unused9: u7 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_TDT1R
    pub const CAN_TDT1R: *volatile CAN_TDT1R_struct = @ptrFromInt(base_address + 0x194);

    /// CAN_TDL1R
    pub const CAN_TDL1R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_TDL1R
    pub const CAN_TDL1R: *volatile CAN_TDL1R_struct = @ptrFromInt(base_address + 0x198);

    /// CAN_TDH1R
    pub const CAN_TDH1R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_TDH1R
    pub const CAN_TDH1R: *volatile CAN_TDH1R_struct = @ptrFromInt(base_address + 0x19c);

    /// CAN_TI2R
    pub const CAN_TI2R_struct = packed struct {
        /// TXRQ [0:0]
        /// TXRQ
        TXRQ: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_TI2R
    pub const CAN_TI2R: *volatile CAN_TI2R_struct = @ptrFromInt(base_address + 0x1a0);

    /// CAN_TDT2R
    pub const CAN_TDT2R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// TGT [8:8]
        /// TGT
        TGT: u1 = 0,
        /// unused [9:15]
        _unused9: u7 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_TDT2R
    pub const CAN_TDT2R: *volatile CAN_TDT2R_struct = @ptrFromInt(base_address + 0x1a4);

    /// CAN_TDL2R
    pub const CAN_TDL2R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_TDL2R
    pub const CAN_TDL2R: *volatile CAN_TDL2R_struct = @ptrFromInt(base_address + 0x1a8);

    /// CAN_TDH2R
    pub const CAN_TDH2R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_TDH2R
    pub const CAN_TDH2R: *volatile CAN_TDH2R_struct = @ptrFromInt(base_address + 0x1ac);

    /// CAN_RI0R
    pub const CAN_RI0R_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_RI0R
    pub const CAN_RI0R: *volatile CAN_RI0R_struct = @ptrFromInt(base_address + 0x1b0);

    /// CAN_RDT0R
    pub const CAN_RDT0R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// FMI [8:15]
        /// FMI
        FMI: u8 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_RDT0R
    pub const CAN_RDT0R: *volatile CAN_RDT0R_struct = @ptrFromInt(base_address + 0x1b4);

    /// CAN_RDL0R
    pub const CAN_RDL0R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_RDL0R
    pub const CAN_RDL0R: *volatile CAN_RDL0R_struct = @ptrFromInt(base_address + 0x1b8);

    /// CAN_RDH0R
    pub const CAN_RDH0R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_RDH0R
    pub const CAN_RDH0R: *volatile CAN_RDH0R_struct = @ptrFromInt(base_address + 0x1bc);

    /// CAN_RI1R
    pub const CAN_RI1R_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// RTR [1:1]
        /// RTR
        RTR: u1 = 0,
        /// IDE [2:2]
        /// IDE
        IDE: u1 = 0,
        /// EXID [3:20]
        /// EXID
        EXID: u18 = 0,
        /// STID [21:31]
        /// STID
        STID: u11 = 0,
    };
    /// CAN_RI1R
    pub const CAN_RI1R: *volatile CAN_RI1R_struct = @ptrFromInt(base_address + 0x1c0);

    /// CAN_RDT1R
    pub const CAN_RDT1R_struct = packed struct {
        /// DLC [0:3]
        /// DLC
        DLC: u4 = 0,
        /// unused [4:7]
        _unused4: u4 = 0,
        /// FMI [8:15]
        /// FMI
        FMI: u8 = 0,
        /// TIME [16:31]
        /// TIME
        TIME: u16 = 0,
    };
    /// CAN_RDT1R
    pub const CAN_RDT1R: *volatile CAN_RDT1R_struct = @ptrFromInt(base_address + 0x1c4);

    /// CAN_RDL1R
    pub const CAN_RDL1R_struct = packed struct {
        /// DATA0 [0:7]
        /// DATA0
        DATA0: u8 = 0,
        /// DATA1 [8:15]
        /// DATA1
        DATA1: u8 = 0,
        /// DATA2 [16:23]
        /// DATA2
        DATA2: u8 = 0,
        /// DATA3 [24:31]
        /// DATA3
        DATA3: u8 = 0,
    };
    /// CAN_RDL1R
    pub const CAN_RDL1R: *volatile CAN_RDL1R_struct = @ptrFromInt(base_address + 0x1c8);

    /// CAN_RDH1R
    pub const CAN_RDH1R_struct = packed struct {
        /// DATA4 [0:7]
        /// DATA4
        DATA4: u8 = 0,
        /// DATA5 [8:15]
        /// DATA5
        DATA5: u8 = 0,
        /// DATA6 [16:23]
        /// DATA6
        DATA6: u8 = 0,
        /// DATA7 [24:31]
        /// DATA7
        DATA7: u8 = 0,
    };
    /// CAN_RDH1R
    pub const CAN_RDH1R: *volatile CAN_RDH1R_struct = @ptrFromInt(base_address + 0x1cc);

    /// CAN_FMR
    pub const CAN_FMR_struct = packed struct {
        /// FINIT [0:0]
        /// FINIT
        FINIT: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FMR
    pub const CAN_FMR: *volatile CAN_FMR_struct = @ptrFromInt(base_address + 0x200);

    /// CAN_FM1R
    pub const CAN_FM1R_struct = packed struct {
        /// FBM0 [0:0]
        /// Filter mode
        FBM0: u1 = 0,
        /// FBM1 [1:1]
        /// Filter mode
        FBM1: u1 = 0,
        /// FBM2 [2:2]
        /// Filter mode
        FBM2: u1 = 0,
        /// FBM3 [3:3]
        /// Filter mode
        FBM3: u1 = 0,
        /// FBM4 [4:4]
        /// Filter mode
        FBM4: u1 = 0,
        /// FBM5 [5:5]
        /// Filter mode
        FBM5: u1 = 0,
        /// FBM6 [6:6]
        /// Filter mode
        FBM6: u1 = 0,
        /// FBM7 [7:7]
        /// Filter mode
        FBM7: u1 = 0,
        /// FBM8 [8:8]
        /// Filter mode
        FBM8: u1 = 0,
        /// FBM9 [9:9]
        /// Filter mode
        FBM9: u1 = 0,
        /// FBM10 [10:10]
        /// Filter mode
        FBM10: u1 = 0,
        /// FBM11 [11:11]
        /// Filter mode
        FBM11: u1 = 0,
        /// FBM12 [12:12]
        /// Filter mode
        FBM12: u1 = 0,
        /// FBM13 [13:13]
        /// Filter mode
        FBM13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FM1R
    pub const CAN_FM1R: *volatile CAN_FM1R_struct = @ptrFromInt(base_address + 0x204);

    /// CAN_FS1R
    pub const CAN_FS1R_struct = packed struct {
        /// FSC0 [0:0]
        /// Filter scale configuration
        FSC0: u1 = 0,
        /// FSC1 [1:1]
        /// Filter scale configuration
        FSC1: u1 = 0,
        /// FSC2 [2:2]
        /// Filter scale configuration
        FSC2: u1 = 0,
        /// FSC3 [3:3]
        /// Filter scale configuration
        FSC3: u1 = 0,
        /// FSC4 [4:4]
        /// Filter scale configuration
        FSC4: u1 = 0,
        /// FSC5 [5:5]
        /// Filter scale configuration
        FSC5: u1 = 0,
        /// FSC6 [6:6]
        /// Filter scale configuration
        FSC6: u1 = 0,
        /// FSC7 [7:7]
        /// Filter scale configuration
        FSC7: u1 = 0,
        /// FSC8 [8:8]
        /// Filter scale configuration
        FSC8: u1 = 0,
        /// FSC9 [9:9]
        /// Filter scale configuration
        FSC9: u1 = 0,
        /// FSC10 [10:10]
        /// Filter scale configuration
        FSC10: u1 = 0,
        /// FSC11 [11:11]
        /// Filter scale configuration
        FSC11: u1 = 0,
        /// FSC12 [12:12]
        /// Filter scale configuration
        FSC12: u1 = 0,
        /// FSC13 [13:13]
        /// Filter scale configuration
        FSC13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FS1R
    pub const CAN_FS1R: *volatile CAN_FS1R_struct = @ptrFromInt(base_address + 0x20c);

    /// CAN_FFA1R
    pub const CAN_FFA1R_struct = packed struct {
        /// FFA0 [0:0]
        /// Filter FIFO assignment for filter
        FFA0: u1 = 0,
        /// FFA1 [1:1]
        /// Filter FIFO assignment for filter
        FFA1: u1 = 0,
        /// FFA2 [2:2]
        /// Filter FIFO assignment for filter
        FFA2: u1 = 0,
        /// FFA3 [3:3]
        /// Filter FIFO assignment for filter
        FFA3: u1 = 0,
        /// FFA4 [4:4]
        /// Filter FIFO assignment for filter
        FFA4: u1 = 0,
        /// FFA5 [5:5]
        /// Filter FIFO assignment for filter
        FFA5: u1 = 0,
        /// FFA6 [6:6]
        /// Filter FIFO assignment for filter
        FFA6: u1 = 0,
        /// FFA7 [7:7]
        /// Filter FIFO assignment for filter
        FFA7: u1 = 0,
        /// FFA8 [8:8]
        /// Filter FIFO assignment for filter
        FFA8: u1 = 0,
        /// FFA9 [9:9]
        /// Filter FIFO assignment for filter
        FFA9: u1 = 0,
        /// FFA10 [10:10]
        /// Filter FIFO assignment for filter
        FFA10: u1 = 0,
        /// FFA11 [11:11]
        /// Filter FIFO assignment for filter
        FFA11: u1 = 0,
        /// FFA12 [12:12]
        /// Filter FIFO assignment for filter
        FFA12: u1 = 0,
        /// FFA13 [13:13]
        /// Filter FIFO assignment for filter
        FFA13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FFA1R
    pub const CAN_FFA1R: *volatile CAN_FFA1R_struct = @ptrFromInt(base_address + 0x214);

    /// CAN_FA1R
    pub const CAN_FA1R_struct = packed struct {
        /// FACT0 [0:0]
        /// Filter active
        FACT0: u1 = 0,
        /// FACT1 [1:1]
        /// Filter active
        FACT1: u1 = 0,
        /// FACT2 [2:2]
        /// Filter active
        FACT2: u1 = 0,
        /// FACT3 [3:3]
        /// Filter active
        FACT3: u1 = 0,
        /// FACT4 [4:4]
        /// Filter active
        FACT4: u1 = 0,
        /// FACT5 [5:5]
        /// Filter active
        FACT5: u1 = 0,
        /// FACT6 [6:6]
        /// Filter active
        FACT6: u1 = 0,
        /// FACT7 [7:7]
        /// Filter active
        FACT7: u1 = 0,
        /// FACT8 [8:8]
        /// Filter active
        FACT8: u1 = 0,
        /// FACT9 [9:9]
        /// Filter active
        FACT9: u1 = 0,
        /// FACT10 [10:10]
        /// Filter active
        FACT10: u1 = 0,
        /// FACT11 [11:11]
        /// Filter active
        FACT11: u1 = 0,
        /// FACT12 [12:12]
        /// Filter active
        FACT12: u1 = 0,
        /// FACT13 [13:13]
        /// Filter active
        FACT13: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// CAN_FA1R
    pub const CAN_FA1R: *volatile CAN_FA1R_struct = @ptrFromInt(base_address + 0x21c);

    /// F0R1
    pub const F0R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 0 register 1
    pub const F0R1: *volatile F0R1_struct = @ptrFromInt(base_address + 0x240);

    /// F0R2
    pub const F0R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 0 register 2
    pub const F0R2: *volatile F0R2_struct = @ptrFromInt(base_address + 0x244);

    /// F1R1
    pub const F1R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 1 register 1
    pub const F1R1: *volatile F1R1_struct = @ptrFromInt(base_address + 0x248);

    /// F1R2
    pub const F1R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 1 register 2
    pub const F1R2: *volatile F1R2_struct = @ptrFromInt(base_address + 0x24c);

    /// F2R1
    pub const F2R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 2 register 1
    pub const F2R1: *volatile F2R1_struct = @ptrFromInt(base_address + 0x250);

    /// F2R2
    pub const F2R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 2 register 2
    pub const F2R2: *volatile F2R2_struct = @ptrFromInt(base_address + 0x254);

    /// F3R1
    pub const F3R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 3 register 1
    pub const F3R1: *volatile F3R1_struct = @ptrFromInt(base_address + 0x258);

    /// F3R2
    pub const F3R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 3 register 2
    pub const F3R2: *volatile F3R2_struct = @ptrFromInt(base_address + 0x25c);

    /// F4R1
    pub const F4R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 4 register 1
    pub const F4R1: *volatile F4R1_struct = @ptrFromInt(base_address + 0x260);

    /// F4R2
    pub const F4R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 4 register 2
    pub const F4R2: *volatile F4R2_struct = @ptrFromInt(base_address + 0x264);

    /// F5R1
    pub const F5R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 5 register 1
    pub const F5R1: *volatile F5R1_struct = @ptrFromInt(base_address + 0x268);

    /// F5R2
    pub const F5R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 5 register 2
    pub const F5R2: *volatile F5R2_struct = @ptrFromInt(base_address + 0x26c);

    /// F6R1
    pub const F6R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 6 register 1
    pub const F6R1: *volatile F6R1_struct = @ptrFromInt(base_address + 0x270);

    /// F6R2
    pub const F6R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 6 register 2
    pub const F6R2: *volatile F6R2_struct = @ptrFromInt(base_address + 0x274);

    /// F7R1
    pub const F7R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 7 register 1
    pub const F7R1: *volatile F7R1_struct = @ptrFromInt(base_address + 0x278);

    /// F7R2
    pub const F7R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 7 register 2
    pub const F7R2: *volatile F7R2_struct = @ptrFromInt(base_address + 0x27c);

    /// F8R1
    pub const F8R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 8 register 1
    pub const F8R1: *volatile F8R1_struct = @ptrFromInt(base_address + 0x280);

    /// F8R2
    pub const F8R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 8 register 2
    pub const F8R2: *volatile F8R2_struct = @ptrFromInt(base_address + 0x284);

    /// F9R1
    pub const F9R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 9 register 1
    pub const F9R1: *volatile F9R1_struct = @ptrFromInt(base_address + 0x288);

    /// F9R2
    pub const F9R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 9 register 2
    pub const F9R2: *volatile F9R2_struct = @ptrFromInt(base_address + 0x28c);

    /// F10R1
    pub const F10R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 10 register 1
    pub const F10R1: *volatile F10R1_struct = @ptrFromInt(base_address + 0x290);

    /// F10R2
    pub const F10R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 10 register 2
    pub const F10R2: *volatile F10R2_struct = @ptrFromInt(base_address + 0x294);

    /// F11R1
    pub const F11R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 11 register 1
    pub const F11R1: *volatile F11R1_struct = @ptrFromInt(base_address + 0x298);

    /// F11R2
    pub const F11R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 11 register 2
    pub const F11R2: *volatile F11R2_struct = @ptrFromInt(base_address + 0x29c);

    /// F12R1
    pub const F12R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 4 register 1
    pub const F12R1: *volatile F12R1_struct = @ptrFromInt(base_address + 0x2a0);

    /// F12R2
    pub const F12R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 12 register 2
    pub const F12R2: *volatile F12R2_struct = @ptrFromInt(base_address + 0x2a4);

    /// F13R1
    pub const F13R1_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 13 register 1
    pub const F13R1: *volatile F13R1_struct = @ptrFromInt(base_address + 0x2a8);

    /// F13R2
    pub const F13R2_struct = packed struct {
        /// FB0 [0:0]
        /// Filter bits
        FB0: u1 = 0,
        /// FB1 [1:1]
        /// Filter bits
        FB1: u1 = 0,
        /// FB2 [2:2]
        /// Filter bits
        FB2: u1 = 0,
        /// FB3 [3:3]
        /// Filter bits
        FB3: u1 = 0,
        /// FB4 [4:4]
        /// Filter bits
        FB4: u1 = 0,
        /// FB5 [5:5]
        /// Filter bits
        FB5: u1 = 0,
        /// FB6 [6:6]
        /// Filter bits
        FB6: u1 = 0,
        /// FB7 [7:7]
        /// Filter bits
        FB7: u1 = 0,
        /// FB8 [8:8]
        /// Filter bits
        FB8: u1 = 0,
        /// FB9 [9:9]
        /// Filter bits
        FB9: u1 = 0,
        /// FB10 [10:10]
        /// Filter bits
        FB10: u1 = 0,
        /// FB11 [11:11]
        /// Filter bits
        FB11: u1 = 0,
        /// FB12 [12:12]
        /// Filter bits
        FB12: u1 = 0,
        /// FB13 [13:13]
        /// Filter bits
        FB13: u1 = 0,
        /// FB14 [14:14]
        /// Filter bits
        FB14: u1 = 0,
        /// FB15 [15:15]
        /// Filter bits
        FB15: u1 = 0,
        /// FB16 [16:16]
        /// Filter bits
        FB16: u1 = 0,
        /// FB17 [17:17]
        /// Filter bits
        FB17: u1 = 0,
        /// FB18 [18:18]
        /// Filter bits
        FB18: u1 = 0,
        /// FB19 [19:19]
        /// Filter bits
        FB19: u1 = 0,
        /// FB20 [20:20]
        /// Filter bits
        FB20: u1 = 0,
        /// FB21 [21:21]
        /// Filter bits
        FB21: u1 = 0,
        /// FB22 [22:22]
        /// Filter bits
        FB22: u1 = 0,
        /// FB23 [23:23]
        /// Filter bits
        FB23: u1 = 0,
        /// FB24 [24:24]
        /// Filter bits
        FB24: u1 = 0,
        /// FB25 [25:25]
        /// Filter bits
        FB25: u1 = 0,
        /// FB26 [26:26]
        /// Filter bits
        FB26: u1 = 0,
        /// FB27 [27:27]
        /// Filter bits
        FB27: u1 = 0,
        /// FB28 [28:28]
        /// Filter bits
        FB28: u1 = 0,
        /// FB29 [29:29]
        /// Filter bits
        FB29: u1 = 0,
        /// FB30 [30:30]
        /// Filter bits
        FB30: u1 = 0,
        /// FB31 [31:31]
        /// Filter bits
        FB31: u1 = 0,
    };
    /// Filter bank 13 register 2
    pub const F13R2: *volatile F13R2_struct = @ptrFromInt(base_address + 0x2ac);
};

/// Digital to analog converter
pub const DAC = struct {
    pub const base_address = 0x40007400;
    /// CR
    pub const CR_struct = packed struct {
        /// EN1 [0:0]
        /// DAC channel1 enable
        EN1: u1 = 0,
        /// BOFF1 [1:1]
        /// DAC channel1 output buffer
        BOFF1: u1 = 0,
        /// TEN1 [2:2]
        /// DAC channel1 trigger
        TEN1: u1 = 0,
        /// TSEL1 [3:5]
        /// DAC channel1 trigger
        TSEL1: u3 = 0,
        /// WAVE1 [6:7]
        /// DAC channel1 noise/triangle wave
        WAVE1: u2 = 0,
        /// MAMP1 [8:11]
        /// DAC channel1 mask/amplitude
        MAMP1: u4 = 0,
        /// DMAEN1 [12:12]
        /// DAC channel1 DMA enable
        DMAEN1: u1 = 0,
        /// unused [13:15]
        _unused13: u3 = 0,
        /// EN2 [16:16]
        /// DAC channel2 enable
        EN2: u1 = 0,
        /// BOFF2 [17:17]
        /// DAC channel2 output buffer
        BOFF2: u1 = 0,
        /// TEN2 [18:18]
        /// DAC channel2 trigger
        TEN2: u1 = 0,
        /// TSEL2 [19:21]
        /// DAC channel2 trigger
        TSEL2: u3 = 0,
        /// WAVE2 [22:23]
        /// DAC channel2 noise/triangle wave
        WAVE2: u2 = 0,
        /// MAMP2 [24:27]
        /// DAC channel2 mask/amplitude
        MAMP2: u4 = 0,
        /// DMAEN2 [28:28]
        /// DAC channel2 DMA enable
        DMAEN2: u1 = 0,
        /// unused [29:31]
        _unused29: u3 = 0,
    };
    /// Control register (DAC_CR)
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x0);

    /// SWTRIGR
    pub const SWTRIGR_struct = packed struct {
        /// SWTRIG1 [0:0]
        /// DAC channel1 software
        SWTRIG1: u1 = 0,
        /// SWTRIG2 [1:1]
        /// DAC channel2 software
        SWTRIG2: u1 = 0,
        /// unused [2:31]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC software trigger register
    pub const SWTRIGR: *volatile SWTRIGR_struct = @ptrFromInt(base_address + 0x4);

    /// DHR12R1
    pub const DHR12R1_struct = packed struct {
        /// DACC1DHR [0:11]
        /// DAC channel1 12-bit right-aligned
        DACC1DHR: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel1 12-bit right-aligned data
    pub const DHR12R1: *volatile DHR12R1_struct = @ptrFromInt(base_address + 0x8);

    /// DHR12L1
    pub const DHR12L1_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// DACC1DHR [4:15]
        /// DAC channel1 12-bit left-aligned
        DACC1DHR: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel1 12-bit left aligned data
    pub const DHR12L1: *volatile DHR12L1_struct = @ptrFromInt(base_address + 0xc);

    /// DHR8R1
    pub const DHR8R1_struct = packed struct {
        /// DACC1DHR [0:7]
        /// DAC channel1 8-bit right-aligned
        DACC1DHR: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel1 8-bit right aligned data
    pub const DHR8R1: *volatile DHR8R1_struct = @ptrFromInt(base_address + 0x10);

    /// DHR12R2
    pub const DHR12R2_struct = packed struct {
        /// DACC2DHR [0:11]
        /// DAC channel2 12-bit right-aligned
        DACC2DHR: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel2 12-bit right aligned data
    pub const DHR12R2: *volatile DHR12R2_struct = @ptrFromInt(base_address + 0x14);

    /// DHR12L2
    pub const DHR12L2_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// DACC2DHR [4:15]
        /// DAC channel2 12-bit left-aligned
        DACC2DHR: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel2 12-bit left aligned data
    pub const DHR12L2: *volatile DHR12L2_struct = @ptrFromInt(base_address + 0x18);

    /// DHR8R2
    pub const DHR8R2_struct = packed struct {
        /// DACC2DHR [0:7]
        /// DAC channel2 8-bit right-aligned
        DACC2DHR: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel2 8-bit right-aligned data
    pub const DHR8R2: *volatile DHR8R2_struct = @ptrFromInt(base_address + 0x1c);

    /// DHR12RD
    pub const DHR12RD_struct = packed struct {
        /// DACC1DHR [0:11]
        /// DAC channel1 12-bit right-aligned
        DACC1DHR: u12 = 0,
        /// unused [12:15]
        _unused12: u4 = 0,
        /// DACC2DHR [16:27]
        /// DAC channel2 12-bit right-aligned
        DACC2DHR: u12 = 0,
        /// unused [28:31]
        _unused28: u4 = 0,
    };
    /// Dual DAC 12-bit right-aligned data holding
    pub const DHR12RD: *volatile DHR12RD_struct = @ptrFromInt(base_address + 0x20);

    /// DHR12LD
    pub const DHR12LD_struct = packed struct {
        /// unused [0:3]
        _unused0: u4 = 0,
        /// DACC1DHR [4:15]
        /// DAC channel1 12-bit left-aligned
        DACC1DHR: u12 = 0,
        /// unused [16:19]
        _unused16: u4 = 0,
        /// DACC2DHR [20:31]
        /// DAC channel2 12-bit right-aligned
        DACC2DHR: u12 = 0,
    };
    /// DUAL DAC 12-bit left aligned data holding
    pub const DHR12LD: *volatile DHR12LD_struct = @ptrFromInt(base_address + 0x24);

    /// DHR8RD
    pub const DHR8RD_struct = packed struct {
        /// DACC1DHR [0:7]
        /// DAC channel1 8-bit right-aligned
        DACC1DHR: u8 = 0,
        /// DACC2DHR [8:15]
        /// DAC channel2 8-bit right-aligned
        DACC2DHR: u8 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DUAL DAC 8-bit right aligned data holding
    pub const DHR8RD: *volatile DHR8RD_struct = @ptrFromInt(base_address + 0x28);

    /// DOR1
    pub const DOR1_struct = packed struct {
        /// DACC1DOR [0:11]
        /// DAC channel1 data output
        DACC1DOR: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel1 data output register
    pub const DOR1: *volatile DOR1_struct = @ptrFromInt(base_address + 0x2c);

    /// DOR2
    pub const DOR2_struct = packed struct {
        /// DACC2DOR [0:11]
        /// DAC channel2 data output
        DACC2DOR: u12 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// DAC channel2 data output register
    pub const DOR2: *volatile DOR2_struct = @ptrFromInt(base_address + 0x30);
};

/// Debug support
pub const DBG = struct {
    pub const base_address = 0xe0042000;
    /// IDCODE
    pub const IDCODE_struct = packed struct {
        /// DEV_ID [0:11]
        /// DEV_ID
        DEV_ID: u12 = 0,
        /// unused [12:15]
        _unused12: u4 = 0,
        /// REV_ID [16:31]
        /// REV_ID
        REV_ID: u16 = 0,
    };
    /// DBGMCU_IDCODE
    pub const IDCODE: *volatile IDCODE_struct = @ptrFromInt(base_address + 0x0);

    /// CR
    pub const CR_struct = packed struct {
        /// DBG_SLEEP [0:0]
        /// DBG_SLEEP
        DBG_SLEEP: u1 = 0,
        /// DBG_STOP [1:1]
        /// DBG_STOP
        DBG_STOP: u1 = 0,
        /// DBG_STANDBY [2:2]
        /// DBG_STANDBY
        DBG_STANDBY: u1 = 0,
        /// unused [3:4]
        _unused3: u2 = 0,
        /// TRACE_IOEN [5:5]
        /// TRACE_IOEN
        TRACE_IOEN: u1 = 0,
        /// TRACE_MODE [6:7]
        /// TRACE_MODE
        TRACE_MODE: u2 = 0,
        /// DBG_IWDG_STOP [8:8]
        /// DBG_IWDG_STOP
        DBG_IWDG_STOP: u1 = 0,
        /// DBG_WWDG_STOP [9:9]
        /// DBG_WWDG_STOP
        DBG_WWDG_STOP: u1 = 0,
        /// DBG_TIM1_STOP [10:10]
        /// DBG_TIM1_STOP
        DBG_TIM1_STOP: u1 = 0,
        /// DBG_TIM2_STOP [11:11]
        /// DBG_TIM2_STOP
        DBG_TIM2_STOP: u1 = 0,
        /// DBG_TIM3_STOP [12:12]
        /// DBG_TIM3_STOP
        DBG_TIM3_STOP: u1 = 0,
        /// DBG_TIM4_STOP [13:13]
        /// DBG_TIM4_STOP
        DBG_TIM4_STOP: u1 = 0,
        /// DBG_CAN1_STOP [14:14]
        /// DBG_CAN1_STOP
        DBG_CAN1_STOP: u1 = 0,
        /// DBG_I2C1_SMBUS_TIMEOUT [15:15]
        /// DBG_I2C1_SMBUS_TIMEOUT
        DBG_I2C1_SMBUS_TIMEOUT: u1 = 0,
        /// DBG_I2C2_SMBUS_TIMEOUT [16:16]
        /// DBG_I2C2_SMBUS_TIMEOUT
        DBG_I2C2_SMBUS_TIMEOUT: u1 = 0,
        /// DBG_TIM8_STOP [17:17]
        /// DBG_TIM8_STOP
        DBG_TIM8_STOP: u1 = 0,
        /// DBG_TIM5_STOP [18:18]
        /// DBG_TIM5_STOP
        DBG_TIM5_STOP: u1 = 0,
        /// DBG_TIM6_STOP [19:19]
        /// DBG_TIM6_STOP
        DBG_TIM6_STOP: u1 = 0,
        /// DBG_TIM7_STOP [20:20]
        /// DBG_TIM7_STOP
        DBG_TIM7_STOP: u1 = 0,
        /// DBG_CAN2_STOP [21:21]
        /// DBG_CAN2_STOP
        DBG_CAN2_STOP: u1 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// DBGMCU_CR
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x4);
};

/// Universal asynchronous receiver
pub const UART4 = struct {
    pub const base_address = 0x40004c00;
    /// SR
    pub const SR_struct = packed struct {
        /// PE [0:0]
        /// Parity error
        PE: u1 = 0,
        /// FE [1:1]
        /// Framing error
        FE: u1 = 0,
        /// NE [2:2]
        /// Noise error flag
        NE: u1 = 0,
        /// ORE [3:3]
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE [4:4]
        /// IDLE line detected
        IDLE: u1 = 0,
        /// RXNE [5:5]
        /// Read data register not
        RXNE: u1 = 0,
        /// TC [6:6]
        /// Transmission complete
        TC: u1 = 0,
        /// TXE [7:7]
        /// Transmit data register
        TXE: u1 = 0,
        /// LBD [8:8]
        /// LIN break detection flag
        LBD: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_SR
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:8]
        /// DR
        DR: u9 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_DR
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4);

    /// BRR
    pub const BRR_struct = packed struct {
        /// DIV_Fraction [0:3]
        /// DIV_Fraction
        DIV_Fraction: u4 = 0,
        /// DIV_Mantissa [4:15]
        /// DIV_Mantissa
        DIV_Mantissa: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_BRR
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x8);

    /// CR1
    pub const CR1_struct = packed struct {
        /// SBK [0:0]
        /// Send break
        SBK: u1 = 0,
        /// RWU [1:1]
        /// Receiver wakeup
        RWU: u1 = 0,
        /// RE [2:2]
        /// Receiver enable
        RE: u1 = 0,
        /// TE [3:3]
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLEIE [4:4]
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNEIE [5:5]
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// TCIE [6:6]
        /// Transmission complete interrupt
        TCIE: u1 = 0,
        /// TXEIE [7:7]
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PEIE [8:8]
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// PS [9:9]
        /// Parity selection
        PS: u1 = 0,
        /// PCE [10:10]
        /// Parity control enable
        PCE: u1 = 0,
        /// WAKE [11:11]
        /// Wakeup method
        WAKE: u1 = 0,
        /// M [12:12]
        /// Word length
        M: u1 = 0,
        /// UE [13:13]
        /// USART enable
        UE: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_CR1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0xc);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADD [0:3]
        /// Address of the USART node
        ADD: u4 = 0,
        /// unused [4:4]
        _unused4: u1 = 0,
        /// LBDL [5:5]
        /// lin break detection length
        LBDL: u1 = 0,
        /// LBDIE [6:6]
        /// LIN break detection interrupt
        LBDIE: u1 = 0,
        /// unused [7:11]
        _unused7: u1 = 0,
        _unused8: u4 = 0,
        /// STOP [12:13]
        /// STOP bits
        STOP: u2 = 0,
        /// LINEN [14:14]
        /// LIN mode enable
        LINEN: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_CR2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x10);

    /// CR3
    pub const CR3_struct = packed struct {
        /// EIE [0:0]
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IREN [1:1]
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IRLP [2:2]
        /// IrDA low-power
        IRLP: u1 = 0,
        /// HDSEL [3:3]
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// unused [4:5]
        _unused4: u2 = 0,
        /// DMAR [6:6]
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMAT [7:7]
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_CR3
    pub const CR3: *volatile CR3_struct = @ptrFromInt(base_address + 0x14);
};

/// Universal asynchronous receiver
pub const UART5 = struct {
    pub const base_address = 0x40005000;
    /// SR
    pub const SR_struct = packed struct {
        /// PE [0:0]
        /// PE
        PE: u1 = 0,
        /// FE [1:1]
        /// FE
        FE: u1 = 0,
        /// NE [2:2]
        /// NE
        NE: u1 = 0,
        /// ORE [3:3]
        /// ORE
        ORE: u1 = 0,
        /// IDLE [4:4]
        /// IDLE
        IDLE: u1 = 0,
        /// RXNE [5:5]
        /// RXNE
        RXNE: u1 = 0,
        /// TC [6:6]
        /// TC
        TC: u1 = 0,
        /// TXE [7:7]
        /// TXE
        TXE: u1 = 0,
        /// LBD [8:8]
        /// LBD
        LBD: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_SR
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0x0);

    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:8]
        /// DR
        DR: u9 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_DR
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x4);

    /// BRR
    pub const BRR_struct = packed struct {
        /// DIV_Fraction [0:3]
        /// DIV_Fraction
        DIV_Fraction: u4 = 0,
        /// DIV_Mantissa [4:15]
        /// DIV_Mantissa
        DIV_Mantissa: u12 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_BRR
    pub const BRR: *volatile BRR_struct = @ptrFromInt(base_address + 0x8);

    /// CR1
    pub const CR1_struct = packed struct {
        /// SBK [0:0]
        /// SBK
        SBK: u1 = 0,
        /// RWU [1:1]
        /// RWU
        RWU: u1 = 0,
        /// RE [2:2]
        /// RE
        RE: u1 = 0,
        /// TE [3:3]
        /// TE
        TE: u1 = 0,
        /// IDLEIE [4:4]
        /// IDLEIE
        IDLEIE: u1 = 0,
        /// RXNEIE [5:5]
        /// RXNEIE
        RXNEIE: u1 = 0,
        /// TCIE [6:6]
        /// TCIE
        TCIE: u1 = 0,
        /// TXEIE [7:7]
        /// TXEIE
        TXEIE: u1 = 0,
        /// PEIE [8:8]
        /// PEIE
        PEIE: u1 = 0,
        /// PS [9:9]
        /// PS
        PS: u1 = 0,
        /// PCE [10:10]
        /// PCE
        PCE: u1 = 0,
        /// WAKE [11:11]
        /// WAKE
        WAKE: u1 = 0,
        /// M [12:12]
        /// M
        M: u1 = 0,
        /// UE [13:13]
        /// UE
        UE: u1 = 0,
        /// unused [14:31]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_CR1
    pub const CR1: *volatile CR1_struct = @ptrFromInt(base_address + 0xc);

    /// CR2
    pub const CR2_struct = packed struct {
        /// ADD [0:3]
        /// ADD
        ADD: u4 = 0,
        /// unused [4:4]
        _unused4: u1 = 0,
        /// LBDL [5:5]
        /// LBDL
        LBDL: u1 = 0,
        /// LBDIE [6:6]
        /// LBDIE
        LBDIE: u1 = 0,
        /// unused [7:11]
        _unused7: u1 = 0,
        _unused8: u4 = 0,
        /// STOP [12:13]
        /// STOP
        STOP: u2 = 0,
        /// LINEN [14:14]
        /// LINEN
        LINEN: u1 = 0,
        /// unused [15:31]
        _unused15: u1 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_CR2
    pub const CR2: *volatile CR2_struct = @ptrFromInt(base_address + 0x10);

    /// CR3
    pub const CR3_struct = packed struct {
        /// EIE [0:0]
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IREN [1:1]
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IRLP [2:2]
        /// IrDA low-power
        IRLP: u1 = 0,
        /// HDSEL [3:3]
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// DMAT [7:7]
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// UART4_CR3
    pub const CR3: *volatile CR3_struct = @ptrFromInt(base_address + 0x14);
};

/// CRC calculation unit
pub const CRC = struct {
    pub const base_address = 0x40023000;
    /// DR
    pub const DR_struct = packed struct {
        /// DR [0:31]
        /// Data Register
        DR: u32 = 4294967295,
    };
    /// Data register
    pub const DR: *volatile DR_struct = @ptrFromInt(base_address + 0x0);

    /// IDR
    pub const IDR_struct = packed struct {
        /// IDR [0:7]
        /// Independent Data register
        IDR: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Independent Data register
    pub const IDR: *volatile IDR_struct = @ptrFromInt(base_address + 0x4);

    /// CR
    pub const CR_struct = packed struct {
        /// RESET [0:0]
        /// Reset bit
        RESET: u1 = 0,
        /// unused [1:31]
        _unused1: u7 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x8);
};

/// FLASH
pub const FLASH = struct {
    pub const base_address = 0x40022000;
    /// ACR
    pub const ACR_struct = packed struct {
        /// LATENCY [0:2]
        /// Latency
        LATENCY: u3 = 0,
        /// HLFCYA [3:3]
        /// Flash half cycle access
        HLFCYA: u1 = 0,
        /// PRFTBE [4:4]
        /// Prefetch buffer enable
        PRFTBE: u1 = 1,
        /// PRFTBS [5:5]
        /// Prefetch buffer status
        PRFTBS: u1 = 1,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Flash access control register
    pub const ACR: *volatile ACR_struct = @ptrFromInt(base_address + 0x0);

    /// KEYR
    pub const KEYR_struct = packed struct {
        /// KEY [0:31]
        /// FPEC key
        KEY: u32 = 0,
    };
    /// Flash key register
    pub const KEYR: *volatile KEYR_struct = @ptrFromInt(base_address + 0x4);

    /// OPTKEYR
    pub const OPTKEYR_struct = packed struct {
        /// OPTKEY [0:31]
        /// Option byte key
        OPTKEY: u32 = 0,
    };
    /// Flash option key register
    pub const OPTKEYR: *volatile OPTKEYR_struct = @ptrFromInt(base_address + 0x8);

    /// SR
    pub const SR_struct = packed struct {
        /// BSY [0:0]
        /// Busy
        BSY: u1 = 0,
        /// unused [1:1]
        _unused1: u1 = 0,
        /// PGERR [2:2]
        /// Programming error
        PGERR: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// WRPRTERR [4:4]
        /// Write protection error
        WRPRTERR: u1 = 0,
        /// EOP [5:5]
        /// End of operation
        EOP: u1 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Status register
    pub const SR: *volatile SR_struct = @ptrFromInt(base_address + 0xc);

    /// CR
    pub const CR_struct = packed struct {
        /// PG [0:0]
        /// Programming
        PG: u1 = 0,
        /// PER [1:1]
        /// Page Erase
        PER: u1 = 0,
        /// MER [2:2]
        /// Mass Erase
        MER: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// OPTPG [4:4]
        /// Option byte programming
        OPTPG: u1 = 0,
        /// OPTER [5:5]
        /// Option byte erase
        OPTER: u1 = 0,
        /// STRT [6:6]
        /// Start
        STRT: u1 = 0,
        /// LOCK [7:7]
        /// Lock
        LOCK: u1 = 1,
        /// unused [8:8]
        _unused8: u1 = 0,
        /// OPTWRE [9:9]
        /// Option bytes write enable
        OPTWRE: u1 = 0,
        /// ERRIE [10:10]
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// unused [11:11]
        _unused11: u1 = 0,
        /// EOPIE [12:12]
        /// End of operation interrupt
        EOPIE: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Control register
    pub const CR: *volatile CR_struct = @ptrFromInt(base_address + 0x10);

    /// AR
    pub const AR_struct = packed struct {
        /// FAR [0:31]
        /// Flash Address
        FAR: u32 = 0,
    };
    /// Flash address register
    pub const AR: *volatile AR_struct = @ptrFromInt(base_address + 0x14);

    /// OBR
    pub const OBR_struct = packed struct {
        /// OPTERR [0:0]
        /// Option byte error
        OPTERR: u1 = 0,
        /// RDPRT [1:1]
        /// Read protection
        RDPRT: u1 = 0,
        /// WDG_SW [2:2]
        /// WDG_SW
        WDG_SW: u1 = 1,
        /// nRST_STOP [3:3]
        /// nRST_STOP
        nRST_STOP: u1 = 1,
        /// nRST_STDBY [4:4]
        /// nRST_STDBY
        nRST_STDBY: u1 = 1,
        /// unused [5:9]
        _unused5: u3 = 7,
        _unused8: u2 = 3,
        /// Data0 [10:17]
        /// Data0
        Data0: u8 = 255,
        /// Data1 [18:25]
        /// Data1
        Data1: u8 = 255,
        /// unused [26:31]
        _unused26: u6 = 0,
    };
    /// Option byte register
    pub const OBR: *volatile OBR_struct = @ptrFromInt(base_address + 0x1c);

    /// WRPR
    pub const WRPR_struct = packed struct {
        /// WRP [0:31]
        /// Write protect
        WRP: u32 = 4294967295,
    };
    /// Write protection register
    pub const WRPR: *volatile WRPR_struct = @ptrFromInt(base_address + 0x20);
};

/// Universal serial bus full-speed device
pub const USB = struct {
    pub const base_address = 0x40005c00;
    /// EP0R
    pub const EP0R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 0 register
    pub const EP0R: *volatile EP0R_struct = @ptrFromInt(base_address + 0x0);

    /// EP1R
    pub const EP1R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 1 register
    pub const EP1R: *volatile EP1R_struct = @ptrFromInt(base_address + 0x4);

    /// EP2R
    pub const EP2R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 2 register
    pub const EP2R: *volatile EP2R_struct = @ptrFromInt(base_address + 0x8);

    /// EP3R
    pub const EP3R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 3 register
    pub const EP3R: *volatile EP3R_struct = @ptrFromInt(base_address + 0xc);

    /// EP4R
    pub const EP4R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 4 register
    pub const EP4R: *volatile EP4R_struct = @ptrFromInt(base_address + 0x10);

    /// EP5R
    pub const EP5R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 5 register
    pub const EP5R: *volatile EP5R_struct = @ptrFromInt(base_address + 0x14);

    /// EP6R
    pub const EP6R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 6 register
    pub const EP6R: *volatile EP6R_struct = @ptrFromInt(base_address + 0x18);

    /// EP7R
    pub const EP7R_struct = packed struct {
        /// EA [0:3]
        /// Endpoint address
        EA: u4 = 0,
        /// STAT_TX [4:5]
        /// Status bits, for transmission
        STAT_TX: u2 = 0,
        /// DTOG_TX [6:6]
        /// Data Toggle, for transmission
        DTOG_TX: u1 = 0,
        /// CTR_TX [7:7]
        /// Correct Transfer for
        CTR_TX: u1 = 0,
        /// EP_KIND [8:8]
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// EP_TYPE [9:10]
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// SETUP [11:11]
        /// Setup transaction
        SETUP: u1 = 0,
        /// STAT_RX [12:13]
        /// Status bits, for reception
        STAT_RX: u2 = 0,
        /// DTOG_RX [14:14]
        /// Data Toggle, for reception
        DTOG_RX: u1 = 0,
        /// CTR_RX [15:15]
        /// Correct transfer for
        CTR_RX: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// endpoint 7 register
    pub const EP7R: *volatile EP7R_struct = @ptrFromInt(base_address + 0x1c);

    /// CNTR
    pub const CNTR_struct = packed struct {
        /// FRES [0:0]
        /// Force USB Reset
        FRES: u1 = 1,
        /// PDWN [1:1]
        /// Power down
        PDWN: u1 = 1,
        /// LPMODE [2:2]
        /// Low-power mode
        LPMODE: u1 = 0,
        /// FSUSP [3:3]
        /// Force suspend
        FSUSP: u1 = 0,
        /// RESUME [4:4]
        /// Resume request
        RESUME: u1 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// ESOFM [8:8]
        /// Expected start of frame interrupt
        ESOFM: u1 = 0,
        /// SOFM [9:9]
        /// Start of frame interrupt
        SOFM: u1 = 0,
        /// RESETM [10:10]
        /// USB reset interrupt mask
        RESETM: u1 = 0,
        /// SUSPM [11:11]
        /// Suspend mode interrupt
        SUSPM: u1 = 0,
        /// WKUPM [12:12]
        /// Wakeup interrupt mask
        WKUPM: u1 = 0,
        /// ERRM [13:13]
        /// Error interrupt mask
        ERRM: u1 = 0,
        /// PMAOVRM [14:14]
        /// Packet memory area over / underrun
        PMAOVRM: u1 = 0,
        /// CTRM [15:15]
        /// Correct transfer interrupt
        CTRM: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// control register
    pub const CNTR: *volatile CNTR_struct = @ptrFromInt(base_address + 0x40);

    /// ISTR
    pub const ISTR_struct = packed struct {
        /// EP_ID [0:3]
        /// Endpoint Identifier
        EP_ID: u4 = 0,
        /// DIR [4:4]
        /// Direction of transaction
        DIR: u1 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// ESOF [8:8]
        /// Expected start frame
        ESOF: u1 = 0,
        /// SOF [9:9]
        /// start of frame
        SOF: u1 = 0,
        /// RESET [10:10]
        /// reset request
        RESET: u1 = 0,
        /// SUSP [11:11]
        /// Suspend mode request
        SUSP: u1 = 0,
        /// WKUP [12:12]
        /// Wakeup
        WKUP: u1 = 0,
        /// ERR [13:13]
        /// Error
        ERR: u1 = 0,
        /// PMAOVR [14:14]
        /// Packet memory area over /
        PMAOVR: u1 = 0,
        /// CTR [15:15]
        /// Correct transfer
        CTR: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// interrupt status register
    pub const ISTR: *volatile ISTR_struct = @ptrFromInt(base_address + 0x44);

    /// FNR
    pub const FNR_struct = packed struct {
        /// FN [0:10]
        /// Frame number
        FN: u11 = 0,
        /// LSOF [11:12]
        /// Lost SOF
        LSOF: u2 = 0,
        /// LCK [13:13]
        /// Locked
        LCK: u1 = 0,
        /// RXDM [14:14]
        /// Receive data - line status
        RXDM: u1 = 0,
        /// RXDP [15:15]
        /// Receive data + line status
        RXDP: u1 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// frame number register
    pub const FNR: *volatile FNR_struct = @ptrFromInt(base_address + 0x48);

    /// DADDR
    pub const DADDR_struct = packed struct {
        /// ADD [0:6]
        /// Device address
        ADD: u7 = 0,
        /// EF [7:7]
        /// Enable function
        EF: u1 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device address
    pub const DADDR: *volatile DADDR_struct = @ptrFromInt(base_address + 0x4c);

    /// BTABLE
    pub const BTABLE_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// BTABLE [3:15]
        /// Buffer table
        BTABLE: u13 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Buffer table address
    pub const BTABLE: *volatile BTABLE_struct = @ptrFromInt(base_address + 0x50);
};

/// USB on the go full speed
pub const OTG_FS_DEVICE = struct {
    pub const base_address = 0x50000800;
    /// FS_DCFG
    pub const FS_DCFG_struct = packed struct {
        /// DSPD [0:1]
        /// Device speed
        DSPD: u2 = 0,
        /// NZLSOHSK [2:2]
        /// Non-zero-length status OUT
        NZLSOHSK: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// DAD [4:10]
        /// Device address
        DAD: u7 = 0,
        /// PFIVL [11:12]
        /// Periodic frame interval
        PFIVL: u2 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 32,
        _unused24: u8 = 2,
    };
    /// OTG_FS device configuration register
    pub const FS_DCFG: *volatile FS_DCFG_struct = @ptrFromInt(base_address + 0x0);

    /// FS_DCTL
    pub const FS_DCTL_struct = packed struct {
        /// RWUSIG [0:0]
        /// Remote wakeup signaling
        RWUSIG: u1 = 0,
        /// SDIS [1:1]
        /// Soft disconnect
        SDIS: u1 = 0,
        /// GINSTS [2:2]
        /// Global IN NAK status
        GINSTS: u1 = 0,
        /// GONSTS [3:3]
        /// Global OUT NAK status
        GONSTS: u1 = 0,
        /// TCTL [4:6]
        /// Test control
        TCTL: u3 = 0,
        /// SGINAK [7:7]
        /// Set global IN NAK
        SGINAK: u1 = 0,
        /// CGINAK [8:8]
        /// Clear global IN NAK
        CGINAK: u1 = 0,
        /// SGONAK [9:9]
        /// Set global OUT NAK
        SGONAK: u1 = 0,
        /// CGONAK [10:10]
        /// Clear global OUT NAK
        CGONAK: u1 = 0,
        /// POPRGDNE [11:11]
        /// Power-on programming done
        POPRGDNE: u1 = 0,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device control register
    pub const FS_DCTL: *volatile FS_DCTL_struct = @ptrFromInt(base_address + 0x4);

    /// FS_DSTS
    pub const FS_DSTS_struct = packed struct {
        /// SUSPSTS [0:0]
        /// Suspend status
        SUSPSTS: u1 = 0,
        /// ENUMSPD [1:2]
        /// Enumerated speed
        ENUMSPD: u2 = 0,
        /// EERR [3:3]
        /// Erratic error
        EERR: u1 = 0,
        /// unused [4:7]
        _unused4: u4 = 1,
        /// FNSOF [8:21]
        /// Frame number of the received
        FNSOF: u14 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device status register
    pub const FS_DSTS: *volatile FS_DSTS_struct = @ptrFromInt(base_address + 0x8);

    /// FS_DIEPMSK
    pub const FS_DIEPMSK_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed interrupt
        XFRCM: u1 = 0,
        /// EPDM [1:1]
        /// Endpoint disabled interrupt
        EPDM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// TOM [3:3]
        /// Timeout condition mask (Non-isochronous
        TOM: u1 = 0,
        /// ITTXFEMSK [4:4]
        /// IN token received when TxFIFO empty
        ITTXFEMSK: u1 = 0,
        /// INEPNMM [5:5]
        /// IN token received with EP mismatch
        INEPNMM: u1 = 0,
        /// INEPNEM [6:6]
        /// IN endpoint NAK effective
        INEPNEM: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device IN endpoint common interrupt
    pub const FS_DIEPMSK: *volatile FS_DIEPMSK_struct = @ptrFromInt(base_address + 0x10);

    /// FS_DOEPMSK
    pub const FS_DOEPMSK_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed interrupt
        XFRCM: u1 = 0,
        /// EPDM [1:1]
        /// Endpoint disabled interrupt
        EPDM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STUPM [3:3]
        /// SETUP phase done mask
        STUPM: u1 = 0,
        /// OTEPDM [4:4]
        /// OUT token received when endpoint
        OTEPDM: u1 = 0,
        /// unused [5:31]
        _unused5: u3 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device OUT endpoint common interrupt
    pub const FS_DOEPMSK: *volatile FS_DOEPMSK_struct = @ptrFromInt(base_address + 0x14);

    /// FS_DAINT
    pub const FS_DAINT_struct = packed struct {
        /// IEPINT [0:15]
        /// IN endpoint interrupt bits
        IEPINT: u16 = 0,
        /// OEPINT [16:31]
        /// OUT endpoint interrupt
        OEPINT: u16 = 0,
    };
    /// OTG_FS device all endpoints interrupt
    pub const FS_DAINT: *volatile FS_DAINT_struct = @ptrFromInt(base_address + 0x18);

    /// FS_DAINTMSK
    pub const FS_DAINTMSK_struct = packed struct {
        /// IEPM [0:15]
        /// IN EP interrupt mask bits
        IEPM: u16 = 0,
        /// OEPINT [16:31]
        /// OUT endpoint interrupt
        OEPINT: u16 = 0,
    };
    /// OTG_FS all endpoints interrupt mask register
    pub const FS_DAINTMSK: *volatile FS_DAINTMSK_struct = @ptrFromInt(base_address + 0x1c);

    /// DVBUSDIS
    pub const DVBUSDIS_struct = packed struct {
        /// VBUSDT [0:15]
        /// Device VBUS discharge time
        VBUSDT: u16 = 6103,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device VBUS discharge time
    pub const DVBUSDIS: *volatile DVBUSDIS_struct = @ptrFromInt(base_address + 0x28);

    /// DVBUSPULSE
    pub const DVBUSPULSE_struct = packed struct {
        /// DVBUSP [0:11]
        /// Device VBUS pulsing time
        DVBUSP: u12 = 1464,
        /// unused [12:31]
        _unused12: u4 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device VBUS pulsing time
    pub const DVBUSPULSE: *volatile DVBUSPULSE_struct = @ptrFromInt(base_address + 0x2c);

    /// DIEPEMPMSK
    pub const DIEPEMPMSK_struct = packed struct {
        /// INEPTXFEM [0:15]
        /// IN EP Tx FIFO empty interrupt mask
        INEPTXFEM: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device IN endpoint FIFO empty
    pub const DIEPEMPMSK: *volatile DIEPEMPMSK_struct = @ptrFromInt(base_address + 0x34);

    /// FS_DIEPCTL0
    pub const FS_DIEPCTL0_struct = packed struct {
        /// MPSIZ [0:1]
        /// Maximum packet size
        MPSIZ: u2 = 0,
        /// unused [2:14]
        _unused2: u6 = 0,
        _unused8: u7 = 0,
        /// USBAEP [15:15]
        /// USB active endpoint
        USBAEP: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// NAKSTS [17:17]
        /// NAK status
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// unused [20:20]
        _unused20: u1 = 0,
        /// STALL [21:21]
        /// STALL handshake
        STALL: u1 = 0,
        /// TXFNUM [22:25]
        /// TxFIFO number
        TXFNUM: u4 = 0,
        /// CNAK [26:26]
        /// Clear NAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// Set NAK
        SNAK: u1 = 0,
        /// unused [28:29]
        _unused28: u2 = 0,
        /// EPDIS [30:30]
        /// Endpoint disable
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// Endpoint enable
        EPENA: u1 = 0,
    };
    /// OTG_FS device control IN endpoint 0 control
    pub const FS_DIEPCTL0: *volatile FS_DIEPCTL0_struct = @ptrFromInt(base_address + 0x100);

    /// DIEPCTL1
    pub const DIEPCTL1_struct = packed struct {
        /// MPSIZ [0:10]
        /// MPSIZ
        MPSIZ: u11 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 0,
        /// EONUM_DPID [16:16]
        /// EONUM/DPID
        EONUM_DPID: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// unused [20:20]
        _unused20: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// TXFNUM [22:25]
        /// TXFNUM
        TXFNUM: u4 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// SD0PID_SEVNFRM [28:28]
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1 = 0,
        /// SODDFRM_SD1PID [29:29]
        /// SODDFRM/SD1PID
        SODDFRM_SD1PID: u1 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// OTG device endpoint-1 control
    pub const DIEPCTL1: *volatile DIEPCTL1_struct = @ptrFromInt(base_address + 0x120);

    /// DIEPCTL2
    pub const DIEPCTL2_struct = packed struct {
        /// MPSIZ [0:10]
        /// MPSIZ
        MPSIZ: u11 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 0,
        /// EONUM_DPID [16:16]
        /// EONUM/DPID
        EONUM_DPID: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// unused [20:20]
        _unused20: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// TXFNUM [22:25]
        /// TXFNUM
        TXFNUM: u4 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// SD0PID_SEVNFRM [28:28]
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1 = 0,
        /// SODDFRM [29:29]
        /// SODDFRM
        SODDFRM: u1 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// OTG device endpoint-2 control
    pub const DIEPCTL2: *volatile DIEPCTL2_struct = @ptrFromInt(base_address + 0x140);

    /// DIEPCTL3
    pub const DIEPCTL3_struct = packed struct {
        /// MPSIZ [0:10]
        /// MPSIZ
        MPSIZ: u11 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 0,
        /// EONUM_DPID [16:16]
        /// EONUM/DPID
        EONUM_DPID: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// unused [20:20]
        _unused20: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// TXFNUM [22:25]
        /// TXFNUM
        TXFNUM: u4 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// SD0PID_SEVNFRM [28:28]
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1 = 0,
        /// SODDFRM [29:29]
        /// SODDFRM
        SODDFRM: u1 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// OTG device endpoint-3 control
    pub const DIEPCTL3: *volatile DIEPCTL3_struct = @ptrFromInt(base_address + 0x160);

    /// DOEPCTL0
    pub const DOEPCTL0_struct = packed struct {
        /// MPSIZ [0:1]
        /// MPSIZ
        MPSIZ: u2 = 0,
        /// unused [2:14]
        _unused2: u6 = 0,
        _unused8: u7 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 1,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// SNPM [20:20]
        /// SNPM
        SNPM: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// unused [22:25]
        _unused22: u2 = 0,
        _unused24: u2 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// unused [28:29]
        _unused28: u2 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// device endpoint-0 control
    pub const DOEPCTL0: *volatile DOEPCTL0_struct = @ptrFromInt(base_address + 0x300);

    /// DOEPCTL1
    pub const DOEPCTL1_struct = packed struct {
        /// MPSIZ [0:10]
        /// MPSIZ
        MPSIZ: u11 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 0,
        /// EONUM_DPID [16:16]
        /// EONUM/DPID
        EONUM_DPID: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// SNPM [20:20]
        /// SNPM
        SNPM: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// unused [22:25]
        _unused22: u2 = 0,
        _unused24: u2 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// SD0PID_SEVNFRM [28:28]
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1 = 0,
        /// SODDFRM [29:29]
        /// SODDFRM
        SODDFRM: u1 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// device endpoint-1 control
    pub const DOEPCTL1: *volatile DOEPCTL1_struct = @ptrFromInt(base_address + 0x320);

    /// DOEPCTL2
    pub const DOEPCTL2_struct = packed struct {
        /// MPSIZ [0:10]
        /// MPSIZ
        MPSIZ: u11 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 0,
        /// EONUM_DPID [16:16]
        /// EONUM/DPID
        EONUM_DPID: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// SNPM [20:20]
        /// SNPM
        SNPM: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// unused [22:25]
        _unused22: u2 = 0,
        _unused24: u2 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// SD0PID_SEVNFRM [28:28]
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1 = 0,
        /// SODDFRM [29:29]
        /// SODDFRM
        SODDFRM: u1 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// device endpoint-2 control
    pub const DOEPCTL2: *volatile DOEPCTL2_struct = @ptrFromInt(base_address + 0x340);

    /// DOEPCTL3
    pub const DOEPCTL3_struct = packed struct {
        /// MPSIZ [0:10]
        /// MPSIZ
        MPSIZ: u11 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// USBAEP [15:15]
        /// USBAEP
        USBAEP: u1 = 0,
        /// EONUM_DPID [16:16]
        /// EONUM/DPID
        EONUM_DPID: u1 = 0,
        /// NAKSTS [17:17]
        /// NAKSTS
        NAKSTS: u1 = 0,
        /// EPTYP [18:19]
        /// EPTYP
        EPTYP: u2 = 0,
        /// SNPM [20:20]
        /// SNPM
        SNPM: u1 = 0,
        /// Stall [21:21]
        /// Stall
        Stall: u1 = 0,
        /// unused [22:25]
        _unused22: u2 = 0,
        _unused24: u2 = 0,
        /// CNAK [26:26]
        /// CNAK
        CNAK: u1 = 0,
        /// SNAK [27:27]
        /// SNAK
        SNAK: u1 = 0,
        /// SD0PID_SEVNFRM [28:28]
        /// SD0PID/SEVNFRM
        SD0PID_SEVNFRM: u1 = 0,
        /// SODDFRM [29:29]
        /// SODDFRM
        SODDFRM: u1 = 0,
        /// EPDIS [30:30]
        /// EPDIS
        EPDIS: u1 = 0,
        /// EPENA [31:31]
        /// EPENA
        EPENA: u1 = 0,
    };
    /// device endpoint-3 control
    pub const DOEPCTL3: *volatile DOEPCTL3_struct = @ptrFromInt(base_address + 0x360);

    /// DIEPINT0
    pub const DIEPINT0_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// TOC [3:3]
        /// TOC
        TOC: u1 = 0,
        /// ITTXFE [4:4]
        /// ITTXFE
        ITTXFE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// INEPNE [6:6]
        /// INEPNE
        INEPNE: u1 = 0,
        /// TXFE [7:7]
        /// TXFE
        TXFE: u1 = 1,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-x interrupt
    pub const DIEPINT0: *volatile DIEPINT0_struct = @ptrFromInt(base_address + 0x108);

    /// DIEPINT1
    pub const DIEPINT1_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// TOC [3:3]
        /// TOC
        TOC: u1 = 0,
        /// ITTXFE [4:4]
        /// ITTXFE
        ITTXFE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// INEPNE [6:6]
        /// INEPNE
        INEPNE: u1 = 0,
        /// TXFE [7:7]
        /// TXFE
        TXFE: u1 = 1,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-1 interrupt
    pub const DIEPINT1: *volatile DIEPINT1_struct = @ptrFromInt(base_address + 0x128);

    /// DIEPINT2
    pub const DIEPINT2_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// TOC [3:3]
        /// TOC
        TOC: u1 = 0,
        /// ITTXFE [4:4]
        /// ITTXFE
        ITTXFE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// INEPNE [6:6]
        /// INEPNE
        INEPNE: u1 = 0,
        /// TXFE [7:7]
        /// TXFE
        TXFE: u1 = 1,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-2 interrupt
    pub const DIEPINT2: *volatile DIEPINT2_struct = @ptrFromInt(base_address + 0x148);

    /// DIEPINT3
    pub const DIEPINT3_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// TOC [3:3]
        /// TOC
        TOC: u1 = 0,
        /// ITTXFE [4:4]
        /// ITTXFE
        ITTXFE: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// INEPNE [6:6]
        /// INEPNE
        INEPNE: u1 = 0,
        /// TXFE [7:7]
        /// TXFE
        TXFE: u1 = 1,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-3 interrupt
    pub const DIEPINT3: *volatile DIEPINT3_struct = @ptrFromInt(base_address + 0x168);

    /// DOEPINT0
    pub const DOEPINT0_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STUP [3:3]
        /// STUP
        STUP: u1 = 0,
        /// OTEPDIS [4:4]
        /// OTEPDIS
        OTEPDIS: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// B2BSTUP [6:6]
        /// B2BSTUP
        B2BSTUP: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 1,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-0 interrupt
    pub const DOEPINT0: *volatile DOEPINT0_struct = @ptrFromInt(base_address + 0x308);

    /// DOEPINT1
    pub const DOEPINT1_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STUP [3:3]
        /// STUP
        STUP: u1 = 0,
        /// OTEPDIS [4:4]
        /// OTEPDIS
        OTEPDIS: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// B2BSTUP [6:6]
        /// B2BSTUP
        B2BSTUP: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 1,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-1 interrupt
    pub const DOEPINT1: *volatile DOEPINT1_struct = @ptrFromInt(base_address + 0x328);

    /// DOEPINT2
    pub const DOEPINT2_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STUP [3:3]
        /// STUP
        STUP: u1 = 0,
        /// OTEPDIS [4:4]
        /// OTEPDIS
        OTEPDIS: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// B2BSTUP [6:6]
        /// B2BSTUP
        B2BSTUP: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 1,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-2 interrupt
    pub const DOEPINT2: *volatile DOEPINT2_struct = @ptrFromInt(base_address + 0x348);

    /// DOEPINT3
    pub const DOEPINT3_struct = packed struct {
        /// XFRC [0:0]
        /// XFRC
        XFRC: u1 = 0,
        /// EPDISD [1:1]
        /// EPDISD
        EPDISD: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STUP [3:3]
        /// STUP
        STUP: u1 = 0,
        /// OTEPDIS [4:4]
        /// OTEPDIS
        OTEPDIS: u1 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// B2BSTUP [6:6]
        /// B2BSTUP
        B2BSTUP: u1 = 0,
        /// unused [7:31]
        _unused7: u1 = 1,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-3 interrupt
    pub const DOEPINT3: *volatile DOEPINT3_struct = @ptrFromInt(base_address + 0x368);

    /// DIEPTSIZ0
    pub const DIEPTSIZ0_struct = packed struct {
        /// XFRSIZ [0:6]
        /// Transfer size
        XFRSIZ: u7 = 0,
        /// unused [7:18]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u3 = 0,
        /// PKTCNT [19:20]
        /// Packet count
        PKTCNT: u2 = 0,
        /// unused [21:31]
        _unused21: u3 = 0,
        _unused24: u8 = 0,
    };
    /// device endpoint-0 transfer size
    pub const DIEPTSIZ0: *volatile DIEPTSIZ0_struct = @ptrFromInt(base_address + 0x110);

    /// DOEPTSIZ0
    pub const DOEPTSIZ0_struct = packed struct {
        /// XFRSIZ [0:6]
        /// Transfer size
        XFRSIZ: u7 = 0,
        /// unused [7:18]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u3 = 0,
        /// PKTCNT [19:19]
        /// Packet count
        PKTCNT: u1 = 0,
        /// unused [20:28]
        _unused20: u4 = 0,
        _unused24: u5 = 0,
        /// STUPCNT [29:30]
        /// SETUP packet count
        STUPCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device OUT endpoint-0 transfer size
    pub const DOEPTSIZ0: *volatile DOEPTSIZ0_struct = @ptrFromInt(base_address + 0x310);

    /// DIEPTSIZ1
    pub const DIEPTSIZ1_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// MCNT [29:30]
        /// Multi count
        MCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device endpoint-1 transfer size
    pub const DIEPTSIZ1: *volatile DIEPTSIZ1_struct = @ptrFromInt(base_address + 0x130);

    /// DIEPTSIZ2
    pub const DIEPTSIZ2_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// MCNT [29:30]
        /// Multi count
        MCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device endpoint-2 transfer size
    pub const DIEPTSIZ2: *volatile DIEPTSIZ2_struct = @ptrFromInt(base_address + 0x150);

    /// DIEPTSIZ3
    pub const DIEPTSIZ3_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// MCNT [29:30]
        /// Multi count
        MCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device endpoint-3 transfer size
    pub const DIEPTSIZ3: *volatile DIEPTSIZ3_struct = @ptrFromInt(base_address + 0x170);

    /// DTXFSTS0
    pub const DTXFSTS0_struct = packed struct {
        /// INEPTFSAV [0:15]
        /// IN endpoint TxFIFO space
        INEPTFSAV: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device IN endpoint transmit FIFO
    pub const DTXFSTS0: *volatile DTXFSTS0_struct = @ptrFromInt(base_address + 0x118);

    /// DTXFSTS1
    pub const DTXFSTS1_struct = packed struct {
        /// INEPTFSAV [0:15]
        /// IN endpoint TxFIFO space
        INEPTFSAV: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device IN endpoint transmit FIFO
    pub const DTXFSTS1: *volatile DTXFSTS1_struct = @ptrFromInt(base_address + 0x138);

    /// DTXFSTS2
    pub const DTXFSTS2_struct = packed struct {
        /// INEPTFSAV [0:15]
        /// IN endpoint TxFIFO space
        INEPTFSAV: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device IN endpoint transmit FIFO
    pub const DTXFSTS2: *volatile DTXFSTS2_struct = @ptrFromInt(base_address + 0x158);

    /// DTXFSTS3
    pub const DTXFSTS3_struct = packed struct {
        /// INEPTFSAV [0:15]
        /// IN endpoint TxFIFO space
        INEPTFSAV: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS device IN endpoint transmit FIFO
    pub const DTXFSTS3: *volatile DTXFSTS3_struct = @ptrFromInt(base_address + 0x178);

    /// DOEPTSIZ1
    pub const DOEPTSIZ1_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// RXDPID_STUPCNT [29:30]
        /// Received data PID/SETUP packet
        RXDPID_STUPCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device OUT endpoint-1 transfer size
    pub const DOEPTSIZ1: *volatile DOEPTSIZ1_struct = @ptrFromInt(base_address + 0x330);

    /// DOEPTSIZ2
    pub const DOEPTSIZ2_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// RXDPID_STUPCNT [29:30]
        /// Received data PID/SETUP packet
        RXDPID_STUPCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device OUT endpoint-2 transfer size
    pub const DOEPTSIZ2: *volatile DOEPTSIZ2_struct = @ptrFromInt(base_address + 0x350);

    /// DOEPTSIZ3
    pub const DOEPTSIZ3_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// RXDPID_STUPCNT [29:30]
        /// Received data PID/SETUP packet
        RXDPID_STUPCNT: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// device OUT endpoint-3 transfer size
    pub const DOEPTSIZ3: *volatile DOEPTSIZ3_struct = @ptrFromInt(base_address + 0x370);
};

/// USB on the go full speed
pub const OTG_FS_GLOBAL = struct {
    pub const base_address = 0x50000000;
    /// FS_GOTGCTL
    pub const FS_GOTGCTL_struct = packed struct {
        /// SRQSCS [0:0]
        /// Session request success
        SRQSCS: u1 = 0,
        /// SRQ [1:1]
        /// Session request
        SRQ: u1 = 0,
        /// unused [2:7]
        _unused2: u6 = 0,
        /// HNGSCS [8:8]
        /// Host negotiation success
        HNGSCS: u1 = 0,
        /// HNPRQ [9:9]
        /// HNP request
        HNPRQ: u1 = 0,
        /// HSHNPEN [10:10]
        /// Host set HNP enable
        HSHNPEN: u1 = 0,
        /// DHNPEN [11:11]
        /// Device HNP enabled
        DHNPEN: u1 = 1,
        /// unused [12:15]
        _unused12: u4 = 0,
        /// CIDSTS [16:16]
        /// Connector ID status
        CIDSTS: u1 = 0,
        /// DBCT [17:17]
        /// Long/short debounce time
        DBCT: u1 = 0,
        /// ASVLD [18:18]
        /// A-session valid
        ASVLD: u1 = 0,
        /// BSVLD [19:19]
        /// B-session valid
        BSVLD: u1 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS control and status register
    pub const FS_GOTGCTL: *volatile FS_GOTGCTL_struct = @ptrFromInt(base_address + 0x0);

    /// FS_GOTGINT
    pub const FS_GOTGINT_struct = packed struct {
        /// unused [0:1]
        _unused0: u2 = 0,
        /// SEDET [2:2]
        /// Session end detected
        SEDET: u1 = 0,
        /// unused [3:7]
        _unused3: u5 = 0,
        /// SRSSCHG [8:8]
        /// Session request success status
        SRSSCHG: u1 = 0,
        /// HNSSCHG [9:9]
        /// Host negotiation success status
        HNSSCHG: u1 = 0,
        /// unused [10:16]
        _unused10: u6 = 0,
        _unused16: u1 = 0,
        /// HNGDET [17:17]
        /// Host negotiation detected
        HNGDET: u1 = 0,
        /// ADTOCHG [18:18]
        /// A-device timeout change
        ADTOCHG: u1 = 0,
        /// DBCDNE [19:19]
        /// Debounce done
        DBCDNE: u1 = 0,
        /// unused [20:31]
        _unused20: u4 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS interrupt register
    pub const FS_GOTGINT: *volatile FS_GOTGINT_struct = @ptrFromInt(base_address + 0x4);

    /// FS_GAHBCFG
    pub const FS_GAHBCFG_struct = packed struct {
        /// GINT [0:0]
        /// Global interrupt mask
        GINT: u1 = 0,
        /// unused [1:6]
        _unused1: u6 = 0,
        /// TXFELVL [7:7]
        /// TxFIFO empty level
        TXFELVL: u1 = 0,
        /// PTXFELVL [8:8]
        /// Periodic TxFIFO empty
        PTXFELVL: u1 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS AHB configuration register
    pub const FS_GAHBCFG: *volatile FS_GAHBCFG_struct = @ptrFromInt(base_address + 0x8);

    /// FS_GUSBCFG
    pub const FS_GUSBCFG_struct = packed struct {
        /// TOCAL [0:2]
        /// FS timeout calibration
        TOCAL: u3 = 0,
        /// unused [3:5]
        _unused3: u3 = 0,
        /// PHYSEL [6:6]
        /// Full Speed serial transceiver
        PHYSEL: u1 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// SRPCAP [8:8]
        /// SRP-capable
        SRPCAP: u1 = 0,
        /// HNPCAP [9:9]
        /// HNP-capable
        HNPCAP: u1 = 1,
        /// TRDT [10:13]
        /// USB turnaround time
        TRDT: u4 = 2,
        /// unused [14:28]
        _unused14: u2 = 0,
        _unused16: u8 = 0,
        _unused24: u5 = 0,
        /// FHMOD [29:29]
        /// Force host mode
        FHMOD: u1 = 0,
        /// FDMOD [30:30]
        /// Force device mode
        FDMOD: u1 = 0,
        /// CTXPKT [31:31]
        /// Corrupt Tx packet
        CTXPKT: u1 = 0,
    };
    /// OTG_FS USB configuration register
    pub const FS_GUSBCFG: *volatile FS_GUSBCFG_struct = @ptrFromInt(base_address + 0xc);

    /// FS_GRSTCTL
    pub const FS_GRSTCTL_struct = packed struct {
        /// CSRST [0:0]
        /// Core soft reset
        CSRST: u1 = 0,
        /// HSRST [1:1]
        /// HCLK soft reset
        HSRST: u1 = 0,
        /// FCRST [2:2]
        /// Host frame counter reset
        FCRST: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// RXFFLSH [4:4]
        /// RxFIFO flush
        RXFFLSH: u1 = 0,
        /// TXFFLSH [5:5]
        /// TxFIFO flush
        TXFFLSH: u1 = 0,
        /// TXFNUM [6:10]
        /// TxFIFO number
        TXFNUM: u5 = 0,
        /// unused [11:30]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u7 = 32,
        /// AHBIDL [31:31]
        /// AHB master idle
        AHBIDL: u1 = 0,
    };
    /// OTG_FS reset register
    pub const FS_GRSTCTL: *volatile FS_GRSTCTL_struct = @ptrFromInt(base_address + 0x10);

    /// FS_GINTSTS
    pub const FS_GINTSTS_struct = packed struct {
        /// CMOD [0:0]
        /// Current mode of operation
        CMOD: u1 = 0,
        /// MMIS [1:1]
        /// Mode mismatch interrupt
        MMIS: u1 = 0,
        /// OTGINT [2:2]
        /// OTG interrupt
        OTGINT: u1 = 0,
        /// SOF [3:3]
        /// Start of frame
        SOF: u1 = 0,
        /// RXFLVL [4:4]
        /// RxFIFO non-empty
        RXFLVL: u1 = 0,
        /// NPTXFE [5:5]
        /// Non-periodic TxFIFO empty
        NPTXFE: u1 = 1,
        /// GINAKEFF [6:6]
        /// Global IN non-periodic NAK
        GINAKEFF: u1 = 0,
        /// GOUTNAKEFF [7:7]
        /// Global OUT NAK effective
        GOUTNAKEFF: u1 = 0,
        /// unused [8:9]
        _unused8: u2 = 0,
        /// ESUSP [10:10]
        /// Early suspend
        ESUSP: u1 = 0,
        /// USBSUSP [11:11]
        /// USB suspend
        USBSUSP: u1 = 0,
        /// USBRST [12:12]
        /// USB reset
        USBRST: u1 = 0,
        /// ENUMDNE [13:13]
        /// Enumeration done
        ENUMDNE: u1 = 0,
        /// ISOODRP [14:14]
        /// Isochronous OUT packet dropped
        ISOODRP: u1 = 0,
        /// EOPF [15:15]
        /// End of periodic frame
        EOPF: u1 = 0,
        /// unused [16:17]
        _unused16: u2 = 0,
        /// IEPINT [18:18]
        /// IN endpoint interrupt
        IEPINT: u1 = 0,
        /// OEPINT [19:19]
        /// OUT endpoint interrupt
        OEPINT: u1 = 0,
        /// IISOIXFR [20:20]
        /// Incomplete isochronous IN
        IISOIXFR: u1 = 0,
        /// IPXFR_INCOMPISOOUT [21:21]
        /// Incomplete periodic transfer(Host
        IPXFR_INCOMPISOOUT: u1 = 0,
        /// unused [22:23]
        _unused22: u2 = 0,
        /// HPRTINT [24:24]
        /// Host port interrupt
        HPRTINT: u1 = 0,
        /// HCINT [25:25]
        /// Host channels interrupt
        HCINT: u1 = 0,
        /// PTXFE [26:26]
        /// Periodic TxFIFO empty
        PTXFE: u1 = 1,
        /// unused [27:27]
        _unused27: u1 = 0,
        /// CIDSCHG [28:28]
        /// Connector ID status change
        CIDSCHG: u1 = 0,
        /// DISCINT [29:29]
        /// Disconnect detected
        DISCINT: u1 = 0,
        /// SRQINT [30:30]
        /// Session request/new session detected
        SRQINT: u1 = 0,
        /// WKUPINT [31:31]
        /// Resume/remote wakeup detected
        WKUPINT: u1 = 0,
    };
    /// OTG_FS core interrupt register
    pub const FS_GINTSTS: *volatile FS_GINTSTS_struct = @ptrFromInt(base_address + 0x14);

    /// FS_GINTMSK
    pub const FS_GINTMSK_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// MMISM [1:1]
        /// Mode mismatch interrupt
        MMISM: u1 = 0,
        /// OTGINT [2:2]
        /// OTG interrupt mask
        OTGINT: u1 = 0,
        /// SOFM [3:3]
        /// Start of frame mask
        SOFM: u1 = 0,
        /// RXFLVLM [4:4]
        /// Receive FIFO non-empty
        RXFLVLM: u1 = 0,
        /// NPTXFEM [5:5]
        /// Non-periodic TxFIFO empty
        NPTXFEM: u1 = 0,
        /// GINAKEFFM [6:6]
        /// Global non-periodic IN NAK effective
        GINAKEFFM: u1 = 0,
        /// GONAKEFFM [7:7]
        /// Global OUT NAK effective
        GONAKEFFM: u1 = 0,
        /// unused [8:9]
        _unused8: u2 = 0,
        /// ESUSPM [10:10]
        /// Early suspend mask
        ESUSPM: u1 = 0,
        /// USBSUSPM [11:11]
        /// USB suspend mask
        USBSUSPM: u1 = 0,
        /// USBRST [12:12]
        /// USB reset mask
        USBRST: u1 = 0,
        /// ENUMDNEM [13:13]
        /// Enumeration done mask
        ENUMDNEM: u1 = 0,
        /// ISOODRPM [14:14]
        /// Isochronous OUT packet dropped interrupt
        ISOODRPM: u1 = 0,
        /// EOPFM [15:15]
        /// End of periodic frame interrupt
        EOPFM: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// EPMISM [17:17]
        /// Endpoint mismatch interrupt
        EPMISM: u1 = 0,
        /// IEPINT [18:18]
        /// IN endpoints interrupt
        IEPINT: u1 = 0,
        /// OEPINT [19:19]
        /// OUT endpoints interrupt
        OEPINT: u1 = 0,
        /// IISOIXFRM [20:20]
        /// Incomplete isochronous IN transfer
        IISOIXFRM: u1 = 0,
        /// IPXFRM_IISOOXFRM [21:21]
        /// Incomplete periodic transfer mask(Host
        IPXFRM_IISOOXFRM: u1 = 0,
        /// unused [22:23]
        _unused22: u2 = 0,
        /// PRTIM [24:24]
        /// Host port interrupt mask
        PRTIM: u1 = 0,
        /// HCIM [25:25]
        /// Host channels interrupt
        HCIM: u1 = 0,
        /// PTXFEM [26:26]
        /// Periodic TxFIFO empty mask
        PTXFEM: u1 = 0,
        /// unused [27:27]
        _unused27: u1 = 0,
        /// CIDSCHGM [28:28]
        /// Connector ID status change
        CIDSCHGM: u1 = 0,
        /// DISCINT [29:29]
        /// Disconnect detected interrupt
        DISCINT: u1 = 0,
        /// SRQIM [30:30]
        /// Session request/new session detected
        SRQIM: u1 = 0,
        /// WUIM [31:31]
        /// Resume/remote wakeup detected interrupt
        WUIM: u1 = 0,
    };
    /// OTG_FS interrupt mask register
    pub const FS_GINTMSK: *volatile FS_GINTMSK_struct = @ptrFromInt(base_address + 0x18);

    /// FS_GRXSTSR_Device
    pub const FS_GRXSTSR_Device_struct = packed struct {
        /// EPNUM [0:3]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// BCNT [4:14]
        /// Byte count
        BCNT: u11 = 0,
        /// DPID [15:16]
        /// Data PID
        DPID: u2 = 0,
        /// PKTSTS [17:20]
        /// Packet status
        PKTSTS: u4 = 0,
        /// FRMNUM [21:24]
        /// Frame number
        FRMNUM: u4 = 0,
        /// unused [25:31]
        _unused25: u7 = 0,
    };
    /// OTG_FS Receive status debug read(Device
    pub const FS_GRXSTSR_Device: *volatile FS_GRXSTSR_Device_struct = @ptrFromInt(base_address + 0x1c);

    /// FS_GRXSTSR_Host
    pub const FS_GRXSTSR_Host_struct = packed struct {
        /// EPNUM [0:3]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// BCNT [4:14]
        /// Byte count
        BCNT: u11 = 0,
        /// DPID [15:16]
        /// Data PID
        DPID: u2 = 0,
        /// PKTSTS [17:20]
        /// Packet status
        PKTSTS: u4 = 0,
        /// FRMNUM [21:24]
        /// Frame number
        FRMNUM: u4 = 0,
        /// unused [25:31]
        _unused25: u7 = 0,
    };
    /// OTG_FS Receive status debug read(Host
    pub const FS_GRXSTSR_Host: *volatile FS_GRXSTSR_Host_struct = @ptrFromInt(base_address + 0x1c);

    /// FS_GRXFSIZ
    pub const FS_GRXFSIZ_struct = packed struct {
        /// RXFD [0:15]
        /// RxFIFO depth
        RXFD: u16 = 512,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS Receive FIFO size register
    pub const FS_GRXFSIZ: *volatile FS_GRXFSIZ_struct = @ptrFromInt(base_address + 0x24);

    /// FS_GNPTXFSIZ_Device
    pub const FS_GNPTXFSIZ_Device_struct = packed struct {
        /// TX0FSA [0:15]
        /// Endpoint 0 transmit RAM start
        TX0FSA: u16 = 512,
        /// TX0FD [16:31]
        /// Endpoint 0 TxFIFO depth
        TX0FD: u16 = 0,
    };
    /// OTG_FS non-periodic transmit FIFO size
    pub const FS_GNPTXFSIZ_Device: *volatile FS_GNPTXFSIZ_Device_struct = @ptrFromInt(base_address + 0x28);

    /// FS_GNPTXFSIZ_Host
    pub const FS_GNPTXFSIZ_Host_struct = packed struct {
        /// NPTXFSA [0:15]
        /// Non-periodic transmit RAM start
        NPTXFSA: u16 = 512,
        /// NPTXFD [16:31]
        /// Non-periodic TxFIFO depth
        NPTXFD: u16 = 0,
    };
    /// OTG_FS non-periodic transmit FIFO size
    pub const FS_GNPTXFSIZ_Host: *volatile FS_GNPTXFSIZ_Host_struct = @ptrFromInt(base_address + 0x28);

    /// FS_GNPTXSTS
    pub const FS_GNPTXSTS_struct = packed struct {
        /// NPTXFSAV [0:15]
        /// Non-periodic TxFIFO space
        NPTXFSAV: u16 = 512,
        /// NPTQXSAV [16:23]
        /// Non-periodic transmit request queue
        NPTQXSAV: u8 = 8,
        /// NPTXQTOP [24:30]
        /// Top of the non-periodic transmit request
        NPTXQTOP: u7 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS non-periodic transmit FIFO/queue
    pub const FS_GNPTXSTS: *volatile FS_GNPTXSTS_struct = @ptrFromInt(base_address + 0x2c);

    /// FS_GCCFG
    pub const FS_GCCFG_struct = packed struct {
        /// unused [0:15]
        _unused0: u8 = 0,
        _unused8: u8 = 0,
        /// PWRDWN [16:16]
        /// Power down
        PWRDWN: u1 = 0,
        /// unused [17:17]
        _unused17: u1 = 0,
        /// VBUSASEN [18:18]
        /// Enable the VBUS sensing
        VBUSASEN: u1 = 0,
        /// VBUSBSEN [19:19]
        /// Enable the VBUS sensing
        VBUSBSEN: u1 = 0,
        /// SOFOUTEN [20:20]
        /// SOF output enable
        SOFOUTEN: u1 = 0,
        /// unused [21:31]
        _unused21: u3 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS general core configuration register
    pub const FS_GCCFG: *volatile FS_GCCFG_struct = @ptrFromInt(base_address + 0x38);

    /// FS_CID
    pub const FS_CID_struct = packed struct {
        /// PRODUCT_ID [0:31]
        /// Product ID field
        PRODUCT_ID: u32 = 4096,
    };
    /// core ID register
    pub const FS_CID: *volatile FS_CID_struct = @ptrFromInt(base_address + 0x3c);

    /// FS_HPTXFSIZ
    pub const FS_HPTXFSIZ_struct = packed struct {
        /// PTXSA [0:15]
        /// Host periodic TxFIFO start
        PTXSA: u16 = 1536,
        /// PTXFSIZ [16:31]
        /// Host periodic TxFIFO depth
        PTXFSIZ: u16 = 512,
    };
    /// OTG_FS Host periodic transmit FIFO size
    pub const FS_HPTXFSIZ: *volatile FS_HPTXFSIZ_struct = @ptrFromInt(base_address + 0x100);

    /// FS_DIEPTXF1
    pub const FS_DIEPTXF1_struct = packed struct {
        /// INEPTXSA [0:15]
        /// IN endpoint FIFO2 transmit RAM start
        INEPTXSA: u16 = 1024,
        /// INEPTXFD [16:31]
        /// IN endpoint TxFIFO depth
        INEPTXFD: u16 = 512,
    };
    /// OTG_FS device IN endpoint transmit FIFO size
    pub const FS_DIEPTXF1: *volatile FS_DIEPTXF1_struct = @ptrFromInt(base_address + 0x104);

    /// FS_DIEPTXF2
    pub const FS_DIEPTXF2_struct = packed struct {
        /// INEPTXSA [0:15]
        /// IN endpoint FIFO3 transmit RAM start
        INEPTXSA: u16 = 1024,
        /// INEPTXFD [16:31]
        /// IN endpoint TxFIFO depth
        INEPTXFD: u16 = 512,
    };
    /// OTG_FS device IN endpoint transmit FIFO size
    pub const FS_DIEPTXF2: *volatile FS_DIEPTXF2_struct = @ptrFromInt(base_address + 0x108);

    /// FS_DIEPTXF3
    pub const FS_DIEPTXF3_struct = packed struct {
        /// INEPTXSA [0:15]
        /// IN endpoint FIFO4 transmit RAM start
        INEPTXSA: u16 = 1024,
        /// INEPTXFD [16:31]
        /// IN endpoint TxFIFO depth
        INEPTXFD: u16 = 512,
    };
    /// OTG_FS device IN endpoint transmit FIFO size
    pub const FS_DIEPTXF3: *volatile FS_DIEPTXF3_struct = @ptrFromInt(base_address + 0x10c);
};

/// USB on the go full speed
pub const OTG_FS_HOST = struct {
    pub const base_address = 0x50000400;
    /// FS_HCFG
    pub const FS_HCFG_struct = packed struct {
        /// FSLSPCS [0:1]
        /// FS/LS PHY clock select
        FSLSPCS: u2 = 0,
        /// FSLSS [2:2]
        /// FS- and LS-only support
        FSLSS: u1 = 0,
        /// unused [3:31]
        _unused3: u5 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host configuration register
    pub const FS_HCFG: *volatile FS_HCFG_struct = @ptrFromInt(base_address + 0x0);

    /// HFIR
    pub const HFIR_struct = packed struct {
        /// FRIVL [0:15]
        /// Frame interval
        FRIVL: u16 = 60000,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS Host frame interval
    pub const HFIR: *volatile HFIR_struct = @ptrFromInt(base_address + 0x4);

    /// FS_HFNUM
    pub const FS_HFNUM_struct = packed struct {
        /// FRNUM [0:15]
        /// Frame number
        FRNUM: u16 = 16383,
        /// FTREM [16:31]
        /// Frame time remaining
        FTREM: u16 = 0,
    };
    /// OTG_FS host frame number/frame time
    pub const FS_HFNUM: *volatile FS_HFNUM_struct = @ptrFromInt(base_address + 0x8);

    /// FS_HPTXSTS
    pub const FS_HPTXSTS_struct = packed struct {
        /// PTXFSAVL [0:15]
        /// Periodic transmit data FIFO space
        PTXFSAVL: u16 = 256,
        /// PTXQSAV [16:23]
        /// Periodic transmit request queue space
        PTXQSAV: u8 = 8,
        /// PTXQTOP [24:31]
        /// Top of the periodic transmit request
        PTXQTOP: u8 = 0,
    };
    /// OTG_FS_Host periodic transmit FIFO/queue
    pub const FS_HPTXSTS: *volatile FS_HPTXSTS_struct = @ptrFromInt(base_address + 0x10);

    /// HAINT
    pub const HAINT_struct = packed struct {
        /// HAINT [0:15]
        /// Channel interrupts
        HAINT: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS Host all channels interrupt
    pub const HAINT: *volatile HAINT_struct = @ptrFromInt(base_address + 0x14);

    /// HAINTMSK
    pub const HAINTMSK_struct = packed struct {
        /// HAINTM [0:15]
        /// Channel interrupt mask
        HAINTM: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host all channels interrupt mask
    pub const HAINTMSK: *volatile HAINTMSK_struct = @ptrFromInt(base_address + 0x18);

    /// FS_HPRT
    pub const FS_HPRT_struct = packed struct {
        /// PCSTS [0:0]
        /// Port connect status
        PCSTS: u1 = 0,
        /// PCDET [1:1]
        /// Port connect detected
        PCDET: u1 = 0,
        /// PENA [2:2]
        /// Port enable
        PENA: u1 = 0,
        /// PENCHNG [3:3]
        /// Port enable/disable change
        PENCHNG: u1 = 0,
        /// POCA [4:4]
        /// Port overcurrent active
        POCA: u1 = 0,
        /// POCCHNG [5:5]
        /// Port overcurrent change
        POCCHNG: u1 = 0,
        /// PRES [6:6]
        /// Port resume
        PRES: u1 = 0,
        /// PSUSP [7:7]
        /// Port suspend
        PSUSP: u1 = 0,
        /// PRST [8:8]
        /// Port reset
        PRST: u1 = 0,
        /// unused [9:9]
        _unused9: u1 = 0,
        /// PLSTS [10:11]
        /// Port line status
        PLSTS: u2 = 0,
        /// PPWR [12:12]
        /// Port power
        PPWR: u1 = 0,
        /// PTCTL [13:16]
        /// Port test control
        PTCTL: u4 = 0,
        /// PSPD [17:18]
        /// Port speed
        PSPD: u2 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host port control and status register
    pub const FS_HPRT: *volatile FS_HPRT_struct = @ptrFromInt(base_address + 0x40);

    /// FS_HCCHAR0
    pub const FS_HCCHAR0_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-0 characteristics
    pub const FS_HCCHAR0: *volatile FS_HCCHAR0_struct = @ptrFromInt(base_address + 0x100);

    /// FS_HCCHAR1
    pub const FS_HCCHAR1_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-1 characteristics
    pub const FS_HCCHAR1: *volatile FS_HCCHAR1_struct = @ptrFromInt(base_address + 0x120);

    /// FS_HCCHAR2
    pub const FS_HCCHAR2_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-2 characteristics
    pub const FS_HCCHAR2: *volatile FS_HCCHAR2_struct = @ptrFromInt(base_address + 0x140);

    /// FS_HCCHAR3
    pub const FS_HCCHAR3_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-3 characteristics
    pub const FS_HCCHAR3: *volatile FS_HCCHAR3_struct = @ptrFromInt(base_address + 0x160);

    /// FS_HCCHAR4
    pub const FS_HCCHAR4_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-4 characteristics
    pub const FS_HCCHAR4: *volatile FS_HCCHAR4_struct = @ptrFromInt(base_address + 0x180);

    /// FS_HCCHAR5
    pub const FS_HCCHAR5_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-5 characteristics
    pub const FS_HCCHAR5: *volatile FS_HCCHAR5_struct = @ptrFromInt(base_address + 0x1a0);

    /// FS_HCCHAR6
    pub const FS_HCCHAR6_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-6 characteristics
    pub const FS_HCCHAR6: *volatile FS_HCCHAR6_struct = @ptrFromInt(base_address + 0x1c0);

    /// FS_HCCHAR7
    pub const FS_HCCHAR7_struct = packed struct {
        /// MPSIZ [0:10]
        /// Maximum packet size
        MPSIZ: u11 = 0,
        /// EPNUM [11:14]
        /// Endpoint number
        EPNUM: u4 = 0,
        /// EPDIR [15:15]
        /// Endpoint direction
        EPDIR: u1 = 0,
        /// unused [16:16]
        _unused16: u1 = 0,
        /// LSDEV [17:17]
        /// Low-speed device
        LSDEV: u1 = 0,
        /// EPTYP [18:19]
        /// Endpoint type
        EPTYP: u2 = 0,
        /// MCNT [20:21]
        /// Multicount
        MCNT: u2 = 0,
        /// DAD [22:28]
        /// Device address
        DAD: u7 = 0,
        /// ODDFRM [29:29]
        /// Odd frame
        ODDFRM: u1 = 0,
        /// CHDIS [30:30]
        /// Channel disable
        CHDIS: u1 = 0,
        /// CHENA [31:31]
        /// Channel enable
        CHENA: u1 = 0,
    };
    /// OTG_FS host channel-7 characteristics
    pub const FS_HCCHAR7: *volatile FS_HCCHAR7_struct = @ptrFromInt(base_address + 0x1e0);

    /// FS_HCINT0
    pub const FS_HCINT0_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-0 interrupt register
    pub const FS_HCINT0: *volatile FS_HCINT0_struct = @ptrFromInt(base_address + 0x108);

    /// FS_HCINT1
    pub const FS_HCINT1_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-1 interrupt register
    pub const FS_HCINT1: *volatile FS_HCINT1_struct = @ptrFromInt(base_address + 0x128);

    /// FS_HCINT2
    pub const FS_HCINT2_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-2 interrupt register
    pub const FS_HCINT2: *volatile FS_HCINT2_struct = @ptrFromInt(base_address + 0x148);

    /// FS_HCINT3
    pub const FS_HCINT3_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-3 interrupt register
    pub const FS_HCINT3: *volatile FS_HCINT3_struct = @ptrFromInt(base_address + 0x168);

    /// FS_HCINT4
    pub const FS_HCINT4_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-4 interrupt register
    pub const FS_HCINT4: *volatile FS_HCINT4_struct = @ptrFromInt(base_address + 0x188);

    /// FS_HCINT5
    pub const FS_HCINT5_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-5 interrupt register
    pub const FS_HCINT5: *volatile FS_HCINT5_struct = @ptrFromInt(base_address + 0x1a8);

    /// FS_HCINT6
    pub const FS_HCINT6_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-6 interrupt register
    pub const FS_HCINT6: *volatile FS_HCINT6_struct = @ptrFromInt(base_address + 0x1c8);

    /// FS_HCINT7
    pub const FS_HCINT7_struct = packed struct {
        /// XFRC [0:0]
        /// Transfer completed
        XFRC: u1 = 0,
        /// CHH [1:1]
        /// Channel halted
        CHH: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALL [3:3]
        /// STALL response received
        STALL: u1 = 0,
        /// NAK [4:4]
        /// NAK response received
        NAK: u1 = 0,
        /// ACK [5:5]
        /// ACK response received/transmitted
        ACK: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// TXERR [7:7]
        /// Transaction error
        TXERR: u1 = 0,
        /// BBERR [8:8]
        /// Babble error
        BBERR: u1 = 0,
        /// FRMOR [9:9]
        /// Frame overrun
        FRMOR: u1 = 0,
        /// DTERR [10:10]
        /// Data toggle error
        DTERR: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-7 interrupt register
    pub const FS_HCINT7: *volatile FS_HCINT7_struct = @ptrFromInt(base_address + 0x1e8);

    /// FS_HCINTMSK0
    pub const FS_HCINTMSK0_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-0 mask register
    pub const FS_HCINTMSK0: *volatile FS_HCINTMSK0_struct = @ptrFromInt(base_address + 0x10c);

    /// FS_HCINTMSK1
    pub const FS_HCINTMSK1_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-1 mask register
    pub const FS_HCINTMSK1: *volatile FS_HCINTMSK1_struct = @ptrFromInt(base_address + 0x12c);

    /// FS_HCINTMSK2
    pub const FS_HCINTMSK2_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-2 mask register
    pub const FS_HCINTMSK2: *volatile FS_HCINTMSK2_struct = @ptrFromInt(base_address + 0x14c);

    /// FS_HCINTMSK3
    pub const FS_HCINTMSK3_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-3 mask register
    pub const FS_HCINTMSK3: *volatile FS_HCINTMSK3_struct = @ptrFromInt(base_address + 0x16c);

    /// FS_HCINTMSK4
    pub const FS_HCINTMSK4_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-4 mask register
    pub const FS_HCINTMSK4: *volatile FS_HCINTMSK4_struct = @ptrFromInt(base_address + 0x18c);

    /// FS_HCINTMSK5
    pub const FS_HCINTMSK5_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-5 mask register
    pub const FS_HCINTMSK5: *volatile FS_HCINTMSK5_struct = @ptrFromInt(base_address + 0x1ac);

    /// FS_HCINTMSK6
    pub const FS_HCINTMSK6_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-6 mask register
    pub const FS_HCINTMSK6: *volatile FS_HCINTMSK6_struct = @ptrFromInt(base_address + 0x1cc);

    /// FS_HCINTMSK7
    pub const FS_HCINTMSK7_struct = packed struct {
        /// XFRCM [0:0]
        /// Transfer completed mask
        XFRCM: u1 = 0,
        /// CHHM [1:1]
        /// Channel halted mask
        CHHM: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// STALLM [3:3]
        /// STALL response received interrupt
        STALLM: u1 = 0,
        /// NAKM [4:4]
        /// NAK response received interrupt
        NAKM: u1 = 0,
        /// ACKM [5:5]
        /// ACK response received/transmitted
        ACKM: u1 = 0,
        /// NYET [6:6]
        /// response received interrupt
        NYET: u1 = 0,
        /// TXERRM [7:7]
        /// Transaction error mask
        TXERRM: u1 = 0,
        /// BBERRM [8:8]
        /// Babble error mask
        BBERRM: u1 = 0,
        /// FRMORM [9:9]
        /// Frame overrun mask
        FRMORM: u1 = 0,
        /// DTERRM [10:10]
        /// Data toggle error mask
        DTERRM: u1 = 0,
        /// unused [11:31]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS host channel-7 mask register
    pub const FS_HCINTMSK7: *volatile FS_HCINTMSK7_struct = @ptrFromInt(base_address + 0x1ec);

    /// FS_HCTSIZ0
    pub const FS_HCTSIZ0_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-0 transfer size
    pub const FS_HCTSIZ0: *volatile FS_HCTSIZ0_struct = @ptrFromInt(base_address + 0x110);

    /// FS_HCTSIZ1
    pub const FS_HCTSIZ1_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-1 transfer size
    pub const FS_HCTSIZ1: *volatile FS_HCTSIZ1_struct = @ptrFromInt(base_address + 0x130);

    /// FS_HCTSIZ2
    pub const FS_HCTSIZ2_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-2 transfer size
    pub const FS_HCTSIZ2: *volatile FS_HCTSIZ2_struct = @ptrFromInt(base_address + 0x150);

    /// FS_HCTSIZ3
    pub const FS_HCTSIZ3_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-3 transfer size
    pub const FS_HCTSIZ3: *volatile FS_HCTSIZ3_struct = @ptrFromInt(base_address + 0x170);

    /// FS_HCTSIZ4
    pub const FS_HCTSIZ4_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-x transfer size
    pub const FS_HCTSIZ4: *volatile FS_HCTSIZ4_struct = @ptrFromInt(base_address + 0x190);

    /// FS_HCTSIZ5
    pub const FS_HCTSIZ5_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-5 transfer size
    pub const FS_HCTSIZ5: *volatile FS_HCTSIZ5_struct = @ptrFromInt(base_address + 0x1b0);

    /// FS_HCTSIZ6
    pub const FS_HCTSIZ6_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-6 transfer size
    pub const FS_HCTSIZ6: *volatile FS_HCTSIZ6_struct = @ptrFromInt(base_address + 0x1d0);

    /// FS_HCTSIZ7
    pub const FS_HCTSIZ7_struct = packed struct {
        /// XFRSIZ [0:18]
        /// Transfer size
        XFRSIZ: u19 = 0,
        /// PKTCNT [19:28]
        /// Packet count
        PKTCNT: u10 = 0,
        /// DPID [29:30]
        /// Data PID
        DPID: u2 = 0,
        /// unused [31:31]
        _unused31: u1 = 0,
    };
    /// OTG_FS host channel-7 transfer size
    pub const FS_HCTSIZ7: *volatile FS_HCTSIZ7_struct = @ptrFromInt(base_address + 0x1f0);
};

/// USB on the go full speed
pub const OTG_FS_PWRCLK = struct {
    pub const base_address = 0x50000e00;
    /// FS_PCGCCTL
    pub const FS_PCGCCTL_struct = packed struct {
        /// STPPCLK [0:0]
        /// Stop PHY clock
        STPPCLK: u1 = 0,
        /// GATEHCLK [1:1]
        /// Gate HCLK
        GATEHCLK: u1 = 0,
        /// unused [2:3]
        _unused2: u2 = 0,
        /// PHYSUSP [4:4]
        /// PHY Suspended
        PHYSUSP: u1 = 0,
        /// unused [5:31]
        _unused5: u3 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// OTG_FS power and clock gating control
    pub const FS_PCGCCTL: *volatile FS_PCGCCTL_struct = @ptrFromInt(base_address + 0x0);
};

/// Ethernet: MAC management counters
pub const ETHERNET_MMC = struct {
    pub const base_address = 0x40028100;
    /// MMCCR
    pub const MMCCR_struct = packed struct {
        /// CR [0:0]
        /// Counter reset
        CR: u1 = 0,
        /// CSR [1:1]
        /// Counter stop rollover
        CSR: u1 = 0,
        /// ROR [2:2]
        /// Reset on read
        ROR: u1 = 0,
        /// unused [3:30]
        _unused3: u5 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u7 = 0,
        /// MCF [31:31]
        /// MMC counter freeze
        MCF: u1 = 0,
    };
    /// Ethernet MMC control register
    pub const MMCCR: *volatile MMCCR_struct = @ptrFromInt(base_address + 0x0);

    /// MMCRIR
    pub const MMCRIR_struct = packed struct {
        /// unused [0:4]
        _unused0: u5 = 0,
        /// RFCES [5:5]
        /// Received frames CRC error
        RFCES: u1 = 0,
        /// RFAES [6:6]
        /// Received frames alignment error
        RFAES: u1 = 0,
        /// unused [7:16]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u1 = 0,
        /// RGUFS [17:17]
        /// Received Good Unicast Frames
        RGUFS: u1 = 0,
        /// unused [18:31]
        _unused18: u6 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MMC receive interrupt register
    pub const MMCRIR: *volatile MMCRIR_struct = @ptrFromInt(base_address + 0x4);

    /// MMCTIR
    pub const MMCTIR_struct = packed struct {
        /// unused [0:13]
        _unused0: u8 = 0,
        _unused8: u6 = 0,
        /// TGFSCS [14:14]
        /// Transmitted good frames single collision
        TGFSCS: u1 = 0,
        /// TGFMSCS [15:15]
        /// Transmitted good frames more single
        TGFMSCS: u1 = 0,
        /// unused [16:20]
        _unused16: u5 = 0,
        /// TGFS [21:21]
        /// Transmitted good frames
        TGFS: u1 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MMC transmit interrupt register
    pub const MMCTIR: *volatile MMCTIR_struct = @ptrFromInt(base_address + 0x8);

    /// MMCRIMR
    pub const MMCRIMR_struct = packed struct {
        /// unused [0:4]
        _unused0: u5 = 0,
        /// RFCEM [5:5]
        /// Received frame CRC error
        RFCEM: u1 = 0,
        /// RFAEM [6:6]
        /// Received frames alignment error
        RFAEM: u1 = 0,
        /// unused [7:16]
        _unused7: u1 = 0,
        _unused8: u8 = 0,
        _unused16: u1 = 0,
        /// RGUFM [17:17]
        /// Received good unicast frames
        RGUFM: u1 = 0,
        /// unused [18:31]
        _unused18: u6 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MMC receive interrupt mask register
    pub const MMCRIMR: *volatile MMCRIMR_struct = @ptrFromInt(base_address + 0xc);

    /// MMCTIMR
    pub const MMCTIMR_struct = packed struct {
        /// unused [0:13]
        _unused0: u8 = 0,
        _unused8: u6 = 0,
        /// TGFSCM [14:14]
        /// Transmitted good frames single collision
        TGFSCM: u1 = 0,
        /// TGFMSCM [15:15]
        /// Transmitted good frames more single
        TGFMSCM: u1 = 0,
        /// unused [16:20]
        _unused16: u5 = 0,
        /// TGFM [21:21]
        /// Transmitted good frames
        TGFM: u1 = 0,
        /// unused [22:31]
        _unused22: u2 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MMC transmit interrupt mask
    pub const MMCTIMR: *volatile MMCTIMR_struct = @ptrFromInt(base_address + 0x10);

    /// MMCTGFSCCR
    pub const MMCTGFSCCR_struct = packed struct {
        /// TGFSCC [0:31]
        /// Transmitted good frames after a single
        TGFSCC: u32 = 0,
    };
    /// Ethernet MMC transmitted good frames after a
    pub const MMCTGFSCCR: *volatile MMCTGFSCCR_struct = @ptrFromInt(base_address + 0x4c);

    /// MMCTGFMSCCR
    pub const MMCTGFMSCCR_struct = packed struct {
        /// TGFMSCC [0:31]
        /// Transmitted good frames after more than
        TGFMSCC: u32 = 0,
    };
    /// Ethernet MMC transmitted good frames after
    pub const MMCTGFMSCCR: *volatile MMCTGFMSCCR_struct = @ptrFromInt(base_address + 0x50);

    /// MMCTGFCR
    pub const MMCTGFCR_struct = packed struct {
        /// TGFC [0:31]
        /// Transmitted good frames
        TGFC: u32 = 0,
    };
    /// Ethernet MMC transmitted good frames counter
    pub const MMCTGFCR: *volatile MMCTGFCR_struct = @ptrFromInt(base_address + 0x68);

    /// MMCRFCECR
    pub const MMCRFCECR_struct = packed struct {
        /// RFCFC [0:31]
        /// Received frames with CRC error
        RFCFC: u32 = 0,
    };
    /// Ethernet MMC received frames with CRC error
    pub const MMCRFCECR: *volatile MMCRFCECR_struct = @ptrFromInt(base_address + 0x94);

    /// MMCRFAECR
    pub const MMCRFAECR_struct = packed struct {
        /// RFAEC [0:31]
        /// Received frames with alignment error
        RFAEC: u32 = 0,
    };
    /// Ethernet MMC received frames with alignment
    pub const MMCRFAECR: *volatile MMCRFAECR_struct = @ptrFromInt(base_address + 0x98);

    /// MMCRGUFCR
    pub const MMCRGUFCR_struct = packed struct {
        /// RGUFC [0:31]
        /// Received good unicast frames
        RGUFC: u32 = 0,
    };
    /// MMC received good unicast frames counter
    pub const MMCRGUFCR: *volatile MMCRGUFCR_struct = @ptrFromInt(base_address + 0xc4);
};

/// Ethernet: media access control
pub const ETHERNET_MAC = struct {
    pub const base_address = 0x40028000;
    /// MACCR
    pub const MACCR_struct = packed struct {
        /// unused [0:1]
        _unused0: u2 = 0,
        /// RE [2:2]
        /// Receiver enable
        RE: u1 = 0,
        /// TE [3:3]
        /// Transmitter enable
        TE: u1 = 0,
        /// DC [4:4]
        /// Deferral check
        DC: u1 = 0,
        /// BL [5:6]
        /// Back-off limit
        BL: u2 = 0,
        /// APCS [7:7]
        /// Automatic pad/CRC
        APCS: u1 = 0,
        /// unused [8:8]
        _unused8: u1 = 0,
        /// RD [9:9]
        /// Retry disable
        RD: u1 = 0,
        /// IPCO [10:10]
        /// IPv4 checksum offload
        IPCO: u1 = 0,
        /// DM [11:11]
        /// Duplex mode
        DM: u1 = 0,
        /// LM [12:12]
        /// Loopback mode
        LM: u1 = 0,
        /// ROD [13:13]
        /// Receive own disable
        ROD: u1 = 0,
        /// FES [14:14]
        /// Fast Ethernet speed
        FES: u1 = 0,
        /// unused [15:15]
        _unused15: u1 = 1,
        /// CSD [16:16]
        /// Carrier sense disable
        CSD: u1 = 0,
        /// IFG [17:19]
        /// Interframe gap
        IFG: u3 = 0,
        /// unused [20:21]
        _unused20: u2 = 0,
        /// JD [22:22]
        /// Jabber disable
        JD: u1 = 0,
        /// WD [23:23]
        /// Watchdog disable
        WD: u1 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// Ethernet MAC configuration register
    pub const MACCR: *volatile MACCR_struct = @ptrFromInt(base_address + 0x0);

    /// MACFFR
    pub const MACFFR_struct = packed struct {
        /// PM [0:0]
        /// Promiscuous mode
        PM: u1 = 0,
        /// HU [1:1]
        /// Hash unicast
        HU: u1 = 0,
        /// HM [2:2]
        /// Hash multicast
        HM: u1 = 0,
        /// DAIF [3:3]
        /// Destination address inverse
        DAIF: u1 = 0,
        /// PAM [4:4]
        /// Pass all multicast
        PAM: u1 = 0,
        /// BFD [5:5]
        /// Broadcast frames disable
        BFD: u1 = 0,
        /// PCF [6:7]
        /// Pass control frames
        PCF: u2 = 0,
        /// SAIF [8:8]
        /// Source address inverse
        SAIF: u1 = 0,
        /// SAF [9:9]
        /// Source address filter
        SAF: u1 = 0,
        /// HPF [10:10]
        /// Hash or perfect filter
        HPF: u1 = 0,
        /// unused [11:30]
        _unused11: u5 = 0,
        _unused16: u8 = 0,
        _unused24: u7 = 0,
        /// RA [31:31]
        /// Receive all
        RA: u1 = 0,
    };
    /// Ethernet MAC frame filter register
    pub const MACFFR: *volatile MACFFR_struct = @ptrFromInt(base_address + 0x4);

    /// MACHTHR
    pub const MACHTHR_struct = packed struct {
        /// HTH [0:31]
        /// Hash table high
        HTH: u32 = 0,
    };
    /// Ethernet MAC hash table high
    pub const MACHTHR: *volatile MACHTHR_struct = @ptrFromInt(base_address + 0x8);

    /// MACHTLR
    pub const MACHTLR_struct = packed struct {
        /// HTL [0:31]
        /// Hash table low
        HTL: u32 = 0,
    };
    /// Ethernet MAC hash table low
    pub const MACHTLR: *volatile MACHTLR_struct = @ptrFromInt(base_address + 0xc);

    /// MACMIIAR
    pub const MACMIIAR_struct = packed struct {
        /// MB [0:0]
        /// MII busy
        MB: u1 = 0,
        /// MW [1:1]
        /// MII write
        MW: u1 = 0,
        /// CR [2:4]
        /// Clock range
        CR: u3 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// MR [6:10]
        /// MII register
        MR: u5 = 0,
        /// PA [11:15]
        /// PHY address
        PA: u5 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MAC MII address register
    pub const MACMIIAR: *volatile MACMIIAR_struct = @ptrFromInt(base_address + 0x10);

    /// MACMIIDR
    pub const MACMIIDR_struct = packed struct {
        /// MD [0:15]
        /// MII data
        MD: u16 = 0,
        /// unused [16:31]
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MAC MII data register
    pub const MACMIIDR: *volatile MACMIIDR_struct = @ptrFromInt(base_address + 0x14);

    /// MACFCR
    pub const MACFCR_struct = packed struct {
        /// FCB_BPA [0:0]
        /// Flow control busy/back pressure
        FCB_BPA: u1 = 0,
        /// TFCE [1:1]
        /// Transmit flow control
        TFCE: u1 = 0,
        /// RFCE [2:2]
        /// Receive flow control
        RFCE: u1 = 0,
        /// UPFD [3:3]
        /// Unicast pause frame detect
        UPFD: u1 = 0,
        /// PLT [4:5]
        /// Pause low threshold
        PLT: u2 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// ZQPD [7:7]
        /// Zero-quanta pause disable
        ZQPD: u1 = 0,
        /// unused [8:15]
        _unused8: u8 = 0,
        /// PT [16:31]
        /// Pass control frames
        PT: u16 = 0,
    };
    /// Ethernet MAC flow control register
    pub const MACFCR: *volatile MACFCR_struct = @ptrFromInt(base_address + 0x18);

    /// MACVLANTR
    pub const MACVLANTR_struct = packed struct {
        /// VLANTI [0:15]
        /// VLAN tag identifier (for receive
        VLANTI: u16 = 0,
        /// VLANTC [16:16]
        /// 12-bit VLAN tag comparison
        VLANTC: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MAC VLAN tag register
    pub const MACVLANTR: *volatile MACVLANTR_struct = @ptrFromInt(base_address + 0x1c);

    /// MACRWUFFR
    pub const MACRWUFFR_struct = packed struct {
        /// unused [0:31]
        _unused0: u8 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MAC remote wakeup frame filter
    pub const MACRWUFFR: *volatile MACRWUFFR_struct = @ptrFromInt(base_address + 0x28);

    /// MACPMTCSR
    pub const MACPMTCSR_struct = packed struct {
        /// PD [0:0]
        /// Power down
        PD: u1 = 0,
        /// MPE [1:1]
        /// Magic Packet enable
        MPE: u1 = 0,
        /// WFE [2:2]
        /// Wakeup frame enable
        WFE: u1 = 0,
        /// unused [3:4]
        _unused3: u2 = 0,
        /// MPR [5:5]
        /// Magic packet received
        MPR: u1 = 0,
        /// WFR [6:6]
        /// Wakeup frame received
        WFR: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// GU [9:9]
        /// Global unicast
        GU: u1 = 0,
        /// unused [10:30]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u7 = 0,
        /// WFFRPR [31:31]
        /// Wakeup frame filter register pointer
        WFFRPR: u1 = 0,
    };
    /// Ethernet MAC PMT control and status register
    pub const MACPMTCSR: *volatile MACPMTCSR_struct = @ptrFromInt(base_address + 0x2c);

    /// MACSR
    pub const MACSR_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// PMTS [3:3]
        /// PMT status
        PMTS: u1 = 0,
        /// MMCS [4:4]
        /// MMC status
        MMCS: u1 = 0,
        /// MMCRS [5:5]
        /// MMC receive status
        MMCRS: u1 = 0,
        /// MMCTS [6:6]
        /// MMC transmit status
        MMCTS: u1 = 0,
        /// unused [7:8]
        _unused7: u1 = 0,
        _unused8: u1 = 0,
        /// TSTS [9:9]
        /// Time stamp trigger status
        TSTS: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MAC interrupt status register
    pub const MACSR: *volatile MACSR_struct = @ptrFromInt(base_address + 0x38);

    /// MACIMR
    pub const MACIMR_struct = packed struct {
        /// unused [0:2]
        _unused0: u3 = 0,
        /// PMTIM [3:3]
        /// PMT interrupt mask
        PMTIM: u1 = 0,
        /// unused [4:8]
        _unused4: u4 = 0,
        _unused8: u1 = 0,
        /// TSTIM [9:9]
        /// Time stamp trigger interrupt
        TSTIM: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet MAC interrupt mask register
    pub const MACIMR: *volatile MACIMR_struct = @ptrFromInt(base_address + 0x3c);

    /// MACA0HR
    pub const MACA0HR_struct = packed struct {
        /// MACA0H [0:15]
        /// MAC address0 high
        MACA0H: u16 = 65535,
        /// unused [16:30]
        _unused16: u8 = 16,
        _unused24: u7 = 0,
        /// MO [31:31]
        /// Always 1
        MO: u1 = 0,
    };
    /// Ethernet MAC address 0 high register
    pub const MACA0HR: *volatile MACA0HR_struct = @ptrFromInt(base_address + 0x40);

    /// MACA0LR
    pub const MACA0LR_struct = packed struct {
        /// MACA0L [0:31]
        /// MAC address0 low
        MACA0L: u32 = 4294967295,
    };
    /// Ethernet MAC address 0 low
    pub const MACA0LR: *volatile MACA0LR_struct = @ptrFromInt(base_address + 0x44);

    /// MACA1HR
    pub const MACA1HR_struct = packed struct {
        /// MACA1H [0:15]
        /// MAC address1 high
        MACA1H: u16 = 65535,
        /// unused [16:23]
        _unused16: u8 = 0,
        /// MBC [24:29]
        /// Mask byte control
        MBC: u6 = 0,
        /// SA [30:30]
        /// Source address
        SA: u1 = 0,
        /// AE [31:31]
        /// Address enable
        AE: u1 = 0,
    };
    /// Ethernet MAC address 1 high register
    pub const MACA1HR: *volatile MACA1HR_struct = @ptrFromInt(base_address + 0x48);

    /// MACA1LR
    pub const MACA1LR_struct = packed struct {
        /// MACA1L [0:31]
        /// MAC address1 low
        MACA1L: u32 = 4294967295,
    };
    /// Ethernet MAC address1 low
    pub const MACA1LR: *volatile MACA1LR_struct = @ptrFromInt(base_address + 0x4c);

    /// MACA2HR
    pub const MACA2HR_struct = packed struct {
        /// ETH_MACA2HR [0:15]
        /// Ethernet MAC address 2 high
        ETH_MACA2HR: u16 = 80,
        /// unused [16:23]
        _unused16: u8 = 0,
        /// MBC [24:29]
        /// Mask byte control
        MBC: u6 = 0,
        /// SA [30:30]
        /// Source address
        SA: u1 = 0,
        /// AE [31:31]
        /// Address enable
        AE: u1 = 0,
    };
    /// Ethernet MAC address 2 high register
    pub const MACA2HR: *volatile MACA2HR_struct = @ptrFromInt(base_address + 0x50);

    /// MACA2LR
    pub const MACA2LR_struct = packed struct {
        /// MACA2L [0:30]
        /// MAC address2 low
        MACA2L: u31 = 2147483647,
        /// unused [31:31]
        _unused31: u1 = 1,
    };
    /// Ethernet MAC address 2 low
    pub const MACA2LR: *volatile MACA2LR_struct = @ptrFromInt(base_address + 0x54);

    /// MACA3HR
    pub const MACA3HR_struct = packed struct {
        /// MACA3H [0:15]
        /// MAC address3 high
        MACA3H: u16 = 65535,
        /// unused [16:23]
        _unused16: u8 = 0,
        /// MBC [24:29]
        /// Mask byte control
        MBC: u6 = 0,
        /// SA [30:30]
        /// Source address
        SA: u1 = 0,
        /// AE [31:31]
        /// Address enable
        AE: u1 = 0,
    };
    /// Ethernet MAC address 3 high register
    pub const MACA3HR: *volatile MACA3HR_struct = @ptrFromInt(base_address + 0x58);

    /// MACA3LR
    pub const MACA3LR_struct = packed struct {
        /// MBCA3L [0:31]
        /// MAC address3 low
        MBCA3L: u32 = 4294967295,
    };
    /// Ethernet MAC address 3 low
    pub const MACA3LR: *volatile MACA3LR_struct = @ptrFromInt(base_address + 0x5c);
};

/// Ethernet: Precision time protocol
pub const ETHERNET_PTP = struct {
    pub const base_address = 0x40028700;
    /// PTPTSCR
    pub const PTPTSCR_struct = packed struct {
        /// TSE [0:0]
        /// Time stamp enable
        TSE: u1 = 0,
        /// TSFCU [1:1]
        /// Time stamp fine or coarse
        TSFCU: u1 = 0,
        /// TSSTI [2:2]
        /// Time stamp system time
        TSSTI: u1 = 0,
        /// TSSTU [3:3]
        /// Time stamp system time
        TSSTU: u1 = 0,
        /// TSITE [4:4]
        /// Time stamp interrupt trigger
        TSITE: u1 = 0,
        /// TSARU [5:5]
        /// Time stamp addend register
        TSARU: u1 = 0,
        /// unused [6:31]
        _unused6: u2 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet PTP time stamp control register
    pub const PTPTSCR: *volatile PTPTSCR_struct = @ptrFromInt(base_address + 0x0);

    /// PTPSSIR
    pub const PTPSSIR_struct = packed struct {
        /// STSSI [0:7]
        /// System time subsecond
        STSSI: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet PTP subsecond increment
    pub const PTPSSIR: *volatile PTPSSIR_struct = @ptrFromInt(base_address + 0x4);

    /// PTPTSHR
    pub const PTPTSHR_struct = packed struct {
        /// STS [0:31]
        /// System time second
        STS: u32 = 0,
    };
    /// Ethernet PTP time stamp high
    pub const PTPTSHR: *volatile PTPTSHR_struct = @ptrFromInt(base_address + 0x8);

    /// PTPTSLR
    pub const PTPTSLR_struct = packed struct {
        /// STSS [0:30]
        /// System time subseconds
        STSS: u31 = 0,
        /// STPNS [31:31]
        /// System time positive or negative
        STPNS: u1 = 0,
    };
    /// Ethernet PTP time stamp low register
    pub const PTPTSLR: *volatile PTPTSLR_struct = @ptrFromInt(base_address + 0xc);

    /// PTPTSHUR
    pub const PTPTSHUR_struct = packed struct {
        /// TSUS [0:31]
        /// Time stamp update second
        TSUS: u32 = 0,
    };
    /// Ethernet PTP time stamp high update
    pub const PTPTSHUR: *volatile PTPTSHUR_struct = @ptrFromInt(base_address + 0x10);

    /// PTPTSLUR
    pub const PTPTSLUR_struct = packed struct {
        /// TSUSS [0:30]
        /// Time stamp update
        TSUSS: u31 = 0,
        /// TSUPNS [31:31]
        /// Time stamp update positive or negative
        TSUPNS: u1 = 0,
    };
    /// Ethernet PTP time stamp low update register
    pub const PTPTSLUR: *volatile PTPTSLUR_struct = @ptrFromInt(base_address + 0x14);

    /// PTPTSAR
    pub const PTPTSAR_struct = packed struct {
        /// TSA [0:31]
        /// Time stamp addend
        TSA: u32 = 0,
    };
    /// Ethernet PTP time stamp addend
    pub const PTPTSAR: *volatile PTPTSAR_struct = @ptrFromInt(base_address + 0x18);

    /// PTPTTHR
    pub const PTPTTHR_struct = packed struct {
        /// TTSH [0:31]
        /// Target time stamp high
        TTSH: u32 = 0,
    };
    /// Ethernet PTP target time high
    pub const PTPTTHR: *volatile PTPTTHR_struct = @ptrFromInt(base_address + 0x1c);

    /// PTPTTLR
    pub const PTPTTLR_struct = packed struct {
        /// TTSL [0:31]
        /// Target time stamp low
        TTSL: u32 = 0,
    };
    /// Ethernet PTP target time low
    pub const PTPTTLR: *volatile PTPTTLR_struct = @ptrFromInt(base_address + 0x20);
};

/// Ethernet: DMA controller operation
pub const ETHERNET_DMA = struct {
    pub const base_address = 0x40029000;
    /// DMABMR
    pub const DMABMR_struct = packed struct {
        /// SR [0:0]
        /// Software reset
        SR: u1 = 1,
        /// DA [1:1]
        /// DMA Arbitration
        DA: u1 = 0,
        /// DSL [2:6]
        /// Descriptor skip length
        DSL: u5 = 0,
        /// unused [7:7]
        _unused7: u1 = 0,
        /// PBL [8:13]
        /// Programmable burst length
        PBL: u6 = 1,
        /// RTPR [14:15]
        /// Rx Tx priority ratio
        RTPR: u2 = 0,
        /// FB [16:16]
        /// Fixed burst
        FB: u1 = 0,
        /// RDP [17:22]
        /// Rx DMA PBL
        RDP: u6 = 1,
        /// USP [23:23]
        /// Use separate PBL
        USP: u1 = 0,
        /// FPM [24:24]
        /// 4xPBL mode
        FPM: u1 = 0,
        /// AAB [25:25]
        /// Address-aligned beats
        AAB: u1 = 0,
        /// unused [26:31]
        _unused26: u6 = 0,
    };
    /// Ethernet DMA bus mode register
    pub const DMABMR: *volatile DMABMR_struct = @ptrFromInt(base_address + 0x0);

    /// DMATPDR
    pub const DMATPDR_struct = packed struct {
        /// TPD [0:31]
        /// Transmit poll demand
        TPD: u32 = 0,
    };
    /// Ethernet DMA transmit poll demand
    pub const DMATPDR: *volatile DMATPDR_struct = @ptrFromInt(base_address + 0x4);

    /// DMARPDR
    pub const DMARPDR_struct = packed struct {
        /// RPD [0:31]
        /// Receive poll demand
        RPD: u32 = 0,
    };
    /// EHERNET DMA receive poll demand
    pub const DMARPDR: *volatile DMARPDR_struct = @ptrFromInt(base_address + 0x8);

    /// DMARDLAR
    pub const DMARDLAR_struct = packed struct {
        /// SRL [0:31]
        /// Start of receive list
        SRL: u32 = 0,
    };
    /// Ethernet DMA receive descriptor list address
    pub const DMARDLAR: *volatile DMARDLAR_struct = @ptrFromInt(base_address + 0xc);

    /// DMATDLAR
    pub const DMATDLAR_struct = packed struct {
        /// STL [0:31]
        /// Start of transmit list
        STL: u32 = 0,
    };
    /// Ethernet DMA transmit descriptor list
    pub const DMATDLAR: *volatile DMATDLAR_struct = @ptrFromInt(base_address + 0x10);

    /// DMASR
    pub const DMASR_struct = packed struct {
        /// TS [0:0]
        /// Transmit status
        TS: u1 = 0,
        /// TPSS [1:1]
        /// Transmit process stopped
        TPSS: u1 = 0,
        /// TBUS [2:2]
        /// Transmit buffer unavailable
        TBUS: u1 = 0,
        /// TJTS [3:3]
        /// Transmit jabber timeout
        TJTS: u1 = 0,
        /// ROS [4:4]
        /// Receive overflow status
        ROS: u1 = 0,
        /// TUS [5:5]
        /// Transmit underflow status
        TUS: u1 = 0,
        /// RS [6:6]
        /// Receive status
        RS: u1 = 0,
        /// RBUS [7:7]
        /// Receive buffer unavailable
        RBUS: u1 = 0,
        /// RPSS [8:8]
        /// Receive process stopped
        RPSS: u1 = 0,
        /// PWTS [9:9]
        /// Receive watchdog timeout
        PWTS: u1 = 0,
        /// ETS [10:10]
        /// Early transmit status
        ETS: u1 = 0,
        /// unused [11:12]
        _unused11: u2 = 0,
        /// FBES [13:13]
        /// Fatal bus error status
        FBES: u1 = 0,
        /// ERS [14:14]
        /// Early receive status
        ERS: u1 = 0,
        /// AIS [15:15]
        /// Abnormal interrupt summary
        AIS: u1 = 0,
        /// NIS [16:16]
        /// Normal interrupt summary
        NIS: u1 = 0,
        /// RPS [17:19]
        /// Receive process state
        RPS: u3 = 0,
        /// TPS [20:22]
        /// Transmit process state
        TPS: u3 = 0,
        /// EBS [23:25]
        /// Error bits status
        EBS: u3 = 0,
        /// unused [26:26]
        _unused26: u1 = 0,
        /// MMCS [27:27]
        /// MMC status
        MMCS: u1 = 0,
        /// PMTS [28:28]
        /// PMT status
        PMTS: u1 = 0,
        /// TSTS [29:29]
        /// Time stamp trigger status
        TSTS: u1 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// Ethernet DMA status register
    pub const DMASR: *volatile DMASR_struct = @ptrFromInt(base_address + 0x14);

    /// DMAOMR
    pub const DMAOMR_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// SR [1:1]
        /// SR
        SR: u1 = 0,
        /// OSF [2:2]
        /// OSF
        OSF: u1 = 0,
        /// RTC [3:4]
        /// RTC
        RTC: u2 = 0,
        /// unused [5:5]
        _unused5: u1 = 0,
        /// FUGF [6:6]
        /// FUGF
        FUGF: u1 = 0,
        /// FEF [7:7]
        /// FEF
        FEF: u1 = 0,
        /// unused [8:12]
        _unused8: u5 = 0,
        /// ST [13:13]
        /// ST
        ST: u1 = 0,
        /// TTC [14:16]
        /// TTC
        TTC: u3 = 0,
        /// unused [17:19]
        _unused17: u3 = 0,
        /// FTF [20:20]
        /// FTF
        FTF: u1 = 0,
        /// TSF [21:21]
        /// TSF
        TSF: u1 = 0,
        /// unused [22:23]
        _unused22: u2 = 0,
        /// DFRF [24:24]
        /// DFRF
        DFRF: u1 = 0,
        /// RSF [25:25]
        /// RSF
        RSF: u1 = 0,
        /// DTCEFD [26:26]
        /// DTCEFD
        DTCEFD: u1 = 0,
        /// unused [27:31]
        _unused27: u5 = 0,
    };
    /// Ethernet DMA operation mode
    pub const DMAOMR: *volatile DMAOMR_struct = @ptrFromInt(base_address + 0x18);

    /// DMAIER
    pub const DMAIER_struct = packed struct {
        /// TIE [0:0]
        /// Transmit interrupt enable
        TIE: u1 = 0,
        /// TPSIE [1:1]
        /// Transmit process stopped interrupt
        TPSIE: u1 = 0,
        /// TBUIE [2:2]
        /// Transmit buffer unavailable interrupt
        TBUIE: u1 = 0,
        /// TJTIE [3:3]
        /// Transmit jabber timeout interrupt
        TJTIE: u1 = 0,
        /// ROIE [4:4]
        /// Overflow interrupt enable
        ROIE: u1 = 0,
        /// TUIE [5:5]
        /// Underflow interrupt enable
        TUIE: u1 = 0,
        /// RIE [6:6]
        /// Receive interrupt enable
        RIE: u1 = 0,
        /// RBUIE [7:7]
        /// Receive buffer unavailable interrupt
        RBUIE: u1 = 0,
        /// RPSIE [8:8]
        /// Receive process stopped interrupt
        RPSIE: u1 = 0,
        /// RWTIE [9:9]
        /// receive watchdog timeout interrupt
        RWTIE: u1 = 0,
        /// ETIE [10:10]
        /// Early transmit interrupt
        ETIE: u1 = 0,
        /// unused [11:12]
        _unused11: u2 = 0,
        /// FBEIE [13:13]
        /// Fatal bus error interrupt
        FBEIE: u1 = 0,
        /// ERIE [14:14]
        /// Early receive interrupt
        ERIE: u1 = 0,
        /// AISE [15:15]
        /// Abnormal interrupt summary
        AISE: u1 = 0,
        /// NISE [16:16]
        /// Normal interrupt summary
        NISE: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// Ethernet DMA interrupt enable
    pub const DMAIER: *volatile DMAIER_struct = @ptrFromInt(base_address + 0x1c);

    /// DMAMFBOCR
    pub const DMAMFBOCR_struct = packed struct {
        /// MFC [0:15]
        /// Missed frames by the
        MFC: u16 = 0,
        /// OMFC [16:16]
        /// Overflow bit for missed frame
        OMFC: u1 = 0,
        /// MFA [17:27]
        /// Missed frames by the
        MFA: u11 = 0,
        /// OFOC [28:28]
        /// Overflow bit for FIFO overflow
        OFOC: u1 = 0,
        /// unused [29:31]
        _unused29: u3 = 0,
    };
    /// Ethernet DMA missed frame and buffer
    pub const DMAMFBOCR: *volatile DMAMFBOCR_struct = @ptrFromInt(base_address + 0x20);

    /// DMACHTDR
    pub const DMACHTDR_struct = packed struct {
        /// HTDAP [0:31]
        /// Host transmit descriptor address
        HTDAP: u32 = 0,
    };
    /// Ethernet DMA current host transmit
    pub const DMACHTDR: *volatile DMACHTDR_struct = @ptrFromInt(base_address + 0x48);

    /// DMACHRDR
    pub const DMACHRDR_struct = packed struct {
        /// HRDAP [0:31]
        /// Host receive descriptor address
        HRDAP: u32 = 0,
    };
    /// Ethernet DMA current host receive descriptor
    pub const DMACHRDR: *volatile DMACHRDR_struct = @ptrFromInt(base_address + 0x4c);

    /// DMACHTBAR
    pub const DMACHTBAR_struct = packed struct {
        /// HTBAP [0:31]
        /// Host transmit buffer address
        HTBAP: u32 = 0,
    };
    /// Ethernet DMA current host transmit buffer
    pub const DMACHTBAR: *volatile DMACHTBAR_struct = @ptrFromInt(base_address + 0x50);

    /// DMACHRBAR
    pub const DMACHRBAR_struct = packed struct {
        /// HRBAP [0:31]
        /// Host receive buffer address
        HRBAP: u32 = 0,
    };
    /// Ethernet DMA current host receive buffer
    pub const DMACHRBAR: *volatile DMACHRBAR_struct = @ptrFromInt(base_address + 0x54);
};

/// Nested Vectored Interrupt
pub const NVIC = struct {
    pub const base_address = 0xe000e100;
    /// ISER0
    pub const ISER0_struct = packed struct {
        /// SETENA [0:31]
        /// SETENA
        SETENA: u32 = 0,
    };
    /// Interrupt Set-Enable Register
    pub const ISER0: *volatile ISER0_struct = @ptrFromInt(base_address + 0x0);

    /// ISER1
    pub const ISER1_struct = packed struct {
        /// SETENA [0:31]
        /// SETENA
        SETENA: u32 = 0,
    };
    /// Interrupt Set-Enable Register
    pub const ISER1: *volatile ISER1_struct = @ptrFromInt(base_address + 0x4);

    /// ICER0
    pub const ICER0_struct = packed struct {
        /// CLRENA [0:31]
        /// CLRENA
        CLRENA: u32 = 0,
    };
    /// Interrupt Clear-Enable
    pub const ICER0: *volatile ICER0_struct = @ptrFromInt(base_address + 0x80);

    /// ICER1
    pub const ICER1_struct = packed struct {
        /// CLRENA [0:31]
        /// CLRENA
        CLRENA: u32 = 0,
    };
    /// Interrupt Clear-Enable
    pub const ICER1: *volatile ICER1_struct = @ptrFromInt(base_address + 0x84);

    /// ISPR0
    pub const ISPR0_struct = packed struct {
        /// SETPEND [0:31]
        /// SETPEND
        SETPEND: u32 = 0,
    };
    /// Interrupt Set-Pending Register
    pub const ISPR0: *volatile ISPR0_struct = @ptrFromInt(base_address + 0x100);

    /// ISPR1
    pub const ISPR1_struct = packed struct {
        /// SETPEND [0:31]
        /// SETPEND
        SETPEND: u32 = 0,
    };
    /// Interrupt Set-Pending Register
    pub const ISPR1: *volatile ISPR1_struct = @ptrFromInt(base_address + 0x104);

    /// ICPR0
    pub const ICPR0_struct = packed struct {
        /// CLRPEND [0:31]
        /// CLRPEND
        CLRPEND: u32 = 0,
    };
    /// Interrupt Clear-Pending
    pub const ICPR0: *volatile ICPR0_struct = @ptrFromInt(base_address + 0x180);

    /// ICPR1
    pub const ICPR1_struct = packed struct {
        /// CLRPEND [0:31]
        /// CLRPEND
        CLRPEND: u32 = 0,
    };
    /// Interrupt Clear-Pending
    pub const ICPR1: *volatile ICPR1_struct = @ptrFromInt(base_address + 0x184);

    /// IABR0
    pub const IABR0_struct = packed struct {
        /// ACTIVE [0:31]
        /// ACTIVE
        ACTIVE: u32 = 0,
    };
    /// Interrupt Active Bit Register
    pub const IABR0: *volatile IABR0_struct = @ptrFromInt(base_address + 0x200);

    /// IABR1
    pub const IABR1_struct = packed struct {
        /// ACTIVE [0:31]
        /// ACTIVE
        ACTIVE: u32 = 0,
    };
    /// Interrupt Active Bit Register
    pub const IABR1: *volatile IABR1_struct = @ptrFromInt(base_address + 0x204);

    /// IPR0
    pub const IPR0_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR0: *volatile IPR0_struct = @ptrFromInt(base_address + 0x300);

    /// IPR1
    pub const IPR1_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR1: *volatile IPR1_struct = @ptrFromInt(base_address + 0x304);

    /// IPR2
    pub const IPR2_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR2: *volatile IPR2_struct = @ptrFromInt(base_address + 0x308);

    /// IPR3
    pub const IPR3_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR3: *volatile IPR3_struct = @ptrFromInt(base_address + 0x30c);

    /// IPR4
    pub const IPR4_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR4: *volatile IPR4_struct = @ptrFromInt(base_address + 0x310);

    /// IPR5
    pub const IPR5_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR5: *volatile IPR5_struct = @ptrFromInt(base_address + 0x314);

    /// IPR6
    pub const IPR6_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR6: *volatile IPR6_struct = @ptrFromInt(base_address + 0x318);

    /// IPR7
    pub const IPR7_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR7: *volatile IPR7_struct = @ptrFromInt(base_address + 0x31c);

    /// IPR8
    pub const IPR8_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR8: *volatile IPR8_struct = @ptrFromInt(base_address + 0x320);

    /// IPR9
    pub const IPR9_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR9: *volatile IPR9_struct = @ptrFromInt(base_address + 0x324);

    /// IPR10
    pub const IPR10_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR10: *volatile IPR10_struct = @ptrFromInt(base_address + 0x328);

    /// IPR11
    pub const IPR11_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR11: *volatile IPR11_struct = @ptrFromInt(base_address + 0x32c);

    /// IPR12
    pub const IPR12_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR12: *volatile IPR12_struct = @ptrFromInt(base_address + 0x330);

    /// IPR13
    pub const IPR13_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR13: *volatile IPR13_struct = @ptrFromInt(base_address + 0x334);

    /// IPR14
    pub const IPR14_struct = packed struct {
        /// IPR_N0 [0:7]
        /// IPR_N0
        IPR_N0: u8 = 0,
        /// IPR_N1 [8:15]
        /// IPR_N1
        IPR_N1: u8 = 0,
        /// IPR_N2 [16:23]
        /// IPR_N2
        IPR_N2: u8 = 0,
        /// IPR_N3 [24:31]
        /// IPR_N3
        IPR_N3: u8 = 0,
    };
    /// Interrupt Priority Register
    pub const IPR14: *volatile IPR14_struct = @ptrFromInt(base_address + 0x338);
};

/// Memory protection unit
pub const MPU = struct {
    pub const base_address = 0xe000ed90;
    /// MPU_TYPER
    pub const MPU_TYPER_struct = packed struct {
        /// SEPARATE [0:0]
        /// Separate flag
        SEPARATE: u1 = 0,
        /// unused [1:7]
        _unused1: u7 = 0,
        /// DREGION [8:15]
        /// Number of MPU data regions
        DREGION: u8 = 8,
        /// IREGION [16:23]
        /// Number of MPU instruction
        IREGION: u8 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// MPU type register
    pub const MPU_TYPER: *volatile MPU_TYPER_struct = @ptrFromInt(base_address + 0x0);

    /// MPU_CTRL
    pub const MPU_CTRL_struct = packed struct {
        /// ENABLE [0:0]
        /// Enables the MPU
        ENABLE: u1 = 0,
        /// HFNMIENA [1:1]
        /// Enables the operation of MPU during hard
        HFNMIENA: u1 = 0,
        /// PRIVDEFENA [2:2]
        /// Enable priviliged software access to
        PRIVDEFENA: u1 = 0,
        /// unused [3:31]
        _unused3: u5 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// MPU control register
    pub const MPU_CTRL: *volatile MPU_CTRL_struct = @ptrFromInt(base_address + 0x4);

    /// MPU_RNR
    pub const MPU_RNR_struct = packed struct {
        /// REGION [0:7]
        /// MPU region
        REGION: u8 = 0,
        /// unused [8:31]
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// MPU region number register
    pub const MPU_RNR: *volatile MPU_RNR_struct = @ptrFromInt(base_address + 0x8);

    /// MPU_RBAR
    pub const MPU_RBAR_struct = packed struct {
        /// REGION [0:3]
        /// MPU region field
        REGION: u4 = 0,
        /// VALID [4:4]
        /// MPU region number valid
        VALID: u1 = 0,
        /// ADDR [5:31]
        /// Region base address field
        ADDR: u27 = 0,
    };
    /// MPU region base address
    pub const MPU_RBAR: *volatile MPU_RBAR_struct = @ptrFromInt(base_address + 0xc);

    /// MPU_RASR
    pub const MPU_RASR_struct = packed struct {
        /// ENABLE [0:0]
        /// Region enable bit.
        ENABLE: u1 = 0,
        /// SIZE [1:5]
        /// Size of the MPU protection
        SIZE: u5 = 0,
        /// unused [6:7]
        _unused6: u2 = 0,
        /// SRD [8:15]
        /// Subregion disable bits
        SRD: u8 = 0,
        /// B [16:16]
        /// memory attribute
        B: u1 = 0,
        /// C [17:17]
        /// memory attribute
        C: u1 = 0,
        /// S [18:18]
        /// Shareable memory attribute
        S: u1 = 0,
        /// TEX [19:21]
        /// memory attribute
        TEX: u3 = 0,
        /// unused [22:23]
        _unused22: u2 = 0,
        /// AP [24:26]
        /// Access permission
        AP: u3 = 0,
        /// unused [27:27]
        _unused27: u1 = 0,
        /// XN [28:28]
        /// Instruction access disable
        XN: u1 = 0,
        /// unused [29:31]
        _unused29: u3 = 0,
    };
    /// MPU region attribute and size
    pub const MPU_RASR: *volatile MPU_RASR_struct = @ptrFromInt(base_address + 0x10);
};

/// System control block ACTLR
pub const SCB_ACTRL = struct {
    pub const base_address = 0xe000e008;
    /// ACTRL
    pub const ACTRL_struct = packed struct {
        /// unused [0:1]
        _unused0: u2 = 0,
        /// DISFOLD [2:2]
        /// DISFOLD
        DISFOLD: u1 = 0,
        /// unused [3:9]
        _unused3: u5 = 0,
        _unused8: u2 = 0,
        /// FPEXCODIS [10:10]
        /// FPEXCODIS
        FPEXCODIS: u1 = 0,
        /// DISRAMODE [11:11]
        /// DISRAMODE
        DISRAMODE: u1 = 0,
        /// DISITMATBFLUSH [12:12]
        /// DISITMATBFLUSH
        DISITMATBFLUSH: u1 = 0,
        /// unused [13:31]
        _unused13: u3 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Auxiliary control register
    pub const ACTRL: *volatile ACTRL_struct = @ptrFromInt(base_address + 0x0);
};

/// Nested vectored interrupt
pub const NVIC_STIR = struct {
    pub const base_address = 0xe000ef00;
    /// STIR
    pub const STIR_struct = packed struct {
        /// INTID [0:8]
        /// Software generated interrupt
        INTID: u9 = 0,
        /// unused [9:31]
        _unused9: u7 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Software trigger interrupt
    pub const STIR: *volatile STIR_struct = @ptrFromInt(base_address + 0x0);
};

/// System control block
pub const SCB = struct {
    pub const base_address = 0xe000ed00;
    /// CPUID
    pub const CPUID_struct = packed struct {
        /// Revision [0:3]
        /// Revision number
        Revision: u4 = 1,
        /// PartNo [4:15]
        /// Part number of the
        PartNo: u12 = 3108,
        /// Constant [16:19]
        /// Reads as 0xF
        Constant: u4 = 15,
        /// Variant [20:23]
        /// Variant number
        Variant: u4 = 0,
        /// Implementer [24:31]
        /// Implementer code
        Implementer: u8 = 65,
    };
    /// CPUID base register
    pub const CPUID: *volatile CPUID_struct = @ptrFromInt(base_address + 0x0);

    /// ICSR
    pub const ICSR_struct = packed struct {
        /// VECTACTIVE [0:8]
        /// Active vector
        VECTACTIVE: u9 = 0,
        /// unused [9:10]
        _unused9: u2 = 0,
        /// RETTOBASE [11:11]
        /// Return to base level
        RETTOBASE: u1 = 0,
        /// VECTPENDING [12:18]
        /// Pending vector
        VECTPENDING: u7 = 0,
        /// unused [19:21]
        _unused19: u3 = 0,
        /// ISRPENDING [22:22]
        /// Interrupt pending flag
        ISRPENDING: u1 = 0,
        /// unused [23:24]
        _unused23: u1 = 0,
        _unused24: u1 = 0,
        /// PENDSTCLR [25:25]
        /// SysTick exception clear-pending
        PENDSTCLR: u1 = 0,
        /// PENDSTSET [26:26]
        /// SysTick exception set-pending
        PENDSTSET: u1 = 0,
        /// PENDSVCLR [27:27]
        /// PendSV clear-pending bit
        PENDSVCLR: u1 = 0,
        /// PENDSVSET [28:28]
        /// PendSV set-pending bit
        PENDSVSET: u1 = 0,
        /// unused [29:30]
        _unused29: u2 = 0,
        /// NMIPENDSET [31:31]
        /// NMI set-pending bit.
        NMIPENDSET: u1 = 0,
    };
    /// Interrupt control and state
    pub const ICSR: *volatile ICSR_struct = @ptrFromInt(base_address + 0x4);

    /// VTOR
    pub const VTOR_struct = packed struct {
        /// unused [0:8]
        _unused0: u8 = 0,
        _unused8: u1 = 0,
        /// TBLOFF [9:29]
        /// Vector table base offset
        TBLOFF: u21 = 0,
        /// unused [30:31]
        _unused30: u2 = 0,
    };
    /// Vector table offset register
    pub const VTOR: *volatile VTOR_struct = @ptrFromInt(base_address + 0x8);

    /// AIRCR
    pub const AIRCR_struct = packed struct {
        /// VECTRESET [0:0]
        /// VECTRESET
        VECTRESET: u1 = 0,
        /// VECTCLRACTIVE [1:1]
        /// VECTCLRACTIVE
        VECTCLRACTIVE: u1 = 0,
        /// SYSRESETREQ [2:2]
        /// SYSRESETREQ
        SYSRESETREQ: u1 = 0,
        /// unused [3:7]
        _unused3: u5 = 0,
        /// PRIGROUP [8:10]
        /// PRIGROUP
        PRIGROUP: u3 = 0,
        /// unused [11:14]
        _unused11: u4 = 0,
        /// ENDIANESS [15:15]
        /// ENDIANESS
        ENDIANESS: u1 = 0,
        /// VECTKEYSTAT [16:31]
        /// Register key
        VECTKEYSTAT: u16 = 0,
    };
    /// Application interrupt and reset control
    pub const AIRCR: *volatile AIRCR_struct = @ptrFromInt(base_address + 0xc);

    /// SCR
    pub const SCR_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// SLEEPONEXIT [1:1]
        /// SLEEPONEXIT
        SLEEPONEXIT: u1 = 0,
        /// SLEEPDEEP [2:2]
        /// SLEEPDEEP
        SLEEPDEEP: u1 = 0,
        /// unused [3:3]
        _unused3: u1 = 0,
        /// SEVEONPEND [4:4]
        /// Send Event on Pending bit
        SEVEONPEND: u1 = 0,
        /// unused [5:31]
        _unused5: u3 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// System control register
    pub const SCR: *volatile SCR_struct = @ptrFromInt(base_address + 0x10);

    /// CCR
    pub const CCR_struct = packed struct {
        /// NONBASETHRDENA [0:0]
        /// Configures how the processor enters
        NONBASETHRDENA: u1 = 0,
        /// USERSETMPEND [1:1]
        /// USERSETMPEND
        USERSETMPEND: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// UNALIGN__TRP [3:3]
        /// UNALIGN_ TRP
        UNALIGN__TRP: u1 = 0,
        /// DIV_0_TRP [4:4]
        /// DIV_0_TRP
        DIV_0_TRP: u1 = 0,
        /// unused [5:7]
        _unused5: u3 = 0,
        /// BFHFNMIGN [8:8]
        /// BFHFNMIGN
        BFHFNMIGN: u1 = 0,
        /// STKALIGN [9:9]
        /// STKALIGN
        STKALIGN: u1 = 0,
        /// unused [10:31]
        _unused10: u6 = 0,
        _unused16: u8 = 0,
        _unused24: u8 = 0,
    };
    /// Configuration and control
    pub const CCR: *volatile CCR_struct = @ptrFromInt(base_address + 0x14);

    /// SHPR1
    pub const SHPR1_struct = packed struct {
        /// PRI_4 [0:7]
        /// Priority of system handler
        PRI_4: u8 = 0,
        /// PRI_5 [8:15]
        /// Priority of system handler
        PRI_5: u8 = 0,
        /// PRI_6 [16:23]
        /// Priority of system handler
        PRI_6: u8 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// System handler priority
    pub const SHPR1: *volatile SHPR1_struct = @ptrFromInt(base_address + 0x18);

    /// SHPR2
    pub const SHPR2_struct = packed struct {
        /// unused [0:23]
        _unused0: u8 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        /// PRI_11 [24:31]
        /// Priority of system handler
        PRI_11: u8 = 0,
    };
    /// System handler priority
    pub const SHPR2: *volatile SHPR2_struct = @ptrFromInt(base_address + 0x1c);

    /// SHPR3
    pub const SHPR3_struct = packed struct {
        /// PRI_12 [16:23]
        /// Priority of system handler
        PRI_12: u8 = 0,
        _unused8: u8 = 0,
        /// PRI_14 [16:23]
        /// Priority of system handler
        PRI_14: u8 = 0,
        /// PRI_15 [24:31]
        /// Priority of system handler
        PRI_15: u8 = 0,
    };
    /// System handler priority
    pub const SHPR3: *volatile SHPR3_struct = @ptrFromInt(base_address + 0x20);

    /// SHCRS
    pub const SHCRS_struct = packed struct {
        /// MEMFAULTACT [0:0]
        /// Memory management fault exception active
        MEMFAULTACT: u1 = 0,
        /// BUSFAULTACT [1:1]
        /// Bus fault exception active
        BUSFAULTACT: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// USGFAULTACT [3:3]
        /// Usage fault exception active
        USGFAULTACT: u1 = 0,
        /// unused [4:6]
        _unused4: u3 = 0,
        /// SVCALLACT [7:7]
        /// SVC call active bit
        SVCALLACT: u1 = 0,
        /// MONITORACT [8:8]
        /// Debug monitor active bit
        MONITORACT: u1 = 0,
        /// unused [9:9]
        _unused9: u1 = 0,
        /// PENDSVACT [10:10]
        /// PendSV exception active
        PENDSVACT: u1 = 0,
        /// SYSTICKACT [11:11]
        /// SysTick exception active
        SYSTICKACT: u1 = 0,
        /// USGFAULTPENDED [12:12]
        /// Usage fault exception pending
        USGFAULTPENDED: u1 = 0,
        /// MEMFAULTPENDED [13:13]
        /// Memory management fault exception
        MEMFAULTPENDED: u1 = 0,
        /// BUSFAULTPENDED [14:14]
        /// Bus fault exception pending
        BUSFAULTPENDED: u1 = 0,
        /// SVCALLPENDED [15:15]
        /// SVC call pending bit
        SVCALLPENDED: u1 = 0,
        /// MEMFAULTENA [16:16]
        /// Memory management fault enable
        MEMFAULTENA: u1 = 0,
        /// BUSFAULTENA [17:17]
        /// Bus fault enable bit
        BUSFAULTENA: u1 = 0,
        /// USGFAULTENA [18:18]
        /// Usage fault enable bit
        USGFAULTENA: u1 = 0,
        /// unused [19:31]
        _unused19: u5 = 0,
        _unused24: u8 = 0,
    };
    /// System handler control and state
    pub const SHCRS: *volatile SHCRS_struct = @ptrFromInt(base_address + 0x24);

    /// CFSR_UFSR_BFSR_MMFSR
    pub const CFSR_UFSR_BFSR_MMFSR_struct = packed struct {
        /// IACCVIOL [0:0]
        /// IACCVIOL
        IACCVIOL: u1 = 0,
        /// DACCVIOL [1:1]
        /// DACCVIOL
        DACCVIOL: u1 = 0,
        /// unused [2:2]
        _unused2: u1 = 0,
        /// MUNSTKERR [3:3]
        /// MUNSTKERR
        MUNSTKERR: u1 = 0,
        /// MSTKERR [4:4]
        /// MSTKERR
        MSTKERR: u1 = 0,
        /// MLSPERR [5:5]
        /// MLSPERR
        MLSPERR: u1 = 0,
        /// unused [6:6]
        _unused6: u1 = 0,
        /// MMARVALID [7:7]
        /// MMARVALID
        MMARVALID: u1 = 0,
        /// IBUSERR [8:8]
        /// Instruction bus error
        IBUSERR: u1 = 0,
        /// PRECISERR [9:9]
        /// Precise data bus error
        PRECISERR: u1 = 0,
        /// IMPRECISERR [10:10]
        /// Imprecise data bus error
        IMPRECISERR: u1 = 0,
        /// UNSTKERR [11:11]
        /// Bus fault on unstacking for a return
        UNSTKERR: u1 = 0,
        /// STKERR [12:12]
        /// Bus fault on stacking for exception
        STKERR: u1 = 0,
        /// LSPERR [13:13]
        /// Bus fault on floating-point lazy state
        LSPERR: u1 = 0,
        /// unused [14:14]
        _unused14: u1 = 0,
        /// BFARVALID [15:15]
        /// Bus Fault Address Register (BFAR) valid
        BFARVALID: u1 = 0,
        /// UNDEFINSTR [16:16]
        /// Undefined instruction usage
        UNDEFINSTR: u1 = 0,
        /// INVSTATE [17:17]
        /// Invalid state usage fault
        INVSTATE: u1 = 0,
        /// INVPC [18:18]
        /// Invalid PC load usage
        INVPC: u1 = 0,
        /// NOCP [19:19]
        /// No coprocessor usage
        NOCP: u1 = 0,
        /// unused [20:23]
        _unused20: u4 = 0,
        /// UNALIGNED [24:24]
        /// Unaligned access usage
        UNALIGNED: u1 = 0,
        /// DIVBYZERO [25:25]
        /// Divide by zero usage fault
        DIVBYZERO: u1 = 0,
        /// unused [26:31]
        _unused26: u6 = 0,
    };
    /// Configurable fault status
    pub const CFSR_UFSR_BFSR_MMFSR: *volatile CFSR_UFSR_BFSR_MMFSR_struct = @ptrFromInt(base_address + 0x28);

    /// HFSR
    pub const HFSR_struct = packed struct {
        /// unused [0:0]
        _unused0: u1 = 0,
        /// VECTTBL [1:1]
        /// Vector table hard fault
        VECTTBL: u1 = 0,
        /// unused [2:29]
        _unused2: u6 = 0,
        _unused8: u8 = 0,
        _unused16: u8 = 0,
        _unused24: u6 = 0,
        /// FORCED [30:30]
        /// Forced hard fault
        FORCED: u1 = 0,
        /// DEBUG_VT [31:31]
        /// Reserved for Debug use
        DEBUG_VT: u1 = 0,
    };
    /// Hard fault status register
    pub const HFSR: *volatile HFSR_struct = @ptrFromInt(base_address + 0x2c);

    /// MMFAR
    pub const MMFAR_struct = packed struct {
        /// MMFAR [0:31]
        /// Memory management fault
        MMFAR: u32 = 0,
    };
    /// Memory management fault address
    pub const MMFAR: *volatile MMFAR_struct = @ptrFromInt(base_address + 0x34);

    /// BFAR
    pub const BFAR_struct = packed struct {
        /// BFAR [0:31]
        /// Bus fault address
        BFAR: u32 = 0,
    };
    /// Bus fault address register
    pub const BFAR: *volatile BFAR_struct = @ptrFromInt(base_address + 0x38);
};

/// SysTick timer
pub const STK = struct {
    pub const base_address = 0xe000e010;
    /// CTRL
    pub const CTRL_struct = packed struct {
        /// ENABLE [0:0]
        /// Counter enable
        ENABLE: u1 = 0,
        /// TICKINT [1:1]
        /// SysTick exception request
        TICKINT: u1 = 0,
        /// CLKSOURCE [2:2]
        /// Clock source selection
        CLKSOURCE: u1 = 0,
        /// unused [3:15]
        _unused3: u5 = 0,
        _unused8: u8 = 0,
        /// COUNTFLAG [16:16]
        /// COUNTFLAG
        COUNTFLAG: u1 = 0,
        /// unused [17:31]
        _unused17: u7 = 0,
        _unused24: u8 = 0,
    };
    /// SysTick control and status
    pub const CTRL: *volatile CTRL_struct = @ptrFromInt(base_address + 0x0);

    /// LOAD_
    pub const LOAD__struct = packed struct {
        /// RELOAD [0:23]
        /// RELOAD value
        RELOAD: u24 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// SysTick reload value register
    pub const LOAD_: *volatile LOAD__struct = @ptrFromInt(base_address + 0x4);

    /// VAL
    pub const VAL_struct = packed struct {
        /// CURRENT [0:23]
        /// Current counter value
        CURRENT: u24 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// SysTick current value register
    pub const VAL: *volatile VAL_struct = @ptrFromInt(base_address + 0x8);

    /// CALIB
    pub const CALIB_struct = packed struct {
        /// TENMS [0:23]
        /// Calibration value
        TENMS: u24 = 0,
        /// unused [24:31]
        _unused24: u8 = 0,
    };
    /// SysTick calibration value
    pub const CALIB: *volatile CALIB_struct = @ptrFromInt(base_address + 0xc);
};
pub const Interrupts = enum(u8) {
    EXTI3 = 9,
    TIM2 = 28,
    I2C2_EV = 33,
    RCC = 5,
    TIM1_CC = 27,
    TIM7 = 55,
    USART1 = 37,
    TIM3 = 29,
    DMA1_Channel5 = 15,
    TIM8_CC = 46,
    TIM6 = 54,
    SPI2 = 36,
    DMA1_Channel7 = 17,
    ADC1_2 = 18,
    USB_LP_CAN_RX0 = 20,
    EXTI1 = 7,
    DMA1_Channel6 = 16,
    DMA1_Channel4 = 14,
    I2C1_ER = 32,
    TIM8_UP = 44,
    DMA2_Channel4_5 = 59,
    TIM8_BRK = 43,
    TIM5 = 50,
    EXTI4 = 10,
    SPI1 = 35,
    UART4 = 52,
    RTC = 3,
    TIM4 = 30,
    CAN_SCE = 22,
    DMA1_Channel1 = 11,
    USART2 = 38,
    DMA1_Channel3 = 13,
    WWDG = 0,
    FSMC = 48,
    DMA2_Channel2 = 57,
    TIM1_BRK = 24,
    EXTI0 = 6,
    SDIO = 49,
    CAN_RX1 = 21,
    DMA2_Channel3 = 58,
    PVD = 1,
    EXTI15_10 = 40,
    TIM8_TRG_COM = 45,
    I2C2_ER = 34,
    SPI3 = 51,
    TIM1_TRG_COM = 26,
    I2C1_EV = 31,
    RTCAlarm = 41,
    ADC3 = 47,
    USART3 = 39,
    TAMPER = 2,
    TIM1_UP = 25,
    UART5 = 53,
    EXTI9_5 = 23,
    USB_HP_CAN_TX = 19,
    DMA1_Channel2 = 12,
    EXTI2 = 8,
    FLASH = 4,
    DMA2_Channel1 = 56,
};
