//-----------------------------------------------------------------------------
// Title         : Memory module for instruction
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : MEMI.v
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

module MEMI(RA,
            WA,
            DW,
            CLK,
            RCEB,
            WCEB,
            BANK,
            QW);
    parameter ADRS  = 14;
    parameter BITS  = 128;
    parameter WORDS = 8192;
    
    input [ADRS-1:0] RA; // Read address input
                        // LSB : ram select
    input [ADRS-1:0] WA; // Write address input
                        // LSB : ram select
    input [BITS-1:0] DW; // Write data input
    input CLK; // CLK input
    input RCEB; // Read chip enable for SRAM operation [active low]
    input WCEB; // Write chip enable for SRAM operation [active low]
    input BANK; // Read bank select, 0:bank0, 1:bank1
    output [BITS-1:0] QW; // Read data output
    
    wire BlockW; // ram select
    
    wire [BITS-1:0] QW; // Read data
    wire [BITS-1:0] q0, q1; // Read data
    wire [ADRS-2:0] adrs0, adrs1; // Address
    wire ce0b, ce1b;
    wire we0b, we1b;
    
    reg a0;
    reg bnk;
    
    /*
     sram_sp_uhde_w8192b128c4b8 bank0_ram0(.A(adrs0), .D(DW), .CLK(CLK), .CEN(ce00b), .GWEN(we00b), .Q(q00),
     .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
     .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
     sram_sp_uhde_w8192b128c4b8 bank0_ram1(.A(adrs0), .D(DW), .CLK(CLK), .CEN(ce01b), .GWEN(we01b), .Q(q01),
     .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
     .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
     sram_sp_uhde_w8192b128c4b8 bank1_ram0(.A(adrs1), .D(DW), .CLK(CLK), .CEN(ce10b), .GWEN(we10b), .Q(q10),
     .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
     .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
     sram_sp_uhde_w8192b128c4b8 bank1_ram1(.A(adrs1), .D(DW), .CLK(CLK), .CEN(ce11b), .GWEN(we11b), .Q(q11),
     .EMA(3'b0), .EMAW(2'b0), .EMAS(1'b0), .RET1N(1'b1), .STOV(1'b0),
     .RAWL(1'b0), .RAWLM(2'b0), .WABL(1'b0), .WABLM(3'b0));
    */
    ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
    bank0_ram0(.A(adrs0), .D(DW), .CLK(CLK), .CEB(ce0b), .WEB(we0b), .Q(q0),
    .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    
    ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
    bank0_ram1(.A(adrs0), .D(DW), .CLK(CLK), .CEB(ce1b), .WEB(we1b), .Q(q1),
    .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    
    assign adrs0 = BANK ? WA[ADRS-1:0] : RA[ADRS-1:0];
    assign adrs1 = BANK ? RA[ADRS-1:0] : WA[ADRS-1:0];

    assign ce0b = BANK ? WCEB : RCEB;
    assign ce1b = BANK ? WCEB : RCEB;
    
    assign we0b = BANK ? WCEB : 1'b1;
    assign we1b = BANK ? WCEB : 1'b1;
    
    assign QW = bnk ? q1 : q0;
    
    always @(posedge CLK)
    begin
        bnk <= BANK;
    end
    
endmodule // memi
