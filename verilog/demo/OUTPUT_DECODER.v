//-----------------------------------------------------------------------------
// Title         : OUTPUT_DECODER module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : OUTPUT_DECODER.v
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
module OUTPUT_DECODER (input wire [4:0] D_IN,
                       input wire D_EN,
                       output reg [31:0] OUTPUT_EN);
    
    always @(D_IN, D_EN) begin
        OUTPUT_EN = 0;
        if (D_EN) begin
            OUTPUT_EN[D_IN] = 1'b1;
        end
    end
    
endmodule
