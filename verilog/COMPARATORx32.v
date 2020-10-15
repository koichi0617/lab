//-----------------------------------------------------------------------------
// Title         : Comparatorx64 module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : COMPARATORx64.v
// Author        : Yasuhiro NAKAHARA <nakahara@arch.cs.kumamoto-u.ac.jp>
// Created       : 30.07.2019
// Last modified : 30.07.2019
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
module COMPARATORx32 (input wire CLK,
                      input wire RSTL,
                      input wire [63:0] D_IN,
                      input wire D_EN,
                      input wire SWITCH,
                      input wire COMPARE_EN,
                      input wire COMPARE_MODE,
                      output [63:0] D_OUT);
    
    
    genvar i;
    parameter MODULE_NUMBER = 32;
    generate
    for(i = 0; i < MODULE_NUMBER; i = i + 1) begin:GEN_C
        COMPARATOR C1(
        .CLK(CLK),
        .RSTL(RSTL),
        .D_IN(D_IN[i*2+1:i*2]),
        .D_EN(D_EN),
        .SWITCH(SWITCH),
        .COMPARE_EN(COMPARE_EN),
        .COMPARE_MODE(COMPARE_MODE),
        .D_OUT(D_OUT[i*2+1:i*2])
        );
    end
    endgenerate
    
endmodule
