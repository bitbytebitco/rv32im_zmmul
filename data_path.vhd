library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;

entity data_path is
	port(
		clock : in std_logic;
	    reset : in std_logic;
		in_PCSel : in std_logic;
		in_incr_pc : in std_logic;
		out_inst : out std_logic_vector(31 downto 0);
		in_ImmSel : in std_logic_vector(2 downto 0);
		in_RegWEn : in std_logic;
		in_BrUn : in std_logic;
		out_BrEq : out std_logic;
		out_BrLT: out std_logic;
		in_BSel : in std_logic;
		in_ASel : in std_logic;
		in_ALUSel : in std_logic_vector(3 downto 0);
		in_MemRW : in std_logic; 
		in_ByteSel : in std_logic_vector(2 downto 0);
		in_WBSel : in std_logic_vector(1 downto 0);
		from_memory : in std_logic_vector( 31 downto 0);
		o_address : out std_logic_vector( 31 downto 0);
		o_write : out std_logic;
		o_byte_sel : out std_logic_vector(2 downto 0);
		to_memory : out std_logic_vector( 31 downto 0)
	);
end entity;


architecture data_path_arch of data_path is 
    

    -- SIGNAL DECLARATIONS
    signal w_BrU, w_MemRW : std_logic;
    signal w_ByteSel : std_logic_vector(2 downto 0);
    signal w_inst, w_imm, ALUResult, in_PC, PC, PC_plus_four, DataA, DataB, A, B, wb : std_logic_vector(31 downto 0) := x"00000000";
    signal PC_uns, PC_plus_four_uns : unsigned(31 downto 0) := x"00000000";
    
    -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF PC : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF DataB : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF o_address : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF to_memory : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF wb : SIGNAL IS "true";

    signal opcode : std_logic_vector(6 downto 0);
    
    signal rd : std_logic_vector(4 downto 0);  

    --IMEM
    component instruction_memory
        port(
            in_addr : in std_logic_vector(31 downto 0);
            out_inst : out std_logic_vector(31 downto 0)
        );
    end component;


    -- REGISTER FILE
    component register_file
        port(
            clock : in std_logic;
            reset : in std_logic;
            in_RegWEn : in std_logic;
            in_AddrA : in std_logic_vector(4 downto 0);
            in_AddrB : in std_logic_vector(4 downto 0);
            in_AddrD : in std_logic_vector(4 downto 0);
            in_DataD : in std_logic_vector(31 downto 0);
            out_DataA : out std_logic_vector(31 downto 0);
            out_DataB : out std_logic_vector(31 downto 0)
        );
    end component;
    
    -- ALU
    component alu
        port(
            in_A : in std_logic_vector(31 downto 0);
            in_B : in std_logic_vector(31 downto 0);
            in_ALUSel : in std_logic_vector(3 downto 0);
            out_ALUResult : out std_logic_vector(31 downto 0)	
        );
    end component;
    
    -- branch comparator
    component branch_comparator 
        port(
            i_A, i_B : in std_logic_vector(31 downto 0); 
            i_BrU  : in std_logic;
            o_BrEq, o_BrLT : out std_logic);
    end component;
    
    -- immediate generator
    component imm_gen
        port(
            i_inst : in std_logic_vector(31 downto 0);
            i_ImmSel : in std_logic_vector(2 downto 0);
            o_imm : out std_logic_vector(31 downto 0)
        );
    end component;

  begin
      
    
    w_BrU <= in_BrUn; -- assigning to signal for reading
    o_write <= in_MemRW;
    o_byte_sel <= in_ByteSel;
    out_inst <= w_inst;
    o_address <= ALUResult;
    
    to_memory <= DataB;

    -- PC Mux Init
    PC_MUX : process(clock, reset, in_PCSel, ALUResult, PC_plus_four)
      begin
        if(reset = '0') then
            PC <= x"00000000";
        elsif(rising_edge(clock)) then
            if(in_PCSel = '1') then
                PC <= ALUResult;
            else 
                PC <= PC_plus_four;
            end if;
        end if;
    end process;	
   

    -- PC Adder (plus 4)
--    PC_uns <= unsigned(PC);
--    PC_plus_four <= std_logic_vector(PC_plus_four_uns);
    
    PC_plus_four <= std_logic_vector(unsigned(PC) + 4);

--      PC_plus_four <= std_logic_vector(unsigned(PC) + 4) when in_incr_pc = '1' else PC_plus_four;
    
--    in_PC <= PC_plus_four;

--    PC_ADDER : process(PC_uns, in_incr_pc)
--        begin
--            --PC_plus_four_uns <= x"00000000";
--            if(in_incr_pc = '1') then
--                PC_plus_four_uns <= PC_uns + 4;
--            end if;
--    end process;
    
    

    -- IMEM init
    IMEM : instruction_memory 
        port map(
            in_addr => PC,
            out_inst => w_inst
        );

    -- Immediate Generation
    
    IMMEDIATE_GEN : imm_gen 
        port map(
            i_inst => w_inst,
            i_ImmSel => in_ImmSel,
            o_imm => w_imm
        );
    
    

    -- Register File
    REG_FILE : register_file
        port map(
            clock => clock,
            reset => reset,
            in_RegWEn => in_RegWEn,
            in_AddrA => w_inst(19 downto 15),
            in_AddrB => w_inst(24 downto 20),
            in_AddrD => w_inst(11 downto 7),
            in_DataD => wb, -- temporarily set to ALU output
            out_DataA => DataA,
            out_DataB => DataB 
        );
	
	
	-- branch comparator
    BRANCH_COMP : branch_comparator 
        port map(
            i_A =>  DataA,
            i_B =>  DataB,
            i_BrU => w_BrU, 
            o_BrEq => out_BrEq,
            o_BrLT => out_BrLT
        );

    -- ALU Init
    ARITH_UNIT : alu 
        port map(	
            in_A => A,
            in_B => B,
            in_ALUSel => in_ALUSel,
            out_ALUResult => ALUResult
        );


    -- B Multiplexer Init
    BMUX : process(in_BSel, DataB, w_imm)
        begin
            if(in_BSel = '1') then
                B <= w_imm;
            else 
                B <= DataB;
            end if;
   end process;


    -- A Multiplexer Init
    AMUX : process(in_ASel, DataA, PC)
        begin
            if(in_ASel = '1') then
                A <= PC;
            else 
                A <= DataA;
            end if;
    end process;


    -- DMEM init
--    DMEM : data_memory 
--        port map(
--            clock => clock,
--            in_Addr => ALUResult,
--            in_MemRW => w_MemRW, 
--            in_DataW => DataB,
--            i_ByteSel => w_ByteSel,
--            out_DataR => w_out_mem
--        );

--wb <= ALUResult;

    -- wb Mux Init
    WB_MUX : process(in_WBSel, from_memory, ALUResult, PC_plus_four)
    begin
        
        case(in_WBSel) is
            when "00" => wb <= from_memory;
            when "01" => wb <= ALUResult;
            when "10" => wb <= PC_plus_four;
            when others => wb <= x"00000000";
        end case;
    end process;

end architecture;

