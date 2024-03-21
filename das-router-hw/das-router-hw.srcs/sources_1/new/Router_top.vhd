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

    -- almost copy pasted from router.vhd
    component router is
    port ( 
        i_req:  in std_logic;
        addr:   in std_logic_vector(16 downto 0);
        o_req0: out std_logic;
        o_req1: out std_logic;
        o_req2: out std_logic;
        
        -- additional ports that we didn't thought of before
        i_ack:  in std_logic;
        o_ack0: out std_logic;
        o_ack1: out std_logic;
        o_ack2: out std_logic
    );
    end component router;
  
    
    component arbiter is
    PORT (
        rst : IN STD_LOGIC;
        -- Channel A
        inA_req   : in  std_logic;
        inA_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inA_ack   : out std_logic;
        -- Channel B
        inB_req   : in std_logic;
        inB_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inB_ack   : out std_logic;
        -- Output channel
        outC_req  : out std_logic;
        outC_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
        outC_ack  : in  std_logic
    );
    end component arbiter;

    signal r_nw_a_nw_req : STD_LOGIC; -- nw router to nw arbiter - request (and data?)
    signal r_nw_a_nw_ack : STD_LOGIC; -- nw router to nw arbiter - ack
    
    signal r_n_a_nw_req : STD_LOGIC; -- n router to nw arbiter - request (and data?)
    signal r_n_a_nw_ack : STD_LOGIC; -- n router to nw arbiter - ack
    
    signal r_nw_a_n_req : STD_LOGIC; -- nw router to n arbiter - request (and data?)
    signal r_nw_a_n_ack : STD_LOGIC; -- nw router to n arbiter - ack
    
    signal out_a_nw_req : STD_LOGIC; -- output of nw arbiter
    signal out_a_nw_ack : STD_LOGIC;
    
    -- bits initialized with 0 to use in the data fields because I'm not sure what it is supposed to be
    signal data : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0'); 

begin

-- rst ?? is this some kind of clock signal?

  -- actually, we might need to create an arbiter with more inputs
  -- than two? we also should check how many  
  
  A_nw: component arbiter 
    port map (
    rst => rst,
    
    inA_req => r_nw_a_nw_req,
    inA_data => data, -- do we have a data to send? I'm a bit confused..?
    inA_ack => r_nw_a_nw_ack,
    
    inB_req =>  r_n_a_nw_req,
    inB_data => data,
    inB_ack => r_n_a_nw_ack,
    
    outC_req => out_a_nw_req,
    outC_data => data,
    outC_ack => out_a_nw_ack  
    );
    

  R_nw: component router
    port map (
      i_req => ir_nw,
      addr => id_nw,
      
      o_req0 => r_nw_a_nw_req,
      o_req1 => r_nw_a_n_req, 
      o_req2 => r_nw_a_nw_req, -- change this one (actually, at the end we have to verify this directions thing)
      
      i_ack => ia_nw,
      o_ack0 => r_nw_a_nw_ack,
      o_ack1 => r_nw_a_n_ack,
      o_ack2 => r_nw_a_n_ack -- same for this one
      
    );


end Behavioral;
