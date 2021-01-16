`timescale	100ps/100ps

module sequencer_test;

parameter STEP = 50;

reg clk,rstn,purge;
reg [255:0] q;
wire [15:0] a;
wire [31:0] pc;
wire ceb;
reg [255:0] memory [0:1000]; //[ビット幅] レジスタ [ワード長] 

always begin
    clk = 1; #(STEP/2);
    clk = 0; #(STEP/2);
end

//assign q = (!ceb) ? memory[{2'b0,a[14:1]}] : 255'b0;
always @(posedge clk) begin
    if (!ceb) q <= memory[{2'b0,a[14:1]}];
    else q <= 255'b0;
end

SEQUENCER SEQUENCER_0(
.CLK(clk),
.RSTL(rstn),
.PURGE(purge),
.QI(q),
.RADDRI(a),
.RCEBI(ceb)
);

initial begin
    $dumpfile("sequencer_test.vcd"); //dumpファイルの名前を指定
    $dumpvars(0, SEQUENCER_0); //dumpを取る対象指定
    $readmemb("memfile.dat", memory); //memoryにmemfile.datを書き込み

    rstn = 0;
    purge = 0;

    #(STEP * 2 + 1)
                rstn = 1;

    #STEP
                purge = 0;

    #(STEP * 20000) 
            $dumpflush; //dumpファイルのバッファをクリア
    #STEP   $finish;

end

endmodule