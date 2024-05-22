
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.arbiter3;
use work.router;

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
    inA_req => ir_vertical,
    inA_data => id_vertical,
    inA_ack => ia_vertical,
    
    inB_req => ir_horizontal,
    inB_data => id_horizontal,
    inB_ack => ia_horizontal,
    
    inC_req => ir_oblique,
    inC_data => id_oblique,
    inC_ack => ia_oblique,
    
    out_req => orr,
    out_data => od,
    out_ack => oa
    );

end Behavioral;


----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.corner_node_top;



entity corner_node_top_tb is
end entity;

architecture tb of corner_node_top_tb is
    type t_bit_arr is array (0 to 2) of std_logic;
    type t_data_arr is array (0 to 2) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal ack_out : t_bit_arr;
    signal data_in : t_data_arr;
    signal req_in : t_bit_arr;
    
    signal ack_in : t_bit_arr;
    signal data_out : t_data_arr;
    signal req_out : t_bit_arr;
   
   signal rst : std_logic;
   
   signal ia, ir, oa, orr : std_logic;
   signal id, od : std_logic_vector(DATA_WIDTH-1 downto 0);
   
    -- horizontal -> 0
    -- vertical -> 1
    -- oblique -> 2
    
    signal direction : Integer := 0;
        
begin

node: entity corner_node_top
generic map( 
-- 0 nw north west
-- 1 ne north east
-- 2 se south east
-- 3 sw south west

    CORNER => 1
    )
    port map (
        rst => rst,
        ia  => ia,
        ir  => ir,
        id  => id,
        oa  => oa,
        orr  => orr,
        od  => od,
        
        oa_horizontal => ack_out(0),
        oa_vertical   => ack_out(1),
        oa_oblique    => ack_out(2),
        ia_horizontal => ack_in(0),
        ia_vertical   => ack_in(1),
        ia_oblique    => ack_in(2),
        
        or_horizontal => req_out(0),
        or_vertical   => req_out(1),
        or_oblique    => req_out(2),
        ir_horizontal => req_in(0),
        ir_vertical   => req_in(1),
        ir_oblique    => req_in(2),
        
        od_horizontal => data_out(0),
        od_vertical   => data_out(1),
        od_oblique    => data_out(2),
        id_horizontal => data_in(0),
        id_vertical   => data_in(1),
        id_oblique    => data_in(2)
        
        -- internal_nw_req_horizontal => internal_nw_req_horizontal,
        -- internal_nw_req_vertical => internal_nw_req_vertical
    );
    
    process begin
        -- horizontal -> 0
        -- vertical -> 1
        -- oblique -> 2
    
--        rst <= '1', '0' after 7ns;
--        ack_out <= (others =>'0');
--        req_in <= (others =>'0');
--        data_in <= (others => (others => '0'));
   
--        ir <= '0'; oa <= '0';
        
--        id <= (others =>'0');
        
        
--        -- currently in (3,3), wanna go to (0,1)
--        id <= "0000000000000000000000000000000000000000000000000011001100010000";
--        ir <= '0', '1' after 20ns;
        
--        wait until ia = '1';
        
--        -- we should see something on the oblique (2) line
--        wait until req_out(2) = '1';
--        ack_out(2) <= '1';
        
        
--        id <= "0000000000000000000000000100000000000000000000000011001100010000";
--        ir <= '1', '0' after 20ns;
--        wait until ia = '0';
--        -- we should see something on the oblique (2) line
--        wait until req_in(2) = '0';
--        ack_out(2) <= '0';
        

--        wait for 50ns;
--        finish;


        -- direction <= 1; -- vertical
        -- (3,3) to (3,0)
        -- "0000000000000000000000000000000000000000000000000011001100000011"

        direction <= 2; -- oblique
        -- (3,3) to (0,0)
        -- "0000000000000000000000000000000000000000000000000011001100000000"

        rst <= '1', '0' after 7ns;
        ack_out <= (others =>'0');
        req_in <= (others =>'0');
        data_in <= (others => (others => '0'));
   
        ir <= '0'; oa <= '0';
        
        id <= (others =>'0');
        
        wait for 20ns;
        -- currently in (3,3), wanna go to (3,0)
        id <= "0000000000000000000000000000000000000000000000000011001100000000";
        ir <= '0', '1' after 20ns;
        
        wait until ia = '1';
        

        -- we should see something on the vertical (1) line
        wait until req_out(direction) = '1';
        ack_out(direction) <= '0','1' after 50ns;
        

        
        wait for 20ns;
        id <= "0000000000000000000000000000000000000000000000000011001100000000";
        ir <= '1', '0' after 30ns;
        

        
        wait until ia = '0';
        -- we should see something on the vertical (1) line
        wait until req_out(direction) = '0';
        ack_out(direction) <= '1', '0' after 50ns;
        
                
        wait for 20ns;
        -- currently in (3,3), wanna go to (3,0)
        id <= "0000000000000000000000000000000000000000000000000011001100000000";
        ir <= '0', '1' after 20ns;
        
        wait until ia = '1';
        

        -- we should see something on the vertical (1) line
        wait until req_out(direction) = '1';
        ack_out(direction) <= '0','1' after 50ns;
        
        

        wait for 50ns;



        
        -- it's in (3,3) and goes to (3, 0)
--        --data_in(0) <= "0011001100000011";
        
--        -- it's in (3,3) and goes to (5,3)
--        data_in(2) <= "0011001100110101";
--        req_in(2) <= '0', '1' after 40ns;
--        wait until ack_in(2) = '1';
        
--        ack_out(5) <= '1';



        
    end process;
end architecture;


