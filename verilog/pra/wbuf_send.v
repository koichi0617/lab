module wbuf_send(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND,
	input wire [15:0] addr,
	input wire [15:0] loop,
	input wire [5:0] wbuf_ec,
	output reg [2:0] cnt,
	output reg [15:0] RADDRX, //_WEの処理の数値
	output reg RADDRX_WE, //0：SRAMアドレス移動(加算), 1：アドレス指定(上書き)
	output reg RCEBX, //データを取り出す処理
	output reg WBUF_EN, //0：PB受け入れ中止, 1：PB受け入れ開始
	output reg [5:0] WBUF_EN_CTRL, //PBの列指定
	output reg WBUF_EN_CTRL_WE,
	output reg [15:0] COUNTER0, //ループ回数
	output reg COUNTER0_WE, //ループ回数を固定
	output reg JUMP_COUNTER0
	);

	
	//ループ用カウンター
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)			COUNTER0 <= 16'd0;
		else if(WBUF_SEND)
			COUNTER0 <= loop;
		else if(COUNTER0 != 0 && cnt == 3'b100)
      COUNTER0 <= COUNTER0 - 1;
	end

	//ループの中身用カウンタ(4サイクル)
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)			cnt <= 3'd0;
		else if(|COUNTER0) begin //COUNTER0が0以外の時
			if(cnt == 3'b100) begin
				if(COUNTER0 == 16'd1)
					cnt <= 3'b000;
				else
					cnt <= 3'b001;
			end else
        cnt <= cnt + 1;
		end else
			cnt <= 3'b000;
	end

	//RADDRX
	always @(cnt)  begin
		if (!RSTL)			RADDRX <= 16'd0;
		else if(WBUF_SEND)
			COUNTER0 <= loop;
		else  begin 
			case(RADDRX_WE)
				1'b0:
					RADDRX <= RADDRX + RADDRX;
				1'b1:
					RADDRX <= addr;
			endcase
		end
	end

	//WBUF_EN_CTRL
	always@ (posedge CLK or negedge RSTL)
	begin
		if (!RSTL)       WBUF_EN_CTRL <= 6'b0;
		else if(WBUF_SEND)
			WBUF_EN_CTRL <= lwbuf_ec;
		else begin
			case(INST_WBUF_EN_CTRL_WE)
				1'b0:
					WBUF_EN_CTRL <= WBUF_EN_CTRL + WBUF_EN_CTRL;
				1'b1:
					WBUF_EN_CTRL <= wbuf_ec;
			endcase
		end
	end


  always @(cnt)  begin
		if (!RSTL) begin
			WBUF_EN <= 0;
			RCEBX <= 0;
		end 
		else  begin 
			case(cnt)
				3'b000: begin
					WBUF_EN <= 0;
					RCEBX <= 0;
				end
				3'b001: begin
					WBUF_EN <= 1;
					RCEBX <= 0;
				end
				3'b010: begin
					WBUF_EN <= 1;
					RCEBX <= 0;
				end
				3'b011: begin
					WBUF_EN <= 1;
					RCEBX <= 0;
				end
				3'b100: begin
					WBUF_EN <= 1;
					RCEBX <= 0;
				end
			endcase
		end
	end


endmodule