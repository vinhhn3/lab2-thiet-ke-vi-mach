dump -file accumulator_tb.fsdb -type fsdb
dump -add / -aggregates
run 10000ns
exit
