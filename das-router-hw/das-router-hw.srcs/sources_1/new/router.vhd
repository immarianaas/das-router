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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity router is
    port ( 
        i_req:  in std_logic;
        addr:   in std_logic_vector(16 downto 0);
        o_req0: out std_logic;
        o_req1: out std_logic;
        o_req2: out std_logic;
        
        -- unsure if right, but:
        -- additional ports that we didn't thought of before
        i_ack:  in std_logic;
        o_ack0: out std_logic;
        o_ack1: out std_logic;
        o_ack2: out std_logic
    );
end router;

architecture Behavioral of router is

begin


end Behavioral;
