MCFILE = sandbox.mc

comp:
	vcs -cm line+tgl+cond +incdir+../../HDL/IP2/ IP2_TEST.v ../../HDL/IP2/IP2.v ../../HDL/IP2/SEQUENCER_CTRL.v ../../HDL/IP2/MEM_AXIS.v ../../HDL/IP2/AXIS_MEM.v ../../HDL/IP2/MEMI.v ../../HDL/IP2/MEMW.v ../../HDL/IP2/MEMX.v ../../HDL/IP2/SRAM.v ../../HDL/IP2/SEQUENCER_DEF.v ../../HDL/IP2/SEQUENCER.v ../../HDL/IP2/PB_ARRAY32x32_PLUS.v ../../HDL/IP2/PB_ARRAY32x32.v ../../HDL/IP2/PB_ARRAY32x1.v ../../HDL/IP2/PB_ARRAY16x1.v ../../HDL/IP2/PB.v ../../HDL/IP2/INPUT_CTRL.v ../../HDL/IP2/WEIGHT_CTRL.v ../../HDL/IP2/OUTPUT_CTRL.v ../../HDL/IP2/PE8.v ../../HDL/IP2/COMPARATORx32.v ../../HDL/IP2/COMPARATOR.v ../../HDL/IP2/OUTPUT_DECODER.v ../../HDL/IP2/WEIGHT_DECODERx32.v ../../HDL/IP2/WEIGHT_DECODER.v ../../HDL/IP2/WBUF_DECODER.v
	./simv

seq:
	ruby ./scripts/assembler.rb $(MCFILE) > memfile.dat
	iverilog IP2_TEST.v IP2.v SEQUENCER_new.v SEQUENCER_DEF_new.v MEMI.v SRAM.v ./module/wbuf/wbuf_send.v ./module/wbuf/wbuf_send_nopool.v ./module/wbuf/wbuf_send_pool.v ./module/output/output_send.v ./module/output/output_send_nopool.v ./module/output/output_send_pool.v ./module/cal/cal.v ./module/cal/conv_cal.v ./module/cal/fc_cal.v
	vvp a.out
	open wave.vcd

seq2:
	ruby ./scripts/assembler.rb $(MCFILE) > memfile.dat
	python ./scripts/memBankMaker.py memfile.dat
	iverilog sequencer_new_test.v SEQUENCER_new.v SEQUENCER_DEF_new.v wbuf_send.v wbuf_send_nopool.v wbuf_send_pool.v output_send.v output_send_nopool.v output_send_pool.v cal.v conv_cal.v fc_cal.v
	vvp a.out
	open sequencer_new_test.vcd

cover:
	urg -dir simv.vdb -metric line+tgl+cond
	firefox urgReport/dashboard.html &

order:
	python ../scripts/code_to_correct_order.py $(MCFILE)

order1:
	python ../scripts/code_to_correct_order.py conv1.mc

order2:
	python ../scripts/code_to_correct_order.py conv2.mc -l 51

order3:
	python ../scripts/code_to_correct_order.py conv3.mc -l 129

order4:
	python ../scripts/code_to_correct_order.py conv4.mc -l 355