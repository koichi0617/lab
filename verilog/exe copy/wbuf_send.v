module wbuf_send(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND,
	input wire WBUF_SEND_POOL,
	input wire [7:0] COUNTER0,
	input wire [15:0] RADDRX_I,
	input wire [5:0] WBUF_EN_CTRL_I,
	input wire module_busy,
	output wire [15:0] RADDRX,
	output wire RCEBX,
	output wire WBUF_EN,
	output wire [5:0] WBUF_EN_CTRL,
	output wire I_COMPARE_EN,
	output wire I_COMPARE_MODE,
	output wire I_COMPARE_REGEN,
	output wire I_COMPARE_SWITCH,
	output wire WBUF_BUSY
	);

	wire [15:0] RADDRX_NO;
	wire		RCEBX_NO;
	wire		WBUF_EN_NO;
	wire [5:0]  WBUF_EN_CTRL_NO;
	wire		WBUF_NO_BUSY;
	wire [15:0] RADDRX_POOL;
	wire		RCEBX_POOL;
	wire		WBUF_EN_POOL;
	wire [5:0]  WBUF_EN_CTRL_POOL;
	wire		WBUF_POOL_BUSY;
	wire		COUNTER0_O;

	assign RADDRX = (COUNTER0_O) ? RADDRX_NO:RADDRX_POOL;
	assign RCEBX = (COUNTER0_O) ? RCEBX_NO:RCEBX_POOL;
	assign WBUF_EN = (COUNTER0_O) ? WBUF_EN_NO:WBUF_EN_POOL;
	assign WBUF_EN_CTRL = (COUNTER0_O) ? WBUF_EN_CTRL_NO:WBUF_EN_CTRL_POOL;
	assign WBUF_BUSY = WBUF_NO_BUSY | WBUF_POOL_BUSY;

	wbuf_send_nopool wbuf_send_nopool_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .WBUF_SEND(WBUF_SEND),
        .COUNTER0(COUNTER0),
        .RADDRX_I(RADDRX_I),
        .WBUF_EN_CTRL_I(WBUF_EN_CTRL_I),
        .module_busy(module_busy),
        //output
        .RADDRX(RADDRX_NO),
        .RCEBX(RCEBX_NO),
        .WBUF_EN(WBUF_EN_NO),
        .WBUF_EN_CTRL(WBUF_EN_CTRL_NO),
        .WBUF_BUSY(WBUF_NO_BUSY),
		.COUNTER0_O(COUNTER0_O)
    );

	wbuf_send_pool wbuf_send_pool_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .WBUF_SEND_POOL(WBUF_SEND_POOL),
        .COUNTER0(COUNTER0),
        .RADDRX_I(RADDRX_I),
        .WBUF_EN_CTRL_I(WBUF_EN_CTRL_I),
        .module_busy(module_busy),
        //output
        .RADDRX(RADDRX_POOL),
        .RCEBX(RCEBX_POOL),
        .WBUF_EN(WBUF_EN_POOL),
        .WBUF_EN_CTRL(WBUF_EN_CTRL_POOL),
        .I_COMPARE_EN(I_COMPARE_EN),
        .I_COMPARE_MODE(I_COMPARE_MODE),
        .I_COMPARE_REGEN(I_COMPARE_REGEN),
        .I_COMPARE_SWITCH(I_COMPARE_SWITCH),
        .WBUF_POOL_BUSY(WBUF_POOL_BUSY)
    );

endmodule