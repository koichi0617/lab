module conv_cal(
	input wire CLK, 
	input wire RSTL,
	input wire CONV_CAL, //開始スイッチ
	//input wire [15:0] addr, //SRAMの開始アドレス
	input wire [15:0] loop, //ループ回数
	//input wire [5:0] wbuf_ec, //PBの列指定
	output reg [2:0] cnt, //#のサイクル(5サイクル)
	output reg [15:0] RADDRW, //SRAMの重みを読み込み
	output reg RCEBW, //0:重みを読み込む処理
	//output reg WBUF_EN, //0：PB受け入れ中止, 1：PB受け入れ開始
	//output reg [5:0] WBUF_EN_CTRL, //PBの列指定
	output reg [15:0] COUNTER0, //ループ回数
  output reg NL_EN, //PBの値をずらす(4サイクル後にずれる)
  output reg MAC_EN //MAC演算を行う(畳み込む)
	);

	
	//COUNTER0:ループ回数用カウンター
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)			
			COUNTER0 <= 16'd0;
		else if(CONV_CAL) begin
			COUNTER0 <= loop;
		end else if(cnt == 3'b101) //１ループを4サイクル設定
			COUNTER0 <= COUNTER0 - 1;
	end

	//cnt:ループの中身用カウンタ(5サイクル)
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			cnt <= 3'b000;
		else if(COUNTER0) begin
			if(cnt == 3'b101) begin
				if(COUNTER0 == 16'd1) begin
					cnt <= 3'b000;
				end else
					cnt <= 3'b001;
			end else
        cnt <= cnt + 1;
		end else
			cnt <= 3'b000;
	end

	//RADDRW
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			RADDRW <= 16'd0;
    else if(CONV_CAL)
      RADDRW <= 16'd0;
		else if(COUNTER0)
      if(cnt != 3'b101 || COUNTER0 != 1) //!が入ると||は&&になるっぽい
			  if(cnt == 3'b011)
          RADDRW <= RADDRW;
        else
          RADDRW <= RADDRW + 16'd1;
	end

  //RCEBW
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			RCEBW <= 1;
		else if(CONV_CAL)
			RCEBW <= 0;
		else if(cnt == 3'b101 && COUNTER0 == 1)
			RCEBW <= 1;
	end

	//NL_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			NL_EN <= 0;
		else if(COUNTER0) begin
      if(cnt == 3'b100)
        NL_EN <= 0;
      else if(COUNTER0 == 1 && cnt == 3'b101)
        NL_EN <= 0;
      else
        NL_EN <= 1;
    end else
      NL_EN <= 0;
	end

  //MAC_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			MAC_EN <= 0;
    else if(COUNTER0) begin
      if(cnt == 3'b001 || cnt == 3'b010 || cnt == 3'b011 || cnt == 3'b100)
        MAC_EN <= 0;
      else if(cnt == 3'b101 && COUNTER0 == 1)
        MAC_EN <= 0;
      else
        MAC_EN <= 1;
    end
	end


endmodule