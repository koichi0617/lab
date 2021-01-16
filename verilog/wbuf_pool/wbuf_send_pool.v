module wbuf_send_pool(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND_POOL, //開始スイッチ
	input wire [15:0] addr, //SRAMの開始アドレス
	input wire [15:0] loop, //ループ回数
  input wire [7:0] sharp, //#の個数
	input wire [5:0] wbuf_ec, //PBの列指定
	output reg [2:0] cnt, //#のサイクル(4周期)
	output reg [7:0] cnt_sharp, //#用カウンター
	output reg [3:0] cnt_loop, //ループ中のサイクル(8周期)
	output reg [15:0] RADDRX, //_WEの処理の数値
	output reg RCEBX, //データを取り出す処理
	output reg WBUF_EN, //1：PB受け入れ開始
	output reg [5:0] WBUF_EN_CTRL, //PBの列指定
	output reg [15:0] COUNTER0, //ループ回数
	output reg WBUF_PURGE, //0:MAC演算機（PBに備えついている）のレジスタをリセット
	output reg I_COMPARE_MODE, //縦二つのデータを比較するモード
	output reg I_COMPARE_REGEN, //１：SRAMから比較機へのデータ転送開始(現在のアドレスの値を転送)
	output reg I_COMPARE_SWITCH, //比較機のレジスタを切り替え(アドレスが４進んだ時点で切り替え)
	output reg I_COMPARE_EN //比較機で比較して大きい方のデータを返す
	);

	//#用カウンター
  always @(posedge CLK or negedge RSTL) begin
    if (!RSTL)			
			cnt_sharp <= 8'd0;
    else if(WBUF_SEND_POOL)
      cnt_sharp <= 8'd1;
    else if(cnt_sharp != sharp)
      cnt_sharp <= cnt_sharp + 1;
  end

  //ループの外用カウンター(4サイクル)
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			cnt <= 3'b000;
    else if(WBUF_SEND_POOL)
      cnt <= 3'b001;
    else if(cnt == 3'b100) begin
      if(cnt_sharp == sharp)
        cnt <= 3'b000;
      else
        cnt <= 3'b001;
    end
    else
      cnt <= cnt + 1;
	end

	//ループ用カウンター
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)			
			COUNTER0 <= 16'd0;
		else if(WBUF_SEND_POOL) begin
			COUNTER0 <= loop;
		end else if(COUNTER0 != 0 && cnt_loop == 4'b1000) //１ループを8サイクル設定
			COUNTER0 <= COUNTER0 - 1;
	end

	//ループの中身用カウンタ(8サイクル)
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			cnt_loop <= 4'b0000;
		else if(COUNTER0) begin
			if(cnt_loop == 4'b1000) begin
				if(COUNTER0 == 16'd1) begin
					cnt_loop <= 4'b0000;
					WBUF_EN <= 0;
				end else
					cnt_loop <= 4'b0001;
			end else
        cnt_loop <= cnt_loop + 1;
		end else
			cnt_loop <= 4'b0000;
	end

  //WBUF_PURGE
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			WBUF_PURGE <= 0;
		else if(WBUF_SEND_POOL)
			WBUF_PURGE <= 1;
    else if(I_COMPARE_MODE == 1)
			WBUF_PURGE <= 0;
	end

	//RADDRX
	always @(cnt) begin
		if (!RSTL)			
			RADDRX <= 16'd0;
		else if(WBUF_SEND_POOL)
			RADDRX <= addr;
    else if(RADDRX == 3)
      RADDRX <= RADDRX + 16'd125;
    else if(cnt_loop == 3)
      RADDRX <= RADDRX - 16'd127;
    else if(cnt_loop == 7)
      RADDRX <= RADDRX + 16'd125;
    else if(cnt_loop != 5 || cnt_loop != 6)
			RADDRX <= RADDRX + 16'd1;
	end

	//WBUF_EN_CTRL
	always@ (cnt) begin
		if (!RSTL)       
			WBUF_EN_CTRL <= 6'b0;
		else if(WBUF_SEND_POOL) 
			WBUF_EN_CTRL <= wbuf_ec;
		else if(cnt == 4'b0001)
			WBUF_EN_CTRL <= WBUF_EN_CTRL + 6'b1;
	end

  //I_COMPARE
  always@ (posedge CLK or negedge RSTL) begin
    if(!RSTL) begin
      I_COMPARE_MODE <= 0;
      I_COMPARE_REGEN <= 0;
      I_COMPARE_SWITCH <= 0;
      I_COMPARE_EN <= 0;
    end
    else if(WBUF_SEND_POOL)
      I_COMPARE_MODE <= 1;

  end


endmodule