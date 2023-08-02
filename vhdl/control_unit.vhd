library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

entity control_unit is
	port(
		out_PCSel : out std_logic;
		out_incr_pc : out std_logic;
		in_inst : in std_logic_vector(31 downto 0);
		out_ImmSel : out std_logic_vector(2 downto 0);
		out_RegWEn : out std_logic;
		out_BrUn : out std_logic;
		in_BrEq : in std_logic;
		in_BrLT: in std_logic;
		out_BSel : out std_logic;
		out_ASel : out std_logic;
		out_ALUSel : out std_logic_vector(3 downto 0);
		out_MemRW : out std_logic; 
		out_ByteSel : out std_logic_vector(2 downto 0);
		out_WBSel : out std_logic_vector(1 downto 0) 
	);
end entity;



architecture control_unit_arch of control_unit is
    -- Mnemonic Constant Declarations
    constant LUI : std_logic_vector(6 downto 0) := "0110111"; -- Load Upper Immediate : rd ? imm u, pc ? pc+4
    constant AUIPC : std_logic_vector(6 downto 0) := "0010111"; -- Add Upper Immediate to PC : rd ? pc + imm u, pc ? pc+4
    constant JAL : std_logic_vector(6 downto 0) := "1101111";
    constant RTYPE : std_logic_vector(6 downto 0) := "0110011";
    constant ITYPE_ARITH : std_logic_vector(6 downto 0) := "0010011";
    constant ITYPE_LOAD : std_logic_vector(6 downto 0) := "0000011";
    constant STYPE : std_logic_vector(6 downto 0) := "0100011";
    constant BTYPE : std_logic_vector(6 downto 0) := "1100011";
    
    signal funct7 : std_logic_vector(6 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);
    signal ADD_FLAG : std_logic := '0';

    begin
    
         

	-- Next State Logic (FSM)
	COMB_LOG : process(in_inst, in_BrEq, in_BrLT)
        variable inst_type : std_logic_vector(6 downto 0);
            begin   
                inst_type := in_inst(6 downto 0);
	       
	        out_PCSel <= '0'; 
            out_incr_pc <= '0';
            out_ImmSel <= "000"; 
            out_RegWEn <= '0';
            out_BrUn <= '0';
            out_BSel <= '0';
            out_ASel <= '0';
            out_ALUSel <= "0000"; 
            out_MemRW <= '0';
            out_ByteSel <= "000";
            out_WBSel <= "XX";
	       
	        case inst_type is
	           when LUI =>
	                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                    out_incr_pc <= '1';
                    out_ImmSel <= "001"; -- U-type
                    out_RegWEn <= '1';
                    out_BrUn <= '0';
                    out_BSel <= '1';
                    out_ASel <= '-';
                    out_ALUSel <= "0001"; -- "0000"=A, "0001"=B, "0010"=Add, "0011"=Sub
                    out_MemRW <= '0';
                    out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
	           when AUIPC =>  
                    out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                    out_incr_pc <= '1';
                    out_ImmSel <= "001"; -- U-type
                    out_RegWEn <= '1';
                    out_BrUn <= '0';
                    out_BSel <= '1';
                    out_ASel <= '1';
                    out_ALUSel <= "0010"; -- "0000"=A, "0001"=B, "0010"=Add, "0011"=Sub
                    out_MemRW <= '0';
                    out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4   
                when JAL =>  
                    out_PCSel <= '1'; -- "0"=PC_plus_4, "1"=ALU
                    out_incr_pc <= '1';
                    out_ImmSel <= "100"; -- J-type
                    out_RegWEn <= '1';
                    out_BrUn <= '0';
                    out_BSel <= '1';
                    out_ASel <= '1';
                    out_ALUSel <= "0010"; -- ADD
                    out_MemRW <= '0';
                    out_WBSel <= "10"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4   
                when STYPE =>   
                    if (in_inst(14 downto 12) = "000") then                             -- SB 
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "010"; -- S-Type
                        out_RegWEn <= '0';
                        out_BrUn <= '0';
                        out_BSel <= '1'; -- immediate
                        out_ASel <= '0'; -- A
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '1'; -- write
                        out_ByteSel <= "000"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "--"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4   
                    elsif (in_inst(14 downto 12) = "001") then                          -- SH
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "010"; -- S-Type
                        out_RegWEn <= '0';
                        out_BrUn <= '0';
                        out_BSel <= '1'; -- immediate
                        out_ASel <= '0'; -- A
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '1'; -- write
                        out_ByteSel <= "001"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "--"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4 
                    elsif (in_inst(14 downto 12) = "010") then                          -- SW
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "010"; -- S-Type
                        out_RegWEn <= '0';
                        out_BrUn <= '0';
                        out_BSel <= '1'; -- immediate
                        out_ASel <= '0'; -- A
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '1'; -- write
                        out_ByteSel <= "010"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "--"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4 
                    else
                    end if;
                when ITYPE_LOAD =>  
                    if (in_inst(14 downto 12) = "000") then                             -- LB
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "000"; -- "000"=I
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '1';
                        out_ASel <= '0';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_ByteSel <= "000"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "00"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "001") then                             -- LH
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "000"; -- "000"=I
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '1';
                        out_ASel <= '0';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_ByteSel <= "001"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "00"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "010") then                             -- LW
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "000"; -- "000"=I
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '1';
                        out_ASel <= '0';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_ByteSel <= "010"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "00"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "100") then                             -- LBU
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "000"; -- "000"=I
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '1';
                        out_ASel <= '0';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_ByteSel <= "011"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "00"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "101") then                             -- LHU
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "000"; -- "000"=I
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '1';
                        out_ASel <= '0';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_ByteSel <= "100"; -- SIGNED[ 000: Byte, 001: Half, 010: Word ] ; UNSIGNED[ 011:Byte , 100:Half  ] 
                        out_WBSel <= "00"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    else
                    end if;
                when ITYPE_ARITH =>  
                    -- I-Type Arithmetic (addi/slti/sltiu/xori/ori/andi/slli/srli/srai)
                    if (in_inst(14 downto 12) = "000") then -- ADDI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "0010"; -- ADD
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "010") then -- SLTI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "0101"; -- SLT
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "011") then -- SLTIU
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "0110"; -- SLTU
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "100") then -- XORI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "0111"; -- XOR
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "110") then -- ORI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "1011"; -- XOR
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(14 downto 12) = "111") then -- ANDI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "1100"; -- AND
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "001") then -- SLLI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "0100"; -- SLL
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "101") then -- SRLI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "1000"; -- SRL
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0100000" and in_inst(14 downto 12)= "101") then -- SRAI
                                out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                                out_incr_pc <= '1';
                                out_ImmSel <= "000"; -- "000"=I
                                out_RegWEn <= '1';
                                out_BrUn <= '0';
                                out_BSel <= '1';
                                out_ASel <= '0';
                                out_ALUSel <= "1001"; -- SRA
                                out_MemRW <= '0';
                                out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    else           
                    end if;
                when BTYPE => 
                    if (in_inst(14 downto 12) = "000") then -- BEQ    
                        if(in_BrEq = '1') then 
                            out_PCSel <= '1'; -- "0"=PC_plus_4, "1"=ALU
                        else 
                            out_PCSel <= '0'; 
                        end if;
                        
                        out_incr_pc <= '0';
                        out_ImmSel <= "011"; -- "000"=I
                        out_RegWEn <= '0';
                        out_BrUn <= '0';
                        out_BSel <= '1';
                        out_ASel <= '1';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_WBSel <= "--"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4    
                    elsif (in_inst(14 downto 12) = "111") then -- BGEU    
                        if(in_BrLT = '0' or in_BrEq = '1') then 
                            out_PCSel <= '1'; -- "0"=PC_plus_4, "1"=ALU
                        else 
                            out_PCSel <= '0'; 
                        end if;
                        
                        out_incr_pc <= '0';
                        out_ImmSel <= "011"; -- "000"=I
                        out_RegWEn <= '0';
                        out_BrUn <= '1';
                        out_BSel <= '1';
                        out_ASel <= '1';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_WBSel <= "--"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4 
                    elsif (in_inst(14 downto 12) = "110") then -- BLTU    
                        if(in_BrLT = '1') then 
                            out_PCSel <= '1'; -- "0"=PC_plus_4, "1"=ALU
                        else 
                            out_PCSel <= '0'; 
                        end if;
                        
                        out_incr_pc <= '0';
                        out_ImmSel <= "011"; -- "000"=I
                        out_RegWEn <= '0';
                        out_BrUn <= '1';
                        out_BSel <= '1';
                        out_ASel <= '1';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_WBSel <= "--"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4    
                    else
                    end if;
                when RTYPE =>
                    if (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "000") then -- ADD
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "0010"; -- ADD
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0100000" and in_inst(14 downto 12) = "000") then -- SUB
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "0011"; -- SUB
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "001") then -- SLL
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---";
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "0100"; -- SLL
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "010") then -- SLT
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "0101"; -- SLT
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "011") then -- SLTU
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "0110"; -- SLTU
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "100") then -- XOR
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "0111"; -- XOR
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "101") then -- SRL
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---";
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "1000"; -- SRL
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0100000" and in_inst(14 downto 12) = "101") then -- SRA
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "1001"; -- SRA
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "110") then -- OR
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "1011"; -- OR
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000000" and in_inst(14 downto 12) = "111") then -- AND
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '1';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "1100"; -- AND
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    elsif (in_inst(31 downto 25) = "0000001" and in_inst(14 downto 12) = "000") then -- MUL
                        out_PCSel <= '0'; -- "0"=PC_plus_4, "1"=ALU
                        out_incr_pc <= '0';
                        out_ImmSel <= "---"; 
                        out_RegWEn <= '1';
                        out_BrUn <= '0';
                        out_BSel <= '0';
                        out_ASel <= '0';
                        out_ALUSel <= "1010"; -- MUL
                        out_MemRW <= '0';
                        out_WBSel <= "01"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
                    else 
                    end if;
                when others => 
                    out_PCSel <= 'X'; -- "0"=PC_plus_4, "1"=ALU
                    out_incr_pc <= 'X';
                    out_ImmSel <= "---"; 
                    out_RegWEn <= 'X';
                    out_BrUn <= 'X';
                    out_BSel <= 'X';
                    out_ASel <= 'X';
                    out_ALUSel <= "XXXX"; -- MUL
                    out_MemRW <= 'X';
                    out_WBSel <= "XX"; -- "00"=DataR, "01"=ALU, "10"=PC_plus_4
	        end case;
	           
	  
--            if(in_inst(6 downto 0) = LUI) then
                
--            elsif(in_inst(6 downto 0) = AUIPC) then
                
--            elsif(in_inst(6 downto 0) = STYPE) then    
                
--            elsif(in_inst(6 downto 0) = ITYPE_LOAD ) then -- I-Type (Load)    
                
--            elsif(in_inst(6 downto 0) = ITYPE_ARITH ) then 
                
--            elsif(in_inst(6 downto 0) = BTYPE ) then -- B-type 
                
--            elsif(in_inst(6 downto 0) = RTYPE ) then -- R-type 
                
--            else 
--                -- 
--            end if;
            
	end process;
end architecture;