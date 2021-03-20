`include "SEQUENCER_DEF.v"

module SEQUENCER (input wire CLK,
                  input wire RSTL,
                  input wire PURGE,
                  input wire MBUSYW,
                  input wire MBUSYXI,
                  input wire MBUSYXO,
                  input wire [255:0] QI,
                  output wire [13:0] RADDRI,
                  output wire RCEBI,
                  output wire [15:0] RADDRX,
                  output wire [15:0] RADDRW,
                  output wire [15:0] WADDRX,
                  output wire BANKX,
                  output wire BANKW,
                  output wire RCEBW,
                  output wire RCEBX,
                  output wire WCEBX,
                  output wire REQW,
                  output wire WBUF_PURGE,
                  output wire WBUF_EN,
                  output wire [5:0] WBUF_EN_CTRL,
                  output wire WBUF_ALL_EN,
                  output wire WBUF_SWITCH,
                  output wire FC_WEIGHT_EN,
                  output wire NL_EN,
                  output wire SHIFT_MODE,
                  output wire [1:0] NL_SEL,
                  output wire MAC_EN,
                  output wire RESULT_REQ,
                  output wire [3:0] OLSB,
                  output wire RESULT_PURGE,
                  output wire OUTPUT_EN,
                  output wire [5:0] OUTPUT_EN_CTRL,
                  output wire I_COMPARE_EN,
                  output wire I_COMPARE_MODE,
                  output wire I_COMPARE_SWITCH,
                  output wire O_COMPARE_EN,
                  output wire O_COMPARE_MODE,
                  output wire O_COMPARE_SWITCH,
                  output wire CAL_MODE,
                  output wire CONV_FC_MODE,
                  output wire FEEDBACK_MODE,
                  output wire CONF_EN,
                  output wire I_COMPARE_REGEN,
                  output wire [1:0] NL_LOOP_SEL,
                  output wire SEQ_LOAD_I,
                  output wire SEQ_FIN,
                  output wire SEQ_STARTW,
                  output wire SEQ_STARTX,
                  output wire SEQ_STARTX_OUT,
                  output wire RCEBX0);
    
    reg [31:0] pc; //SRAM（マイクロコード）の何行目からもってくるか
    reg [15:0] counter0; //ループ回数
    reg [15:0] counter1; //ループ回数
    reg [15:0] counter2; //ループ回数
    reg [15:0] counter3; //ループ回数
    reg [15:0] reg_raddrx; //SRAMからの読み取りアドレス
    reg [15:0] reg_waddrx; //SRAMアドレス
    reg [15:0] reg_raddrw;
    reg [15:0] reg_raddrx_bak;
    reg [15:0] reg_raddrw_bak;
    reg [5:0]  reg_wbufenctrl;
    reg [5:0]  reg_outputenctrl;
    reg        reg_switch;
    reg [15:0] reg_raddrx_latch;
    reg [15:0] reg_waddrx_latch;
    reg [15:0] reg_raddrw_latch;
    reg [5:0]  reg_wbufenctrl_latch;
    reg [5:0]  reg_outputenctrl_latch;
    reg        reg_switch_latch;
    reg [255:0] qi_latch;
    
    assign RADDRI = pc[14:0]; //SRAMの何行目かを指定
    assign RCEBI  = 1'b0;
    assign RADDRX         = reg_raddrx_latch;
    assign WADDRX         = reg_waddrx_latch;
    assign RADDRW         = reg_raddrw_latch;
    assign WBUF_EN_CTRL   = reg_wbufenctrl_latch;
    assign OUTPUT_EN_CTRL = reg_outputenctrl_latch;
    assign WBUF_SWITCH    = reg_switch_latch;
    
    //PC
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       pc <= 32'b0;
        else if (PURGE)  pc <= 32'b0;
        else if (QI[`INST_WAIT_MBUSYW] && MBUSYW) pc <= pc - 1'b1;
        else if (QI[`INST_WAIT_MBUSYXI] && MBUSYXI) pc <= pc - 1'b1;
        else if (QI[`INST_WAIT_MBUSYXO] && MBUSYXO) pc <= pc - 1'b1;
        else begin
            case({QI[`INST_JUMP_COUNTER3],QI[`INST_JUMP_COUNTER2],QI[`INST_JUMP_COUNTER1],QI[`INST_JUMP_COUNTER0]})
                4'b0001:
                    if (counter0 == 32'b1)
                        pc <= pc + 1'b1;
                    else
                        pc <= QI[`INST_PC_E:`INST_PC_S];
                4'b0010:
                    if (counter1 == 32'b1)
                        pc <= pc + 1'b1;
                    else
                        pc <= QI[`INST_PC_E:`INST_PC_S];
                4'b0100:
                    if (counter2 == 32'b1)
                        pc <= pc + 1'b1;
                    else
                        pc <= QI[`INST_PC_E:`INST_PC_S];
                4'b1000:
                    if (counter3 == 32'b1)
                        pc <= pc + 1'b1;
                    else
                        pc <= QI[`INST_PC_E:`INST_PC_S];
                default:
                    pc <= pc + 1'b1;
            endcase
        end
    end
    
    //COUNTER0
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter0 <= 16'b0;
        else if (PURGE)  counter0 <= 16'b0;
        else begin
            case(QI[`INST_COUNTER0_WE])
                1'b1:
                    if (counter0 == 16'b0)
                        counter0 <= QI[`INST_COUNTER0_E:`INST_COUNTER0_S];
                    else
                        counter0 <= counter0;
                default:
                    case(QI[`INST_JUMP_COUNTER0])
                        1'b1:
                            counter0 <= counter0 - 1'b1;
                        default:
                            counter0 <= counter0;
                    endcase
            endcase
        end
    end
    
    //COUNTER1
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter1 <= 16'b0;
        else if (PURGE)  counter1 <= 16'b0;
        else begin
            case(QI[`INST_COUNTER1_WE])
                1'b1:
                    if (counter1 == 16'b0)
                        counter1 <= QI[`INST_COUNTER1_E:`INST_COUNTER1_S];
                    else
                        counter1 <= counter1;
                default:
                    case(QI[`INST_JUMP_COUNTER1])
                        1'b1:
                            counter1 <= counter1 - 1'b1;
                        default:
                            counter1 <= counter1;
                    endcase
            endcase
        end
    end
    
    //COUNTER2
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter2 <= 16'b0;
        else if (PURGE)  counter2 <= 16'b0;
        else begin
            case(QI[`INST_COUNTER2_WE])
                1'b1:
                    if (counter2 == 16'b0)
                        counter2 <= QI[`INST_COUNTER2_E:`INST_COUNTER2_S];
                    else
                        counter2 <= counter2;
                default:
                    case(QI[`INST_JUMP_COUNTER2])
                        1'b1:
                            counter2 <= counter2 - 1'b1;
                        default:
                            counter2 <= counter2;
                    endcase
            endcase
        end
    end
    
    //COUNTER3
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter3 <= 16'b0;
        else if (PURGE)  counter3 <= 16'b0;
        else begin
            case(QI[`INST_COUNTER3_WE])
                1'b1:
                    if (counter3 == 16'b0)
                        counter3 <= QI[`INST_COUNTER3_E:`INST_COUNTER3_S];
                    else
                        counter3 <= counter3;
                default:
                    case(QI[`INST_JUMP_COUNTER3])
                        1'b1:
                            counter3 <= counter3 - 1'b1;
                        default:
                            counter3 <= counter3;
                    endcase
            endcase
        end
    end
    
    //RADDRX
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrx <= 16'b0;
        else if (PURGE)  reg_raddrx <= 16'b0;
        else begin
            case(QI[`INST_RADDRX_WE])
                1'b0:
                    if ((reg_raddrx_bak != 16'b0) && (QI[`INST_RADDRX_BAK] == 1'b1))
                        reg_raddrx <= reg_raddrx_bak;
                    else
                        case(QI[`INST_RADDRX_E])
                            1'b0:
                                reg_raddrx <= reg_raddrx + QI[`INST_RADDRX_E - 1:`INST_RADDRX_S];
                            1'b1:
                                reg_raddrx <= reg_raddrx - QI[`INST_RADDRX_E - 1:`INST_RADDRX_S];
                            endcase
                1'b1:
                    reg_raddrx <= QI[`INST_RADDRX_E:`INST_RADDRX_S];
            endcase
        end
    end
    
    //RADDRX_BAK
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrx_bak <= 16'b0;
        else if (PURGE)  reg_raddrx_bak <= 16'b0;
        else begin
        case(QI[`INST_RADDRX_BAK])
            1'b0:
                reg_raddrx_bak <= reg_raddrx_bak;
            1'b1:
                if (reg_raddrx_bak != 16'b0)
                    reg_raddrx_bak <= 0;
                else
                    reg_raddrx_bak <= reg_raddrx;
            endcase
        end
    end
    
    //RADDRW
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrw <= 16'b0;
        else if (PURGE)  reg_raddrw <= 16'b0;
        else begin
            case(QI[`INST_RADDRW_WE])
                1'b0:
                    if ((reg_raddrw_bak != 16'b0) && (QI[`INST_RADDRW_BAK] == 1'b1))
                        reg_raddrw <= reg_raddrw_bak;
                    else
                        case(QI[`INST_RADDRW_E])
                            1'b0:
                                reg_raddrw <= reg_raddrw + QI[`INST_RADDRW_E - 1:`INST_RADDRW_S];
                            1'b1:
                                reg_raddrw <= reg_raddrw - QI[`INST_RADDRW_E - 1:`INST_RADDRW_S];
                        endcase
                1'b1:
                    reg_raddrw <= QI[`INST_RADDRW_E:`INST_RADDRW_S];
            endcase
        end
    end
    
    //RADDRW_BAK
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrw_bak <= 16'b0;
        else if (PURGE)  reg_raddrw_bak <= 16'b0;
        else begin
            case(QI[`INST_RADDRW_BAK])
                1'b0:
                    reg_raddrw_bak <= reg_raddrw_bak;
                1'b1:
                    if (reg_raddrw_bak > 16'b0)
                        reg_raddrw_bak <= 0;
                    else
                        reg_raddrw_bak <= reg_raddrw;
            endcase
        end
    end
    
    //WADDRX
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_waddrx <= 16'b0;
        else if (PURGE)  reg_waddrx <= 16'b0;
        else begin
            case(QI[`INST_WADDRX_WE])
                1'b0:
                    case(QI[`INST_WADDRX_E])
                        1'b0:
                            reg_waddrx <= reg_waddrx + QI[`INST_WADDRX_E - 1:`INST_WADDRX_S];
                        1'b1:
                            reg_waddrx <= reg_waddrx - QI[`INST_WADDRX_E - 1:`INST_WADDRX_S];
                    endcase
                1'b1:
                    reg_waddrx <= QI[`INST_WADDRX_E:`INST_WADDRX_S];
            endcase
        end
    end

    //WBUF_EN_CTRL
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_wbufenctrl <= 6'b0;
        else if (PURGE)  reg_wbufenctrl <= 6'b0;
        else begin
            case(QI[`INST_WBUF_EN_CTRL_WE])
                1'b0:
                    reg_wbufenctrl <= reg_wbufenctrl + QI[`INST_WBUF_EN_CTRL_E:`INST_WBUF_EN_CTRL_S];
                1'b1:
                    reg_wbufenctrl <= QI[`INST_WBUF_EN_CTRL_E:`INST_WBUF_EN_CTRL_S];
            endcase
        end
    end

    //OUTPUT_EN_CTRL
    always@ (posedge CLK or negedge RSTL)
    begin
        if(!RSTL)       reg_outputenctrl  <= 6'b0;
        else if (PURGE)  reg_outputenctrl <= 6'b0;
        else begin
            case(QI[`INST_OUTPUT_EN_CTRL_WE])
                1'b0:
                    reg_outputenctrl <= reg_outputenctrl + QI[`INST_OUTPUT_EN_CTRL_E:`INST_OUTPUT_EN_CTRL_S];
                1'b1:
                    reg_outputenctrl <= QI[`INST_OUTPUT_EN_CTRL_E:`INST_OUTPUT_EN_CTRL_S];
            endcase
        end
    end

    //WBUF_SWITCH
    always@ (posedge CLK or negedge RSTL)
    begin
        if(!RSTL)       reg_switch                 <= 6'b0;
        else if (PURGE)  reg_switch                <= 6'b0;
        else if (QI[`INST_WBUF_SWITCH]) reg_switch <= !(reg_switch);
    end

    //qi_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       qi_latch <= 256'b0;
        else begin
            if(!PURGE)
                qi_latch <= QI;
        end
    end

    //raddrx_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrx_latch <= 16'b0;
        else begin
            if(!PURGE)
                reg_raddrx_latch <= reg_raddrx;
        end
    end

    //waddrx_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_waddrx_latch <= 16'b0;
        else begin
            if(!PURGE)
                reg_waddrx_latch <= reg_waddrx;
        end
    end

    //raddrw_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrw_latch <= 16'b0;
        else begin
            if(!PURGE)
                reg_raddrw_latch <= reg_raddrw;
        end
    end

    //wbuf_en_ctrl_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_wbufenctrl_latch <= 6'b0;
        else begin
            if(!PURGE)
                reg_wbufenctrl_latch <= reg_wbufenctrl;
        end
    end

    //output_en_ctrl_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_outputenctrl_latch <= 6'b0;
        else begin
            if(!PURGE)
                reg_outputenctrl_latch <= reg_outputenctrl;
        end
    end

    //reg_switch_latch_ctrl_latch
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_switch_latch <= 1'b0;
        else begin
            if(!PURGE)
                reg_switch_latch <= reg_switch;
        end
    end

    //Assign QI to CTRL pins : MEMIの値を制御信号に変換
    assign BANKX            = qi_latch[`INST_BANKX];
    assign WCEBX            = qi_latch[`INST_WCEBX];
    assign RCEBX            = qi_latch[`INST_RCEBX];
    assign REQX             = qi_latch[`INST_REQX];
    assign BANKW            = qi_latch[`INST_BANKW];
    assign RCEBW            = qi_latch[`INST_RCEBW];
    assign REQW             = qi_latch[`INST_REQW];
    assign WBUF_PURGE       = qi_latch[`INST_WBUF_PURGE];
    assign WBUF_EN          = qi_latch[`INST_WBUF_EN];
    assign WBUF_ALL_EN      = qi_latch[`INST_WBUF_ALL_EN];
    assign FC_WEIGHT_EN     = qi_latch[`INST_FC_WEIGHT_EN];
    assign NL_EN            = qi_latch[`INST_NL_EN];
    assign SHIFT_MODE       = qi_latch[`INST_SHIFT_MODE];
    assign NL_SEL           = qi_latch[`INST_NL_SEL_E:`INST_NL_SEL_S];
    assign MAC_EN           = qi_latch[`INST_MAC_EN];
    assign RESULT_REQ       = qi_latch[`INST_RESULT_REQ];
    assign OLSB             = qi_latch[`INST_OLSB_E:`INST_OLSB_S];
    assign RESULT_PURGE     = qi_latch[`INST_RESULT_PURGE];
    assign OUTPUT_EN        = qi_latch[`INST_OUTPUT_EN];
    assign I_COMPARE_EN     = qi_latch[`INST_I_COMPARE_EN];
    assign I_COMPARE_MODE   = qi_latch[`INST_I_COMPARE_MODE];
    assign I_COMPARE_SWITCH = qi_latch[`INST_I_COMPARE_SWITCH];
    assign O_COMPARE_EN     = qi_latch[`INST_O_COMPARE_EN];
    assign O_COMPARE_MODE   = qi_latch[`INST_O_COMPARE_MODE];
    assign O_COMPARE_SWITCH = qi_latch[`INST_O_COMPARE_SWITCH];
    assign CAL_MODE         = qi_latch[`INST_CAL_MODE];
    assign CONV_FC_MODE     = qi_latch[`INST_CONV_FC_MODE];
    assign FEEDBACK_MODE    = qi_latch[`INST_FEEDBACK_MODE];
    assign CONF_EN          = qi_latch[`INST_CONF_EN];
    assign I_COMPARE_REGEN  = qi_latch[`INST_I_COMPARE_REGEN];
    assign NL_LOOP_SEL      = qi_latch[`INST_NL_LOOP_SEL_E:`INST_NL_LOOP_SEL_S];
    assign SEQ_LOAD_I       = qi_latch[`INST_SEQ_LOAD_I];
    assign SEQ_FIN          = qi_latch[`INST_SEQ_FIN];
    assign SEQ_STARTW       = qi_latch[`INST_SEQ_STARTW];
    assign SEQ_STARTX       = qi_latch[`INST_SEQ_STARTX];
    assign SEQ_STARTX_OUT   = qi_latch[`INST_SEQ_STARTX_OUT];
    assign RCEBX0           = qi_latch[`INST_RCEBX0];

endmodule
