//-----------------------------------------------------------------------------
// Title         : WEIGHT_CTRL module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : WEIGHT_CTRL.v
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
module WEIGHT_CTRL(input CLK,
                   input RSTL,
                   input [1:0] WEIGHT,
                   input WEIGHT_EN,
                   input CAL_MODE,
                   input CONV_FC_MODE, //1:FC 0:CONV
                   input MAC_EN_I,
                   output [1:0] D_OUT,
                   output MAC_EN_O);
    
    reg  [7:0] REG;
    wire       REG_EN;
    wire       ALL_ZERO;
    wire [1:0] REG_IN;
    
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG <= 8'b0;
        end
        else begin
            if (REG_EN) begin
                REG[7:0] <= {REG_IN,REG[7:2]};
            end
        end
    end
    
    assign ALL_ZERO = ~|(REG[7:0]);
    assign D_OUT    = (CONV_FC_MODE ? {REG[1:0]}           : WEIGHT);
    assign REG_IN   = (CAL_MODE     ? 0                    : WEIGHT);
    assign REG_EN   = (CAL_MODE     ? !ALL_ZERO            : WEIGHT_EN);
    assign MAC_EN_O = (CONV_FC_MODE ? (!ALL_ZERO)&MAC_EN_I : MAC_EN_I);
    
endmodule
