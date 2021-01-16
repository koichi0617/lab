MCFILE = sandbox.mc

comp:
	vcs -cm line+tgl+cond +incdir+../../HDL/IP2/ IP2_TEST.v ../../HDL/IP2/IP2.v ../../HDL/IP2/SEQUENCER_CTRL.v ../../HDL/IP2/MEM_AXIS.v ../../HDL/IP2/AXIS_MEM.v ../../HDL/IP2/MEMI.v ../../HDL/IP2/MEMW.v ../../HDL/IP2/MEMX.v ../../HDL/IP2/SRAM.v ../../HDL/IP2/SEQUENCER_DEF.v ../../HDL/IP2/SEQUENCER.v ../../HDL/IP2/PB_ARRAY32x32_PLUS.v ../../HDL/IP2/PB_ARRAY32x32.v ../../HDL/IP2/PB_ARRAY32x1.v ../../HDL/IP2/PB_ARRAY16x1.v ../../HDL/IP2/PB.v ../../HDL/IP2/INPUT_CTRL.v ../../HDL/IP2/WEIGHT_CTRL.v ../../HDL/IP2/OUTPUT_CTRL.v ../../HDL/IP2/PE8.v ../../HDL/IP2/COMPARATORx32.v ../../HDL/IP2/COMPARATOR.v ../../HDL/IP2/OUTPUT_DECODER.v ../../HDL/IP2/WEIGHT_DECODERx32.v ../../HDL/IP2/WEIGHT_DECODER.v ../../HDL/IP2/WBUF_DECODER.v
	./simv

seq:
	ruby ./scripts/assembler.rb $(MCFILE) > memfile.dat
	python ./scripts/memBankMaker.py memfile.dat
	iverilog sequencer_test.v SEQUENCER.v
	vvp a.out
	open sequencer_test.vcd

seq2:
	ruby ./scripts/assembler.rb $(MCFILE) > memfile.dat
	python ./scripts/memBankMaker.py memfile.dat
	iverilog sequencer_new_test.v SEQUENCER_new.v SEQUENCER_DEF_new.v wbuf_send.v
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