module output_send_test;
  reg CLK, RSTL, OUTPUT_SEND;
  reg [15:0] addr;
  reg [15:0] loop;
  reg [5:0] output_ec;
  reg [15:0] pc;
  wire [2:0] cnt;
  wire [15:0] WADDRX;
  wire [5:0] OUTPUT_EN_CTRL;
  wire [15:0] COUNTER0;
  wire OUTPUT_EN, WCEBX;

  output_send output_send_instance(
    .CLK(CLK),
    .RSTL(RSTL),
    .OUTPUT_SEND(OUTPUT_SEND),
    .addr(addr),
    .loop(loop),
    .pc(pc),
    .output_ec(output_ec),
    .cnt(cnt),
    .WADDRX(WADDRX),
    .COUNTER0(COUNTER0),
    .WCEBX(WCEBX),
    .OUTPUT_EN(OUTPUT_EN),
    .OUTPUT_EN_CTRL(OUTPUT_EN_CTRL)
  );

  parameter step = 10;

  initial begin
    CLK = 0;
    forever #(step) CLK = ~CLK;
  end

  initial begin
    pc = 0;
    #(step*3)
    forever #(step*2) pc = pc + 1;
  end

  initial begin
    RSTL = 0;
    OUTPUT_SEND = 0;
    addr = 16'd0; //SRAMの開始アドレス
    output_ec = 6'd0; //PBの開始列
    loop = 5; //ループ回数
    #(step*3)
    RSTL = 1;
    OUTPUT_SEND = 1;

    #step
    OUTPUT_SEND = 0;
  end

  // initial begin
  //   #(step*45) 
  //   OUTPUT_SEND = 1;
  //   #step
  //   OUTPUT_SEND = 0;
  // end

  initial begin
    #(step*100) $finish();
  end
  
  initial begin
    $dumpfile("output_send_test.vcd");
    $dumpvars(0, output_send_instance);
  end

endmodule