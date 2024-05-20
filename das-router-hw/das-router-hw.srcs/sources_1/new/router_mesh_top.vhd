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
use work.corner_node_top;
use work.side_node_top;


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
        ack_33_in: out std_logic;
        
        data_test: out std_logic_vector(DATA_WIDTH-1 downto 0);
        req_test: out std_logic;
        ack_test: out std_logic

    );
end router_mesh_top;

architecture Behavioral of router_mesh_top is


signal ack_01_00 : std_logic;
signal req_01_00 : std_logic;
signal data_01_00: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_00_01 : std_logic;
signal req_00_01 : std_logic;
signal data_00_01: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_00 : std_logic;
signal req_11_00 : std_logic;
signal data_11_00: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_00_11 : std_logic;
signal req_00_11 : std_logic;
signal data_00_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_00 : std_logic;
signal req_10_00 : std_logic;
signal data_10_00: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_00_10 : std_logic;
signal req_00_10 : std_logic;
signal data_00_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_01 : std_logic;
signal req_02_01 : std_logic;
signal data_02_01: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_02 : std_logic;
signal req_01_02 : std_logic;
signal data_01_02: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_01 : std_logic;
signal req_12_01 : std_logic;
signal data_12_01: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_12 : std_logic;
signal req_01_12 : std_logic;
signal data_01_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_01 : std_logic;
signal req_11_01 : std_logic;
signal data_11_01: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_11 : std_logic;
signal req_01_11 : std_logic;
signal data_01_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_01 : std_logic;
signal req_10_01 : std_logic;
signal data_10_01: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_01_10 : std_logic;
signal req_01_10 : std_logic;
signal data_01_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_03_02 : std_logic;
signal req_03_02 : std_logic;
signal data_03_02: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_03 : std_logic;
signal req_02_03 : std_logic;
signal data_02_03: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_02 : std_logic;
signal req_13_02 : std_logic;
signal data_13_02: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_13 : std_logic;
signal req_02_13 : std_logic;
signal data_02_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_02 : std_logic;
signal req_12_02 : std_logic;
signal data_12_02: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_12 : std_logic;
signal req_02_12 : std_logic;
signal data_02_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_02 : std_logic;
signal req_11_02 : std_logic;
signal data_11_02: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_02_11 : std_logic;
signal req_02_11 : std_logic;
signal data_02_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_03 : std_logic;
signal req_13_03 : std_logic;
signal data_13_03: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_03_13 : std_logic;
signal req_03_13 : std_logic;
signal data_03_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_03 : std_logic;
signal req_12_03 : std_logic;
signal data_12_03: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_03_12 : std_logic;
signal req_03_12 : std_logic;
signal data_03_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_10 : std_logic;
signal req_11_10 : std_logic;
signal data_11_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_11 : std_logic;
signal req_10_11 : std_logic;
signal data_10_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_10 : std_logic;
signal req_21_10 : std_logic;
signal data_21_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_21 : std_logic;
signal req_10_21 : std_logic;
signal data_10_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_10 : std_logic;
signal req_20_10 : std_logic;
signal data_20_10: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_10_20 : std_logic;
signal req_10_20 : std_logic;
signal data_10_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_11 : std_logic;
signal req_12_11 : std_logic;
signal data_12_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_12 : std_logic;
signal req_11_12 : std_logic;
signal data_11_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_11 : std_logic;
signal req_22_11 : std_logic;
signal data_22_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_22 : std_logic;
signal req_11_22 : std_logic;
signal data_11_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_11 : std_logic;
signal req_21_11 : std_logic;
signal data_21_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_21 : std_logic;
signal req_11_21 : std_logic;
signal data_11_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_11 : std_logic;
signal req_20_11 : std_logic;
signal data_20_11: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_11_20 : std_logic;
signal req_11_20 : std_logic;
signal data_11_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_12 : std_logic;
signal req_13_12 : std_logic;
signal data_13_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_13 : std_logic;
signal req_12_13 : std_logic;
signal data_12_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_12 : std_logic;
signal req_23_12 : std_logic;
signal data_23_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_23 : std_logic;
signal req_12_23 : std_logic;
signal data_12_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_12 : std_logic;
signal req_22_12 : std_logic;
signal data_22_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_22 : std_logic;
signal req_12_22 : std_logic;
signal data_12_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_12 : std_logic;
signal req_21_12 : std_logic;
signal data_21_12: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_12_21 : std_logic;
signal req_12_21 : std_logic;
signal data_12_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_13 : std_logic;
signal req_23_13 : std_logic;
signal data_23_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_23 : std_logic;
signal req_13_23 : std_logic;
signal data_13_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_13 : std_logic;
signal req_22_13 : std_logic;
signal data_22_13: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_13_22 : std_logic;
signal req_13_22 : std_logic;
signal data_13_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_20 : std_logic;
signal req_21_20 : std_logic;
signal data_21_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_21 : std_logic;
signal req_20_21 : std_logic;
signal data_20_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_31_20 : std_logic;
signal req_31_20 : std_logic;
signal data_31_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_31 : std_logic;
signal req_20_31 : std_logic;
signal data_20_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_30_20 : std_logic;
signal req_30_20 : std_logic;
signal data_30_20: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_20_30 : std_logic;
signal req_20_30 : std_logic;
signal data_20_30: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_21 : std_logic;
signal req_22_21 : std_logic;
signal data_22_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_22 : std_logic;
signal req_21_22 : std_logic;
signal data_21_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_32_21 : std_logic;
signal req_32_21 : std_logic;
signal data_32_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_32 : std_logic;
signal req_21_32 : std_logic;
signal data_21_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_31_21 : std_logic;
signal req_31_21 : std_logic;
signal data_31_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_31 : std_logic;
signal req_21_31 : std_logic;
signal data_21_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_30_21 : std_logic;
signal req_30_21 : std_logic;
signal data_30_21: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_21_30 : std_logic;
signal req_21_30 : std_logic;
signal data_21_30: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_22 : std_logic;
signal req_23_22 : std_logic;
signal data_23_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_23 : std_logic;
signal req_22_23 : std_logic;
signal data_22_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_33_22 : std_logic;
signal req_33_22 : std_logic;
signal data_33_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_33 : std_logic;
signal req_22_33 : std_logic;
signal data_22_33: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_32_22 : std_logic;
signal req_32_22 : std_logic;
signal data_32_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_32 : std_logic;
signal req_22_32 : std_logic;
signal data_22_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_31_22 : std_logic;
signal req_31_22 : std_logic;
signal data_31_22: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_22_31 : std_logic;
signal req_22_31 : std_logic;
signal data_22_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_33_23 : std_logic;
signal req_33_23 : std_logic;
signal data_33_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_33 : std_logic;
signal req_23_33 : std_logic;
signal data_23_33: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_32_23 : std_logic;
signal req_32_23 : std_logic;
signal data_32_23: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_23_32 : std_logic;
signal req_23_32 : std_logic;
signal data_23_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_31_30 : std_logic;
signal req_31_30 : std_logic;
signal data_31_30: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_30_31 : std_logic;
signal req_30_31 : std_logic;
signal data_30_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_32_31 : std_logic;
signal req_32_31 : std_logic;
signal data_32_31: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_31_32 : std_logic;
signal req_31_32 : std_logic;
signal data_31_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_33_32 : std_logic;
signal req_33_32 : std_logic;
signal data_33_32: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ack_32_33 : std_logic;
signal req_32_33 : std_logic;
signal data_32_33: std_logic_vector(DATA_WIDTH-1 downto 0);


signal zero: std_logic;


begin

zero <= '0';

data_test <= data_12_23;
req_test <= req_12_23;
ack_test <= ack_23_12;


    router00: entity corner_node_top
    generic map(
        CORNER => 3
    )
    port map(
        rst => rst,
        ia  => ack_00_in,
        ir  => req_00_in,
        id  => data_00_in,
        oa  => ack_00_out,
        orr => req_00_out,
        od  => data_00_out,
        
        oa_horizontal => ack_10_00,
        oa_vertical   => ack_01_00,
        oa_oblique    => ack_11_00,
        ia_horizontal => ack_00_10,
        ia_vertical   => ack_00_01,
        ia_oblique    => ack_00_11,
        
        or_horizontal => req_00_10,
        or_vertical   => req_00_01,
        or_oblique    => req_00_11,
        ir_horizontal => req_10_00,
        ir_vertical   => req_01_00,
        ir_oblique    => req_11_00,
        
        od_horizontal => data_00_10,
        od_vertical   => data_00_01,
        od_oblique    => data_00_11,
        id_horizontal => data_10_00,
        id_vertical   => data_01_00,
        id_oblique    => data_11_00
    );
    

    router01: entity side_node_top
    generic map( 
        SIDE => 1
    )
    port map (
        rst => rst,
        ia  => ack_01_in,
        ir  => req_01_in,
        id  => data_01_in,
        oa  => ack_01_out,
        orr => req_01_out,
        od  => data_01_out,
        
        or_straight => req_01_11,
        oa_straight => ack_11_01,
        od_straight => data_01_11,
        
        ir_straight => req_11_01,
        ia_straight => ack_01_11,
        id_straight => data_11_01,
        
        or_left => req_01_02,
        oa_left => ack_02_01,
        od_left => data_01_02,
        
        ir_left => req_02_01,
        ia_left => ack_01_02,
        id_left => data_02_01,
        
        or_right => req_01_00,
        oa_right => ack_00_01,
        od_right => data_01_00,
        
        ir_right => req_00_01,
        ia_right => ack_01_00,
        id_right => data_00_01,
        
        or_lefto => req_01_12,
        oa_lefto => ack_12_01,
        od_lefto => data_01_12,
        
        ir_lefto => req_12_01,
        ia_lefto => ack_01_12,
        id_lefto => data_12_01,
        
        or_righto => req_01_10,
        oa_righto => ack_10_01,
        od_righto => data_01_10,
        
        ir_righto => req_10_01,
        ia_righto => ack_01_10,
        id_righto => data_10_01
    );
    

    router02: entity side_node_top
    generic map( 
        SIDE => 1
    )
    port map (
        rst => rst,
        ia  => ack_02_in,
        ir  => req_02_in,
        id  => data_02_in,
        oa  => ack_02_out,
        orr => req_02_out,
        od  => data_02_out,
        
        or_straight => req_02_12,
        oa_straight => ack_12_02,
        od_straight => data_02_12,
        
        ir_straight => req_12_02,
        ia_straight => ack_02_12,
        id_straight => data_12_02,
        
        or_left => req_02_03,
        oa_left => ack_03_02,
        od_left => data_02_03,
        
        ir_left => req_03_02,
        ia_left => ack_02_03,
        id_left => data_03_02,
        
        or_right => req_02_01,
        oa_right => ack_01_02,
        od_right => data_02_01,
        
        ir_right => req_01_02,
        ia_right => ack_02_01,
        id_right => data_01_02,
        
        or_lefto => req_02_13,
        oa_lefto => ack_13_02,
        od_lefto => data_02_13,
        
        ir_lefto => req_13_02,
        ia_lefto => ack_02_13,
        id_lefto => data_13_02,
        
        or_righto => req_02_11,
        oa_righto => ack_11_02,
        od_righto => data_02_11,
        
        ir_righto => req_11_02,
        ia_righto => ack_02_11,
        id_righto => data_11_02
    );
    

    router03: entity corner_node_top
    generic map(
        CORNER => 0
    )
    port map(
        rst => rst,
        ia  => ack_03_in,
        ir  => req_03_in,
        id  => data_03_in,
        oa  => ack_03_out,
        orr => req_03_out,
        od  => data_03_out,
        
        oa_horizontal => ack_13_03,
        oa_vertical   => ack_02_03,
        oa_oblique    => ack_12_03,
        ia_horizontal => ack_03_13,
        ia_vertical   => ack_03_02,
        ia_oblique    => ack_03_12,
        
        or_horizontal => req_03_13,
        or_vertical   => req_03_02,
        or_oblique    => req_03_12,
        ir_horizontal => req_13_03,
        ir_vertical   => req_02_03,
        ir_oblique    => req_12_03,
        
        od_horizontal => data_03_13,
        od_vertical   => data_03_02,
        od_oblique    => data_03_12,
        id_horizontal => data_13_03,
        id_vertical   => data_02_03,
        id_oblique    => data_12_03
    );
    

    router10: entity side_node_top
    generic map( 
        SIDE => 2
    )
    port map (
        rst => rst,
        ia  => ack_10_in,
        ir  => req_10_in,
        id  => data_10_in,
        oa  => ack_10_out,
        orr => req_10_out,
        od  => data_10_out,
        
        or_straight => req_10_11,
        oa_straight => ack_11_10,
        od_straight => data_10_11,
        
        ir_straight => req_11_10,
        ia_straight => ack_10_11,
        id_straight => data_11_10,
        
        or_left => req_10_00,
        oa_left => ack_00_10,
        od_left => data_10_00,
        
        ir_left => req_00_10,
        ia_left => ack_10_00,
        id_left => data_00_10,
        
        or_right => req_10_20,
        oa_right => ack_20_10,
        od_right => data_10_20,
        
        ir_right => req_20_10,
        ia_right => ack_10_20,
        id_right => data_20_10,
        
        or_lefto => req_10_01,
        oa_lefto => ack_01_10,
        od_lefto => data_10_01,
        
        ir_lefto => req_01_10,
        ia_lefto => ack_10_01,
        id_lefto => data_01_10,
        
        or_righto => req_10_21,
        oa_righto => ack_21_10,
        od_righto => data_10_21,
        
        ir_righto => req_21_10,
        ia_righto => ack_10_21,
        id_righto => data_21_10
    );
    


  router11: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_11_02,
        ia_n =>     ack_11_12,
        ia_ne =>    ack_11_22,
        ia_e =>     ack_11_21,
        ia_se =>    ack_11_20,
        ia_s =>     ack_11_10,
        ia_sw =>    ack_11_00,
        ia_w =>     ack_11_01,

        ir_nw   => req_02_11,
        ir_n    => req_12_11,
        ir_ne   => req_22_11,
        ir_e    => req_21_11,
        ir_se   => req_20_11,
        ir_s    => req_10_11,
        ir_sw   => req_00_11,
        ir_w    => req_01_11,
        
        id_nw   => data_02_11,
        id_n    => data_12_11,
        id_ne   => data_22_11,
        id_e    => data_21_11,
        id_se   => data_20_11,
        id_s    => data_10_11,
        id_sw   => data_00_11,
        id_w    => data_01_11,

        oa_nw   => ack_02_11,
        oa_n    => ack_12_11,
        oa_ne   => ack_22_11,
        oa_e    => ack_21_11,
        oa_se   => ack_20_11,
        oa_s    => ack_10_11,
        oa_sw   => ack_00_11,
        oa_w    => ack_01_11,

        or_nw   => req_11_02,
        or_n    => req_11_12,
        or_ne   => req_11_22,
        or_e    => req_11_21,
        or_se   => req_11_20,
        or_s    => req_11_10,
        or_sw   => req_11_00,
        or_w    => req_11_01,

        od_nw   => data_11_02,
        od_n    => data_11_12,
        od_ne   => data_11_22,
        od_e    => data_11_21,
        od_se   => data_11_20,
        od_s    => data_11_10,
        od_sw   => data_11_00,
        od_w    => data_11_01
     );
      
   


  router12: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_12_03,
        ia_n =>     ack_12_13,
        ia_ne =>    ack_12_23,
        ia_e =>     ack_12_22,
        ia_se =>    ack_12_21,
        ia_s =>     ack_12_11,
        ia_sw =>    ack_12_01,
        ia_w =>     ack_12_02,

        ir_nw   => req_03_12,
        ir_n    => req_13_12,
        ir_ne   => req_23_12,
        ir_e    => req_22_12,
        ir_se   => req_21_12,
        ir_s    => req_11_12,
        ir_sw   => req_01_12,
        ir_w    => req_02_12,
        
        id_nw   => data_03_12,
        id_n    => data_13_12,
        id_ne   => data_23_12,
        id_e    => data_22_12,
        id_se   => data_21_12,
        id_s    => data_11_12,
        id_sw   => data_01_12,
        id_w    => data_02_12,

        oa_nw   => ack_03_12,
        oa_n    => ack_13_12,
        oa_ne   => ack_23_12,
        oa_e    => ack_22_12,
        oa_se   => ack_21_12,
        oa_s    => ack_11_12,
        oa_sw   => ack_01_12,
        oa_w    => ack_02_12,

        or_nw   => req_12_03,
        or_n    => req_12_13,
        or_ne   => req_12_23,
        or_e    => req_12_22,
        or_se   => req_12_21,
        or_s    => req_12_11,
        or_sw   => req_12_01,
        or_w    => req_12_02,

        od_nw   => data_12_03,
        od_n    => data_12_13,
        od_ne   => data_12_23,
        od_e    => data_12_22,
        od_se   => data_12_21,
        od_s    => data_12_11,
        od_sw   => data_12_01,
        od_w    => data_12_02
     );
      
   

    router13: entity side_node_top
    generic map( 
        SIDE => 0
    )
    port map (
        rst => rst,
        ia  => ack_13_in,
        ir  => req_13_in,
        id  => data_13_in,
        oa  => ack_13_out,
        orr => req_13_out,
        od  => data_13_out,
        
        or_straight => req_13_12,
        oa_straight => ack_12_13,
        od_straight => data_13_12,
        
        ir_straight => req_12_13,
        ia_straight => ack_13_12,
        id_straight => data_12_13,
        
        or_left => req_13_23,
        oa_left => ack_23_13,
        od_left => data_13_23,
        
        ir_left => req_23_13,
        ia_left => ack_13_23,
        id_left => data_23_13,
        
        or_right => req_13_03,
        oa_right => ack_03_13,
        od_right => data_13_03,
        
        ir_right => req_03_13,
        ia_right => ack_13_03,
        id_right => data_03_13,
        
        or_lefto => req_13_22,
        oa_lefto => ack_22_13,
        od_lefto => data_13_22,
        
        ir_lefto => req_22_13,
        ia_lefto => ack_13_22,
        id_lefto => data_22_13,
        
        or_righto => req_13_02,
        oa_righto => ack_02_13,
        od_righto => data_13_02,
        
        ir_righto => req_02_13,
        ia_righto => ack_13_02,
        id_righto => data_02_13
    );
    

    router20: entity side_node_top
    generic map( 
        SIDE => 2
    )
    port map (
        rst => rst,
        ia  => ack_20_in,
        ir  => req_20_in,
        id  => data_20_in,
        oa  => ack_20_out,
        orr => req_20_out,
        od  => data_20_out,
        
        or_straight => req_20_21,
        oa_straight => ack_21_20,
        od_straight => data_20_21,
        
        ir_straight => req_21_20,
        ia_straight => ack_20_21,
        id_straight => data_21_20,
        
        or_left => req_20_10,
        oa_left => ack_10_20,
        od_left => data_20_10,
        
        ir_left => req_10_20,
        ia_left => ack_20_10,
        id_left => data_10_20,
        
        or_right => req_20_30,
        oa_right => ack_30_20,
        od_right => data_20_30,
        
        ir_right => req_30_20,
        ia_right => ack_20_30,
        id_right => data_30_20,
        
        or_lefto => req_20_11,
        oa_lefto => ack_11_20,
        od_lefto => data_20_11,
        
        ir_lefto => req_11_20,
        ia_lefto => ack_20_11,
        id_lefto => data_11_20,
        
        or_righto => req_20_31,
        oa_righto => ack_31_20,
        od_righto => data_20_31,
        
        ir_righto => req_31_20,
        ia_righto => ack_20_31,
        id_righto => data_31_20
    );
    


  router21: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_21_12,
        ia_n =>     ack_21_22,
        ia_ne =>    ack_21_32,
        ia_e =>     ack_21_31,
        ia_se =>    ack_21_30,
        ia_s =>     ack_21_20,
        ia_sw =>    ack_21_10,
        ia_w =>     ack_21_11,

        ir_nw   => req_12_21,
        ir_n    => req_22_21,
        ir_ne   => req_32_21,
        ir_e    => req_31_21,
        ir_se   => req_30_21,
        ir_s    => req_20_21,
        ir_sw   => req_10_21,
        ir_w    => req_11_21,
        
        id_nw   => data_12_21,
        id_n    => data_22_21,
        id_ne   => data_32_21,
        id_e    => data_31_21,
        id_se   => data_30_21,
        id_s    => data_20_21,
        id_sw   => data_10_21,
        id_w    => data_11_21,

        oa_nw   => ack_12_21,
        oa_n    => ack_22_21,
        oa_ne   => ack_32_21,
        oa_e    => ack_31_21,
        oa_se   => ack_30_21,
        oa_s    => ack_20_21,
        oa_sw   => ack_10_21,
        oa_w    => ack_11_21,

        or_nw   => req_21_12,
        or_n    => req_21_22,
        or_ne   => req_21_32,
        or_e    => req_21_31,
        or_se   => req_21_30,
        or_s    => req_21_20,
        or_sw   => req_21_10,
        or_w    => req_21_11,

        od_nw   => data_21_12,
        od_n    => data_21_22,
        od_ne   => data_21_32,
        od_e    => data_21_31,
        od_se   => data_21_30,
        od_s    => data_21_20,
        od_sw   => data_21_10,
        od_w    => data_21_11
     );
      
   


  router22: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    ack_22_13,
        ia_n =>     ack_22_23,
        ia_ne =>    ack_22_33,
        ia_e =>     ack_22_32,
        ia_se =>    ack_22_31,
        ia_s =>     ack_22_21,
        ia_sw =>    ack_22_11,
        ia_w =>     ack_22_12,

        ir_nw   => req_13_22,
        ir_n    => req_23_22,
        ir_ne   => req_33_22,
        ir_e    => req_32_22,
        ir_se   => req_31_22,
        ir_s    => req_21_22,
        ir_sw   => req_11_22,
        ir_w    => req_12_22,
        
        id_nw   => data_13_22,
        id_n    => data_23_22,
        id_ne   => data_33_22,
        id_e    => data_32_22,
        id_se   => data_31_22,
        id_s    => data_21_22,
        id_sw   => data_11_22,
        id_w    => data_12_22,

        oa_nw   => ack_13_22,
        oa_n    => ack_23_22,
        oa_ne   => ack_33_22,
        oa_e    => ack_32_22,
        oa_se   => ack_31_22,
        oa_s    => ack_21_22,
        oa_sw   => ack_11_22,
        oa_w    => ack_12_22,

        or_nw   => req_22_13,
        or_n    => req_22_23,
        or_ne   => req_22_33,
        or_e    => req_22_32,
        or_se   => req_22_31,
        or_s    => req_22_21,
        or_sw   => req_22_11,
        or_w    => req_22_12,

        od_nw   => data_22_13,
        od_n    => data_22_23,
        od_ne   => data_22_33,
        od_e    => data_22_32,
        od_se   => data_22_31,
        od_s    => data_22_21,
        od_sw   => data_22_11,
        od_w    => data_22_12
     );
      
   

    router23: entity side_node_top
    generic map( 
        SIDE => 0
    )
    port map (
        rst => rst,
        ia  => ack_23_in,
        ir  => req_23_in,
        id  => data_23_in,
        oa  => ack_23_out,
        orr => req_23_out,
        od  => data_23_out,
        
        or_straight => req_23_22,
        oa_straight => ack_22_23,
        od_straight => data_23_22,
        
        ir_straight => req_22_23,
        ia_straight => ack_23_22,
        id_straight => data_22_23,
        
        or_left => req_23_33,
        oa_left => ack_33_23,
        od_left => data_23_33,
        
        ir_left => req_33_23,
        ia_left => ack_23_33,
        id_left => data_33_23,
        
        or_right => req_23_13,
        oa_right => ack_13_23,
        od_right => data_23_13,
        
        ir_right => req_13_23,
        ia_right => ack_23_13,
        id_right => data_13_23,
        
        or_lefto => req_23_32,
        oa_lefto => ack_32_23,
        od_lefto => data_23_32,
        
        ir_lefto => req_32_23,
        ia_lefto => ack_23_32,
        id_lefto => data_32_23,
        
        or_righto => req_23_12,
        oa_righto => ack_12_23,
        od_righto => data_23_12,
        
        ir_righto => req_12_23,
        ia_righto => ack_23_12,
        id_righto => data_12_23
    );
    

    router30: entity corner_node_top
    generic map(
        CORNER => 2
    )
    port map(
        rst => rst,
        ia  => ack_30_in,
        ir  => req_30_in,
        id  => data_30_in,
        oa  => ack_30_out,
        orr => req_30_out,
        od  => data_30_out,
        
        oa_horizontal => ack_20_30,
        oa_vertical   => ack_31_30,
        oa_oblique    => ack_21_30,
        ia_horizontal => ack_30_20,
        ia_vertical   => ack_30_31,
        ia_oblique    => ack_30_21,
        
        or_horizontal => req_30_20,
        or_vertical   => req_30_31,
        or_oblique    => req_30_21,
        ir_horizontal => req_20_30,
        ir_vertical   => req_31_30,
        ir_oblique    => req_21_30,
        
        od_horizontal => data_30_20,
        od_vertical   => data_30_31,
        od_oblique    => data_30_21,
        id_horizontal => data_20_30,
        id_vertical   => data_31_30,
        id_oblique    => data_21_30
    );
    

    router31: entity side_node_top
    generic map( 
        SIDE => 3
    )
    port map (
        rst => rst,
        ia  => ack_31_in,
        ir  => req_31_in,
        id  => data_31_in,
        oa  => ack_31_out,
        orr => req_31_out,
        od  => data_31_out,
        
        or_straight => req_31_21,
        oa_straight => ack_21_31,
        od_straight => data_31_21,
        
        ir_straight => req_21_31,
        ia_straight => ack_31_21,
        id_straight => data_21_31,
        
        or_left => req_31_30,
        oa_left => ack_30_31,
        od_left => data_31_30,
        
        ir_left => req_30_31,
        ia_left => ack_31_30,
        id_left => data_30_31,
        
        or_right => req_31_32,
        oa_right => ack_32_31,
        od_right => data_31_32,
        
        ir_right => req_32_31,
        ia_right => ack_31_32,
        id_right => data_32_31,
        
        or_lefto => req_31_20,
        oa_lefto => ack_20_31,
        od_lefto => data_31_20,
        
        ir_lefto => req_20_31,
        ia_lefto => ack_31_20,
        id_lefto => data_20_31,
        
        or_righto => req_31_22,
        oa_righto => ack_22_31,
        od_righto => data_31_22,
        
        ir_righto => req_22_31,
        ia_righto => ack_31_22,
        id_righto => data_22_31
    );
    

    router32: entity side_node_top
    generic map( 
        SIDE => 3
    )
    port map (
        rst => rst,
        ia  => ack_32_in,
        ir  => req_32_in,
        id  => data_32_in,
        oa  => ack_32_out,
        orr => req_32_out,
        od  => data_32_out,
        
        or_straight => req_32_22,
        oa_straight => ack_22_32,
        od_straight => data_32_22,
        
        ir_straight => req_22_32,
        ia_straight => ack_32_22,
        id_straight => data_22_32,
        
        or_left => req_32_31,
        oa_left => ack_31_32,
        od_left => data_32_31,
        
        ir_left => req_31_32,
        ia_left => ack_32_31,
        id_left => data_31_32,
        
        or_right => req_32_33,
        oa_right => ack_33_32,
        od_right => data_32_33,
        
        ir_right => req_33_32,
        ia_right => ack_32_33,
        id_right => data_33_32,
        
        or_lefto => req_32_21,
        oa_lefto => ack_21_32,
        od_lefto => data_32_21,
        
        ir_lefto => req_21_32,
        ia_lefto => ack_32_21,
        id_lefto => data_21_32,
        
        or_righto => req_32_23,
        oa_righto => ack_23_32,
        od_righto => data_32_23,
        
        ir_righto => req_23_32,
        ia_righto => ack_32_23,
        id_righto => data_23_32
    );
    

    router33: entity corner_node_top
    generic map(
        CORNER => 1
    )
    port map(
        rst => rst,
        ia  => ack_33_in,
        ir  => req_33_in,
        id  => data_33_in,
        oa  => ack_33_out,
        orr => req_33_out,
        od  => data_33_out,
        
        oa_horizontal => ack_23_33,
        oa_vertical   => ack_32_33,
        oa_oblique    => ack_22_33,
        ia_horizontal => ack_33_23,
        ia_vertical   => ack_33_32,
        ia_oblique    => ack_33_22,
        
        or_horizontal => req_33_23,
        or_vertical   => req_33_32,
        or_oblique    => req_33_22,
        ir_horizontal => req_23_33,
        ir_vertical   => req_32_33,
        ir_oblique    => req_22_33,
        
        od_horizontal => data_33_23,
        od_vertical   => data_33_32,
        od_oblique    => data_33_22,
        id_horizontal => data_23_33,
        id_vertical   => data_32_33,
        id_oblique    => data_22_33
    );
    
    

   


end Behavioral;
