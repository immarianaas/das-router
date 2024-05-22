----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2024 11:40:35 AM
-- Design Name: 
-- Module Name: demux3 - Behavioral
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
use work.demux;
USE work.defs.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux3 is
  port(
    rst           : in  std_logic;
    -- Input port
    inA_req       : in  std_logic;
    inA_data      : in std_logic_vector(DATA_WIDTH-1 downto 0);
    inA_ack       : out std_logic;
    -- Select port 
    inSel_req     : in  std_logic;
    inSel_ack     : out std_logic;
    selector      : in std_logic_vector(1 downto 0);
    -- Output channel 1
    out_oblique_req      : out std_logic;
    out_oblique_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    out_oblique_ack      : in  std_logic;
    -- Output channel 2
    out_horizontal_req      : out std_logic;
    out_horizontal_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    out_horizontal_ack      : in  std_logic;
    -- Output channel 3
    out_vertical_req      : out std_logic;
    out_vertical_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
    out_vertical_ack      : in  std_logic
    );
end demux3;

architecture Behavioral of demux3 is

    signal req1, req2 : std_logic;
    signal ack1, ack2 : std_logic;
    signal data1, data2 : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal shady_ack_oblique, shady_ack_horizontal, shady_ack_vertical : std_logic;

begin

    shady_ack_oblique <= out_oblique_ack; -- after 10ns;
    shady_ack_horizontal <= out_horizontal_ack; -- after 10ns;
    shady_ack_vertical <= out_vertical_ack; -- after 10ns;

    demux1 : entity demux
    port map (
        rst => rst,
        
        inA_req => inA_req,
        inA_data => inA_data,
        inA_ack => inA_ack,
        
        inSel_req => inSel_req,
        inSel_ack => inSel_ack,
        selector => selector(0), -- 00 ILLEGAL DO NOT USE
        
        outB_req => req1,
        outB_ack => ack1,
        outB_data => data1,
        
        outC_req => req2,
        outC_ack => ack2,
        outC_data => data2        
        );
        
    demux2_1 : entity demux
    port map (
        rst => rst,
        
        inA_req => req1,
        inA_data => data1,
        inA_ack => ack1,
        
        inSel_req => req1,
        inSel_ack => ack1,
        selector => selector(1),
        
        outB_req => out_oblique_req,
        outB_ack => shady_ack_oblique,
        outB_data => out_oblique_data,
        
        outC_req => out_horizontal_req,
        outC_ack => shady_ack_horizontal,
        outC_data => out_horizontal_data
        );

    demux2_2 : entity demux
    port map (
        rst => rst,
        
        inA_req => req2,
        inA_data => data2,
        inA_ack => ack2,
        
        inSel_req => req2,
        inSel_ack => ack2,
        selector => selector(1),
        
        outB_req => out_vertical_req,
        outB_ack => shady_ack_vertical,
        outB_data => out_vertical_data,
        
        outC_req => open,
        outC_ack => '0',
        outC_data => open
        );


end Behavioral;



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
USE work.demux3;

entity demux3_tb is
end entity;

architecture tb of demux3_tb is
    signal rst           : std_logic;
    -- Input port
    signal inA_req       : std_logic;
    signal inA_data      : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal inA_ack       : std_logic;
    -- Select port 
    signal inSel_req     : std_logic;
    signal inSel_ack     : std_logic;
    signal selector      : std_logic_vector(1 downto 0);
    --signal selector      : std_logic;
    -- Output channel 1
    signal outB_req      : std_logic; -- sel = "11"
    signal outB_data     : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal outB_ack      : std_logic;
    -- Output channel 2
    signal outC_req      : std_logic; -- sel = "01"
    signal outC_data     : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal outC_ack      : std_logic;
    -- Output channel 3
    signal outD_req      : std_logic; -- sel = "10"
    signal outD_data     : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal outD_ack      : std_logic;
    

begin

    aaa : entity demux3
        port map (
        rst,
        
        inA_req,
        inA_data,
        inA_ack,
        
        inSel_req,
        inSel_ack,
        selector,
        
        outB_req,
        outB_data,        
        outB_ack,
        
        outC_req,
        outC_data,
        outC_ack,
        
        outD_req,
        outD_data,
        outD_ack
        );
        


process begin

    rst <= '1', '0' after 2ns;
    selector <= "11";
    -------- try 1 -------- 
    
    
    inA_req <= '0', '1' after 20 ns;
    inSel_req <= '0', '1' after 20 ns;

    inA_data <= "0000000000000000000000000000000000000000000000000010000000100000";
    
    outB_ack <= '0';
    outC_ack <= '0';
    outD_ack <= '0';
    
    
    wait until outB_req = '1';
    wait for 20 ns;
    outB_ack <= '1';
    
    wait until inA_ack = '1';    
    wait for 50 ns;
    
    -------- try 2 -------- 
      
    inA_req <= '1', '0' after 20 ns;
    inSel_req <= '1', '0' after 20 ns;
    inA_data <= "0000000000000000000000000000001000000000000000000010000000100000";
    
    wait until outB_req = '0';
    -- wait for 6 ns; -- important!
    outB_ack <= '0';
    
    wait until inA_ack = '0';
    
    wait for 50 ns;
    
    -------- try 3 --------

    inA_req <= '0', '1' after 20 ns;
    inSel_req <= '0', '1' after 20 ns;
    inA_data <= "0000000010000000000000000000000000000000000000000010000000100000";
    
    wait until outB_req = '1';
    wait for 20 ns;
    outB_ack <= '1';
    
    
    wait until inA_ack = '1';

    
    wait for 50 ns;


    
    
    
    
    
    --wait for 50 ns;
    --i_addr <= "0011001100110011";
    
    --wait for 50 ns;
    
    --assert i_req = '0' report "hello" severity failure;


    -- i_req <= '0', '1' after 15 ns;
    
    -- dy, dx, y, x
    --i_addr <= "0000000000000001", "0001000000000000" after 50ns; -- x = 1, y = 0, dx = 0, dy = 0
    
    -- o_addr should be "0101"
    --o_ack_horizontal <= '0', '1' after 25ns; --ack2 and req2 should be the same
    

--------------------

    --wait for 100 ns;
    
    --i_req <= '0', '1' after 50 ns;
    
    -- dy, dx, y, x
    --i_addr <= "0001000000000000"; -- x = 1, y = 0, dx = 0, dy = 1
    
    -- o_addr should be "0101" ?
    --o_ack_horizontal <= '0', '1' after 75ns; --ack2 and req2 should be the same
    
    end process;
end architecture;

