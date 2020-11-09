
#Basic
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {00EB5824}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {ACEB000F}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {00000000}
#add_force {/cpu_tb/U_1/mw_U_0ram_table[8]} -radix hex {00000000}

#give a reset signal
add_force reset 0
run 2500ps

add_force reset 1
run 5 ns
add_force reset 0

run 300 ns


# TEST1
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {00EB5824}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {ACEB000F}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {20070011}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {200BFFFD}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {00EB5822}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {aceb000f}

#give a reset signal
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 500 ns


# TEST 2
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {00075843}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {aceb000f}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {00000000}

#give a reset signal
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 500 ns


# TEST 3
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {3C011001}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {342D0020}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {2009FFD3}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {71205021}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {ADAA0000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {00000000}

#give a reset signal
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 500 ns

# TEST 4
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {3C011001}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {3403FF0F}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {AC230020}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {3405BBBB}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {8C220020}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {00452024}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {AC240024}

#give a reset signal
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 500 ns

#Test 5
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {200BFFFD}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {05700003}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {08000007}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {03E00008}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {00000000}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {AC1F0020}

#give a reset signal
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 500ns

