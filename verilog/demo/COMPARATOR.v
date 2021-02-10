//-----------------------------------------------------------------------------
// Title         : Comparator module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : COMPARATOR.v
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
module COMPARATOR (input wire CLK,
                   input wire RSTL,
                   input wire [1:0] D_IN,
                   input wire D_EN,
                   input wire SWITCH,
                   input wire COMPARE_EN,
                   input wire COMPARE_MODE,
                   output [1:0] D_OUT);
    
    reg [7:0] REG1, REG2;
    reg [1:0] STATE;
    reg [1:0] COUNTER;
    wire      COMPARE;
    wire      REG1_EN,REG2_EN;
    wire[1:0] D1_IN, D2_IN, COMPARED_NUM;
    
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            STATE   <= 2'b0;
            COUNTER <= 3'b0;
        end
        else if (COMPARE_MODE) begin
            case(STATE)
                2'b00:begin
                    if (COMPARE_EN) begin
                        if (COMPARE) begin
                            STATE <= 2'b01;
                        end
                        else begin
                            STATE <= 2'b11;
                        end
                    end
                end
                2'b01:begin
                    if (COUNTER == 3'd3) begin
                        COUNTER <= 3'd0;
                        STATE   <= 2'b00;
                    end
                    else begin
                        COUNTER <= COUNTER + 1;
                    end
                end
                2'b11:begin
                    if (COUNTER == 3'd3) begin
                        COUNTER <= 3'd0;
                        STATE   <= 2'b00;
                    end
                    else begin
                        COUNTER <= COUNTER + 1;
                    end
                end
                default:STATE <= 2'b00;
            endcase
        end
    end
        
    //REG1
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG1 <= 8'b0;
        end
        else begin
            if (REG1_EN) begin
                REG1 <= {D1_IN,REG1[7:2]};
            end
        end
    end

    //REG2
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL) begin
            REG2 <= 8'b0;
        end
        else begin
            if (REG2_EN) begin
                REG2 <= {D2_IN,REG2[7:2]};
            end
        end
    end
    
    assign D1_IN        = (!SWITCH ? D_IN[1:0] : 0);
    assign D2_IN        = (SWITCH ? D_IN[1:0] : 0);
    assign REG1_EN      = (D_EN & !SWITCH) | STATE[0];
    assign REG2_EN      = (D_EN & SWITCH)  | STATE[0];
    assign COMPARED_NUM = (STATE[1] ? REG2[1:0]:REG1[1:0]);
    assign COMPARE      = (REG1 > REG2);
    assign D_OUT        = (COMPARE_MODE) ? (STATE[0]) ? COMPARED_NUM : 0 : D_IN;
endmodule
