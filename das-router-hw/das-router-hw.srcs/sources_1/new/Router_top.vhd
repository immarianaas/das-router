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
    
    
    
    
    
    
    
    
    
    
        
    -- NORTH WEST router to SOUTH arbiter
    signal r_nw_a_s_req : STD_LOGIC;  -- nw router to s arbiter - request
    signal r_nw_a_s_data : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);  -- nw router to s arbiter - data
    signal r_nw_a_s_ack : STD_LOGIC;  -- nw router to s arbiter - ack
    
    -- NORTH WEST router to SOUTH EAST arbiter -- not needed?
    signal r_nw_a_se_req : STD_LOGIC;
    signal r_nw_a_se_data: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);  
    signal r_nw_a_se_ack : STD_LOGIC;  
    
    -- NORTH WEST router to EAST arbiter
    signal r_nw_a_e_req : STD_LOGIC;  -- nw router to se arbiter - request
    signal r_nw_a_e_addr : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);  -- nw router to se arbiter - data
    signal r_nw_a_e_ack : STD_LOGIC;  -- nw router to s arbiter - ack
    
    
    
    
    
    
    
    -- north west 
    signal nw_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal nw_req_vertical: std_logic;
    
    signal nw_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal nw_req_oblique: std_logic;
    
    signal nw_data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal nw_req_horizontal: std_logic;
    
    -- north east 
    signal ne_data_vertical: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ne_req_vertical: std_logic;
    
    signal ne_data_oblique: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ne_req_oblique: std_logic;
    
    signal ne_data_horizontal: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ne_req_horizontal: std_logic;
    
    
     

begin

-- rst ?? is this some kind of clock signal?

  -- actually, we might need to create an arbiter with more inputs
  -- than two? we also should check how many  
  
  A_south: component arbiter 
    port map (
    rst => rst,
    
    in_vertical_req => nw_vertical_req,
    in_vertical_data => nw_vertical_data
    in_vertical_ack -- todo?
    
    in_oblique_req => nw_vertical_req,
    in_oblique_data => nw_vertical_data,
    in_oblique_req -- todo
    
    in_horizontal_req => nw_horizontal_req,
    in_horizontal_data => nw_horizontal_data,
    in_horizontal_ack -- todo
    
    out_req -- todo
    out_data -- todo
    out_ack -- todo
    
    
    );
    

  R_nw: component router
      generic map (
        DIRECTION => 0
    )
        port map (
        
        i_req => ir_nw,
        i_data => id_nw,
        
        o_data_vertical => nw_data_vertical,
        o_data_oblique => nw_data_oblique,
        o_data_horizontal => nw_data_horizontal,
        
        o_req_vertical => nw_req_vertical,
        o_req_oblique => nw_req_oblique,
        o_req_horizontal => nw_req_horizontal,
        
        i_ack => ia_nw,

        o_ack_vertical -- missing
        o_ack_oblique -- missing
        o_ack_horizontal -- missing
        );
      
      
      
    );
  R_ne: component router
      generic map (
        DIRECTION => 1
    )
        port map (
        
        i_req => ir_ne,
        i_data => id_ne,
        
        o_data_vertical => ne_data_vertical,
        o_data_oblique => ne_data_oblique,
        o_data_horizontal => ne_data_horizontal,
        
        o_req_vertical => ne_req_vertical,
        o_req_oblique => ne_req_oblique,
        o_req_horizontal => ne_req_horizontal,
        
        i_ack => ia_ne,

        o_ack_vertical -- missing
        o_ack_oblique -- missing
        o_ack_horizontal -- missing
        );
      
      
      
      
  R_sw: component router
    port map (
      alias x : addr(15 downto 12), --Sliced vector
      alias y : addr(11 downto 8),
      alias dx : addr(7 downto 4),
      alias dy : addr(3 downto 0),
      dx <= dx +1, -- increment dx and dy
      dy <= dy -1,
      addr_out <= x & y & dx & dy, -- concatenate the vectors
      case id_sw is
        when x > dx and y < dy => 
          o_req0 <= '1'; -- right & up
        when x > dx => 
          o_req1 <= '1'; -- right 
        when others => 
          o_req2 <= '1'; -- up
      end case;
      
      i_req => ir_sw,
      i_ack => ia_sw,
      o_ack0 => r_nw_a_nw_ack,
      o_ack1 => r_nw_a_n_ack,
      o_ack2 => r_nw_a_n_ack 
      
    );
  R_se: component router
    port map (
      alias x : addr(15 downto 12), --Sliced vector
      alias y : addr(11 downto 8),
      alias dx : addr(7 downto 4),
      alias dy : addr(3 downto 0),
      dx <= dx -1, -- decrement dx and dy
      dy <= dy -1,
      addr_out <= x & y & dx & dy, -- concatenate the vectors
      case id_se is
        when x < dx and y < dy => 
          o_req0 <= '1'; -- left & up
        when x < dx => 
          o_req1 <= '1'; -- left 
        when others => 
          o_req2 <= '1'; -- up
      end case;
      
      i_req => ir_se,
      i_ack => ia_se,
      o_ack0 => r_nw_a_nw_ack,
      o_ack1 => r_nw_a_n_ack,
      o_ack2 => r_nw_a_n_ack 
      
    );


end Behavioral;
