----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2024 02:09:04 PM
-- Design Name: 
-- Module Name: router_mesh_top - Behavioral
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
use work.router_node_top;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity router_mesh_top is
    Port (
    
        rst : in STD_LOGIC;
             
        data_00_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_00_in: in std_logic;
        ack_00_out: in std_logic;
        data_00_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_00_out: out std_logic;
        ack_00_in: out std_logic;

        data_01_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_01_in: in std_logic;
        ack_01_out: in std_logic;
        data_01_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_01_out: out std_logic;
        ack_01_in: out std_logic;

        data_02_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_02_in: in std_logic;
        ack_02_out: in std_logic;
        data_02_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_02_out: out std_logic;
        ack_02_in: out std_logic;

        data_03_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_03_in: in std_logic;
        ack_03_out: in std_logic;
        data_03_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_03_out: out std_logic;
        ack_03_in: out std_logic;
        
        data_10_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_10_in: in std_logic;
        ack_10_out: in std_logic;
        data_10_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_10_out: out std_logic;
        ack_10_in: out std_logic;
        
        data_11_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_11_in: in std_logic;
        ack_11_out: in std_logic;
        data_11_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_11_out: out std_logic;
        ack_11_in: out std_logic;

        data_12_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_12_in: in std_logic;
        ack_12_out: in std_logic;
        data_12_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_12_out: out std_logic;
        ack_12_in: out std_logic;
        
        data_13_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_13_in: in std_logic;
        ack_13_out: in std_logic;
        data_13_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_13_out: out std_logic;
        ack_13_in: out std_logic;

        data_20_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_20_in: in std_logic;
        ack_20_out: in std_logic;
        data_20_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_20_out: out std_logic;
        ack_20_in: out std_logic;

        data_21_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_21_in: in std_logic;
        ack_21_out: in std_logic;
        data_21_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_21_out: out std_logic;
        ack_21_in: out std_logic;
        
        data_22_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_22_in: in std_logic;
        ack_22_out: in std_logic;
        data_22_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_22_out: out std_logic;
        ack_22_in: out std_logic;
        
        data_23_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_23_in: in std_logic;
        ack_23_out: in std_logic;
        data_23_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_23_out: out std_logic;
        ack_23_in: out std_logic;
        
        data_30_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_30_in: in std_logic;
        ack_30_out: in std_logic;
        data_30_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_30_out: out std_logic;
        ack_30_in: out std_logic;
        
        data_31_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_31_in: in std_logic;
        ack_31_out: in std_logic;
        data_31_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_31_out: out std_logic;
        ack_31_in: out std_logic;
        
        data_32_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_32_in: in std_logic;
        ack_32_out: in std_logic;
        data_32_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_32_out: out std_logic;
        ack_32_in: out std_logic;

        data_33_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        req_33_in: in std_logic;
        ack_33_out: in std_logic;
        data_33_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_33_out: out std_logic;
        ack_33_in: out std_logic

    );
end router_mesh_top;

architecture Behavioral of router_mesh_top is

begin


end Behavioral;
