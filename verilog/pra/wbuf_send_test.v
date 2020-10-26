module wbuf_send_test;
  reg CLK, RSTL, WBUF_SEND;
  reg [15:0] addr;
  reg [15:0] loop;
  reg [5:0] wbuf_ec;
  wire [2:0] cnt;
  wire [15:0] RADDRX;
  wire [5:0] WBUF_EN_CTRL;
  wire [15:0] COUNTER0;
  wire WBUF_EN, RCEBX;

  wbuf_send wbuf_send_instance(
    .CLK(CLK),
    .RSTL(RSTL),
    .WBUF_SEND(WBUF_SEND),
    .addr(addr),
    .loop(loop),
    .wbuf_ec(wbuf_ec),
    .cnt(cnt),
    .COUNTER0(COUNTER0),
    .RCEBX(RCEBX),
    .WBUF_EN(WBUF_EN),
    .WBUF_EN_CTRL(WBUF_EN_CTRL)
  );

  parameter step = 10;

  initial begin
    CLK = 0;
    forever #(step) CLK = ~CLK;
  end

  initial begin
    RSTL = 0;
    WBUF_SEND = 0;
    addr = 16'b0;
    wbuf_ec = 6'b0;
    loop = 5;
    #(step*3)
    RSTL = 1;
    WBUF_SEND = 1;

    #step
    WBUF_SEND = 0;
  end

  initial begin
    #(step*100) $finish();
  end
  
  initial begin
    $dumpfile("wbuf_send_test.vcd");
    $dumpvars(0, wbuf_send_instance);
  end

endmodule