
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.arbiter3;
use work.router;
use std.env.finish;

entity corner_node_top is
    generic(
        CORNER: in integer range 0 to 3 := 0
        ); 
    port(
        rst : in  std_logic;
        ia  : out std_logic;
        ir  : in  std_logic;
        id  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        oa  : in  std_logic;
        orr  : out std_logic; --or is protected
        od  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        
        oa_horizontal : in std_logic;
        oa_vertical   : in std_logic;
        oa_oblique    : in std_logic;
        ia_horizontal : out std_logic;
        ia_vertical   : out std_logic;
        ia_oblique    : out std_logic;
        
        or_horizontal : out std_logic;
        or_vertical   : out std_logic;
        or_oblique    : out std_logic;
        ir_horizontal : in std_logic;
        ir_vertical   : in std_logic;
        ir_oblique    : in std_logic;
        
        od_horizontal : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_vertical   : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_oblique    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        id_horizontal : in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_vertical   : in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_oblique    : in std_logic_vector(DATA_WIDTH-1 downto 0)
    
    );
        
end corner_node_top;

architecture Behavioral of corner_node_top is

begin

Router_corner: entity router
    generic map(
    DIRECTION => CORNER
    )
    port map(
    rst=>rst,
    i_req =>ir,
    i_data => id,
    
    o_data_vertical => od_vertical,
    o_data_oblique => od_oblique,
    o_data_horizontal => od_horizontal,
    
    o_req_vertical => or_vertical,
    o_req_oblique => or_oblique,
    o_req_horizontal => or_horizontal,
    
    i_ack => ia,
    
    o_ack_vertical => oa_vertical,
    o_ack_oblique => oa_oblique,
    o_ack_horizontal => oa_horizontal
    );

Arbiter_corner : entity arbiter3
    port map ( 
    rst => rst,
    
    inA_req => or_vertical,
    inA_data => od_vertical,
    inA_ack => oa_vertical,
    
    inB_req => or_horizontal,
    inB_data => od_horizontal,
    inB_ack => oa_horizontal,
    
    inC_req => or_oblique,
    inC_data => od_oblique,
    inC_ack => oa_oblique,
    
    out_req => orr,
    out_data => od,
    out_ack => oa
    );

end Behavioral;
