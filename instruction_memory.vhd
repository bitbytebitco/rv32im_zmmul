library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity instruction_memory is
	port(
		in_addr: in std_logic_vector(31 downto 0);
		out_inst : out std_logic_vector(31 downto 0)
	);
end entity;

architecture instruction_memory_arch of instruction_memory is 
    -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF in_addr : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF out_inst : SIGNAL IS "true";

    -- Mnemonic Constant Declarations
    constant LUI : std_logic_vector(6 downto 0) := "0110111"; -- Load Upper Immediate : rd ? imm u, pc ? pc+4

    signal EN : std_logic;
    type rom_type is array (0 to 1023) of std_logic_vector(7 downto 0);

 	 constant ROM : rom_type := ( 
				0 => "00010011", -- addi x4, x0, 1 
				1 => "00000010",
				2 => "00010000",
				3 => "00000000",
				4 => "00010011", -- addi x2, x2, 1
				5 => "00000001",
				6 => "00010001",
				7 => "00000000",
				8 => "11100011", -- bltu x2, x4, -4    
				9 => "01101110",
				10 => "01000001",
				11 => "11111110",
				12 => "00010011", -- xori x8, x8, 0xFFFFFFFF      OLD: xori x3, x3, 0xFFFFFFFF      
				13 => "01000100",
				14 => "11110100",
				15 => "11111111",
				16 => "00100011", -- sw x8, 0(x5)
				17 => "10100000",
				18 => "10000010",
				19 => "00000000",
				20 => "00010011", -- addi x2, x2, -1        
				21 => "00000001",
				22 => "11110001",
				23 => "11111111",
				24 => "11100011", -- bltu x2, x4, -24                   
				25 => "01100100",
				26 => "01000001",
				27 => "11111110",
				others => x"00");	
	 
--	 constant ROM : rom_type := ( 
--				0 => "00110011", -- [3 downto 0] : 1st instruction : ADD x3,x0,x1
--				1 => "00000001",
--				2 => "00010000",
--				3 => "00000000",
--				4 => "10110011", -- [7 downto 4] : 2nd instruction : SUB x4,x3,x1
--				5 => "00000001",
--				6 => "00000001",
--				7 => "01000000",
--				8 => "10110011", -- [12 downto 8] : 3rd instruction : SLTU x4,x3,x1
--				9 => "10110001",
--				10 => "00100001",
--				11 => "00000000",
--				12 => "10110011", -- [12 downto 15] : 4th instruction : SLL x4,x4,x1
--				13 => "00010001",
--				14 => "00010001",
--				15 => "00000000",
--				16 => "10110011", -- [19 downto 16] : 5th instruction : XOR x4,x0,x1
--				17 => "01000001",
--				18 => "00010000",
--				19 => "00000000",
--				20 => "10110011", -- [23 downto 20] : 6th instruction : SRL x4,x4,x1
--				21 => "11010001",
--				22 => "00010001",
--				23 => "00000000",
--				24 => "10110011", -- [27 downto 24] : 7th instruction : SRA x4,x4,x1
--				25 => "11010001",
--				26 => "00010001",
--				27 => "01000000",
--				28 => "10110011", -- [31 downto 28] : 8th instruction : OR x4,x4,x1
--				29 => "11100001",
--				30 => "00010001",
--				31 => "00000000",
--				32 => "10110011", -- [35 downto 32] : 9th instruction : AND x4,x4,x1
--				33 => "01110001",
--				34 => "00010001",
--				35 => "00000000",
--				36 => "00110111", -- [39 downto 36] : 10th instruction : LUI x5,xF0001
--				37 => "00010010",
--				38 => "00000000",
--				39 => "11110000",
--				40 => "00010111", -- [43 downto 40] : 11th instruction : AUIPC x5,xF0001
--				41 => "00010010",
--				42 => "00000000",
--				43 => "00000000",
--				44 => "00010011", -- [47 downto 44] : 12th instruction : ADDI x5,x1,xAAAAA
--				45 => "00000010",
--				46 => "10100001",
--				47 => "10101010",
--				48 => "00010011", -- [51 downto 48] : 13th instruction : SLTI x5,x1,xAAAAA
--				49 => "00100010",
--				50 => "10100001",
--				51 => "10101010",
--				52 => "00010011", -- [55 downto 52] : 14th instruction : SLTIU x5,x1,xAAAAA
--				53 => "00110010",
--				54 => "10100001",
--				55 => "10101010",
--				56 => "00010011", -- [59 downto 56] : 15th instruction : XORI x5,x1,xAAAAA
--				57 => "01000010",
--				58 => "10100001",
--				59 => "10101010",
--				60 => "00010011", -- [63 downto 60] : 16th instruction : ORI x5,x1,xAAAAA
--				61 => "01100010",
--				62 => "10100001",
--				63 => "10101010",
--				64 => "00010011", -- [67 downto 64] : 17th instruction : ANDI x5,x1,xAAAAA
--				65 => "01110010",
--				66 => "10100001",
--				67 => "10101010",
--				68 => "00010011", -- [71 downto 68] : 18th instruction : SLLI x5,x5,x00002
--				69 => "00010010",
--				70 => "00100001",
--				71 => "00000000",
--				72 => "00010011", -- SRLI x5,x3,x00002
--				73 => "01010010",
--				74 => "00100001",
--				75 => "00000000",
--				76 => "00010011", -- SRAI x5,x3,x00002
--				77 => "01010010",
--				78 => "00100001",
--				79 => "01000000",
--				80 => "01100111", -- JALR x4,0x00000
--				81 => "00000010",
--				82 => "00000000",
--				83 => "00000000",
--				84 => "00110011", -- MUL rd,rs1,rs2  ||  rd ← ux(rs1) × ux(rs2)
--				85 => "10000001",
--				86 => "00010010",
--				87 => "00000010",
--				88 => "00010011", -- ADDI x8, zero, 2047
--				89 => "00000011",
--				90 => "11110000",
--				91 => "01111111",
--				92 => "00100011", -- SW x1,1024(x0)
--				93 => "00100000",
--				94 => "00010000",
--				95 => "01000000",
--				96 => "00100011", -- SH x1,1028(x0)
--				97 => "00010010",
--				98 => "00010000",
--				99 => "01000000",
--				100 => "00100011", -- SB x1,1032(x0)
--				101 => "00000011",
--				102 => "00010000",
--				103 => "01000000",
--				104 => "00000011", -- lb x2,1024(x0)
--				105 => "00000001",
--				106 => "00000000",
--				107 => "01000000",
--				108 => "00000011", -- lh x2,1024(x0)
--				109 => "00010001",
--				110 => "00000000",
--				111 => "01000000",
--				112 => "00000011", -- lw x2,1024(x0)
--				113 => "00100001",
--				114 => "00000000",
--				115 => "01000000",
--				116 => "00000011", -- LBU x2,1024(x0)
--				117 => "01000001",
--				118 => "00000000",
--				119 => "01000000",
--				120 => "00000011", -- LHU x2,1024(x0)
--				121 => "01010001",
--				122 => "00000000",
--				123 => "01000000",
--				124 => "00100011", -- SW x1,0(x6)
--				125 => "10100000",
--				126 => "00010011",
--				127 => "00000000",
--				others => x"00");	
    begin
        -- Enable Process
        enable : process(in_addr)
          begin
            if(to_integer(unsigned(in_addr)) >= 0) and (to_integer(unsigned(in_addr)) <= 1023) then
                EN <= '1';
            else 
                EN <= '0';
            end if;
        end process;
    
        -- Memory Process
        memory : process(in_addr)
          begin
            out_inst <= ROM(to_integer(unsigned(in_addr))+3) & ROM(to_integer(unsigned(in_addr))+2) & ROM(to_integer(unsigned(in_addr))+1) & ROM(to_integer(unsigned(in_addr)));
        end process;

end architecture;
