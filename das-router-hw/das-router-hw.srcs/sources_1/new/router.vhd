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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



-- direction:
-- 0 nw north west
-- 01 ne north east
-- 10 se south east
-- 11 sw south west


-- addr
-- [ 12, 8, 4, 0 ] 
-- [ dy, dx, y, x ]
-- [  current y, current x, dest y, destination x ]

entity router is
    generic(
    DIRECTION: in integer range 0 to 3 := 0
    );
    
    port (         
        i_req:  in std_logic;
        i_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        o_data_vertical: out std_logic_vector(DATA_WIDTH-1 downto 0);
        o_data_oblique: out std_logic_vector(DATA_WIDTH-1 downto 0);
        o_data_horizontal: out std_logic_vector(DATA_WIDTH-1 downto 0);

        o_req_vertical: out std_logic; -- vertical
        o_req_oblique: out std_logic; -- obliquious
        o_req_horizontal: out std_logic; -- horizontal
        
        -- unsure if right, but:
        -- additional ports that we didn't thought of before
        i_ack:  out std_logic;
        o_ack_vertical: in std_logic;
        o_ack_oblique: in std_logic;
        o_ack_horizontal: in std_logic
    );
end router;

architecture Behavioral of router is
  signal x, y, dx, dy : std_logic_vector(VALUE_WIDTH-1 downto 0);
  signal addr: std_logic_vector(DATA_WIDTH-1 downto 0);
  
begin
    x <= i_data(VALUE_WIDTH-1 downto VALUE_WIDTH*0);
    y <= i_data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1);
    dx <= i_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2);
    dy <= i_data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3);
    
    
    addr(VALUE_WIDTH-1 downto VALUE_WIDTH*0) <= x;
    addr(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1) <= y;
    
    i_ack <= o_ack_vertical or o_ack_oblique or o_ack_horizontal;
    
    o_req_vertical <= i_req when dx = x else '0';
    o_req_oblique <= i_req when dx /= x and dy /= y else '0';
    o_req_horizontal <= i_req when dy = y else '0';
    
    o_data_vertical <= addr when dx = x else (others => '0');
    o_data_oblique <= addr when dx /= x and dy /= y else (others => '0');
    o_data_horizontal <= addr when dy = y else (others => '0');

        
    c0: if DIRECTION = 0 generate
    
        -- dx <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx < x;
        -- dy <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy < y;

        addr(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x else dx;
        -- o_addr(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector("1111") when dx < x;
        addr(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy > y else dy;
        
    end generate;

    c1: if DIRECTION = 1 generate
        
        addr(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx > x else dx;
        addr(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy > y else dy;
        
    end generate;
    
    c2: if DIRECTION = 2 generate
     
        addr(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx > x;
        addr(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y;
        
    end generate;
       
    c3: if DIRECTION = 3 generate
     
        addr(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x;
        addr(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y;
        
    end generate;


end Behavioral;



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
USE work.router;

entity router_tb is
end entity;

architecture tb of router_tb is
        signal i_req:  std_logic;
        signal i_addr: std_logic_vector(DATA_WIDTH-1 downto 0);
        signal o_data_vertical:  std_logic_vector(DATA_WIDTH-1 downto 0);
        signal o_data_oblique:  std_logic_vector(DATA_WIDTH-1 downto 0);
        signal o_data_horizontal:  std_logic_vector(DATA_WIDTH-1 downto 0);
        signal o_req_vertical:  std_logic; -- vertical
        signal o_req_oblique:  std_logic; -- obliquious
        signal o_req_horizontal:  std_logic; -- horizontal
        
        -- unsure if right, but:
        -- additional ports that we didn't thought of before
        signal i_ack:  std_logic;
        signal o_ack_vertical:  std_logic;
        signal o_ack_oblique:  std_logic;
        signal o_ack_horizontal:  std_logic;

begin

    DUT : entity router
    generic map (
        DIRECTION => 0
    )
        port map (
        i_req,
        i_addr,
        o_data_vertical,
        o_data_oblique,
        o_data_horizontal,
        o_req_vertical,
        o_req_oblique,
        o_req_horizontal,        
        i_ack,
        o_ack_vertical,
        o_ack_oblique,
        o_ack_horizontal
        );


process begin
    i_req <= '0', '1' after 15 ns;
    
    -- dy, dx, y, x
    i_addr <= "0000000000000001", "0001000000000000" after 50ns; -- x = 1, y = 0, dx = 0, dy = 0
    
    -- o_addr should be "0101"
    o_ack_horizontal <= '0', '1' after 25ns; --ack2 and req2 should be the same
    

--------------------

    wait for 100 ns;
    
    i_req <= '0', '1' after 50 ns;
    
    -- dy, dx, y, x
    i_addr <= "0001000000000000"; -- x = 1, y = 0, dx = 0, dy = 1
    
    -- o_addr should be "0101" ?
    o_ack_horizontal <= '0', '1' after 75ns; --ack2 and req2 should be the same
    
    end process;
end architecture;

