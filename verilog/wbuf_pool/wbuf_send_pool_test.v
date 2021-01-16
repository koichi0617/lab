module wbuf_send_pool_test;
  reg CLK, RSTL, WBUF_SEND_POOL;
  reg [15:0] addr;
  reg [15:0] loop;
  reg [7:0] sharp;
  reg [5:0] wbuf_ec;
  wire [2:0] cnt;
  wire [7:0] cnt_sharp;
  wire [3:0] cnt_loop;
  wire [15:0] RADDRX;
  wire [5:0] WBUF_EN_CTRL;
  wire [15:0] COUNTER0;
  wire WBUF_EN, RCEBX, WBUF_PURGE, I_COMPARE_MODE, I_COMPARE_REGEN, I_COMPARE_SWITCH, I_COMPARE_EN;

  wbuf_send_pool wbuf_send_pool_instance(
    .CLK(CLK),
    .RSTL(RSTL),
    .WBUF_SEND_POOL(WBUF_SEND_POOL),
    .addr(addr),
    .loop(loop),
    .sharp(sharp),
    .wbuf_ec(wbuf_ec),
    .cnt(cnt),
    .cnt_sharp(cnt_sharp),
    .cnt_loop(cnt_loop),
    .COUNTER0(COUNTER0),
    .RCEBX(RCEBX),
    .WBUF_EN(WBUF_EN),
    .WBUF_EN_CTRL(WBUF_EN_CTRL),
    .WBUF_PURGE(WBUF_PURGE),
    .I_COMPARE_MODE(I_COMPARE_MODE), 
    .I_COMPARE_REGEN(I_COMPARE_REGEN),
    .I_COMPARE_SWITCH(I_COMPARE_SWITCH),
    .I_COMPARE_EN(I_COMPARE_EN)
  );

  parameter step = 10;

  initial begin
    CLK = 0;
    forever #(step) CLK = ~CLK;
  end

  initial begin
    RSTL = 0;
    WBUF_SEND_POOL = 0;
    addr = 16'b0; //SRAMの開始アドレス
    wbuf_ec = 6'b0; //PBの開始列
    loop = 5; //ループ回数
    sharp = 27; //#の数

    #(step*3)
    RSTL = 1;
    WBUF_SEND_POOL = 1;

    #step
    WBUF_SEND_POOL = 0;
    I_COMPARE_MODE = 1;
    RCEBX = 0;

    #step
    I_COMPARE_REGEN = 1;

    #(step*2)

  end

  initial begin
    #(step*100) $finish();
  end
  
  initial begin
    $dumpfile("wbuf_send_pool_test.vcd");
    $dumpvars(0, wbuf_send_pool_instance);
  end

endmodule