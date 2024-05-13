

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
