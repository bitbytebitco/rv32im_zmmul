# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
#create_clock -name clk -period 10 [get_ports clk]
create_clock -period 20.000 -name CLK -add [get_ports CLK]

set_property PACKAGE_PIN R3 [get_ports RST]
set_property IOSTANDARD LVCMOS33 [get_ports RST]

## PMOD JA
set_property PACKAGE_PIN J1 [get_ports {JA[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[0]}]

set_property PACKAGE_PIN L2 [get_ports {JA[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[1]}]

set_property PACKAGE_PIN J2 [get_ports {JA[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[2]}]

set_property PACKAGE_PIN G2 [get_ports {JA[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]

set_property PACKAGE_PIN H1 [get_ports {JA[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]

set_property PACKAGE_PIN K2 [get_ports {JA[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]

set_property PACKAGE_PIN H2 [get_ports {JA[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]

set_property PACKAGE_PIN G3 [get_ports {JA[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]


set_property PACKAGE_PIN J3 [get_ports io_SCL]
set_property IOSTANDARD LVCMOS33 [get_ports io_SCL]
set_property PULLUP TRUE [get_ports io_SCL]

set_property PACKAGE_PIN L3 [get_ports io_SDA]
set_property IOSTANDARD LVCMOS33 [get_ports io_SDA]
set_property PULLUP TRUE [get_ports io_SDA]


## PMOD JX
#set_property PACKAGE_PIN J3 [get_ports {JX[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[0]}]

#set_property PACKAGE_PIN L3 [get_ports {i_SDA[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {i_SDA[1]}]

#set_property PACKAGE_PIN M2 [get_ports {JX[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[2]}]

#set_property PACKAGE_PIN N2 [get_ports {JX[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[3]}]

#set_property PACKAGE_PIN K3 [get_ports {JX[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[4]}]

#set_property PACKAGE_PIN M3 [get_ports {JX[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[5]}]

#set_property PACKAGE_PIN M1 [get_ports {JX[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[6]}]

#set_property PACKAGE_PIN N1 [get_ports {JX[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JX[7]}]


## LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]

## Switches
set_property PACKAGE_PIN V17 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]
set_property PACKAGE_PIN V16 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]
set_property PACKAGE_PIN W16 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}]
set_property PACKAGE_PIN W17 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[3]}]
set_property PACKAGE_PIN W15 [get_ports {SW[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[4]}]
set_property PACKAGE_PIN V15 [get_ports {SW[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[5]}]
set_property PACKAGE_PIN W14 [get_ports {SW[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[6]}]
set_property PACKAGE_PIN W13 [get_ports {SW[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[7]}]

# Anode Configuration for Display
#set_property PACKAGE_PIN W2 [get_ports {an_conf[0]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an_conf[0]}]
#set_property PACKAGE_PIN U1 [get_ports {an_conf[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an_conf[1]}]
#set_property PACKAGE_PIN T1 [get_ports {i_display[0]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {i_display[0]}]
#set_property PACKAGE_PIN R2 [get_ports {i_display[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {i_display[1]}]


## 7 segment display
#set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
#set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
#set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
#set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
#set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
#set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
#set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]


#set_property PACKAGE_PIN U2 [get_ports {an[0]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
#set_property PACKAGE_PIN U4 [get_ports {an[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
#set_property PACKAGE_PIN V4 [get_ports {an[2]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
#set_property PACKAGE_PIN W4 [get_ports {an[3]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]





create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list CLK_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {C0/CPU_0/DTA_PTH/DataB[0]} {C0/CPU_0/DTA_PTH/DataB[1]} {C0/CPU_0/DTA_PTH/DataB[2]} {C0/CPU_0/DTA_PTH/DataB[3]} {C0/CPU_0/DTA_PTH/DataB[4]} {C0/CPU_0/DTA_PTH/DataB[5]} {C0/CPU_0/DTA_PTH/DataB[6]} {C0/CPU_0/DTA_PTH/DataB[7]} {C0/CPU_0/DTA_PTH/DataB[8]} {C0/CPU_0/DTA_PTH/DataB[9]} {C0/CPU_0/DTA_PTH/DataB[10]} {C0/CPU_0/DTA_PTH/DataB[11]} {C0/CPU_0/DTA_PTH/DataB[12]} {C0/CPU_0/DTA_PTH/DataB[13]} {C0/CPU_0/DTA_PTH/DataB[14]} {C0/CPU_0/DTA_PTH/DataB[15]} {C0/CPU_0/DTA_PTH/DataB[16]} {C0/CPU_0/DTA_PTH/DataB[17]} {C0/CPU_0/DTA_PTH/DataB[18]} {C0/CPU_0/DTA_PTH/DataB[19]} {C0/CPU_0/DTA_PTH/DataB[20]} {C0/CPU_0/DTA_PTH/DataB[21]} {C0/CPU_0/DTA_PTH/DataB[22]} {C0/CPU_0/DTA_PTH/DataB[23]} {C0/CPU_0/DTA_PTH/DataB[24]} {C0/CPU_0/DTA_PTH/DataB[25]} {C0/CPU_0/DTA_PTH/DataB[26]} {C0/CPU_0/DTA_PTH/DataB[27]} {C0/CPU_0/DTA_PTH/DataB[28]} {C0/CPU_0/DTA_PTH/DataB[29]} {C0/CPU_0/DTA_PTH/DataB[30]} {C0/CPU_0/DTA_PTH/DataB[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {C0/CPU_0/DTA_PTH/PC[0]} {C0/CPU_0/DTA_PTH/PC[1]} {C0/CPU_0/DTA_PTH/PC[2]} {C0/CPU_0/DTA_PTH/PC[3]} {C0/CPU_0/DTA_PTH/PC[4]} {C0/CPU_0/DTA_PTH/PC[5]} {C0/CPU_0/DTA_PTH/PC[6]} {C0/CPU_0/DTA_PTH/PC[7]} {C0/CPU_0/DTA_PTH/PC[8]} {C0/CPU_0/DTA_PTH/PC[9]} {C0/CPU_0/DTA_PTH/PC[10]} {C0/CPU_0/DTA_PTH/PC[11]} {C0/CPU_0/DTA_PTH/PC[12]} {C0/CPU_0/DTA_PTH/PC[13]} {C0/CPU_0/DTA_PTH/PC[14]} {C0/CPU_0/DTA_PTH/PC[15]} {C0/CPU_0/DTA_PTH/PC[16]} {C0/CPU_0/DTA_PTH/PC[17]} {C0/CPU_0/DTA_PTH/PC[18]} {C0/CPU_0/DTA_PTH/PC[19]} {C0/CPU_0/DTA_PTH/PC[20]} {C0/CPU_0/DTA_PTH/PC[21]} {C0/CPU_0/DTA_PTH/PC[22]} {C0/CPU_0/DTA_PTH/PC[23]} {C0/CPU_0/DTA_PTH/PC[24]} {C0/CPU_0/DTA_PTH/PC[25]} {C0/CPU_0/DTA_PTH/PC[26]} {C0/CPU_0/DTA_PTH/PC[27]} {C0/CPU_0/DTA_PTH/PC[28]} {C0/CPU_0/DTA_PTH/PC[29]} {C0/CPU_0/DTA_PTH/PC[30]} {C0/CPU_0/DTA_PTH/PC[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {C0/CPU_0/DTA_PTH/o_address[0]} {C0/CPU_0/DTA_PTH/o_address[1]} {C0/CPU_0/DTA_PTH/o_address[2]} {C0/CPU_0/DTA_PTH/o_address[3]} {C0/CPU_0/DTA_PTH/o_address[4]} {C0/CPU_0/DTA_PTH/o_address[5]} {C0/CPU_0/DTA_PTH/o_address[6]} {C0/CPU_0/DTA_PTH/o_address[7]} {C0/CPU_0/DTA_PTH/o_address[8]} {C0/CPU_0/DTA_PTH/o_address[9]} {C0/CPU_0/DTA_PTH/o_address[10]} {C0/CPU_0/DTA_PTH/o_address[11]} {C0/CPU_0/DTA_PTH/o_address[12]} {C0/CPU_0/DTA_PTH/o_address[13]} {C0/CPU_0/DTA_PTH/o_address[14]} {C0/CPU_0/DTA_PTH/o_address[15]} {C0/CPU_0/DTA_PTH/o_address[16]} {C0/CPU_0/DTA_PTH/o_address[17]} {C0/CPU_0/DTA_PTH/o_address[18]} {C0/CPU_0/DTA_PTH/o_address[19]} {C0/CPU_0/DTA_PTH/o_address[20]} {C0/CPU_0/DTA_PTH/o_address[21]} {C0/CPU_0/DTA_PTH/o_address[22]} {C0/CPU_0/DTA_PTH/o_address[23]} {C0/CPU_0/DTA_PTH/o_address[24]} {C0/CPU_0/DTA_PTH/o_address[25]} {C0/CPU_0/DTA_PTH/o_address[26]} {C0/CPU_0/DTA_PTH/o_address[27]} {C0/CPU_0/DTA_PTH/o_address[28]} {C0/CPU_0/DTA_PTH/o_address[29]} {C0/CPU_0/DTA_PTH/o_address[30]} {C0/CPU_0/DTA_PTH/o_address[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {C0/CPU_0/DTA_PTH/to_memory[0]} {C0/CPU_0/DTA_PTH/to_memory[1]} {C0/CPU_0/DTA_PTH/to_memory[2]} {C0/CPU_0/DTA_PTH/to_memory[3]} {C0/CPU_0/DTA_PTH/to_memory[4]} {C0/CPU_0/DTA_PTH/to_memory[5]} {C0/CPU_0/DTA_PTH/to_memory[6]} {C0/CPU_0/DTA_PTH/to_memory[7]} {C0/CPU_0/DTA_PTH/to_memory[8]} {C0/CPU_0/DTA_PTH/to_memory[9]} {C0/CPU_0/DTA_PTH/to_memory[10]} {C0/CPU_0/DTA_PTH/to_memory[11]} {C0/CPU_0/DTA_PTH/to_memory[12]} {C0/CPU_0/DTA_PTH/to_memory[13]} {C0/CPU_0/DTA_PTH/to_memory[14]} {C0/CPU_0/DTA_PTH/to_memory[15]} {C0/CPU_0/DTA_PTH/to_memory[16]} {C0/CPU_0/DTA_PTH/to_memory[17]} {C0/CPU_0/DTA_PTH/to_memory[18]} {C0/CPU_0/DTA_PTH/to_memory[19]} {C0/CPU_0/DTA_PTH/to_memory[20]} {C0/CPU_0/DTA_PTH/to_memory[21]} {C0/CPU_0/DTA_PTH/to_memory[22]} {C0/CPU_0/DTA_PTH/to_memory[23]} {C0/CPU_0/DTA_PTH/to_memory[24]} {C0/CPU_0/DTA_PTH/to_memory[25]} {C0/CPU_0/DTA_PTH/to_memory[26]} {C0/CPU_0/DTA_PTH/to_memory[27]} {C0/CPU_0/DTA_PTH/to_memory[28]} {C0/CPU_0/DTA_PTH/to_memory[29]} {C0/CPU_0/DTA_PTH/to_memory[30]} {C0/CPU_0/DTA_PTH/to_memory[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {C0/CPU_0/DTA_PTH/wb[0]} {C0/CPU_0/DTA_PTH/wb[1]} {C0/CPU_0/DTA_PTH/wb[2]} {C0/CPU_0/DTA_PTH/wb[3]} {C0/CPU_0/DTA_PTH/wb[4]} {C0/CPU_0/DTA_PTH/wb[5]} {C0/CPU_0/DTA_PTH/wb[6]} {C0/CPU_0/DTA_PTH/wb[7]} {C0/CPU_0/DTA_PTH/wb[8]} {C0/CPU_0/DTA_PTH/wb[9]} {C0/CPU_0/DTA_PTH/wb[10]} {C0/CPU_0/DTA_PTH/wb[11]} {C0/CPU_0/DTA_PTH/wb[12]} {C0/CPU_0/DTA_PTH/wb[13]} {C0/CPU_0/DTA_PTH/wb[14]} {C0/CPU_0/DTA_PTH/wb[15]} {C0/CPU_0/DTA_PTH/wb[16]} {C0/CPU_0/DTA_PTH/wb[17]} {C0/CPU_0/DTA_PTH/wb[18]} {C0/CPU_0/DTA_PTH/wb[19]} {C0/CPU_0/DTA_PTH/wb[20]} {C0/CPU_0/DTA_PTH/wb[21]} {C0/CPU_0/DTA_PTH/wb[22]} {C0/CPU_0/DTA_PTH/wb[23]} {C0/CPU_0/DTA_PTH/wb[24]} {C0/CPU_0/DTA_PTH/wb[25]} {C0/CPU_0/DTA_PTH/wb[26]} {C0/CPU_0/DTA_PTH/wb[27]} {C0/CPU_0/DTA_PTH/wb[28]} {C0/CPU_0/DTA_PTH/wb[29]} {C0/CPU_0/DTA_PTH/wb[30]} {C0/CPU_0/DTA_PTH/wb[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {C0/MEM_MAPPER/r_port_out_00[0]} {C0/MEM_MAPPER/r_port_out_00[1]} {C0/MEM_MAPPER/r_port_out_00[2]} {C0/MEM_MAPPER/r_port_out_00[3]} {C0/MEM_MAPPER/r_port_out_00[4]} {C0/MEM_MAPPER/r_port_out_00[5]} {C0/MEM_MAPPER/r_port_out_00[6]} {C0/MEM_MAPPER/r_port_out_00[7]} {C0/MEM_MAPPER/r_port_out_00[8]} {C0/MEM_MAPPER/r_port_out_00[9]} {C0/MEM_MAPPER/r_port_out_00[10]} {C0/MEM_MAPPER/r_port_out_00[11]} {C0/MEM_MAPPER/r_port_out_00[12]} {C0/MEM_MAPPER/r_port_out_00[13]} {C0/MEM_MAPPER/r_port_out_00[14]} {C0/MEM_MAPPER/r_port_out_00[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {C0/MEM_MAPPER/i_data[0]} {C0/MEM_MAPPER/i_data[1]} {C0/MEM_MAPPER/i_data[2]} {C0/MEM_MAPPER/i_data[3]} {C0/MEM_MAPPER/i_data[4]} {C0/MEM_MAPPER/i_data[5]} {C0/MEM_MAPPER/i_data[6]} {C0/MEM_MAPPER/i_data[7]} {C0/MEM_MAPPER/i_data[8]} {C0/MEM_MAPPER/i_data[9]} {C0/MEM_MAPPER/i_data[10]} {C0/MEM_MAPPER/i_data[11]} {C0/MEM_MAPPER/i_data[12]} {C0/MEM_MAPPER/i_data[13]} {C0/MEM_MAPPER/i_data[14]} {C0/MEM_MAPPER/i_data[15]} {C0/MEM_MAPPER/i_data[16]} {C0/MEM_MAPPER/i_data[17]} {C0/MEM_MAPPER/i_data[18]} {C0/MEM_MAPPER/i_data[19]} {C0/MEM_MAPPER/i_data[20]} {C0/MEM_MAPPER/i_data[21]} {C0/MEM_MAPPER/i_data[22]} {C0/MEM_MAPPER/i_data[23]} {C0/MEM_MAPPER/i_data[24]} {C0/MEM_MAPPER/i_data[25]} {C0/MEM_MAPPER/i_data[26]} {C0/MEM_MAPPER/i_data[27]} {C0/MEM_MAPPER/i_data[28]} {C0/MEM_MAPPER/i_data[29]} {C0/MEM_MAPPER/i_data[30]} {C0/MEM_MAPPER/i_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {C0/CPU_0/DTA_PTH/IMEM/out_inst[0]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[1]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[2]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[3]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[4]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[5]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[6]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[7]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[8]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[9]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[10]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[11]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[12]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[13]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[14]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[15]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[16]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[17]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[18]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[19]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[20]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[21]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[22]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[23]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[24]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[25]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[26]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[27]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[28]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[29]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[30]} {C0/CPU_0/DTA_PTH/IMEM/out_inst[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {C0/CPU_0/DTA_PTH/IMEM/in_addr[0]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[1]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[2]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[3]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[4]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[5]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[6]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[7]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[8]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[9]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[10]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[11]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[12]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[13]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[14]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[15]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[16]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[17]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[18]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[19]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[20]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[21]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[22]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[23]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[24]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[25]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[26]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[27]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[28]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[29]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[30]} {C0/CPU_0/DTA_PTH/IMEM/in_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {C0/MEM_MAPPER/i_address[0]} {C0/MEM_MAPPER/i_address[1]} {C0/MEM_MAPPER/i_address[2]} {C0/MEM_MAPPER/i_address[3]} {C0/MEM_MAPPER/i_address[4]} {C0/MEM_MAPPER/i_address[5]} {C0/MEM_MAPPER/i_address[6]} {C0/MEM_MAPPER/i_address[7]} {C0/MEM_MAPPER/i_address[8]} {C0/MEM_MAPPER/i_address[9]} {C0/MEM_MAPPER/i_address[10]} {C0/MEM_MAPPER/i_address[11]} {C0/MEM_MAPPER/i_address[12]} {C0/MEM_MAPPER/i_address[13]} {C0/MEM_MAPPER/i_address[14]} {C0/MEM_MAPPER/i_address[15]} {C0/MEM_MAPPER/i_address[16]} {C0/MEM_MAPPER/i_address[17]} {C0/MEM_MAPPER/i_address[18]} {C0/MEM_MAPPER/i_address[19]} {C0/MEM_MAPPER/i_address[20]} {C0/MEM_MAPPER/i_address[21]} {C0/MEM_MAPPER/i_address[22]} {C0/MEM_MAPPER/i_address[23]} {C0/MEM_MAPPER/i_address[24]} {C0/MEM_MAPPER/i_address[25]} {C0/MEM_MAPPER/i_address[26]} {C0/MEM_MAPPER/i_address[27]} {C0/MEM_MAPPER/i_address[28]} {C0/MEM_MAPPER/i_address[29]} {C0/MEM_MAPPER/i_address[30]} {C0/MEM_MAPPER/i_address[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list C0/w_clk_div]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets CLK_IBUF_BUFG]
