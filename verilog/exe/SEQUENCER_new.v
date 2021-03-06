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
    wire [7:0] counter_end;
    reg [2:0] cnt;
    reg [7:0] counter;
    
    assign RADDRI = {pc[14:0],1'b0}; //SRAMの何行目かを指定
    assign RCEBI  = 1'b0;
    assign WBUF_SWITCH    = reg_switch_latch;
    
    //PC
    always@ (posedge CLK or negedge RSTL)
    begin
        if (!RSTL)       pc <= 16'b0;
        else if (PURGE)  pc <= 16'b0;
        else begin
            case(QI[`INST_WBUF_SEND])
                1'b1:
                    if(counter != QI[`INST_COUNTER0_E:`INST_COUNTER0_S])
                        pc <= pc;
                    else
                        pc <= pc + 1;
                default:
                    pc <= pc + 1;
            endcase
        end
    end

    //counter
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)
			counter <= 1'd0;
		else if(QI[`INST_WBUF_SEND]) begin
			if(cnt == 3'b100)
				counter <= counter + 1;
			else
				counter <= counter;
		end else
			counter <= 1'd0;
	end

    //cnt:モジュール用カウンタ(wbuf & output)
    always@ (posedge CLK or negedge RSTL)
    begin
        if(!RSTL)       cnt <= 0;
        else if(PURGE)  cnt <= 0; 
        else if(QI[`INST_WBUF_SEND]) begin
			if(cnt == 3'b100) begin
				if(counter == QI[`INST_COUNTER0_E:`INST_COUNTER0_S] - 1)
					cnt <= 3'b000;
				else
					cnt <= 3'b001;
			end else
        		cnt <= cnt + 1;
		end else
			cnt <= 3'b000;
    end

    //命令モジュール呼び出し //.下位input(上位input) or .下位output(上位output)
    wbuf_send wbuf_send_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .WBUF_SEND(QI[`INST_WBUF_SEND]),
        .COUNTER0(QI[`INST_COUNTER0_E:`INST_COUNTER0_S]),
        .raddrx(QI[`INST_RADDRX_E:`INST_RADDRX_S]),
        .wbuf_en_ctrl(QI[`INST_WBUF_EN_CTRL_E:`INST_WBUF_EN_CTRL_S]),
        //output
        .RADDRX(RADDRX),
        .RCEBX(RCEBX),
        .WBUF_EN(WBUF_EN),
        .WBUF_EN_CTRL(WBUF_EN_CTRL),
        .COUNTER_END(counter_end)
    );

endmodule
