module wbuf_send_test;
  reg CLK, RSTL, WBUF_SEND;
  reg [7:0] loop;
  wire [2:0] cnt;
  wire [7:0] COUNTER0;
  wire WBUF_EN, RCEBX;

  wbuf_send wbuf_send_instance(
    .CLK(CLK),
    .RSTL(RSTL),
    .loop(loop),
    .WBUF_SEND(WBUF_SEND),
    .cnt(cnt),
    .COUNTER0(COUNTER0),
    .WBUF_EN(WBUF_EN),
    .RCEBX(RCEBX)
  );

  parameter step = 10;

  initial begin
    CLK = 0;
    forever #(step) CLK = ~CLK;
  end

  initial begin
    RSTL = 0;
    WBUF_SEND = 0;
    #(step*3) RSTL = 1;
    WBUF_SEND = 1;
    loop = 5;

    #step
    WBUF_SEND = 0;
    loop = 0;
  end

  initial begin
    #(step*100) $finish();
  end
  
  initial begin
    $dumpfile("wbuf_send_test.vcd");
    $dumpvars(0, wbuf_send_instance);
  end

endmodule