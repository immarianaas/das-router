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
        od_w:   out std_logic_vector(DATA_WIDTH-1 downto 0);
        
        
        -- internal_nw_req_horizontal: out std_logic;
        -- internal_nw_req_vertical: out std_logic
        
        
       test_req: out std_logic;
       test_ack : out std_logic;
       test_ack_oblique: out std_logic

        
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

    --internal_nw_req_horizontal <= nw_req_horizontal;
    --internal_nw_req_vertical <= nw_req_vertical;
    
    -- nw_ack_oblique:
    -- represents the oblique output that comes out
    -- from the NW router
    -- which means, when data comes from NW and goes through an oblique line
    -- it will come out on the SE line
    
--    ia_se <= nw_ack_oblique;
--    ia_sw <= ne_ack_oblique;
--    ia_nw <= se_ack_oblique;
--    ia_ne <= sw_ack_oblique;
    
    nw_ack_oblique <= oa_se;
    ne_ack_oblique <= oa_sw;
    se_ack_oblique <= oa_nw;
    sw_ack_oblique <= oa_ne;
    
    or_se <= nw_req_oblique;
    or_sw <= ne_req_oblique;
    or_nw <= se_req_oblique;
    or_ne <= sw_req_oblique;
    
    od_se <= nw_data_oblique;
    od_sw <= ne_data_oblique;
    od_nw <= se_data_oblique;
    od_ne <= sw_data_oblique;
    
   
    
  
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
    
    test_ack_oblique <= sw_ack_oblique;


    R_sw: entity router
        generic map(
        DIRECTION => 3
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
        o_ack_horizontal => sw_ack_horizontal,
        
        test_ack => test_ack,
        test_req => test_req
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

----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.router_node_top;


entity router_node_top_tb is
end entity;

architecture tb of router_node_top_tb is
    type t_bit_arr is array (0 to 7) of std_logic;
    type t_data_arr is array (0 to 7) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal ack_out : t_bit_arr;
    signal data_in : t_data_arr;
    signal req_in : t_bit_arr;
    
    signal ack_in : t_bit_arr;
    signal data_out : t_data_arr;
    signal req_out : t_bit_arr;
   
   signal rst : std_logic;
   
   signal test_ack, test_req,test_ack_oblique : std_logic;
   

   
   --signal internal_nw_req_horizontal : std_logic;
   -- signal internal_nw_req_vertical : std_logic;
   
begin

node: entity router_node_top
    port map (

        rst => rst,

        ia_nw => ack_in(0),
        ia_n => ack_in(1),
        ia_ne => ack_in(2),
        ia_e => ack_in(3),
        ia_se => ack_in(4),
        ia_s => ack_in(5),
        ia_sw => ack_in(6),
        ia_w => ack_in(7),
        
        ir_nw  =>req_in(0),
        ir_n   =>req_in(1),
        ir_ne  =>req_in(2),
        ir_e   =>req_in(3),
        ir_se  =>req_in(4),
        ir_s   =>req_in(5),
        ir_sw  =>req_in(6),
        ir_w   =>req_in(7),
        
        id_nw  => data_in(0),
        id_n   => data_in(1),
        id_ne  => data_in(2),
        id_e   => data_in(3),
        id_se  => data_in(4),
        id_s   => data_in(5),
        id_sw  => data_in(6),
        id_w   => data_in(7),
        
        oa_nw  => ack_out(0),
        oa_n   => ack_out(1),
        oa_ne  => ack_out(2),
        oa_e   => ack_out(3),
        oa_se  => ack_out(4),
        oa_s   => ack_out(5),
        oa_sw  => ack_out(6),
        oa_w   => ack_out(7),
         
        or_nw  => req_out(0),
        or_n   => req_out(1),
        or_ne  => req_out(2),
        or_e   => req_out(3),
        or_se  => req_out(4),
        or_s   => req_out(5),
        or_sw  => req_out(6),
        or_w   => req_out(7),
        
        od_nw  => data_out(0),
        od_n   => data_out(1),
        od_ne  => data_out(2),
        od_e   => data_out(3),
        od_se  => data_out(4),
        od_s   => data_out(5),
        od_sw  => data_out(6),
        od_w   => data_out(7),
        
        -- internal_nw_req_horizontal => internal_nw_req_horizontal,
        -- internal_nw_req_vertical => internal_nw_req_vertical
        
        test_ack => test_ack,
        test_req => test_req,
        test_ack_oblique => test_ack_oblique
    );
    
    process is
       variable direction: Integer;
        variable direction_out: Integer;
        variable msg1, msg2, msg3 : std_logic_vector(DATA_WIDTH-1 downto 0);
   
   begin
    
--         --  the following doesnt work
--        direction := 2; -- ne
--        direction_out := 6; -- sw
--        -- (3,3) to (0,0)
--        msg := "0000000000000000000000000000000000000000000000000011001100000000";
        
        
         --  the following doesnt work
        direction := 6; -- sw
        direction_out := 2; -- ne
        -- (0,0) to (3,3)
        msg1 := "0000000000000000000000000000000000000000000000000000000000110011";
        msg2 := "0000000000000000100000000000000000000000000000000000000000110011";
        msg3 := "0000001000000000000000000000000000000000000000000000000000110011";


--        direction := 6; -- sw
--        direction_out := 3; -- e
--        -- (0,0) to (3,0)
--        msg1 := "0000000000000000000000000000000000000000000000000000000000000011";
--        msg2 := "0000000000000001000000000000000000000000000000000000000000000011";
--        msg3 := "0000000000000000000000000001000000000000000000000000000000000011";


--    -- works:
--        direction := 6; -- sw
--        direction_out := 1; -- n
--        -- (0,0) to (0,3)
--        msg := "0000000000000000000000000000000000000000000000000000000000110000";

        -- the following works
--        direction := 2; -- ne
--        direction_out := 5; -- s
--        -- (3,3) to (3,0)
--        msg := "0000000000000000000000000000000000000000000000000011001100000011";


--        direction := 1; -- n
--        direction_out := 5; -- s
--        -- (3,3) to (3,0)
--        msg1 := "0000000100000000000000000000000000000000000000000011001100000011";
--        msg2 := "0000000000000100000000000000000000000000000000000011001100000011";
--        msg3 := "0000000000000000000000000100000000000000000000000011001100000011";


        ack_out <= (others =>'0');
        req_in <= (others =>'0');
        data_in <= (others => (others => '0'));
   
        rst <= '1', '0' after 7ns;

        wait for 20ns;

        data_in(direction) <= msg1;
        req_in(direction) <= '0', '1' after 20ns;
        
       
        -- we should see something on the output line
        if req_out(direction_out) /= '1' then
            wait until req_out(direction_out) = '1';
        end if;
        
        if ack_in(direction) /= '1' then
            wait until ack_in(direction) = '1';
        end if;
        
        ack_out(direction_out) <= '0','1' after 20ns;
       
        wait for 50ns;

        
        data_in(direction) <= msg2;
        req_in(direction) <= '1', '0' after 20ns;
        
        if req_out(direction_out) /= '0' then
            wait until req_out(direction_out) = '0';
        end if;
        
        if ack_in(direction) /= '0' then
            wait until ack_in(direction) = '0';
        end if;

        ack_out(direction_out) <= '1', '0' after 20ns;
                
        wait for 50ns;
        
        
        data_in(direction) <= msg3;
        req_in(direction) <= '0', '1' after 20ns;
        

        if req_out(direction_out) /= '1' then
            wait until req_out(direction_out) = '1';
        end if;
        if ack_in(direction) /= '1' then
        wait until ack_in(direction) = '1';
        end if;

        ack_out(direction_out) <= '0','1' after 20ns;
        

        wait for 50ns;


    
--        rst <= '1', '0' after 7ns;
--        ack_out <= (others =>'0');
--        req_in <= (others =>'0');
--        data_in <= (others => (others => '0'));
        
        
        
----        -- it's in (3,3) and goes to (3, 0)
----        --data_in(0) <= "0011001100000011";
        
--        -- it's in (3,3) and goes to (5,3)
--        data_in(0) <= "0011001100110101";
--        req_in(0) <= '0', '1' after 20ns;
        
--        wait until req_out(3) = '1';
        
--        ack_out(3) <= '1';

--        wait for 50ns;
--        finish;


        
--        -- it's in (3,3) and goes to (3, 0)
----        --data_in(0) <= "0011001100000011";
        
----        -- it's in (3,3) and goes to (5,3)
----        data_in(2) <= "0011001100110101";
----        req_in(2) <= '0', '1' after 40ns;
----        wait until ack_in(2) = '1';
        
----        ack_out(5) <= '1';





        
--        ---------------------------------------
        
--        -- south to north
--        data_in(5) <= "0000000000110000";
--        req_in(5) <= '0', '1' after 20ns;
--        wait until ack_in(5) = '1';
        
--        ack_out(1) <= '1';

--        ---------------------------------------
--        -- sw
--        data_in(6) <= "0000000000110011";
--        req_in(6) <= '0', '1' after 20ns;
        
--        wait until ack_in(6) = '1';
        
--        ack_out(2) <= '1';
        

        
 
--        wait for 20ns;
                        
--        -- finish; 
        
    end process;
end architecture;


