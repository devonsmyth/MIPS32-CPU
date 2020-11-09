# restart the simulation
restart

# Forcing A and B
add_force MemoryDataIn -radix hex 20000005

#forcing a clock with 10 ns period
add_force clock 1 {0 5ns} -repeat_every 10ns

#give a reset signal
add_force reset 0
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 42 ns

add_force MemoryDataIn -radix hex 2001000A

run 40 ns

add_force MemoryDataIn -radix hex 00201021

run 42 ns



