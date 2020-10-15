//-----------------------------------------------------------------------------
// Title         : WEIGHT_DECODER module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : WEIGHT_DECODER.v
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
module WEIGHT_DECODER (input wire CLK,
                       input wire RSTL,
                       input wire CONV_FC_MODE,     //(0:conv, 1:fc)
                       input wire [1:0] D_IN,
                       input wire D_EN,
                       input wire CONF_EN,
                       output reg [31:0] WEIGHT_EN,
                       output [1:0] D_OUT,
                       output [1:0] CONF_O);
    
    reg  [1:0] STATE;
    reg  [2:0] COUNTER;
    reg  [5:0] REG;
    reg REG_EN, ADDR_EN;
    wire [1:0] REG_IN;
    wire [1:0] WEIGHT_OR_CONF;
    
    //STATE
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            STATE   <= 2'b0;
            COUNTER <= 3'b0;
            REG_EN  <= 1'b0;
            ADDR_EN <= 1'b0;
        end
        else begin
            if (CONV_FC_MODE) begin
                case(STATE)
                    2'b00:begin
                        REG_EN  <= 1'b0;
                        ADDR_EN <= 1'b0;
                        if (D_EN) begin
                            if (D_IN[0] == 1'b1) begin
                                STATE  <= 2'b10;
                                REG_EN <= 1'b1;
                            end
                            else begin
                                STATE <= 2'b01;
                            end
                        end
                    end
                    2'b01:begin
                        if (COUNTER == 3'd6) begin
                            COUNTER <= 3'b0;
                            STATE   <= 2'b00;
                        end
                        else begin
                            COUNTER <= COUNTER + 1'b1;
                        end
                    end
                    2'b10:begin
                        if (COUNTER == 3'd2) begin
                            COUNTER <= 3'b0;
                            STATE   <= 2'b11;
                            REG_EN  <= 1'b0;
                            ADDR_EN <= 1'b1;
                        end
                        else begin
                            COUNTER <= COUNTER + 1'b1;
                        end
                    end
                    2'b11:begin
                        if (COUNTER == 3'd3) begin
                            COUNTER <= 3'b0;
                            STATE   <= 2'b00;
                            ADDR_EN <= 1'b0;
                        end
                        else begin
                            COUNTER <= COUNTER + 1'b1;
                        end
                    end
                endcase
            end
        end
    end
    
    //REG
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG <= 6'b0;
        end
        else begin
            if (REG_EN) begin
                REG <= {D_IN,REG[5:2]};
            end
        end
    end
    
    always @(ADDR_EN, REG) begin
        WEIGHT_EN = 0;
        if (ADDR_EN) begin
            WEIGHT_EN[REG[4:0]] = 1'b1;
        end
    end
    
    
    assign CONF_O = (CONF_EN ? D_IN : 2'b0);
    assign D_OUT  = ((ADDR_EN | !CONV_FC_MODE)& !CONF_EN  ? D_IN : 2'b0);
endmodule
