MCFILE = sandbox.mc

seq:
	ruby ./scripts/assembler.rb $(MCFILE) > memfile.dat
	iverilog IP2_TEST.v IP2.v SEQUENCER.v SEQUENCER_DEF.v MEMI.v SRAM.v ./module/wbuf/wbuf_send.v ./module/wbuf/wbuf_send_nopool.v ./module/wbuf/wbuf_send_pool.v ./module/output/output_send.v ./module/output/output_send_nopool.v ./module/output/output_send_pool.v ./module/cal/cal.v ./module/cal/conv_cal.v ./module/cal/fc_cal.v
	vvp a.out
	open wave.vcd

# seq2:
# 	ruby ./scripts/assembler.rb $(MCFILE) > memfile.dat
# 	python ./scripts/memBankMaker.py memfile.dat
# 	iverilog sequencer_new_test.v SEQUENCER_new.v SEQUENCER_DEF_new.v wbuf_send.v wbuf_send_nopool.v wbuf_send_pool.v output_send.v output_send_nopool.v output_send_pool.v cal.v conv_cal.v fc_cal.v
# 	vvp a.out
# 	open sequencer_new_test.vcd
