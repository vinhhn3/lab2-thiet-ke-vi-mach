flipflop:
	vhdlan -kdb -nc ../src/flipflops.vhd
	vhdlan -kdb -nc ../tb/flipflops_tb.vhd
	vcs -nc -kdb -debug_access+all flipflops_tb
	./simv -nc -ucli -do scripts/flipflops_tb.tcl
	verdi -nc -warn none -ssf flipflops_tb.fsdb
accumulator:
	vhdlan -kdb -nc ../src/accumulator.vhd
	vhdlan -kdb -nc ../tb/accumulator_tb.vhd
	vcs -nc -kdb -debug_access+all accumulator_tb
	./simv -nc -ucli -do scripts/accumulator_tb.tcl
	verdi -nc -ssf accumulator_tb.fsdb
mac:
	vhdlan -kdb -nc ../src/mac.vhd
	vhdlan -kdb -nc ../tb/mac_tb.vhd
	vcs -nc -kdb -debug_access+all mac_tb
	./simv -nc -ucli -do scripts/mac_tb.tcl
	verdi -nc -warn none -ssf mac_tb.fsdb
.PHONY: clean
clean:
	-rm -rf 64 csrc simv simv.* ucli.key novas* verdi* DVE* work.lib* *.fsdb
