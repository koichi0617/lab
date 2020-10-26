module wbuf_send(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND, //開始スイッチ
	input wire [15:0] addr, //SRAMの開始アドレス
	input wire [15:0] loop, //ループ回数
	input wire [5:0] wbuf_ec, //PBの列指定
	output reg [2:0] cnt, //#のサイクル(4周期)
	output reg [15:0] RADDRX, //_WEの処理の数値
	output reg RCEBX, //データを取り出す処理
	output reg WBUF_EN, //0：PB受け入れ中止, 1：PB受け入れ開始
	output reg [5:0] WBUF_EN_CTRL, //PBの列指定
	output reg [15:0] COUNTER0 //ループ回数
	);

	
	//ループ用カウンター
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)			
			COUNTER0 <= 16'd0;
		else if(WBUF_SEND) begin
			COUNTER0 <= loop;
			RCEBX <= 0;
			WBUF_EN <= 1;
		end else if(COUNTER0 != 0 && cnt == 3'b100) //１ループを4サイクル設定
			COUNTER0 <= COUNTER0 - 1;
	end

	//ループの中身用カウンタ(4サイクル)
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			cnt <= 3'b000;
		else if(COUNTER0) begin
			if(cnt == 3'b100) begin
				if(COUNTER0 == 16'd1) begin
					cnt <= 3'b000;
					WBUF_EN <= 0;
				end else
					cnt <= 3'b001;
			end else
        cnt <= cnt + 1;
		end else
			cnt <= 3'b000;
	end

	//RADDRX
	always @(cnt) begin
		if (!RSTL)			
			RADDRX <= 16'd0;
		else if(WBUF_SEND)
			RADDRX <= addr;
		else if(COUNTER0)
			RADDRX <= RADDRX + 16'b1;
	end

	//WBUF_EN_CTRL
	always@ (cnt) begin
		if (!RSTL)       
			WBUF_EN_CTRL <= 6'b0;
		else if(WBUF_SEND) 
			WBUF_EN_CTRL <= wbuf_ec;
		else if(COUNTER0) begin
			WBUF_EN_CTRL <= WBUF_EN_CTRL + 6'b1;
		end
	end


endmodule