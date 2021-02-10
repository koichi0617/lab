module IP2_TEST;

parameter STEP = 10;
reg CLK, RSTL;
reg [13:0] WADDRI;
reg BANKI;
reg [255:0] DI;
reg WCEBI;

always begin
    CLK = 1; #(STEP/2);
    CLK = 0; #(STEP/2);
end

IP2 ip2_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .PURGE(PURGE),
    .WADDRI(WADDRI),
    .BANKI(BANKI),
    .WCEBI(WCEBI),
    .DI(DI)
);

initial begin
        $display("Start loading memory");
        $dumpfile("wave.vcd");
        $dumpvars(0, ip2_0);
        $readmemb("memfile.dat", ip2_0.sequencer_0.memi_0.bank0_ram0.ram);
        $readmemb("memfile.dat", ip2_0.sequencer_0.memi_0.bank1_ram1.ram);
        $readmemb("memfile.dat", ip2_0.sequencer_0.memi_0.bank1_ram0.ram);
        $readmemb("memfile.dat", ip2_0.sequencer_0.memi_0.bank0_ram1.ram);

        RSTL = 0;
        WADDRI = 0;
        BANKI = 0;
        DI = 0;
        WCEBI = 0;

        #(STEP+1)
            RSTL = 1;


        #(STEP * 20000)
                $dumpflush;
        #STEP   $finish;
end

endmodule
