//-----------------------------------------------------------------------------
// Title         : INPUT_CTRL module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : INPUT_CTRL.v
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
module INPUT_CTRL(input CLK,
                  input RSTL,
                  input PURGE,
                  input [1:0] NL_N,
                  input [1:0] NL_E,
                  input [1:0] NL_W,
                  input [1:0] NL_S,
                  input [1:0] WBUF_I,
                  input [1:0] FEEDBACK_I,
                  input REGSWITCH,
                  input NL_EN,
                  input WBUF_EN,
                  input [1:0] CONFDATA_I,
                  input CONF_EN,
                  input [1:0] NL_SEL,
                  input SHIFT_MODE,
                  input FEEDBACK_MODE,
                  output [1:0] CONFDATA_O,
                  output [1:0] D_OUT);

    wire       REG1_PURGE, REG2_PURGE;
    wire [1:0] CAL_REG_IN, WBUF_REG_IN;
    wire [1:0] REG1_IN, REG2_IN;
    wire       REG1_ENABLE, REG2_ENABLE;
    wire[1:0] DIRECTION_SELECT;
    reg [1:0] DIRECTION_CONF_REG;
    reg [7:0] REG1, REG2;
    
    //4to1 MUX
    function [1:0] MUXOUT;
        input [1:0] INPUT1,INPUT2,INPUT3,INPUT4;
        input [1:0] SELECT;
        begin
            case(SELECT)
                2'b00: MUXOUT = INPUT1;
                2'b01: MUXOUT = INPUT2;
                2'b10: MUXOUT = INPUT3;
                2'b11: MUXOUT = INPUT4;
            endcase
        end
    endfunction
    
    //DIRECTION_CONFIG_REG
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            DIRECTION_CONF_REG <= 2'b0;
        end
        else begin
            if (CONF_EN) begin //configuration mode CONFIGURATION ENABLE
                DIRECTION_CONF_REG <= CONFDATA_I;
            end
        end
    end
    assign CONFDATA_O = DIRECTION_CONF_REG;
    
    //MUX
    assign DIRECTION_SELECT = (SHIFT_MODE ? NL_SEL[1:0] : DIRECTION_CONF_REG[1:0]);
    assign REG1_PURGE  = PURGE & REGSWITCH;
    assign REG2_PURGE  = PURGE & !REGSWITCH;
    assign CAL_REG_IN  = MUXOUT(NL_N, NL_E, NL_W, NL_S, DIRECTION_SELECT);
    assign WBUF_REG_IN = (FEEDBACK_MODE ? FEEDBACK_I : WBUF_I);
    assign REG1_IN     = (REGSWITCH     ? WBUF_REG_IN: CAL_REG_IN);
    assign REG1_ENABLE = (REGSWITCH     ? WBUF_EN |FEEDBACK_MODE : NL_EN);
    assign REG2_IN     = (REGSWITCH     ? CAL_REG_IN : WBUF_REG_IN);
    assign REG2_ENABLE = (REGSWITCH     ? NL_EN      : WBUF_EN | FEEDBACK_MODE);
    
    //REG1
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG1 <= 8'b0;
        end
        else if (REG1_PURGE) begin
            REG1 <= 8'b0;
        end
        else if (REG1_ENABLE) begin
            REG1[7:0] <= {REG1_IN,REG1[7:2]};
        end
    end
            
    //REG2
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG2 <= 8'b0;
        end
        else if (REG2_PURGE) begin
            REG2 <= 8'b0;
        end
        else if (REG2_ENABLE) begin
            REG2[7:0] <= {REG2_IN,REG2[7:2]};
        end
    end
            
    assign D_OUT = (REGSWITCH ? {REG2[1:0]} : {REG1[1:0]});
endmodule
