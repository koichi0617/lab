//-----------------------------------------------------------------------------
// Title         : OUTPUT_CTRL module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : OUTPUT_CTRL.v
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
module OUTPUT_CTRL(input CLK,
                   input RSTL,
                   input [1:0] RESULT,
                   input RESULT_EN,
                   input D_OUT_EN,
                   input FEEDBACK_MODE,
                   output [1:0] D_OUT);
    
    reg  [7:0] REG;
    wire       REG_EN;
    
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG <= 8'b0;
        end
        else begin
            if (REG_EN) begin
                REG[7:0] <= {RESULT,REG[7:2]};
            end
        end
    end
    
    assign REG_EN = RESULT_EN | D_OUT_EN | FEEDBACK_MODE;
    assign D_OUT  = (D_OUT_EN | FEEDBACK_MODE ? REG[1:0] : 2'bzz);
    
endmodule
