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
    input [BITS*2-1:0] DW; // Write data input
    input CLK; // CLK input
    input RCEB; // Read chip enable for SRAM operation [active low]
    input WCEB; // Write chip enable for SRAM operation [active low]
    input BANK; // Read bank select, 0:bank0, 1:bank1
    output [BITS*2-1:0] QW; // Read data output
    
    wire BlockW; // ram select
    
    wire [BITS*2-1:0] QW; // Read data
    wire [BITS-1:0] q00, q01, q10, q11; // Read data
    wire [ADRS-2:0] adrs0, adrs1; // Address
    wire ce00b, ce01b, ce10b, ce11b;
    wire we00b, we01b, we10b, we11b;
    
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
    bank0_ram0(.A(adrs0), .D(DW), .CLK(CLK), .CEB(ce00b), .WEB(we00b), .Q(q00),
    .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    
    ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
    bank0_ram1(.A(adrs0), .D(DW), .CLK(CLK), .CEB(ce01b), .WEB(we01b), .Q(q01),
    .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    
    ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
    bank1_ram0(.A(adrs1), .D(DW), .CLK(CLK), .CEB(ce10b), .WEB(we10b), .Q(q10),
    .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    
    ts1n40lphsb8192x128m4s_250a #(.WORDS(WORDS), .BITS(BITS), .ADRS(ADRS-1))
    bank1_ram1(.A(adrs1), .D(DW), .CLK(CLK), .CEB(ce11b), .WEB(we11b), .Q(q11),
    .BWEB(), .AM(), .DM(), .CEBM(), .WEBM(), .BWEBM(), .BIST(), .PD(), .AWT());
    assign adrs0 = BANK ? WA[ADRS-1:1] : RA[ADRS-1:1];
    assign adrs1 = BANK ? RA[ADRS-1:1] : WA[ADRS-1:1];
    
    assign ce00b = BANK ? (WCEB | BlockW) : RCEB;
    assign ce01b = BANK ? (WCEB | ~BlockW) : RCEB;
    assign ce10b = BANK ? RCEB : (WCEB | BlockW);
    assign ce11b = BANK ? RCEB : (WCEB | ~BlockW);
    
    assign we00b = BANK ? (WCEB | BlockW) : 1'b1;
    assign we01b = BANK ? (WCEB | ~BlockW) : 1'b1;
    assign we10b = BANK ? 1'b1 : (WCEB | BlockW);
    assign we11b = BANK ? 1'b1 : (WCEB | ~BlockW);
    
    assign QW = bnk ? {q11, q10} : {q01, q00};
    
    assign BlockW = WA[0];
    
    always @(posedge CLK)
    begin
        bnk <= BANK;
    end
    
endmodule // memi
