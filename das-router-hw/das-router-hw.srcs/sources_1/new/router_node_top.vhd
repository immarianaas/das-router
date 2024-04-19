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


entity router_node_top is
    Port (

        -- some kind of clock signal? The examples have it, and we need it
        rst : in STD_LOGIC;

        ia_nw:  out std_logic;
        ia_n:   out std_logic;
        ia_ne:  out std_logic;
        ia_e:   out std_logic;
        ia_se:  out std_logic;
        ia_s:   out std_logic;
        ia_sw:  out std_logic;
        ia_w:   out std_logic;
        
        ir_nw:  in std_logic;
        ir_n:   in std_logic;
        ir_ne:  in std_logic;
        ir_e:   in std_logic;
        ir_se:  in std_logic;
        ir_s:   in std_logic;
        ir_sw:  in std_logic;
        ir_w:   in std_logic;
        
        id_nw:  in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_n:   in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_ne:  in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_e:   in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_se:  in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_s:   in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_sw:  in std_logic_vector(DATA_WIDTH-1 downto 0);
        id_w:   in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        oa_nw:  in std_logic;
        oa_n:   in std_logic;
        oa_ne:  in std_logic;
        oa_e:   in std_logic;
        oa_se:  in std_logic;
        oa_s:   in std_logic;
        oa_sw:  in std_logic;
        oa_w:   in std_logic;
         
        or_nw:  out std_logic;
        or_n:   out std_logic;
        or_ne:  out std_logic;
        or_e:   out std_logic;
        or_se:  out std_logic;
        or_s:   out std_logic;
        or_sw:  out std_logic;
        or_w:   out std_logic;
        
        od_nw:  out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_n:   out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_ne:  out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_e:   out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_se:  out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_s:   out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_sw:  out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_w:   out std_logic_vector(DATA_WIDTH-1 downto 0)  
        
    );
end router_node_top;


architecture Behavioral of router_node_top is

    -- north west 
    signal nw_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal nw_req_vertical: std_logic;
    signal nw_ack_vertical: std_logic;
    
    signal nw_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal nw_req_oblique: std_logic;
    signal nw_ack_oblique: std_logic;
    
    signal nw_data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal nw_req_horizontal: std_logic;
    signal nw_ack_horizontal: std_logic;

    -- north east 
    signal ne_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ne_req_vertical: std_logic;
    signal ne_ack_vertical: std_logic;
    
    signal ne_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ne_req_oblique: std_logic;
    signal ne_ack_oblique: std_logic;
    
    signal ne_data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ne_req_horizontal: std_logic;
    signal ne_ack_horizontal: std_logic;
    
    -- south east 
    signal se_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal se_req_vertical: std_logic;
    signal se_ack_vertical: std_logic;
    
    signal se_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal se_req_oblique: std_logic;
    signal se_ack_oblique: std_logic;
    
    signal se_data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal se_req_horizontal: std_logic;
    signal se_ack_horizontal: std_logic;
    
    -- south west 
    signal sw_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal sw_req_vertical: std_logic;
    signal sw_ack_vertical: std_logic;
    
    signal sw_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal sw_req_oblique: std_logic;
    signal sw_ack_oblique: std_logic;
    
    signal sw_data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal sw_req_horizontal: std_logic;
    signal sw_ack_horizontal: std_logic;
    
     

begin

----------------------------------------------------------------------------------------------------  
  A_south: entity arbiter3 
    port map (
    rst => rst,
    
    inA_req => nw_req_vertical,
    inA_data => nw_data_vertical,
    inA_ack => nw_ack_vertical,
    
    inB_req => ne_req_vertical,
    inB_data => ne_data_vertical,
    inB_ack => ne_ack_vertical,
    
    inC_req => ir_n,
    inC_data => id_n,
    inC_ack => ia_n,
    
    out_req => or_s,
    out_data => od_s,
    out_ack => oa_s
     
    );
    

  R_nw: entity router
      generic map (
        DIRECTION => 0
    )
        port map (
        rst => rst,
        
        i_req => ir_nw,
        i_data => id_nw,
        
        o_data_vertical => nw_data_vertical,
        o_data_oblique => nw_data_oblique,
        o_data_horizontal => nw_data_horizontal,
        
        o_req_vertical => nw_req_vertical,
        o_req_oblique => nw_req_oblique,
        o_req_horizontal => nw_req_horizontal,
        
        i_ack => ia_nw,

        o_ack_vertical => nw_ack_vertical,
        o_ack_oblique => nw_ack_oblique, 
        o_ack_horizontal => nw_ack_horizontal 
     );
      
   
  R_ne: entity router
      generic map (
        DIRECTION => 1
    )
        port map (
        rst => rst,
        
        i_req => ir_ne,
        i_data => id_ne,
        
        o_data_vertical => ne_data_vertical,
        o_data_oblique => ne_data_oblique,
        o_data_horizontal => ne_data_horizontal,
        
        o_req_vertical => ne_req_vertical,
        o_req_oblique => ne_req_oblique,
        o_req_horizontal => ne_req_horizontal,
        
        i_ack => ia_ne,

        o_ack_vertical => ne_ack_vertical,
        o_ack_oblique => ne_ack_oblique,
        o_ack_horizontal => ne_ack_horizontal
        );
      
----------------------------------------------------------------------------------------------------

    R_se: entity router
        generic map(
        DIRECTION => 2
        ) 
        port map (
        rst => rst,
        
        i_req => ir_se,
        i_data => id_se,
        
        o_data_vertical => se_data_vertical,
        o_data_oblique => se_data_oblique,
        o_data_horizontal => se_data_horizontal,
        
        o_req_vertical => se_req_vertical,
        o_req_oblique => se_req_oblique,
        o_req_horizontal => se_req_horizontal,
        
        i_ack => ia_se,

        o_ack_vertical => se_ack_vertical,
        o_ack_oblique => se_ack_oblique,
        o_ack_horizontal => se_ack_horizontal
        );
        
        
  A_west: entity arbiter3 
    port map (
    rst => rst,
    
    inA_req => ne_req_horizontal,
    inA_data => ne_data_horizontal,
    inA_ack => ne_ack_horizontal,
    
    inB_req => se_req_horizontal,
    inB_data => se_data_horizontal,
    inB_ack => se_ack_horizontal,
    
    inC_req => ir_e,
    inC_data => id_e,
    inC_ack => ia_e,
    
    out_req => or_w,
    out_data => od_w,
    out_ack => oa_w
    );
    
----------------------------------------------------------------------------------------------------

    R_sw: entity router
        generic map(
        DIRECTION => 2
        ) 
        port map (
        rst => rst,
        
        i_req => ir_sw,
        i_data => id_sw,
        
        o_data_vertical => sw_data_vertical,
        o_data_oblique => sw_data_oblique,
        o_data_horizontal => sw_data_horizontal,
        
        o_req_vertical => sw_req_vertical,
        o_req_oblique => sw_req_oblique,
        o_req_horizontal => sw_req_horizontal,
        
        i_ack => ia_sw,

        o_ack_vertical => sw_ack_vertical,
        o_ack_oblique => sw_ack_oblique,
        o_ack_horizontal => sw_ack_horizontal
        );

        
  A_east: entity arbiter3 
    port map (
    rst => rst,
    
    inA_req => nw_req_horizontal,
    inA_data => nw_data_horizontal,
    inA_ack => nw_ack_horizontal,
    
    inB_req => sw_req_horizontal,
    inB_data => sw_data_horizontal,
    inB_ack => sw_ack_horizontal,
    
    inC_req => ir_w,
    inC_data => id_w,
    inC_ack => ia_w,
    
    out_req => or_e,
    out_data => od_e,
    out_ack => oa_e
    );
    
            
  A_north: entity arbiter3 
    port map ( 
    rst => rst,
    
    inA_req => se_req_vertical,
    inA_data => se_data_vertical,
    inA_ack => se_ack_vertical,
    
    inB_req => sw_req_vertical,
    inB_data => sw_data_vertical,
    inB_ack => sw_ack_vertical,
    
    inC_req => ir_s,
    inC_data => id_s,
    inC_ack => ia_s,
    
    out_req => or_n,
    out_data => od_n,
    out_ack => oa_n
    );
    
        
end Behavioral;
