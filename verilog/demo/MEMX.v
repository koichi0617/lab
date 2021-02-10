//-----------------------------------------------------------------------------
// Title         : Memory module for feature map
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : MEMX.v
// Author        : Masahiro IIDA <iida@cs.kumamoto-u.ac.jp>
// Created       : 12.06.2019
// Last modified : 12.06.2019
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2019 by Kumamoto Univ. This model is the confidential and
// proprietary property of Kumamoto Univ. and the possession or use of this
// file requires a written license from Kumamoto Univ.
//-----------------------------------------------------------------------------
// Modification history :
//-----------------------------------------------------------------------------
module MEMX(RA0,
            RA1,
            WA0,
            WA1,
            DX,
            OX,
            CLK,
            RCEB0,
            RCEB1,
            WCEB0,
            WCEB1,
            BANK,
            QX,
            RX);
    parameter ADRS  = 14;
    parameter BITS  = 64;
    parameter WORDS = 8192;
    
    input [ADRS-1:0] RA0; // Read address input for DRAM
                        // LSB : ram select
    input [ADRS-1:0] RA1; // Read address input for PB Array
                        // LSB : ram select
    input [ADRS-1:0] WA0; // Write address input for DRAM
                        // LSB : ram select
    input [ADRS-1:0] WA1; // Write address input for PB Array
                        // LSB : ram select
    input [BITS-1:0] DX; // Write data input for DRAM
    input [BITS-1:0] OX; // Write data input for for PB Array
    input CLK; // CLK input
    input RCEB0; // Read chip enable for SRAM operation [active low] for DRAM
    input RCEB1; // Read chip enable for SRAM operation [active low] for PB Array
    input WCEB0; // Write chip enable for SRAM operation [active low] for DRAM
    input WCEB1; // Write chip enable for SRAM operation [active low] for PB Array
    input BANK; // Read bank select, 0:bank0, 1:bank1
    output [BITS-1:0] RX; // Read data output to DRAM
    output [BITS-1:0] QX; // Read data output to PB Array
    
    wire BlockR, BlockW; // ram select
    
    wire [BITS-1:0] QX; // Read data
    wire [BITS-1:0] RX; // Read data
    wire [BITS-1:0] id; // Input data
    wire [BITS-1:0] od; // Output data
    wire [BITS-1:0] q00, q01, q10, q11; // Read data
    wire [ADRS-2:0] radr, wadr; // Address
    wire [ADRS-2:0] adrs0, adrs1; // Address
    wire ce00b, ce01b, ce10b, ce11b;
    wire we00b, we01b, we10b, we11b;
    
    reg a0;
    reg bnk;
    
    /*
    sram_sp_uhde_w8192b128c4b8 bank0_ram0(.A(adrs0), .D(id), .CLK(CLK), .CEN(ce00b), .GWEN(we00b), .Q(q00),
    .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
    .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
    sram_sp_uhde_w8192b128c4b8 bank0_ram1(.A(adrs0), .D(id), .CLK(CLK), .CEN(ce01b), .GWEN(we01b), .Q(q01),
    .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
    .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
    sram_sp_uhde_w8192b128c4b8 bank1_ram0(.A(adrs1), .D(id), .CLK(CLK), .CEN(ce10b), .GWEN(we10b), .Q(q10),
    .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
    .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
    sram_sp_uhde_w8192b128c4b8 bank1_ram1(.A(adrs1), .D(id), .CLK(CLK), .CEN(ce11b), .GWEN(we11b), .Q(q11),
    .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
    .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
    */
    
     ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
     bank0_ram0(.A(adrs0), .D(id), .CLK(CLK), .CEB(ce00b), .WEB(we00b), .Q(q00),
     .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
     
     ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
     bank0_ram1(.A(adrs0), .D(id), .CLK(CLK), .CEB(ce01b), .WEB(we01b), .Q(q01),
     .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
     
     ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
     bank1_ram0(.A(adrs1), .D(id), .CLK(CLK), .CEB(ce10b), .WEB(we10b), .Q(q10),
     .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
     
     ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
     bank1_ram1(.A(adrs1), .D(id), .CLK(CLK), .CEB(ce11b), .WEB(we11b), .Q(q11),
     .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    
    assign radr  = ~RCEB0 ? RA0[ADRS-2:0] : RA1[ADRS-2:0]; // Default read adress is RA1(PB Array)
    assign wadr  = ~WCEB0 ? WA0[ADRS-2:0] : WA1[ADRS-2:0];
    assign adrs0 = BANK ? wadr : radr;
    assign adrs1 = BANK ? radr : wadr;
    
    assign ce00b = BANK ? (WCEB0 & WCEB1 | BlockW) : (RCEB0 & RCEB1 | BlockR);
    assign ce01b = BANK ? (WCEB0 & WCEB1 | ~BlockW) : (RCEB0 & RCEB1 | ~BlockR);
    assign ce10b = BANK ? (RCEB0 & RCEB1 | BlockR) : (WCEB0 & WCEB1 | BlockW);
    assign ce11b = BANK ? (RCEB0 & RCEB1 | ~BlockR) : (WCEB0 & WCEB1 | ~BlockW);
    
    assign we00b = BANK ? (WCEB0 & WCEB1 | BlockW) : 1'b1;
    assign we01b = BANK ? (WCEB0 & WCEB1 | ~BlockW) : 1'b1;
    assign we10b = BANK ? 1'b1 : (WCEB0 & WCEB1 | BlockW);
    assign we11b = BANK ? 1'b1 : (WCEB0 & WCEB1 | ~BlockW);
    
    assign od = bnk ? (a0 ? q11 : q10) :(a0 ? q01 : q00);
    assign RX = od;
    assign QX = od;
    
    assign id = ~WCEB0 ? DX : OX;
    
    assign BlockR = ~RCEB0 ? RA0[ADRS-1] : RA1[ADRS-1];
    assign BlockW = ~WCEB0 ? WA0[ADRS-1] : WA1[ADRS-1];
    
    always @(posedge CLK)
    begin
        a0 <= BlockR;
    end
    always @(posedge CLK)
    begin
        bnk <= BANK;
    end
    
endmodule // memx
