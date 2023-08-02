library IEEE;
use IEEE.std_logic_1164.all; 

entity rv32i is 
	port(
		clock : in std_logic;
		reset : in std_logic;
		i_inst: in std_logic_vector(31 downto 0);
		i_load_imem : in std_logic;
		o_address : out std_logic_vector( 31 downto 0);
		o_write : out std_logic;
		o_byte_sel : out std_logic_vector(2 downto 0);
		o_PC : out std_logic_vector(31 downto 0);
		to_memory : out std_logic_vector( 31 downto 0);
		from_memory : in std_logic_vector( 31 downto 0)
	);
end entity;

architecture rv32i_arch of rv32i is

    -- CONTROL UNIT
    component control_unit 
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
    end component;

    -- DATA PATH
    component data_path
	port(
		clock : in std_logic;
	    reset : in std_logic;
	    i_load_imem : in std_logic;
		in_PCSel : in std_logic;
		in_incr_pc : in std_logic;
		in_inst : in std_logic_vector(31 downto 0);
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
		o_PC : out std_logic_vector(31 downto 0);
		to_memory : out std_logic_vector( 31 downto 0)
	);
    end component; 

    -- SIGNAL DECLARATIONS
    signal PCSel, RegWEn, BrUn, BrEq, BrLT, BSel, ASel, MemRW, incr_pc, w_load_imem : std_logic;
    signal ImmSel : std_logic_vector(2 downto 0);
    signal r_inst, r_PC : std_logic_vector(31 downto 0);
    signal ALUSel : std_logic_vector(3 downto 0);
    signal WBSel : std_logic_vector(1 downto 0);
    signal w_ByteSEL : std_logic_vector(2 downto 0);

    begin
    
    r_inst <= i_inst;
    o_PC <= r_PC;
    
    w_load_imem <= i_load_imem;
    
	-- CONTROL UNIT INIT
	CTRL_UNIT : control_unit 
		port map(
			out_PCSel => PCSel,
			out_incr_pc => incr_pc,
			in_inst => r_inst,
			out_ImmSel => ImmSel,
			out_RegWEn => RegWEn,
			out_BrUn => BrUn,
			in_BrEq => BrEq,
			in_BrLT => BrLT,
			out_BSel => BSel,
			out_ASel => ASel,
			out_ALUSel => ALUSel,
			out_MemRW => MemRW,
			out_ByteSel => w_ByteSEL,
			out_WBSel => WBSel
		);
		
--		from_memory : in std_logic_vector( 31 downto 0);
--		o_address : out std_logic_vector( 31 downto 0);
--		o_write : out std_logic;
--		o_byte_sel : out std_logic_vector(2 downto 0);
--		to_memory : out std_logic_vector( 31 downto 0)

	-- DATA PATH INIT
	DTA_PTH : data_path 
		port map(
			clock => clock,
			reset => reset, 
			i_load_imem => w_load_imem,
			in_PCSel => PCSel,
			in_incr_pc => incr_pc,
			in_inst => r_inst,
			in_ImmSel => ImmSel,
			in_RegWEn => RegWEn,
			in_BrUn => BrUn,
			out_BrEq => BrEq,
			out_BrLT => BrLT,
			in_BSel => BSel,
			in_ASel => ASel,
			in_ALUSel => ALUSel,
			in_MemRW => MemRW,
			in_ByteSel => w_ByteSEL,
			in_WBSel => WBSel,
			from_memory => from_memory,
			o_address => o_address,
			o_write => o_write,
			o_byte_sel => o_byte_sel,
			o_PC => r_PC,
			to_memory => to_memory
		);
end architecture;
