----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2024 03:05:19 PM
-- Design Name: 
-- Module Name: router2 - Behavioral
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
use work.defs.all;
use work.click_element;
use work.demux;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity router2 is
  port (
        rst : in std_logic;
        
        ia : out std_logic;
        ir : in  std_logic;
        id : in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        oa_outside : in std_logic;
        oa_inside : in std_logic;
        
        or_outside : out std_logic;
        or_inside : out std_logic;
        
        od_outside : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_inside : out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
         
end router2;

architecture Behavioral of router2 is
    signal x,y,dx,dy : std_logic_vector(VALUE_WIDTH-1 downto 0);
    signal req, ack : std_logic;
    signal processed_data, data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal selector : std_logic;
    
    signal shady_ack : std_logic;
begin

    x <= data(VALUE_WIDTH-1 downto VALUE_WIDTH*0);
    y <= data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1);
    dx <= data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2);
    dy <= data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3); 
    
    processed_data(VALUE_WIDTH-1 downto VALUE_WIDTH*0)<=x;
    processed_data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1) <=y;
    processed_data(DATA_WIDTH-1 downto VALUE_WIDTH*4) <= data(DATA_WIDTH-1 downto VALUE_WIDTH*4);
    
    selector <= '1' when x = dx and y = dy else '0';
    
    -- dx
    processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= dx when x = dx 
        else std_logic_vector(unsigned(dx) - unsigned(ONE)) when x < dx
        else std_logic_vector(unsigned(dx) + unsigned(ONE));    
    
    -- dy
    processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= dy when y = dy 
        else std_logic_vector(unsigned(dy) - unsigned(ONE)) when y < dy
        else std_logic_vector(unsigned(dy) + unsigned(ONE));
    
    click: entity click_element
    port map (
        rst => rst,
        in_ack => ia,
        in_req => ir,
        in_data => id,
        out_req => req,
        out_data => data,
        out_ack => shady_ack
    );
    
    shady_ack <= ack; -- after 10ns;
    
    demux1: entity demux
        port map (
        rst => rst,
        
        inA_req     =>      req,    -- from click
        inA_data    =>      processed_data,   -- from click
        inA_ack     =>      ack,    -- to click
        
        inSel_req   =>      req,
        inSel_ack   =>      ack,
        selector    =>      selector,
        
        -- 1
        outB_req      => or_outside,
        outB_data     => od_outside,
        outB_ack      => oa_outside,

        -- 0
        outC_req      => or_inside,
        outC_data     => od_inside,
        outC_ack      => oa_inside
        );
    
    
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
USE work.router2;

entity router2_tb is
end entity;

architecture tb of router2_tb is

        signal rst : std_logic;
        
        signal ia : std_logic;
        signal ir : std_logic;
        signal id : std_logic_vector(DATA_WIDTH-1 downto 0);
        
        signal oa_outside : std_logic;
        signal oa_inside : std_logic;
        
        signal or_outside : std_logic;
        signal or_inside : std_logic;
        
        signal od_outside : std_logic_vector(DATA_WIDTH-1 downto 0);
        signal od_inside : std_logic_vector(DATA_WIDTH-1 downto 0);
        
begin

    DUT : entity router2
      port map (
        rst => rst,
    
        ia => ia,
        ir => ir,
        id => id,
        
        oa_outside => oa_outside,
        oa_inside => oa_inside,
        
        or_outside => or_outside,
        or_inside => or_inside,
        
        od_outside => od_outside,
        od_inside => od_inside
        );
        
    process begin

--    rst <= '1', '0' after 2ns;
--    ir <= '0', '1' after 7 ns;
--    -- we're in (0,0) and going to (3,0)
--    id <= "0000000000000011"; -- expecting to get (1,0)(3,0) (inside)
    
--    oa_outside <= '0';
--    oa_inside <= '0';

--    wait until or_inside = '1';
--    wait for 7ns;
    
    
    
--    wait for 30 ns;
--    assert od_inside = "0000000100000011" report "fail" severity failure; 
    
--    finish;
    ------------------------------------------------------
    
--    rst <= '1', '0' after 2ns;
--    ir <= '0', '1' after 7 ns;
--    -- we're in (0,3) and going to (0,1)
--    id <= "0011000000010000"; -- expecting to get (0,2) (0,1) (inside)
    
--    oa_outside <= '0';
--    oa_inside <= '0';

--    wait until or_inside = '1';
--    wait for 7ns;
    
    
    
--    wait for 30 ns;
--    assert od_inside = "0010000000010000" report "fail" severity failure; 
    
--    finish;


    
    rst <= '1', '0' after 2ns;
    ir <= '0', '1' after 7 ns;
    -- we're in (0,3) and going to (0,3)
    id <= "0011000000110000"; -- expecting to get (0,3) (0,3) (outside)
    
    oa_outside <= '0';
    oa_inside <= '0';

    wait until or_outside = '1';
    wait for 7ns;
    
    
    
    wait for 30 ns;
    assert od_outside = "0011000000110000" report "fail" severity failure; 
    

    
    end process;
end architecture;
