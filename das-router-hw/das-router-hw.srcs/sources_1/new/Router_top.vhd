----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2024 04:04:43 PM
-- Design Name: 
-- Module Name: Router_top - Behavioral
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

-- nw, n, ne, e, se, s, sw, w


entity router_node_top is
    Port ( 
        ia_nw:  in std_logic;
        ia_n:   in std_logic;
        ia_ne:  in std_logic;
        ia_e:   in std_logic;
        ia_se:  in std_logic;
        ia_s:   in std_logic;
        ia_sw:  in std_logic;
        ia_w:   in std_logic;
        
        ir_nw:  in std_logic;
        ir_n:   in std_logic;
        ir_ne:  in std_logic;
        ir_e:   in std_logic;
        ir_se:  in std_logic;
        ir_s:   in std_logic;
        ir_sw:  in std_logic;
        ir_w:   in std_logic;
        
        id_nw:  in std_logic_vector(16 downto 0);
        id_n:   in std_logic_vector(16 downto 0);
        id_ne:  in std_logic_vector(16 downto 0);
        id_e:   in std_logic_vector(16 downto 0);
        id_se:  in std_logic_vector(16 downto 0);
        id_s:   in std_logic_vector(16 downto 0);
        id_sw:  in std_logic_vector(16 downto 0);
        id_w:   in std_logic_vector(16 downto 0);
        
        oa_nw:  out std_logic;
        oa_n:   out std_logic;
        oa_ne:  out std_logic;
        oa_e:   out std_logic;
        oa_se:  out std_logic;
        oa_s:   out std_logic;
        oa_sw:  out std_logic;
        oa_w:   out std_logic;
         
        or_nw:  out std_logic;
        or_n:   out std_logic;
        or_ne:  out std_logic;
        or_e:   out std_logic;
        or_se:  out std_logic;
        or_s:   out std_logic;
        or_sw:  out std_logic;
        or_w:   out std_logic;
        
        od_nw:  out std_logic_vector(16 downto 0);
        od_n:   out std_logic_vector(16 downto 0);
        od_ne:  out std_logic_vector(16 downto 0);
        od_e:   out std_logic_vector(16 downto 0);
        od_se:  out std_logic_vector(16 downto 0);
        od_s:   out std_logic_vector(16 downto 0);
        od_sw:  out std_logic_vector(16 downto 0);
        od_w:   out std_logic_vector(16 downto 0)  
        
    );
end router_node_top;

architecture Behavioral of router_node_top is

begin


end Behavioral;
