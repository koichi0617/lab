//-----------------------------------------------------------------------------
// Title         : WEIGHT_DECODERx64 module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : WEIGHT_DECODERx64.v
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
module WEIGHT_DECODERx32 (input wire CLK,
                          input wire RSTL,
                          input wire CONV_FC_MODE,   //(0:conv, 1:fc)
                          input wire [63:0] D_IN,
                          input wire D_EN,
                          input wire CONF_EN,
                          output [1023:0] WEIGHT_EN,
                          output [63:0] D_OUT,
                          output [63:0] CONF_O);
    genvar i;
    parameter MODULE_NUMBER = 32;
    generate
    for(i = 0; i < MODULE_NUMBER; i = i + 1) begin:GEN_D
        WEIGHT_DECODER D1 (
        .CLK(CLK),
        .RSTL(RSTL),
        .CONV_FC_MODE(CONV_FC_MODE),//(0:conv, 1:fc)
        .D_IN(D_IN[i*2+1:i*2]),
        .D_EN(D_EN),
        .CONF_EN(CONF_EN),
        .WEIGHT_EN(WEIGHT_EN[32*(i+1)-1:32*i]),
        .D_OUT(D_OUT[i*2+1:i*2]),
        .CONF_O(CONF_O[i*2+1:i*2])
        );
    end
    endgenerate
    
endmodule
    
