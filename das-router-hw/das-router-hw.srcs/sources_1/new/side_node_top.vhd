

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.router5;
use work.arbiter5;
use std.env.finish;

entity side_node_top is
    generic(
    SIDE: in integer range 0 to 3 :=0
    );
    
    port ( 
        rst : in std_logic;
        
        ir : in  std_logic;
        ia : out std_logic;
        id : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        orr : out std_logic;
        oa  : in  std_logic;
        od  : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        or_straight : out std_logic;
        oa_straight : in  std_logic;
        od_straight : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_straight : in  std_logic;
        ia_straight : out std_logic;
        id_straight : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_left : out std_logic;
        oa_left : in  std_logic;
        od_left : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_left : in  std_logic;
        ia_left : out std_logic;
        id_left : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_right : out std_logic;
        oa_right : in  std_logic;
        od_right : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_right : in  std_logic;
        ia_right : out std_logic;
        id_right : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_lefto : out std_logic;
        oa_lefto : in  std_logic;
        od_lefto : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_lefto : in  std_logic;
        ia_lefto : out std_logic;
        id_lefto : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_righto : out std_logic;
        oa_righto : in  std_logic;
        od_righto : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_righto : in  std_logic;
        ia_righto : out std_logic;
        id_righto : in  std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end side_node_top;

architecture Behavioral of side_node_top is

begin

router: entity router5 
    generic map(
        SIDE => SIDE
    )
    
    port map (
        rst => rst,
        ia => ia,
        ir => ir,
        id => id,
        
        oa_straight => oa_straight,
        oa_left => oa_left,
        oa_right => oa_right,
        oa_lefto => oa_lefto,
        oa_righto => oa_righto,
        
        or_straight => or_straight,
        or_left => or_left,
        or_right => or_right,
        or_lefto => or_lefto,
        or_righto => or_righto,
        
        od_straight => od_straight,
        od_left => od_left,
        od_right => od_right,
        od_lefto => od_lefto,
        od_righto => od_righto
    );
    --B,D,E fast
    arbiter : entity arbiter5 
    port map(
    rst => rst,
    
    inA_req => ir_left,
    inA_data => id_left,
    inA_ack => ia_left,
    
    inB_req => ir_lefto,
    inB_data => id_lefto,
    inB_ack => ia_lefto,
    
    inC_req => ir_right,
    inC_data => id_right,
    inC_ack => ia_right,
    
    inD_req => ir_straight,
    inD_data => id_straight,
    inD_ack => ia_straight,
    
    inE_req => ir_righto,
    inE_data => id_righto,
    inE_ack => ia_righto,
    
    out_req => orr,
    out_data => od,
    out_ack => oa
    );

end Behavioral;

----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.side_node_top;
use std.env.finish;

entity side_node_top_tb is
end entity;

architecture tb of side_node_top_tb is
    type t_bit_arr is array (0 to 4) of std_logic;
    type t_data_arr is array (0 to 4) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal ack_out : t_bit_arr;
    signal data_in : t_data_arr;
    signal req_in : t_bit_arr;
    
    signal ack_in : t_bit_arr;
    signal data_out : t_data_arr;
    signal req_out : t_bit_arr;
   
    signal rst : std_logic;
   
    signal ia, ir, oa, orr : std_logic;
    signal id, od : std_logic_vector(DATA_WIDTH-1 downto 0);
    
begin

node: entity side_node_top
generic map( 
    SIDE => 2 -- SOUTH
    )
    port map (
        rst => rst,
        ia  => ia,
        ir  => ir,
        id  => id,
        oa  => oa,
        orr  => orr,
        od  => od,
        
        or_straight => req_out(0),
        oa_straight => ack_out(0),
        od_straight => data_out(0),
        
        ir_straight => req_in(0),
        ia_straight => ack_in(0),
        id_straight => data_in(0),
        
        or_left => req_out(1),
        oa_left => ack_out(1),
        od_left => data_out(1),
        
        ir_left => req_in(1),
        ia_left => ack_in(1),
        id_left => data_in(1),
        
        or_right => req_out(2),
        oa_right => ack_out(2),
        od_right => data_out(2),
        
        ir_right => req_in(2),
        ia_right => ack_out(2),
        id_right => data_out(2),
        
        or_lefto => req_out(3),
        oa_lefto => ack_out(3),
        od_lefto => data_out(3),
        
        ir_lefto => req_in(3),
        ia_lefto => ack_in(3),
        id_lefto => data_in(3),
        
        or_righto => req_out(4),
        oa_righto => ack_out(4),
        od_righto => data_out(4),
        
        ir_righto => req_in(4),
        ia_righto => ack_in(4),
        id_righto => data_in(4)
        
        -- internal_nw_req_horizontal => internal_nw_req_horizontal,
        -- internal_nw_req_vertical => internal_nw_req_vertical
    );
    
    process begin
        -- horizontal -> 0
        -- vertical -> 1
        -- oblique -> 2
    
        rst <= '1', '0' after 7ns;
        ack_out <= (others =>'0');
        req_in <= (others =>'0');
        data_in <= (others => (others => '0'));
   
        ir <= '0'; oa <= '0';
        
        id <= (others =>'0');
        
        
        -- currently in (1,0), wanna go to (2,0)
        id <= "0000000100000010";
        ir <= '0', '1' after 20ns;
        
        -- we should see something on the right line (instead we see something on the straight line?)
        wait until req_out(2) = '1';
        
        ack_out(2) <= '1';

        wait for 50ns;
        finish;


        
        -- it's in (3,3) and goes to (3, 0)
--        --data_in(0) <= "0011001100000011";
        
--        -- it's in (3,3) and goes to (5,3)
--        data_in(2) <= "0011001100110101";
--        req_in(2) <= '0', '1' after 40ns;
--        wait until ack_in(2) = '1';
        
--        ack_out(5) <= '1';



        
    end process;
end architecture;

