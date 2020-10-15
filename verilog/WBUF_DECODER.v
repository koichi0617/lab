//-----------------------------------------------------------------------------
// Title         : WBUF_DECODER module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : WBUF_DECODER.v
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
module WBUF_DECODER (input wire [4:0] D_IN,
                     input wire D_EN,
                     input wire WBUF_ALL_EN,
                     output reg [31:0] WBUF_EN);
    
    always @(D_IN, D_EN, WBUF_ALL_EN) begin
        WBUF_EN = 0;
        if (WBUF_ALL_EN) begin
            WBUF_EN = 32'hFFFFFFFF;
        end
        else if (D_EN) begin
            WBUF_EN[D_IN] = 1'b1;
        end
    end
            
endmodule
