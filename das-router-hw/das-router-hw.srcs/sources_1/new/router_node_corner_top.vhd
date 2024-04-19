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
use work.defs.all;
use work.arbiter3;
use work.router;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- nw, n, ne, e, se, s, sw, w


entity router_node_corner_top is
    generic(
    DIRECTION: in integer range 0 to 3 := 0
    );
    Port (
        -- some kind of clock signal? The examples have it, and we need it
        rst : in STD_LOGIC;
        --acknowledge
        ia_horizontal : out STD_LOGIC;
        ia_oblique : out STD_LOGIC;
        ia_vertical: out STD_LOGIC;
        oa_outside : in STD_LOGIC;
        
        --request
        or_horizontal : out STD_LOGIC;
        or_oblique: out STD_LOGIC;
        or_vertical: out STD_LOGIC;
        ir_outside : in STD_LOGIC;
        
        --data
        id_horizontal : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        id_oblique : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        id_vertical : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        id_outside : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        od_outside: out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        od_horizontal : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        od_oblique : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        od_vertical : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
        --Should be it TM
        
        
        
        
        
    );
end router_node_corner_top;

architecture Behavioral of router_node_corner_top is

    -- corner 
    signal data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal req_vertical: std_logic;
    signal ack_vertical: std_logic;
    
    signal data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal req_oblique: std_logic;
    signal ack_oblique: std_logic;
    
    signal data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal req_horizontal: std_logic;
    signal ack_horizontal: std_logic;

    
    
     

begin

----------------------------------------------------------------------------------------------------  
  Arbiter: entity arbiter3 
    port map (
    rst => rst,
    inA_req => req_vertical,
    inA_data => data_vertical,
    inA_ack => ack_vertical,
    
    inB_req => req_oblique,
    inB_data => data_oblique,
    inB_ack => ack_oblique,
    
    inC_req => req_horizontal,
    inC_data => data_horizontal,
    inC_ack => ack_horizontal,
    
    out_req => ir_outside,
    out_data => od_outside,
    out_ack => oa_outside
     
    );
    

  Router: entity router
      generic map (
        DIRECTION => 0 --TODO: CHANGE
    )
        port map (
        rst => rst,
        
        i_req => ir,
        i_data => id_outside,
        
        o_data_vertical => data_vertical,
        o_data_oblique => data_oblique,
        o_data_horizontal => data_horizontal,
        
        o_req_vertical => req_vertical,
        o_req_oblique => req_oblique,
        o_req_horizontal => req_horizontal,
        
        i_ack => ia,

        o_ack_vertical => ack_vertical,
        o_ack_oblique => ack_oblique, 
        o_ack_horizontal => ack_horizontal 
     );
      
 
        
end Behavioral;
