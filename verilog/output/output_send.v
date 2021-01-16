module output_send(
	input wire CLK, 
	input wire RSTL,
	input wire OUTPUT_SEND, //開始スイッチ
	input wire [15:0] addr, //SRAMの開始アドレス
	input wire [15:0] loop, //ループ回数
	input wire [5:0] output_ec, //PBの列指定
	input wire [15:0] pc, //プログラムカウンタ
	output reg [2:0] cnt, //#のサイクル(4周期)
	output reg [15:0] WADDRX, //_WEの処理の数値
	output reg WCEBX, //データを取り出す処理
	output reg OUTPUT_EN, //0：PB受け入れ中止, 1：PB受け入れ開始
	output reg [5:0] OUTPUT_EN_CTRL, //PBの列指定
	output reg [15:0] COUNTER0 //ループ回数
	);


	// pc
	// always @(posedge CLK or negedge RSTL)  begin
	// 	if (!RSTL)			
	// 		pc <= 16'd0;
	// 	else if(OUTPUT_SEND)
	// 		pc <= pc + 16'd1;
	// end
	
	//ループ用カウンター
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			COUNTER0 <= 16'd0;
			WCEBX <= 1;
			OUTPUT_EN <= 0;
		end else if(OUTPUT_SEND) begin
			COUNTER0 <= loop;
			WCEBX <= 0;
			OUTPUT_EN <= 1;
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
					OUTPUT_EN <= 0;
				end else
					cnt <= 3'b001;
			end else
        cnt <= cnt + 1;
		end else
			cnt <= 3'b000;
	end

	//WADDRX
	always @(cnt) begin
		if (!RSTL)			
			WADDRX <= 16'd0;
		else if(OUTPUT_SEND)
			WADDRX <= addr;
		else if(COUNTER0)
			if(COUNTER0 != loop || cnt != 3'b001)
				WADDRX <= WADDRX + 16'd1;
	end

	//OUTPUT_EN_CTRL
	always@ (cnt) begin
		if (!RSTL)       
			OUTPUT_EN_CTRL <= 6'b0;
		else if(OUTPUT_SEND) 
			OUTPUT_EN_CTRL <= output_ec;
		else if(cnt == 3'b001)
			OUTPUT_EN_CTRL <= OUTPUT_EN_CTRL + 6'b1;
	end


endmodule