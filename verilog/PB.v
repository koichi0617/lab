//-----------------------------------------------------------------------------
// Title         : PB module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : PB.v
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
module PB(input CLK,
          input RSTL,
          //input_ctrl
          input WBUF_PURGE,
          input [1:0] NL_N,
          input [1:0] NL_E,
          input [1:0] NL_W,
          input [1:0] NL_S,
          input NL_EN,
          input [1:0] WBUF_I,
          input WBUF_EN,
          input REGSWITCH,
          input [1:0] CONFDATA_I,
          input CONF_EN,
          input [1:0] NL_SEL,
          input SHIFT_MODE,
          //weight_ctrl
          input [1:0] WEIGHT,
          input WEIGHT_EN,
          input CAL_MODE,
          input CONV_FC_MODE,       //1:FC 0:CONV
          input MAC_EN_I,
          //output_ctrl
          input OUTPUT_EN,
          //mac
          input RESULT_REQ,         // Outdata request (One hot)
          input [3:0] OLSB,
          input RESULT_PURGE,       // Purge request of all FF
          //pe
          input FEEDBACK_MODE,
          //input_ctrl
          output [1:0] NL_OUT,
          output [1:0] OUTPUT,
          output [1:0] CONFDATA_O);
    
    wire MAC_EN, RESULT_EN;
    
    wire [1:0] INPUTX_LINE, WEIGHT_LINE, RESULT_LINE,
    WBUF_INPUT, OUT_TO_TSB;
    
    INPUT_CTRL input_ctrl_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .PURGE(WBUF_PURGE),
    .NL_N(NL_N),
    .NL_E(NL_E),
    .NL_W(NL_W),
    .NL_S(NL_S),
    .WBUF_I(WBUF_INPUT),
    .FEEDBACK_I(OUT_TO_TSB),
    .REGSWITCH(REGSWITCH),
    .NL_EN(NL_EN),
    .WBUF_EN(WBUF_EN),
    .CONFDATA_I(CONFDATA_I),
    .CONF_EN(CONF_EN),
    .NL_SEL(NL_SEL),
    .SHIFT_MODE(SHIFT_MODE),
    .FEEDBACK_MODE(FEEDBACK_MODE),
    .CONFDATA_O(CONFDATA_O),
    .D_OUT(INPUTX_LINE)
    );
    
    WEIGHT_CTRL weight_ctrl_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .WEIGHT(WEIGHT),
    .WEIGHT_EN(WEIGHT_EN),
    .CAL_MODE(CAL_MODE),
    .CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
    .MAC_EN_I(MAC_EN_I),
    .D_OUT(WEIGHT_LINE),
    .MAC_EN_O(MAC_EN)
    );
    
    PE8 mac_0(
    .clk(CLK),
    .rstl(RSTL),
    .xi(INPUTX_LINE),
    .yi(WEIGHT_LINE),
    .en(MAC_EN), // start singal (One hot)
    .orq(RESULT_REQ), // Outdata request (One hot)
    .olsb(OLSB),
    .purge(RESULT_PURGE), // Purge request of all FF
    .do(RESULT_LINE),
    .oe(RESULT_EN) // Out enable
    );
    
    OUTPUT_CTRL output_ctrl_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .RESULT(RESULT_LINE),
    .RESULT_EN(RESULT_EN),
    .FEEDBACK_MODE(FEEDBACK_MODE),
    .D_OUT_EN(OUTPUT_EN),
    .D_OUT(OUT_TO_TSB)
    );
    
    assign WBUF_INPUT = (FEEDBACK_MODE ? OUT_TO_TSB : WBUF_I);
    assign OUTPUT     = (FEEDBACK_MODE ? 2'bzz  : OUT_TO_TSB);
    assign NL_OUT     = INPUTX_LINE;
endmodule
