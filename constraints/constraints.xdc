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
set_property PULLUP true [get_ports io_SCL]

set_property PACKAGE_PIN L3 [get_ports io_SDA]
set_property IOSTANDARD LVCMOS33 [get_ports io_SDA]
set_property PULLUP true [get_ports io_SDA]


##USB-RS232 Interface
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports i_uart_rx]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports o_uart_tx]


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










connect_debug_port u_ila_0/probe7 [get_nets [list C0/MEM_MAPPER/byte_cnt]]

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
connect_debug_port u_ila_0/probe0 [get_nets [list {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[0]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[1]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[2]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[3]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[4]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[5]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[6]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[7]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[8]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[9]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[10]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[11]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[12]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[13]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[14]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[15]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[16]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[17]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[18]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[19]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[20]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[21]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[22]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[23]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[24]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[25]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[26]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[27]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[28]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[29]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[30]} {C0/CPU_0/DTA_PTH/REG_FILE/r_register_2_debug[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 2 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {C0/MEM_MAPPER/bcnt[0]} {C0/MEM_MAPPER/bcnt[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 9 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {C0/MEM_MAPPER/byte_cnt[0]} {C0/MEM_MAPPER/byte_cnt[1]} {C0/MEM_MAPPER/byte_cnt[2]} {C0/MEM_MAPPER/byte_cnt[3]} {C0/MEM_MAPPER/byte_cnt[4]} {C0/MEM_MAPPER/byte_cnt[5]} {C0/MEM_MAPPER/byte_cnt[6]} {C0/MEM_MAPPER/byte_cnt[7]} {C0/MEM_MAPPER/byte_cnt[8]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {C0/MEM_MAPPER/i_PC[0]} {C0/MEM_MAPPER/i_PC[1]} {C0/MEM_MAPPER/i_PC[2]} {C0/MEM_MAPPER/i_PC[3]} {C0/MEM_MAPPER/i_PC[4]} {C0/MEM_MAPPER/i_PC[5]} {C0/MEM_MAPPER/i_PC[6]} {C0/MEM_MAPPER/i_PC[7]} {C0/MEM_MAPPER/i_PC[8]} {C0/MEM_MAPPER/i_PC[9]} {C0/MEM_MAPPER/i_PC[10]} {C0/MEM_MAPPER/i_PC[11]} {C0/MEM_MAPPER/i_PC[12]} {C0/MEM_MAPPER/i_PC[13]} {C0/MEM_MAPPER/i_PC[14]} {C0/MEM_MAPPER/i_PC[15]} {C0/MEM_MAPPER/i_PC[16]} {C0/MEM_MAPPER/i_PC[17]} {C0/MEM_MAPPER/i_PC[18]} {C0/MEM_MAPPER/i_PC[19]} {C0/MEM_MAPPER/i_PC[20]} {C0/MEM_MAPPER/i_PC[21]} {C0/MEM_MAPPER/i_PC[22]} {C0/MEM_MAPPER/i_PC[23]} {C0/MEM_MAPPER/i_PC[24]} {C0/MEM_MAPPER/i_PC[25]} {C0/MEM_MAPPER/i_PC[26]} {C0/MEM_MAPPER/i_PC[27]} {C0/MEM_MAPPER/i_PC[28]} {C0/MEM_MAPPER/i_PC[29]} {C0/MEM_MAPPER/i_PC[30]} {C0/MEM_MAPPER/i_PC[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {C0/MEM_MAPPER/o_data[0]} {C0/MEM_MAPPER/o_data[1]} {C0/MEM_MAPPER/o_data[2]} {C0/MEM_MAPPER/o_data[3]} {C0/MEM_MAPPER/o_data[4]} {C0/MEM_MAPPER/o_data[5]} {C0/MEM_MAPPER/o_data[6]} {C0/MEM_MAPPER/o_data[7]} {C0/MEM_MAPPER/o_data[8]} {C0/MEM_MAPPER/o_data[9]} {C0/MEM_MAPPER/o_data[10]} {C0/MEM_MAPPER/o_data[11]} {C0/MEM_MAPPER/o_data[12]} {C0/MEM_MAPPER/o_data[13]} {C0/MEM_MAPPER/o_data[14]} {C0/MEM_MAPPER/o_data[15]} {C0/MEM_MAPPER/o_data[16]} {C0/MEM_MAPPER/o_data[17]} {C0/MEM_MAPPER/o_data[18]} {C0/MEM_MAPPER/o_data[19]} {C0/MEM_MAPPER/o_data[20]} {C0/MEM_MAPPER/o_data[21]} {C0/MEM_MAPPER/o_data[22]} {C0/MEM_MAPPER/o_data[23]} {C0/MEM_MAPPER/o_data[24]} {C0/MEM_MAPPER/o_data[25]} {C0/MEM_MAPPER/o_data[26]} {C0/MEM_MAPPER/o_data[27]} {C0/MEM_MAPPER/o_data[28]} {C0/MEM_MAPPER/o_data[29]} {C0/MEM_MAPPER/o_data[30]} {C0/MEM_MAPPER/o_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {C0/MEM_MAPPER/i_data[0]} {C0/MEM_MAPPER/i_data[1]} {C0/MEM_MAPPER/i_data[2]} {C0/MEM_MAPPER/i_data[3]} {C0/MEM_MAPPER/i_data[4]} {C0/MEM_MAPPER/i_data[5]} {C0/MEM_MAPPER/i_data[6]} {C0/MEM_MAPPER/i_data[7]} {C0/MEM_MAPPER/i_data[8]} {C0/MEM_MAPPER/i_data[9]} {C0/MEM_MAPPER/i_data[10]} {C0/MEM_MAPPER/i_data[11]} {C0/MEM_MAPPER/i_data[12]} {C0/MEM_MAPPER/i_data[13]} {C0/MEM_MAPPER/i_data[14]} {C0/MEM_MAPPER/i_data[15]} {C0/MEM_MAPPER/i_data[16]} {C0/MEM_MAPPER/i_data[17]} {C0/MEM_MAPPER/i_data[18]} {C0/MEM_MAPPER/i_data[19]} {C0/MEM_MAPPER/i_data[20]} {C0/MEM_MAPPER/i_data[21]} {C0/MEM_MAPPER/i_data[22]} {C0/MEM_MAPPER/i_data[23]} {C0/MEM_MAPPER/i_data[24]} {C0/MEM_MAPPER/i_data[25]} {C0/MEM_MAPPER/i_data[26]} {C0/MEM_MAPPER/i_data[27]} {C0/MEM_MAPPER/i_data[28]} {C0/MEM_MAPPER/i_data[29]} {C0/MEM_MAPPER/i_data[30]} {C0/MEM_MAPPER/i_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {C0/MEM_MAPPER/r_fp_A[0]} {C0/MEM_MAPPER/r_fp_A[1]} {C0/MEM_MAPPER/r_fp_A[2]} {C0/MEM_MAPPER/r_fp_A[3]} {C0/MEM_MAPPER/r_fp_A[4]} {C0/MEM_MAPPER/r_fp_A[5]} {C0/MEM_MAPPER/r_fp_A[6]} {C0/MEM_MAPPER/r_fp_A[7]} {C0/MEM_MAPPER/r_fp_A[8]} {C0/MEM_MAPPER/r_fp_A[9]} {C0/MEM_MAPPER/r_fp_A[10]} {C0/MEM_MAPPER/r_fp_A[11]} {C0/MEM_MAPPER/r_fp_A[12]} {C0/MEM_MAPPER/r_fp_A[13]} {C0/MEM_MAPPER/r_fp_A[14]} {C0/MEM_MAPPER/r_fp_A[15]} {C0/MEM_MAPPER/r_fp_A[16]} {C0/MEM_MAPPER/r_fp_A[17]} {C0/MEM_MAPPER/r_fp_A[18]} {C0/MEM_MAPPER/r_fp_A[19]} {C0/MEM_MAPPER/r_fp_A[20]} {C0/MEM_MAPPER/r_fp_A[21]} {C0/MEM_MAPPER/r_fp_A[22]} {C0/MEM_MAPPER/r_fp_A[23]} {C0/MEM_MAPPER/r_fp_A[24]} {C0/MEM_MAPPER/r_fp_A[25]} {C0/MEM_MAPPER/r_fp_A[26]} {C0/MEM_MAPPER/r_fp_A[27]} {C0/MEM_MAPPER/r_fp_A[28]} {C0/MEM_MAPPER/r_fp_A[29]} {C0/MEM_MAPPER/r_fp_A[30]} {C0/MEM_MAPPER/r_fp_A[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {C0/MEM_MAPPER/r_fp_B[0]} {C0/MEM_MAPPER/r_fp_B[1]} {C0/MEM_MAPPER/r_fp_B[2]} {C0/MEM_MAPPER/r_fp_B[3]} {C0/MEM_MAPPER/r_fp_B[4]} {C0/MEM_MAPPER/r_fp_B[5]} {C0/MEM_MAPPER/r_fp_B[6]} {C0/MEM_MAPPER/r_fp_B[7]} {C0/MEM_MAPPER/r_fp_B[8]} {C0/MEM_MAPPER/r_fp_B[9]} {C0/MEM_MAPPER/r_fp_B[10]} {C0/MEM_MAPPER/r_fp_B[11]} {C0/MEM_MAPPER/r_fp_B[12]} {C0/MEM_MAPPER/r_fp_B[13]} {C0/MEM_MAPPER/r_fp_B[14]} {C0/MEM_MAPPER/r_fp_B[15]} {C0/MEM_MAPPER/r_fp_B[16]} {C0/MEM_MAPPER/r_fp_B[17]} {C0/MEM_MAPPER/r_fp_B[18]} {C0/MEM_MAPPER/r_fp_B[19]} {C0/MEM_MAPPER/r_fp_B[20]} {C0/MEM_MAPPER/r_fp_B[21]} {C0/MEM_MAPPER/r_fp_B[22]} {C0/MEM_MAPPER/r_fp_B[23]} {C0/MEM_MAPPER/r_fp_B[24]} {C0/MEM_MAPPER/r_fp_B[25]} {C0/MEM_MAPPER/r_fp_B[26]} {C0/MEM_MAPPER/r_fp_B[27]} {C0/MEM_MAPPER/r_fp_B[28]} {C0/MEM_MAPPER/r_fp_B[29]} {C0/MEM_MAPPER/r_fp_B[30]} {C0/MEM_MAPPER/r_fp_B[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {C0/MEM_MAPPER/r_fp_result[0]} {C0/MEM_MAPPER/r_fp_result[1]} {C0/MEM_MAPPER/r_fp_result[2]} {C0/MEM_MAPPER/r_fp_result[3]} {C0/MEM_MAPPER/r_fp_result[4]} {C0/MEM_MAPPER/r_fp_result[5]} {C0/MEM_MAPPER/r_fp_result[6]} {C0/MEM_MAPPER/r_fp_result[7]} {C0/MEM_MAPPER/r_fp_result[8]} {C0/MEM_MAPPER/r_fp_result[9]} {C0/MEM_MAPPER/r_fp_result[10]} {C0/MEM_MAPPER/r_fp_result[11]} {C0/MEM_MAPPER/r_fp_result[12]} {C0/MEM_MAPPER/r_fp_result[13]} {C0/MEM_MAPPER/r_fp_result[14]} {C0/MEM_MAPPER/r_fp_result[15]} {C0/MEM_MAPPER/r_fp_result[16]} {C0/MEM_MAPPER/r_fp_result[17]} {C0/MEM_MAPPER/r_fp_result[18]} {C0/MEM_MAPPER/r_fp_result[19]} {C0/MEM_MAPPER/r_fp_result[20]} {C0/MEM_MAPPER/r_fp_result[21]} {C0/MEM_MAPPER/r_fp_result[22]} {C0/MEM_MAPPER/r_fp_result[23]} {C0/MEM_MAPPER/r_fp_result[24]} {C0/MEM_MAPPER/r_fp_result[25]} {C0/MEM_MAPPER/r_fp_result[26]} {C0/MEM_MAPPER/r_fp_result[27]} {C0/MEM_MAPPER/r_fp_result[28]} {C0/MEM_MAPPER/r_fp_result[29]} {C0/MEM_MAPPER/r_fp_result[30]} {C0/MEM_MAPPER/r_fp_result[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {C0/MEM_MAPPER/r_imem_data[0]} {C0/MEM_MAPPER/r_imem_data[1]} {C0/MEM_MAPPER/r_imem_data[2]} {C0/MEM_MAPPER/r_imem_data[3]} {C0/MEM_MAPPER/r_imem_data[4]} {C0/MEM_MAPPER/r_imem_data[5]} {C0/MEM_MAPPER/r_imem_data[6]} {C0/MEM_MAPPER/r_imem_data[7]} {C0/MEM_MAPPER/r_imem_data[8]} {C0/MEM_MAPPER/r_imem_data[9]} {C0/MEM_MAPPER/r_imem_data[10]} {C0/MEM_MAPPER/r_imem_data[11]} {C0/MEM_MAPPER/r_imem_data[12]} {C0/MEM_MAPPER/r_imem_data[13]} {C0/MEM_MAPPER/r_imem_data[14]} {C0/MEM_MAPPER/r_imem_data[15]} {C0/MEM_MAPPER/r_imem_data[16]} {C0/MEM_MAPPER/r_imem_data[17]} {C0/MEM_MAPPER/r_imem_data[18]} {C0/MEM_MAPPER/r_imem_data[19]} {C0/MEM_MAPPER/r_imem_data[20]} {C0/MEM_MAPPER/r_imem_data[21]} {C0/MEM_MAPPER/r_imem_data[22]} {C0/MEM_MAPPER/r_imem_data[23]} {C0/MEM_MAPPER/r_imem_data[24]} {C0/MEM_MAPPER/r_imem_data[25]} {C0/MEM_MAPPER/r_imem_data[26]} {C0/MEM_MAPPER/r_imem_data[27]} {C0/MEM_MAPPER/r_imem_data[28]} {C0/MEM_MAPPER/r_imem_data[29]} {C0/MEM_MAPPER/r_imem_data[30]} {C0/MEM_MAPPER/r_imem_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list C0/MEM_MAPPER/w_imem_dv]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list C0/MEM_MAPPER/w_imem_rw]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets CLK_IBUF_BUFG]
