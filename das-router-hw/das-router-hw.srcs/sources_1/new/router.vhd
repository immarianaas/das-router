----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2024 04:32:13 PM
-- Design Name: 
-- Module Name: router - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;
use work.click_element;
use work.demux3;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



-- DIRECTION WHERE THE DATA COMES FROM!!!! NOT TO WHERE IT GOES
-- direction:
-- 0 nw north west
-- 1 ne north east
-- 2 se south east
-- 3 sw south west


-- addr
-- [ 12, 8, 4, 0 ] 
-- [ dy, dx, y, x ]
-- [  current y, current x, dest y, destination x ]

entity router is
    generic(
    DIRECTION: in integer range 0 to 3 := 0
    );
    
    port (         
        rst   : in std_logic;
    
        i_req:  in std_logic;
        i_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        o_data_vertical: out std_logic_vector(DATA_WIDTH-1 downto 0);
        o_data_oblique: out std_logic_vector(DATA_WIDTH-1 downto 0);
        o_data_horizontal: out std_logic_vector(DATA_WIDTH-1 downto 0);

        o_req_vertical: out std_logic; -- vertical
        o_req_oblique: out std_logic; -- obliquious
        o_req_horizontal: out std_logic; -- horizontal
        
        
        i_ack:  out std_logic;
        o_ack_vertical: in std_logic;
        o_ack_oblique: in std_logic;
        o_ack_horizontal: in std_logic;
        
        test_ack : out std_logic;
        test_req : out std_logic
        
    );
end router;

architecture Behavioral of router is
  signal x, y, dx, dy : std_logic_vector(VALUE_WIDTH-1 downto 0);
  
  -- data -> comes out of the click element
  -- processed data -> data after updating the address 
    signal processed_data, data: std_logic_vector(DATA_WIDTH-1 downto 0);
  
  -- req and ack out of the click element
  signal req, ack : std_logic;
  
  signal selector : std_logic_vector(1 downto 0);
  
  signal shady_ack : std_logic;
  -- 11 is oblique
  -- 01 is horizontal
  -- 10 is vertical
  
begin
    -- x ( 3 downto 0)
    -- y ( 7 downto 4)
    -- dx ( 11 downto 8)
    -- dy (15 downto 12)
     
    x <= data(VALUE_WIDTH-1 downto VALUE_WIDTH*0);
    y <= data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1);
    dx <= data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2);
    dy <= data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3);
    
    
    processed_data(VALUE_WIDTH-1 downto VALUE_WIDTH*0) <= x;
    processed_data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1) <= y;
    processed_data(DATA_WIDTH-1 downto VALUE_WIDTH*4) <= data(DATA_WIDTH-1 downto VALUE_WIDTH*4);
    -- ack_internal <= ack;

    
    click: entity click_element 
    port map (
        rst => rst,
        
        in_ack => i_ack,
        in_req => i_req,
        in_data => i_data,
    -- Output channel
        out_req => req,
        out_data => data,
        out_ack => shady_ack
    );
    
    shady_ack <= ack; -- after 10ns;
    test_ack <= shady_ack;
    test_req <= req;

    
    -- going to be an input for the click element
    -- ack <= o_ack_vertical or o_ack_oblique or o_ack_horizontal;
    
    selector(0) <= '0' when dx = x else '1';
    selector(1) <= '0' when dy = y else '1';
    
    demux: entity demux3
        port map (
        rst => rst,
        
        inA_req     =>      req,    -- from click
        inA_data    =>      processed_data,   -- from click
        inA_ack     =>      ack,    -- to click
        
        inSel_req   =>      req,
        inSel_ack   =>      ack,
        selector    =>      selector,
        
        out_oblique_req      => o_req_oblique,
        out_oblique_data     => o_data_oblique,
        out_oblique_ack      => o_ack_oblique,

        out_horizontal_req      => o_req_horizontal,
        out_horizontal_data     => o_data_horizontal,
        out_horizontal_ack      => o_ack_horizontal,

        out_vertical_req      => o_req_vertical,
        out_vertical_data     => o_data_vertical,
        out_vertical_ack      => o_ack_vertical
        );
    
    
    
        
    c0: if DIRECTION = 0 generate
   
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy > y else dy;
        
    end generate;

    c1: if DIRECTION = 1 generate
        
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx > x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy > y else dy;
        
    end generate;
    
    c2: if DIRECTION = 2 generate
     
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx > x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y else dy;
        
    end generate;
       
    c3: if DIRECTION = 3 generate
     
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y else dy;
        
    end generate;


end Behavioral;



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
USE work.router;


entity router_tb is
end entity;

architecture tb of router_tb is
        signal rst   :  std_logic;
    
        signal i_req:std_logic;
        signal i_data: std_logic_vector(DATA_WIDTH-1 downto 0);
        
        signal o_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
        signal o_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
        signal o_data_horizontal:std_logic_vector(DATA_WIDTH-1 downto 0);

        signal o_req_vertical: std_logic; -- vertical
        signal o_req_oblique: std_logic; -- obliquious
        signal o_req_horizontal:std_logic; -- horizontal
        
        -- unsure if right, but:
        -- additional ports that we didn't thought of before
        signal i_ack:   std_logic;
        signal o_ack_vertical: std_logic;
        signal o_ack_oblique:  std_logic;
        signal o_ack_horizontal: std_logic;
        
begin

    DUT : entity router
    generic map (
        DIRECTION => 1
    )
        port map (
        rst,
    
        i_req,
        i_data,
        
        o_data_vertical,
        o_data_oblique,
        o_data_horizontal,

        o_req_vertical,
        o_req_oblique,
        o_req_horizontal,
        
        -- unsure if right, but:
        -- additional ports that we didn't thought of before
        i_ack,
        o_ack_vertical,
        o_ack_oblique,
        o_ack_horizontal
        );
        


process begin


    rst <= '1', '0' after 2ns;
    i_req <= '0', '1' after 7 ns;
    i_data <= "0011001100110101";
    --o_ack_horizontal <= '0', '1' after 20ns;
    o_ack_horizontal <= '0';
    o_ack_vertical <= '0';
    o_ack_oblique <= '0';
    
    wait until o_req_horizontal = '1';
    wait for 7ns;
    
    o_ack_horizontal <= '1';
    
    
    wait for 30 ns;
    assert o_data_horizontal = "0011001100000011" report "fail" severity failure; 
    assert o_req_horizontal = '1' report "fail" severity failure;
    
    
    
    


    -- NORTH WEST
    
    -------- test 1 -------- 
    rst <= '1', '0' after 2ns;
    i_req <= '0', '1' after 7 ns;
    i_data <= "0000000000110011";
    --o_ack_horizontal <= '0', '1' after 20ns;
    o_ack_horizontal <= '0';
    o_ack_vertical <= '0';
    o_ack_oblique <= '0';
    
    wait until o_req_oblique = '1';
    wait for 7ns;
    
    o_ack_oblique <= '1';
    
    
    wait for 30 ns;
    assert o_data_horizontal = "0000000100000001" report "fail" severity failure; 
    assert o_req_horizontal = '1' report "fail" severity failure;
    --assert o_ack_horizontal = '1' report "fail" severity failure;
    
    -- assert i_ack = "1" report "fail" severity failure;
    -------- -------- -------- --------
    
    -------- test 2 -------- 
    i_req <= '1', '0' after 3 ns;
    i_data <= "0010000000010000";
    --o_ack_horizontal<= '0';
    --o_ack_vertical <= '1', '0' after 15ns;
    --o_ack_oblique <= '0';
    
    wait until i_req = '0';
    wait for 7 ns;
    
    o_ack_horizontal <= '0';
    
    
    wait for 30 ns;
    assert o_data_vertical = "0001000000010000" report "fail" severity failure; 
    assert o_req_vertical = '1' report "fail" severity failure;

    -- assert i_ack = "1" report "fail" severity failure;
    -------- -------- -------- --------
    
    
    
    report "passed! ;)";
    
    end process;
end architecture;

