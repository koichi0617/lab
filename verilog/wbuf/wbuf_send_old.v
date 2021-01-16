module wbuf_send(
	input wire CLK, 
	input wire RSTL,
  input wire WBUF_SEND,
	output reg [15:0] RADDRX, //SRAMのどのアドレスか
	output reg RCEBX, //SRAMのデータを取り出す処理
	output reg WBUF_EN, //PBのデータ受け入れ開始
	output reg [5:0] WBUF_EN_CTRL //PBの列指定
	);

	reg [15:0] pc;
	reg [2:0] cnt;
	reg [7:0] counter0;

	
	//counter0
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			counter0 <= 8'd0;
    end else if(WBUF_SEND) begin
			counter0 <= 8'd32;
			RCEBX <= 0;
		end else if(counter0 != 0 && cnt == 3'b100) //１ループを4サイクル設定
			counter0 <= counter0 - 1;
	end

  //RCEBX
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			RCEBX <= 1;
		else if(counter0)
      RCEBX <= 0;
		else
			RCEBX <= 1;
	end

  //WBUF_EN
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			WBUF_EN <= 3'b000;
		else if(counter0)
      WBUF_EN <= 1;
		else
			WBUF_EN <= 0;
	end

	//cnt:アドレス用カウンタ(4サイクル)
  always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			cnt <= 3'b000;
		else if(counter0) begin
			if(cnt == 3'b100) begin
				if(counter0 == 16'd1) begin
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
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			RADDRX <= 16'd0;
		else if(counter0) begin
      if(cnt == 3'b100 && counter0 == 1)
        RADDRX <= RADDRX;
      else
			  RADDRX <= RADDRX + 16'b1;
    end
	end

	//WBUF_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			WBUF_EN_CTRL <= 6'b0;
		else if(counter0 != 1 && cnt == 3'b100)
			WBUF_EN_CTRL <= WBUF_EN_CTRL + 6'b1;
	end


endmodule