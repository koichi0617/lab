module wbuf_send(
	input wire CLK, 
	input wire RSTL,
	input wire [15:0] reg_raddrx, //SRAMのアドレスを保存しておくレジスタ
	input wire [7:0] COUNTER0,
	input wire [15:0] raddrx,
	input wire [5:0] wbuf_en_ctrl,
	output wire [15:0] RADDRX, //SRAMのどのアドレスか
	output wire RCEBX, //SRAMのデータを取り出す処理
	output wire WBUF_EN, //PBのデータ受け入れ開始
	output wire [5:0] WBUF_EN_CTRL //PBの列指定
	);

	reg [15:0] pc;
	reg [2:0] cnt;
	reg [7:0] counter0;

	//counter0
  always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)
			counter0 <= 8'd0;
		else begin
			case(QI[`INST_WBUF_SEND])
				1'b0:
					counter0 <= 8'd0;
				1'b1:
					counter0 <= COUNTER0;
		end else if(counter0 != 0 && cnt == 3'b100) //１ループを4サイクルに設定
			counter0 <= counter0 - 1;
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

	//RADDRX
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			RADDRX <= 16'd0;
		else begin
			case(QI[`INST_WBUF_SEND])
				1'b0:
					RADDRX <= 16'd0;
				1'b1:
					RADDRX <= raddrx;
		end else if(counter0) begin
      if(cnt == 3'b100 && counter0 == 1)
        RADDRX <= RADDRX;
      else
			  RADDRX <= RADDRX + 16'b1;
    end
	end

	//WBUF_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			WBUF_EN_CTRL <= 6'd0;
		else begin
			case(QI[`INST_WBUF_SEND])
				1'b0:
					WBUF_EN_CTRL <= 6'd0;
				1'b1:
					WBUF_EN_CTRL <= wbuf_en_ctrl;
		end else if(counter0 != 1 && cnt == 3'b100)
			WBUF_EN_CTRL <= WBUF_EN_CTRL + 6'b1;
	end


endmodule