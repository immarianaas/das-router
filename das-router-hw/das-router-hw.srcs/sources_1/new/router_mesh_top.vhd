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

signal ack_00_01: std_logic;
signal req_00_01: std_logic;
signal data_00_01: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_00_11: std_logic;
signal req_00_11: std_logic;
signal data_00_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_00_10: std_logic;
signal req_00_10: std_logic;
signal data_00_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_02: std_logic;
signal req_01_02: std_logic;
signal data_01_02: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_12: std_logic;
signal req_01_12: std_logic;
signal data_01_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_11: std_logic;
signal req_01_11: std_logic;
signal data_01_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_10: std_logic;
signal req_01_10: std_logic;
signal data_01_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_03: std_logic;
signal req_02_03: std_logic;
signal data_02_03: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_13: std_logic;
signal req_02_13: std_logic;
signal data_02_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_12: std_logic;
signal req_02_12: std_logic;
signal data_02_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_11: std_logic;
signal req_02_11: std_logic;
signal data_02_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_03_13: std_logic;
signal req_03_13: std_logic;
signal data_03_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_03_12: std_logic;
signal req_03_12: std_logic;
signal data_03_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_11: std_logic;
signal req_10_11: std_logic;
signal data_10_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_21: std_logic;
signal req_10_21: std_logic;
signal data_10_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_20: std_logic;
signal req_10_20: std_logic;
signal data_10_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_12: std_logic;
signal req_11_12: std_logic;
signal data_11_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_22: std_logic;
signal req_11_22: std_logic;
signal data_11_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_21: std_logic;
signal req_11_21: std_logic;
signal data_11_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_20: std_logic;
signal req_11_20: std_logic;
signal data_11_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_13: std_logic;
signal req_12_13: std_logic;
signal data_12_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_23: std_logic;
signal req_12_23: std_logic;
signal data_12_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_22: std_logic;
signal req_12_22: std_logic;
signal data_12_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_21: std_logic;
signal req_12_21: std_logic;
signal data_12_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_23: std_logic;
signal req_13_23: std_logic;
signal data_13_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_22: std_logic;
signal req_13_22: std_logic;
signal data_13_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_21: std_logic;
signal req_20_21: std_logic;
signal data_20_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_31: std_logic;
signal req_20_31: std_logic;
signal data_20_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_30: std_logic;
signal req_20_30: std_logic;
signal data_20_30: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_22: std_logic;
signal req_21_22: std_logic;
signal data_21_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_32: std_logic;
signal req_21_32: std_logic;
signal data_21_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_31: std_logic;
signal req_21_31: std_logic;
signal data_21_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_30: std_logic;
signal req_21_30: std_logic;
signal data_21_30: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_23: std_logic;
signal req_22_23: std_logic;
signal data_22_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_33: std_logic;
signal req_22_33: std_logic;
signal data_22_33: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_32: std_logic;
signal req_22_32: std_logic;
signal data_22_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_31: std_logic;
signal req_22_31: std_logic;
signal data_22_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_33: std_logic;
signal req_23_33: std_logic;
signal data_23_33: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_32: std_logic;
signal req_23_32: std_logic;
signal data_23_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_30_31: std_logic;
signal req_30_31: std_logic;
signal data_30_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_31_32: std_logic;
signal req_31_32: std_logic;
signal data_31_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_32_33: std_logic;
signal req_32_33: std_logic;
signal data_32_33: std_logic_vector(DATA_WIDTH-1 downto 0);




begin

  router00: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_00_in,
        ia_n =>     ack_00_01,
        ia_ne =>    ack_00_11,
        ia_e =>     ack_00_10,
        ia_se =>    ack_00_in,
        ia_s =>     ack_00_in,
        ia_sw =>    ack_00_in,
        ia_w =>     ack_00_in,

        ir_nw   => req_00_in,
        ir_n    => req_00_01,
        ir_ne   => req_00_11,
        ir_e    => req_00_10,
        ir_se   => req_00_in,
        ir_s    => req_00_in,
        ir_sw   => req_00_in,
        ir_w    => req_00_in,
        
        id_nw   => data_00_in,
        id_n    => data_00_01,
        id_ne   => data_00_11,
        id_e    => data_00_10,
        id_se   => data_00_in,
        id_s    => data_00_in,
        id_sw   => data_00_in,
        id_w    => data_00_in,

        oa_nw   => ack_00_out,
        oa_n    => ack_00_01,
        oa_ne   => ack_00_11,
        oa_e    => ack_00_10,
        oa_se   => ack_00_out,
        oa_s    => ack_00_out,
        oa_sw   => ack_00_out,
        oa_w    => ack_00_out,

        or_nw   => req_00_out,
        or_n    => req_00_01,
        or_ne   => req_00_11,
        or_e    => req_00_10,
        or_se   => req_00_out,
        or_s    => req_00_out,
        or_sw   => req_00_out,
        or_w    => req_00_out,

        od_nw   => data_00_out,
        od_n    => data_00_01,
        od_ne   => data_00_11,
        od_e    => data_00_10,
        od_se   => data_00_out,
        od_s    => data_00_out,
        od_sw   => data_00_out,
        od_w    => data_00_out
     );
      
   


  router01: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_01_in,
        ia_n =>     ack_01_02,
        ia_ne =>    ack_01_12,
        ia_e =>     ack_01_11,
        ia_se =>    ack_01_10,
        ia_s =>     ack_00_01,
        ia_sw =>    ack_01_in,
        ia_w =>     ack_01_in,

        ir_nw   => req_01_in,
        ir_n    => req_01_02,
        ir_ne   => req_01_12,
        ir_e    => req_01_11,
        ir_se   => req_01_10,
        ir_s    => req_00_01,
        ir_sw   => req_01_in,
        ir_w    => req_01_in,
        
        id_nw   => data_01_in,
        id_n    => data_01_02,
        id_ne   => data_01_12,
        id_e    => data_01_11,
        id_se   => data_01_10,
        id_s    => data_00_01,
        id_sw   => data_01_in,
        id_w    => data_01_in,

        oa_nw   => ack_01_out,
        oa_n    => ack_01_02,
        oa_ne   => ack_01_12,
        oa_e    => ack_01_11,
        oa_se   => ack_01_10,
        oa_s    => ack_00_01,
        oa_sw   => ack_01_out,
        oa_w    => ack_01_out,

        or_nw   => req_01_out,
        or_n    => req_01_02,
        or_ne   => req_01_12,
        or_e    => req_01_11,
        or_se   => req_01_10,
        or_s    => req_00_01,
        or_sw   => req_01_out,
        or_w    => req_01_out,

        od_nw   => data_01_out,
        od_n    => data_01_02,
        od_ne   => data_01_12,
        od_e    => data_01_11,
        od_se   => data_01_10,
        od_s    => data_00_01,
        od_sw   => data_01_out,
        od_w    => data_01_out
     );
      
   


  router02: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_02_in,
        ia_n =>     ack_02_03,
        ia_ne =>    ack_02_13,
        ia_e =>     ack_02_12,
        ia_se =>    ack_02_11,
        ia_s =>     ack_01_02,
        ia_sw =>    ack_02_in,
        ia_w =>     ack_02_in,

        ir_nw   => req_02_in,
        ir_n    => req_02_03,
        ir_ne   => req_02_13,
        ir_e    => req_02_12,
        ir_se   => req_02_11,
        ir_s    => req_01_02,
        ir_sw   => req_02_in,
        ir_w    => req_02_in,
        
        id_nw   => data_02_in,
        id_n    => data_02_03,
        id_ne   => data_02_13,
        id_e    => data_02_12,
        id_se   => data_02_11,
        id_s    => data_01_02,
        id_sw   => data_02_in,
        id_w    => data_02_in,

        oa_nw   => ack_02_out,
        oa_n    => ack_02_03,
        oa_ne   => ack_02_13,
        oa_e    => ack_02_12,
        oa_se   => ack_02_11,
        oa_s    => ack_01_02,
        oa_sw   => ack_02_out,
        oa_w    => ack_02_out,

        or_nw   => req_02_out,
        or_n    => req_02_03,
        or_ne   => req_02_13,
        or_e    => req_02_12,
        or_se   => req_02_11,
        or_s    => req_01_02,
        or_sw   => req_02_out,
        or_w    => req_02_out,

        od_nw   => data_02_out,
        od_n    => data_02_03,
        od_ne   => data_02_13,
        od_e    => data_02_12,
        od_se   => data_02_11,
        od_s    => data_01_02,
        od_sw   => data_02_out,
        od_w    => data_02_out
     );
      
   


  router03: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_03_in,
        ia_n =>     ack_03_in,
        ia_ne =>    ack_03_in,
        ia_e =>     ack_03_13,
        ia_se =>    ack_03_12,
        ia_s =>     ack_02_03,
        ia_sw =>    ack_03_in,
        ia_w =>     ack_03_in,

        ir_nw   => req_03_in,
        ir_n    => req_03_in,
        ir_ne   => req_03_in,
        ir_e    => req_03_13,
        ir_se   => req_03_12,
        ir_s    => req_02_03,
        ir_sw   => req_03_in,
        ir_w    => req_03_in,
        
        id_nw   => data_03_in,
        id_n    => data_03_in,
        id_ne   => data_03_in,
        id_e    => data_03_13,
        id_se   => data_03_12,
        id_s    => data_02_03,
        id_sw   => data_03_in,
        id_w    => data_03_in,

        oa_nw   => ack_03_out,
        oa_n    => ack_03_out,
        oa_ne   => ack_03_out,
        oa_e    => ack_03_13,
        oa_se   => ack_03_12,
        oa_s    => ack_02_03,
        oa_sw   => ack_03_out,
        oa_w    => ack_03_out,

        or_nw   => req_03_out,
        or_n    => req_03_out,
        or_ne   => req_03_out,
        or_e    => req_03_13,
        or_se   => req_03_12,
        or_s    => req_02_03,
        or_sw   => req_03_out,
        or_w    => req_03_out,

        od_nw   => data_03_out,
        od_n    => data_03_out,
        od_ne   => data_03_out,
        od_e    => data_03_13,
        od_se   => data_03_12,
        od_s    => data_02_03,
        od_sw   => data_03_out,
        od_w    => data_03_out
     );
      
   


  router10: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_01_10,
        ia_n =>     ack_10_11,
        ia_ne =>    ack_10_21,
        ia_e =>     ack_10_20,
        ia_se =>    ack_10_in,
        ia_s =>     ack_10_in,
        ia_sw =>    ack_10_in,
        ia_w =>     ack_00_10,

        ir_nw   => req_01_10,
        ir_n    => req_10_11,
        ir_ne   => req_10_21,
        ir_e    => req_10_20,
        ir_se   => req_10_in,
        ir_s    => req_10_in,
        ir_sw   => req_10_in,
        ir_w    => req_00_10,
        
        id_nw   => data_01_10,
        id_n    => data_10_11,
        id_ne   => data_10_21,
        id_e    => data_10_20,
        id_se   => data_10_in,
        id_s    => data_10_in,
        id_sw   => data_10_in,
        id_w    => data_00_10,

        oa_nw   => ack_01_10,
        oa_n    => ack_10_11,
        oa_ne   => ack_10_21,
        oa_e    => ack_10_20,
        oa_se   => ack_10_out,
        oa_s    => ack_10_out,
        oa_sw   => ack_10_out,
        oa_w    => ack_00_10,

        or_nw   => req_01_10,
        or_n    => req_10_11,
        or_ne   => req_10_21,
        or_e    => req_10_20,
        or_se   => req_10_out,
        or_s    => req_10_out,
        or_sw   => req_10_out,
        or_w    => req_00_10,

        od_nw   => data_01_10,
        od_n    => data_10_11,
        od_ne   => data_10_21,
        od_e    => data_10_20,
        od_se   => data_10_out,
        od_s    => data_10_out,
        od_sw   => data_10_out,
        od_w    => data_00_10
     );
      
   


  router11: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_02_11,
        ia_n =>     ack_11_12,
        ia_ne =>    ack_11_22,
        ia_e =>     ack_11_21,
        ia_se =>    ack_11_20,
        ia_s =>     ack_10_11,
        ia_sw =>    ack_00_11,
        ia_w =>     ack_01_11,

        ir_nw   => req_02_11,
        ir_n    => req_11_12,
        ir_ne   => req_11_22,
        ir_e    => req_11_21,
        ir_se   => req_11_20,
        ir_s    => req_10_11,
        ir_sw   => req_00_11,
        ir_w    => req_01_11,
        
        id_nw   => data_02_11,
        id_n    => data_11_12,
        id_ne   => data_11_22,
        id_e    => data_11_21,
        id_se   => data_11_20,
        id_s    => data_10_11,
        id_sw   => data_00_11,
        id_w    => data_01_11,

        oa_nw   => ack_02_11,
        oa_n    => ack_11_12,
        oa_ne   => ack_11_22,
        oa_e    => ack_11_21,
        oa_se   => ack_11_20,
        oa_s    => ack_10_11,
        oa_sw   => ack_00_11,
        oa_w    => ack_01_11,

        or_nw   => req_02_11,
        or_n    => req_11_12,
        or_ne   => req_11_22,
        or_e    => req_11_21,
        or_se   => req_11_20,
        or_s    => req_10_11,
        or_sw   => req_00_11,
        or_w    => req_01_11,

        od_nw   => data_02_11,
        od_n    => data_11_12,
        od_ne   => data_11_22,
        od_e    => data_11_21,
        od_se   => data_11_20,
        od_s    => data_10_11,
        od_sw   => data_00_11,
        od_w    => data_01_11
     );
      
   


  router12: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_03_12,
        ia_n =>     ack_12_13,
        ia_ne =>    ack_12_23,
        ia_e =>     ack_12_22,
        ia_se =>    ack_12_21,
        ia_s =>     ack_11_12,
        ia_sw =>    ack_01_12,
        ia_w =>     ack_02_12,

        ir_nw   => req_03_12,
        ir_n    => req_12_13,
        ir_ne   => req_12_23,
        ir_e    => req_12_22,
        ir_se   => req_12_21,
        ir_s    => req_11_12,
        ir_sw   => req_01_12,
        ir_w    => req_02_12,
        
        id_nw   => data_03_12,
        id_n    => data_12_13,
        id_ne   => data_12_23,
        id_e    => data_12_22,
        id_se   => data_12_21,
        id_s    => data_11_12,
        id_sw   => data_01_12,
        id_w    => data_02_12,

        oa_nw   => ack_03_12,
        oa_n    => ack_12_13,
        oa_ne   => ack_12_23,
        oa_e    => ack_12_22,
        oa_se   => ack_12_21,
        oa_s    => ack_11_12,
        oa_sw   => ack_01_12,
        oa_w    => ack_02_12,

        or_nw   => req_03_12,
        or_n    => req_12_13,
        or_ne   => req_12_23,
        or_e    => req_12_22,
        or_se   => req_12_21,
        or_s    => req_11_12,
        or_sw   => req_01_12,
        or_w    => req_02_12,

        od_nw   => data_03_12,
        od_n    => data_12_13,
        od_ne   => data_12_23,
        od_e    => data_12_22,
        od_se   => data_12_21,
        od_s    => data_11_12,
        od_sw   => data_01_12,
        od_w    => data_02_12
     );
      
   


  router13: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_13_in,
        ia_n =>     ack_13_in,
        ia_ne =>    ack_13_in,
        ia_e =>     ack_13_23,
        ia_se =>    ack_13_22,
        ia_s =>     ack_12_13,
        ia_sw =>    ack_02_13,
        ia_w =>     ack_03_13,

        ir_nw   => req_13_in,
        ir_n    => req_13_in,
        ir_ne   => req_13_in,
        ir_e    => req_13_23,
        ir_se   => req_13_22,
        ir_s    => req_12_13,
        ir_sw   => req_02_13,
        ir_w    => req_03_13,
        
        id_nw   => data_13_in,
        id_n    => data_13_in,
        id_ne   => data_13_in,
        id_e    => data_13_23,
        id_se   => data_13_22,
        id_s    => data_12_13,
        id_sw   => data_02_13,
        id_w    => data_03_13,

        oa_nw   => ack_13_out,
        oa_n    => ack_13_out,
        oa_ne   => ack_13_out,
        oa_e    => ack_13_23,
        oa_se   => ack_13_22,
        oa_s    => ack_12_13,
        oa_sw   => ack_02_13,
        oa_w    => ack_03_13,

        or_nw   => req_13_out,
        or_n    => req_13_out,
        or_ne   => req_13_out,
        or_e    => req_13_23,
        or_se   => req_13_22,
        or_s    => req_12_13,
        or_sw   => req_02_13,
        or_w    => req_03_13,

        od_nw   => data_13_out,
        od_n    => data_13_out,
        od_ne   => data_13_out,
        od_e    => data_13_23,
        od_se   => data_13_22,
        od_s    => data_12_13,
        od_sw   => data_02_13,
        od_w    => data_03_13
     );
      
   


  router20: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_11_20,
        ia_n =>     ack_20_21,
        ia_ne =>    ack_20_31,
        ia_e =>     ack_20_30,
        ia_se =>    ack_20_in,
        ia_s =>     ack_20_in,
        ia_sw =>    ack_20_in,
        ia_w =>     ack_10_20,

        ir_nw   => req_11_20,
        ir_n    => req_20_21,
        ir_ne   => req_20_31,
        ir_e    => req_20_30,
        ir_se   => req_20_in,
        ir_s    => req_20_in,
        ir_sw   => req_20_in,
        ir_w    => req_10_20,
        
        id_nw   => data_11_20,
        id_n    => data_20_21,
        id_ne   => data_20_31,
        id_e    => data_20_30,
        id_se   => data_20_in,
        id_s    => data_20_in,
        id_sw   => data_20_in,
        id_w    => data_10_20,

        oa_nw   => ack_11_20,
        oa_n    => ack_20_21,
        oa_ne   => ack_20_31,
        oa_e    => ack_20_30,
        oa_se   => ack_20_out,
        oa_s    => ack_20_out,
        oa_sw   => ack_20_out,
        oa_w    => ack_10_20,

        or_nw   => req_11_20,
        or_n    => req_20_21,
        or_ne   => req_20_31,
        or_e    => req_20_30,
        or_se   => req_20_out,
        or_s    => req_20_out,
        or_sw   => req_20_out,
        or_w    => req_10_20,

        od_nw   => data_11_20,
        od_n    => data_20_21,
        od_ne   => data_20_31,
        od_e    => data_20_30,
        od_se   => data_20_out,
        od_s    => data_20_out,
        od_sw   => data_20_out,
        od_w    => data_10_20
     );
      
   


  router21: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_12_21,
        ia_n =>     ack_21_22,
        ia_ne =>    ack_21_32,
        ia_e =>     ack_21_31,
        ia_se =>    ack_21_30,
        ia_s =>     ack_20_21,
        ia_sw =>    ack_10_21,
        ia_w =>     ack_11_21,

        ir_nw   => req_12_21,
        ir_n    => req_21_22,
        ir_ne   => req_21_32,
        ir_e    => req_21_31,
        ir_se   => req_21_30,
        ir_s    => req_20_21,
        ir_sw   => req_10_21,
        ir_w    => req_11_21,
        
        id_nw   => data_12_21,
        id_n    => data_21_22,
        id_ne   => data_21_32,
        id_e    => data_21_31,
        id_se   => data_21_30,
        id_s    => data_20_21,
        id_sw   => data_10_21,
        id_w    => data_11_21,

        oa_nw   => ack_12_21,
        oa_n    => ack_21_22,
        oa_ne   => ack_21_32,
        oa_e    => ack_21_31,
        oa_se   => ack_21_30,
        oa_s    => ack_20_21,
        oa_sw   => ack_10_21,
        oa_w    => ack_11_21,

        or_nw   => req_12_21,
        or_n    => req_21_22,
        or_ne   => req_21_32,
        or_e    => req_21_31,
        or_se   => req_21_30,
        or_s    => req_20_21,
        or_sw   => req_10_21,
        or_w    => req_11_21,

        od_nw   => data_12_21,
        od_n    => data_21_22,
        od_ne   => data_21_32,
        od_e    => data_21_31,
        od_se   => data_21_30,
        od_s    => data_20_21,
        od_sw   => data_10_21,
        od_w    => data_11_21
     );
      
   


  router22: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_13_22,
        ia_n =>     ack_22_23,
        ia_ne =>    ack_22_33,
        ia_e =>     ack_22_32,
        ia_se =>    ack_22_31,
        ia_s =>     ack_21_22,
        ia_sw =>    ack_11_22,
        ia_w =>     ack_12_22,

        ir_nw   => req_13_22,
        ir_n    => req_22_23,
        ir_ne   => req_22_33,
        ir_e    => req_22_32,
        ir_se   => req_22_31,
        ir_s    => req_21_22,
        ir_sw   => req_11_22,
        ir_w    => req_12_22,
        
        id_nw   => data_13_22,
        id_n    => data_22_23,
        id_ne   => data_22_33,
        id_e    => data_22_32,
        id_se   => data_22_31,
        id_s    => data_21_22,
        id_sw   => data_11_22,
        id_w    => data_12_22,

        oa_nw   => ack_13_22,
        oa_n    => ack_22_23,
        oa_ne   => ack_22_33,
        oa_e    => ack_22_32,
        oa_se   => ack_22_31,
        oa_s    => ack_21_22,
        oa_sw   => ack_11_22,
        oa_w    => ack_12_22,

        or_nw   => req_13_22,
        or_n    => req_22_23,
        or_ne   => req_22_33,
        or_e    => req_22_32,
        or_se   => req_22_31,
        or_s    => req_21_22,
        or_sw   => req_11_22,
        or_w    => req_12_22,

        od_nw   => data_13_22,
        od_n    => data_22_23,
        od_ne   => data_22_33,
        od_e    => data_22_32,
        od_se   => data_22_31,
        od_s    => data_21_22,
        od_sw   => data_11_22,
        od_w    => data_12_22
     );
      
   


  router23: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_23_in,
        ia_n =>     ack_23_in,
        ia_ne =>    ack_23_in,
        ia_e =>     ack_23_33,
        ia_se =>    ack_23_32,
        ia_s =>     ack_22_23,
        ia_sw =>    ack_12_23,
        ia_w =>     ack_13_23,

        ir_nw   => req_23_in,
        ir_n    => req_23_in,
        ir_ne   => req_23_in,
        ir_e    => req_23_33,
        ir_se   => req_23_32,
        ir_s    => req_22_23,
        ir_sw   => req_12_23,
        ir_w    => req_13_23,
        
        id_nw   => data_23_in,
        id_n    => data_23_in,
        id_ne   => data_23_in,
        id_e    => data_23_33,
        id_se   => data_23_32,
        id_s    => data_22_23,
        id_sw   => data_12_23,
        id_w    => data_13_23,

        oa_nw   => ack_23_out,
        oa_n    => ack_23_out,
        oa_ne   => ack_23_out,
        oa_e    => ack_23_33,
        oa_se   => ack_23_32,
        oa_s    => ack_22_23,
        oa_sw   => ack_12_23,
        oa_w    => ack_13_23,

        or_nw   => req_23_out,
        or_n    => req_23_out,
        or_ne   => req_23_out,
        or_e    => req_23_33,
        or_se   => req_23_32,
        or_s    => req_22_23,
        or_sw   => req_12_23,
        or_w    => req_13_23,

        od_nw   => data_23_out,
        od_n    => data_23_out,
        od_ne   => data_23_out,
        od_e    => data_23_33,
        od_se   => data_23_32,
        od_s    => data_22_23,
        od_sw   => data_12_23,
        od_w    => data_13_23
     );
      
   


  router30: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_21_30,
        ia_n =>     ack_30_31,
        ia_ne =>    ack_30_in,
        ia_e =>     ack_30_in,
        ia_se =>    ack_30_in,
        ia_s =>     ack_30_in,
        ia_sw =>    ack_30_in,
        ia_w =>     ack_20_30,

        ir_nw   => req_21_30,
        ir_n    => req_30_31,
        ir_ne   => req_30_in,
        ir_e    => req_30_in,
        ir_se   => req_30_in,
        ir_s    => req_30_in,
        ir_sw   => req_30_in,
        ir_w    => req_20_30,
        
        id_nw   => data_21_30,
        id_n    => data_30_31,
        id_ne   => data_30_in,
        id_e    => data_30_in,
        id_se   => data_30_in,
        id_s    => data_30_in,
        id_sw   => data_30_in,
        id_w    => data_20_30,

        oa_nw   => ack_21_30,
        oa_n    => ack_30_31,
        oa_ne   => ack_30_out,
        oa_e    => ack_30_out,
        oa_se   => ack_30_out,
        oa_s    => ack_30_out,
        oa_sw   => ack_30_out,
        oa_w    => ack_20_30,

        or_nw   => req_21_30,
        or_n    => req_30_31,
        or_ne   => req_30_out,
        or_e    => req_30_out,
        or_se   => req_30_out,
        or_s    => req_30_out,
        or_sw   => req_30_out,
        or_w    => req_20_30,

        od_nw   => data_21_30,
        od_n    => data_30_31,
        od_ne   => data_30_out,
        od_e    => data_30_out,
        od_se   => data_30_out,
        od_s    => data_30_out,
        od_sw   => data_30_out,
        od_w    => data_20_30
     );
      
   


  router31: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_22_31,
        ia_n =>     ack_31_32,
        ia_ne =>    ack_31_in,
        ia_e =>     ack_31_in,
        ia_se =>    ack_31_in,
        ia_s =>     ack_30_31,
        ia_sw =>    ack_20_31,
        ia_w =>     ack_21_31,

        ir_nw   => req_22_31,
        ir_n    => req_31_32,
        ir_ne   => req_31_in,
        ir_e    => req_31_in,
        ir_se   => req_31_in,
        ir_s    => req_30_31,
        ir_sw   => req_20_31,
        ir_w    => req_21_31,
        
        id_nw   => data_22_31,
        id_n    => data_31_32,
        id_ne   => data_31_in,
        id_e    => data_31_in,
        id_se   => data_31_in,
        id_s    => data_30_31,
        id_sw   => data_20_31,
        id_w    => data_21_31,

        oa_nw   => ack_22_31,
        oa_n    => ack_31_32,
        oa_ne   => ack_31_out,
        oa_e    => ack_31_out,
        oa_se   => ack_31_out,
        oa_s    => ack_30_31,
        oa_sw   => ack_20_31,
        oa_w    => ack_21_31,

        or_nw   => req_22_31,
        or_n    => req_31_32,
        or_ne   => req_31_out,
        or_e    => req_31_out,
        or_se   => req_31_out,
        or_s    => req_30_31,
        or_sw   => req_20_31,
        or_w    => req_21_31,

        od_nw   => data_22_31,
        od_n    => data_31_32,
        od_ne   => data_31_out,
        od_e    => data_31_out,
        od_se   => data_31_out,
        od_s    => data_30_31,
        od_sw   => data_20_31,
        od_w    => data_21_31
     );
      
   


  router32: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_23_32,
        ia_n =>     ack_32_33,
        ia_ne =>    ack_32_in,
        ia_e =>     ack_32_in,
        ia_se =>    ack_32_in,
        ia_s =>     ack_31_32,
        ia_sw =>    ack_21_32,
        ia_w =>     ack_22_32,

        ir_nw   => req_23_32,
        ir_n    => req_32_33,
        ir_ne   => req_32_in,
        ir_e    => req_32_in,
        ir_se   => req_32_in,
        ir_s    => req_31_32,
        ir_sw   => req_21_32,
        ir_w    => req_22_32,
        
        id_nw   => data_23_32,
        id_n    => data_32_33,
        id_ne   => data_32_in,
        id_e    => data_32_in,
        id_se   => data_32_in,
        id_s    => data_31_32,
        id_sw   => data_21_32,
        id_w    => data_22_32,

        oa_nw   => ack_23_32,
        oa_n    => ack_32_33,
        oa_ne   => ack_32_out,
        oa_e    => ack_32_out,
        oa_se   => ack_32_out,
        oa_s    => ack_31_32,
        oa_sw   => ack_21_32,
        oa_w    => ack_22_32,

        or_nw   => req_23_32,
        or_n    => req_32_33,
        or_ne   => req_32_out,
        or_e    => req_32_out,
        or_se   => req_32_out,
        or_s    => req_31_32,
        or_sw   => req_21_32,
        or_w    => req_22_32,

        od_nw   => data_23_32,
        od_n    => data_32_33,
        od_ne   => data_32_out,
        od_e    => data_32_out,
        od_se   => data_32_out,
        od_s    => data_31_32,
        od_sw   => data_21_32,
        od_w    => data_22_32
     );
      
   


  router33: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_33_in,
        ia_n =>     ack_33_in,
        ia_ne =>    ack_33_in,
        ia_e =>     ack_33_in,
        ia_se =>    ack_33_in,
        ia_s =>     ack_32_33,
        ia_sw =>    ack_22_33,
        ia_w =>     ack_23_33,

        ir_nw   => req_33_in,
        ir_n    => req_33_in,
        ir_ne   => req_33_in,
        ir_e    => req_33_in,
        ir_se   => req_33_in,
        ir_s    => req_32_33,
        ir_sw   => req_22_33,
        ir_w    => req_23_33,
        
        id_nw   => data_33_in,
        id_n    => data_33_in,
        id_ne   => data_33_in,
        id_e    => data_33_in,
        id_se   => data_33_in,
        id_s    => data_32_33,
        id_sw   => data_22_33,
        id_w    => data_23_33,

        oa_nw   => ack_33_out,
        oa_n    => ack_33_out,
        oa_ne   => ack_33_out,
        oa_e    => ack_33_out,
        oa_se   => ack_33_out,
        oa_s    => ack_32_33,
        oa_sw   => ack_22_33,
        oa_w    => ack_23_33,

        or_nw   => req_33_out,
        or_n    => req_33_out,
        or_ne   => req_33_out,
        or_e    => req_33_out,
        or_se   => req_33_out,
        or_s    => req_32_33,
        or_sw   => req_22_33,
        or_w    => req_23_33,

        od_nw   => data_33_out,
        od_n    => data_33_out,
        od_ne   => data_33_out,
        od_e    => data_33_out,
        od_se   => data_33_out,
        od_s    => data_32_33,
        od_sw   => data_22_33,
        od_w    => data_23_33
     );
      
   


end Behavioral;
