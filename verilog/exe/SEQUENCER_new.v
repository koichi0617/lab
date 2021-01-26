`include "SEQUENCER_DEF_new.v"

module SEQUENCER (input wire CLK,
                  input wire RSTL,
                  input wire PURGE,
                  input wire MBUSYW,
                  input wire MBUSYXI,
                  input wire MBUSYXO,
                  input wire [255:0] QI,
                  output wire [15:0] RADDRI,
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
    
    reg [15:0] pc; //SRAM（マイクロコード）の何行目からもってくるか
    reg [7:0] counter1; //ループ回数
    reg [7:0] counter2; //ループ回数
    reg [7:0] counter3; //ループ回数
    reg [7:0] counter4; //ループ回数
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
    reg [2:0] cnt;
    reg [7:0] counter;
    wire module_busy;
    wire wbuf_busy;
    wire module_en;

    assign RADDRI = {pc[14:0],1'b0};
    assign RCEBI  = 1'b0;
    assign module_busy = wbuf_busy | output_busy | conv_busy;
    assign module_en = QI[`INST_WBUF_SEND] | QI[`INST_OUTPUT_SEND] | QI[`INST_CONV_CAL];

    //PC
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)                          pc <= 16'b0;
        else if (PURGE)                     pc <= 16'b0;
        else if (pc_change & QI[`INST_JUMP_COUNTER1]) begin
            if (counter1 == 8'b1)
                pc <= pc + 1'b1;
            else
                pc <= QI[`INST_PC_E:`INST_PC_S];
        end
        else if (pc_change & QI[`INST_JUMP_COUNTER2]) begin
            if (counter2 == 8'b1)
                pc <= pc + 1'b1;
            else
                pc <= QI[`INST_PC_E:`INST_PC_S];
        end
        else if (pc_change & QI[`INST_JUMP_COUNTER3]) begin
            if (counter3 == 8'b1)
                pc <= pc + 1'b1;
            else
                pc <= QI[`INST_PC_E:`INST_PC_S];
        end
        else if (pc_change & QI[`INST_JUMP_COUNTER4]) begin
            if (counter4 == 8'b1)
                pc <= pc + 1'b1;
            else
                pc <= QI[`INST_PC_E:`INST_PC_S];
        end
        else if (module_busy)               pc <= pc;
        else if (pc_change & module_en)     pc <= pc;
        else pc <= pc + 1'b1;
    end
    
    reg [15:0] delay_pc;
    wire pc_change;
    assign pc_change = (delay_pc != pc) ? 1:0;
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)      delay_pc <= 16'b0;
        else if (PURGE) delay_pc <= 16'b0;
        else            delay_pc <= pc;
    end

    //COUNTER1
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)          counter1 <= 8'b0;
        else if (PURGE)     counter1 <= 8'b0;
        else if (pc_change) 
            begin
                case(QI[`INST_COUNTER1_WE])
                    1'b1:
                        if (counter1 == 8'b0)
                            counter1 <= QI[`INST_COUNTER1_4_E:`INST_COUNTER1_4_S];
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
        else counter1 <= counter1;
    end


    //COUNTER2
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter2 <= 8'b0;
        else if (PURGE)  counter2 <= 8'b0;
        else if (pc_change) 
            begin
                case(QI[`INST_COUNTER2_WE])
                    1'b1:
                        if (counter2 == 8'b0)
                            counter2 <= QI[`INST_COUNTER1_4_E:`INST_COUNTER1_4_S];
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
        else counter2 <= counter2;
    end
    
    //COUNTER3
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter3 <= 8'b0;
        else if (PURGE)  counter3 <= 8'b0;
        else begin
            case(QI[`INST_COUNTER3_WE])
                1'b1:
                    if (counter3 == 8'b0)
                        counter3 <= QI[`INST_COUNTER1_4_E:`INST_COUNTER1_4_S];
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
    

    //COUNTER4
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       counter4 <= 8'b0;
        else if (PURGE)  counter4 <= 8'b0;
        else begin
            case(QI[`INST_COUNTER4_WE])
                1'b1:
                    if (counter4 == 8'b0)
                        counter4 <= QI[`INST_COUNTER1_4_E:`INST_COUNTER1_4_S];
                    else
                        counter4 <= counter4;
                default:
                    case(QI[`INST_JUMP_COUNTER4])
                        1'b1:
                            counter4 <= counter4 - 1'b1;
                        default:
                            counter4 <= counter4;
                    endcase
            endcase
        end
    end

    //pc_adjust
    reg pc_adjust;
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)      pc_adjust <= 0;
        else if (PURGE) pc_adjust <= 0;
        else            pc_adjust <= module_busy;
    end

    //RADDRX
    wire [15:0] raddrx;
    assign raddrx = reg_raddrx;
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrx <= 16'b0;
        else if (PURGE)  reg_raddrx <= 16'b0;
        else if (!module_busy) begin
            case(QI[`INST_RADDRX_WE])
                1'b0:
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
        else    reg_raddrx <= reg_raddrx;
    end

    //WADDRX
    wire [15:0] waddrx;
    assign waddrx = reg_waddrx;
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_waddrx <= 16'b0;
        else if (PURGE)  reg_waddrx <= 16'b0;
        else if (!module_busy) begin
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
        else    reg_waddrx <= reg_waddrx;
    end

    //RADDRW
    wire [15:0] raddrw;
    assign raddrw = reg_raddrw;
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       reg_raddrw <= 16'b0;
        else if (PURGE)  reg_raddrw <= 16'b0;
        else if (!module_busy) begin
            case(QI[`INST_RADDRW_WE])
                1'b0:
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
        else    reg_raddrw <= reg_raddrw;
    end

    //命令モジュール呼び出し //.下位input(上位input) or .下位output(上位output)
    wbuf_send wbuf_send_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .WBUF_SEND(QI[`INST_WBUF_SEND]),
        .COUNTER0(QI[`INST_COUNTER0_E:`INST_COUNTER0_S]),
        .RADDRX_I(raddrx),
        .WBUF_EN_CTRL_I(QI[`INST_WBUF_EN_CTRL_E:`INST_WBUF_EN_CTRL_S]),
        .module_busy(module_busy),
        //output
        .RADDRX(RADDRX),
        .RCEBX(RCEBX),
        .WBUF_EN(WBUF_EN),
        .WBUF_EN_CTRL(WBUF_EN_CTRL),
        .WBUF_BUSY(wbuf_busy)
    );

    output_send output_send_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .OUTPUT_SEND(QI[`INST_OUTPUT_SEND]),
        .COUNTER0(QI[`INST_COUNTER0_E:`INST_COUNTER0_S]),
        .WADDRX_I(waddrx),
        .OUTPUT_EN_CTRL_I(QI[`INST_OUTPUT_EN_CTRL_E:`INST_OUTPUT_EN_CTRL_S]),
        .module_busy(module_busy),
        //output
        .WADDRX(WADDRX),
        .WCEBX(WCEBX),
        .OUTPUT_EN(OUTPUT_EN),
        .OUTPUT_EN_CTRL(OUTPUT_EN_CTRL),
        .OUTPUT_BUSY(output_busy)
    );

    conv_cal conv_cal_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .CONV_CAL(QI[`INST_CONV_CAL]),
        .COUNTER0(QI[`INST_COUNTER0_E:`INST_COUNTER0_S]),
        .RADDRW_I(raddrw),
        .module_busy(module_busy),
        //output
        .RADDRW(RADDRW),
        .RCEBW(RCEBW),
        .MAC_EN(MAC_EN),
        .NL_EN(NL_EN),
        .CONV_BUSY(conv_busy)
    );


endmodule
