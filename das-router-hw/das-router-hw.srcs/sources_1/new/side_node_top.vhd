

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.router5;
use work.router2;
use work.arbiter5;
use work.arbiter3;
use work.arbiter;

entity side_node_top is
    generic(
    SIDE: in integer range 0 to 3 :=0
    );
    
    port ( 
        rst : in std_logic;
        
        ir : in  std_logic;
        ia : out std_logic;
        id : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        orr : out std_logic;
        oa  : in  std_logic;
        od  : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        or_straight : out std_logic;
        oa_straight : in  std_logic;
        od_straight : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_straight : in  std_logic;
        ia_straight : out std_logic;
        id_straight : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_left : out std_logic;
        oa_left : in  std_logic;
        od_left : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_left : in  std_logic;
        ia_left : out std_logic;
        id_left : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_right : out std_logic;
        oa_right : in  std_logic;
        od_right : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_right : in  std_logic;
        ia_right : out std_logic;
        id_right : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_lefto : out std_logic;
        oa_lefto : in  std_logic;
        od_lefto : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_lefto : in  std_logic;
        ia_lefto : out std_logic;
        id_lefto : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        or_righto : out std_logic;
        oa_righto : in  std_logic;
        od_righto : out std_logic_vector(DATA_WIDTH -1 downto 0);
        
        ir_righto : in  std_logic;
        ia_righto : out std_logic;
        id_righto : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        
        
        int_req : out std_logic;
        int_ack : out std_logic
    );
end side_node_top;

architecture Behavioral of side_node_top is
    -- out as in: goes to the outside, and starts from (right, righto, etc)
    signal oa_right_out, or_right_out, oa_righto_out, or_righto_out : std_logic;
    signal oa_left_out, or_left_out, oa_lefto_out, or_lefto_out : std_logic;
    signal od_right_out, od_righto_out, od_left_out, od_lefto_out : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    -- in as in: continues inside, and starts from (right, righto, etc)
    signal ack_right_in, req_right_in, ack_righto_in, req_righto_in : std_logic;
    signal ack_left_in, req_left_in, ack_lefto_in, req_lefto_in : std_logic;
    signal data_right_in, data_righto_in, data_left_in, data_lefto_in : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    -- for ex. oa_right_out will be connected to the out port
    --         ack_right_in will be connected to the left port
    
    -- these signals come from the outside
    -- they pass through the router and go into the arbiter
    signal oa_right_ext, or_right_ext: std_logic;
    signal oa_left_ext, or_left_ext: std_logic;
    signal od_right_ext, od_left_ext: std_logic_vector(DATA_WIDTH-1 downto 0);
    

begin

-- sitting on the right, pointing to the left
router2_right: entity router2
      port map (
        rst => rst,
    
        ia => ia_right,
        ir => ir_right,
        id => id_right,
        
        oa_outside => oa_right_out,
        oa_inside => ack_right_in,
        
        or_outside => or_right_out,
        or_inside => req_right_in,
        
        od_outside => od_right_out,
        od_inside => data_right_in
        );
        
-- sitting on righto
router2_righto: entity router2
      port map (
        rst => rst,
    
        ia => ia_righto,
        ir => ir_righto,
        id => id_righto,
        
        oa_outside => oa_righto_out,
        oa_inside => ack_righto_in,
        
        or_outside => or_righto_out,
        or_inside => req_righto_in,
        
        od_outside => od_righto_out,
        od_inside => data_righto_in
        );
        
router2_lefto: entity router2
      port map (
        rst => rst,
    
        ia => ia_lefto,
        ir => ir_lefto,
        id => id_lefto,
        
        oa_outside => oa_lefto_out,
        oa_inside => ack_lefto_in,
        
        or_outside => or_lefto_out,
        or_inside => req_lefto_in,
        
        od_outside => od_lefto_out,
        od_inside => data_lefto_in
        );
        
router2_left: entity router2
      port map (
        rst => rst,
    
        ia => ia_left,
        ir => ir_left,
        id => id_left,
        
        oa_outside => oa_left_out,
        oa_inside => ack_left_in,
        
        or_outside => or_left_out,
        or_inside => req_left_in,
        
        od_outside => od_left_out,
        od_inside => data_left_in
        );

arbiter_left : ENTITY arbiter3 PORT MAP (
        rst => rst,
        inA_req => req_right_in,
        inA_data => data_right_in,
        inA_ack => ack_right_in,
        inB_req => req_righto_in,
        inB_data => data_righto_in,
        inB_ack => ack_righto_in,
        inC_req => or_left_ext,
        inC_data => od_left_ext,
        inC_ack => oa_left_ext,
        out_req => or_left,
        out_data => od_left,
        out_ack => oa_left
    );
    
-- arbiter that goes to the right
arbiter_right : ENTITY arbiter3 PORT MAP (
        rst => rst,
        inA_req => req_left_in,
        inA_data => data_left_in,
        inA_ack => ack_left_in,
        inB_req => req_lefto_in,
        inB_data => data_lefto_in,
        inB_ack => ack_lefto_in,
        inC_req => or_right_ext,
        inC_data => od_right_ext,
        inC_ack => oa_right_ext,
        out_req => or_right,
        out_data => od_right,
        out_ack => oa_right
    );

router: entity router5 
    generic map(
        SIDE => SIDE
    )
    
    port map (
        rst => rst,
        ia => ia,
        ir => ir,
        id => id,
        
        oa_straight => oa_straight,
        oa_left => oa_left_ext,
        oa_right => oa_right_ext, -- goes into the arbiter on the right
        oa_lefto => oa_lefto,
        oa_righto => oa_righto,
        
        or_straight => or_straight,
        or_left => or_left_ext,
        or_right => or_right_ext,
        or_lefto => or_lefto,
        or_righto => or_righto,
        
        od_straight => od_straight,
        od_left => od_left_ext,
        od_right => od_right_ext,
        od_lefto => od_lefto,
        od_righto => od_righto,
        
        
        int_ack => int_ack,
        int_req => int_req
    );
    
    --B,D,E fast
    arbiter : entity arbiter5 
    port map(
    rst => rst,
    
    inA_req => or_left_out, -- comes from the router2
    inA_data => od_left_out,
    inA_ack => oa_left_out,
    
    inB_req => or_lefto_out,
    inB_data => od_lefto_out,
    inB_ack => oa_lefto_out,
    
    inC_req => or_right_out,
    inC_data => od_right_out,
    inC_ack => oa_right_out,
    
    inD_req => ir_straight,
    inD_data => id_straight,
    inD_ack => ia_straight,
    
    inE_req => or_righto_out,
    inE_data => od_righto_out,
    inE_ack => oa_righto_out,
    
    out_req => orr,
    out_data => od,
    out_ack => oa
    );

end Behavioral;

----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.side_node_top;

entity side_node_top_tb is
end entity;

architecture tb of side_node_top_tb is
    type t_bit_arr is array (0 to 4) of std_logic;
    type t_data_arr is array (0 to 4) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal ack_out : t_bit_arr;
    signal data_in : t_data_arr;
    signal req_in : t_bit_arr;
    
    signal ack_in : t_bit_arr;
    signal data_out : t_data_arr;
    signal req_out : t_bit_arr;
   
    signal rst : std_logic;
   
    signal ia, ir, oa, orr : std_logic;
    signal id, od : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal int_req, int_ack : std_logic;
    
    
    
begin

node: entity side_node_top
generic map( 
    SIDE => 1 -- WEST
    )
    port map (
        rst => rst,
        ia  => ia,
        ir  => ir,
        id  => id,
        oa  => oa,
        orr  => orr,
        od  => od,
        
        or_straight => req_out(0),
        oa_straight => ack_out(0),
        od_straight => data_out(0),
        
        ir_straight => req_in(0),
        ia_straight => ack_in(0),
        id_straight => data_in(0),
        
        or_left => req_out(1),
        oa_left => ack_out(1),
        od_left => data_out(1),
        
        ir_left => req_in(1),
        ia_left => ack_in(1),
        id_left => data_in(1),
        
        or_right => req_out(2),
        oa_right => ack_out(2),
        od_right => data_out(2),
        
        ir_right => req_in(2),
        ia_right => ack_in(2),
        id_right => data_in(2),
        
        or_lefto => req_out(3),
        oa_lefto => ack_out(3),
        od_lefto => data_out(3),
        
        ir_lefto => req_in(3),
        ia_lefto => ack_in(3),
        id_lefto => data_in(3),
        
        or_righto => req_out(4),
        oa_righto => ack_out(4),
        od_righto => data_out(4),
        
        ir_righto => req_in(4),
        ia_righto => ack_in(4),
        id_righto => data_in(4),
        
        
        
        int_req => int_req,
        int_ack => int_ack
        
        -- internal_nw_req_horizontal => internal_nw_req_horizontal,
        -- internal_nw_req_vertical => internal_nw_req_vertical
    );
    
    process is
    
    variable msg1, msg2, msg3: std_logic_vector(DATA_WIDTH-1 downto 0);
    variable direction: Integer;
    
    begin
--        -- horizontal -> 0
--        -- vertical -> 1
--        -- oblique -> 2
    
--        rst <= '1', '0' after 7ns;
--        ack_out <= (others =>'0');
--        req_in <= (others =>'0');
--        data_in <= (others => (others => '0'));
   
--        ir <= '0'; oa <= '0';
        
--        id <= (others =>'0');
----        ir <= '0', '1' after 20ns;

----        -- from (1,0) to (1, 2) works! (straight)
----        -- from (1,0) to (2,0): (right)
----        id <= "0000000100000010";
        
----        -- we should see something on the right line (instead we see something on the straight line?)
----        wait until req_out(2) = '1';
----        ack_out(2) <= '1';
----        wait for 10ns;
        
----        finish;
        
--        req_in(2) <= '0', '1' after 20ns;
--        data_in(2) <= "0001000100010001";
        
--        wait until orr = '1';
        


--        direction := 1;
--        -- (0,1) to (0,2)                                       |  1, 0 ,  2, 0  | -> (0,1) to (0,2)
--        msg1 := "0000000000000000000000000000000000000000000000010001000000100000";
--        msg2 := "0000000000000000000000000000000000000000000000100001000000100000";
--        msg3 := "0000000000000000000000000000000000000000000000110001000000100000";


--        direction := 0; -- straight
--        -- (0,1) to (3,1)                                       |  1, 0 ,  2, 0  | -> (0,1) to (0,2)
--        msg1 := "0000000000000000000000000000000000000000000000010001000000010001";
--        msg2 := "0000000000000000000000000000000000000000000000100001000000010001";
--        msg3 := "0000000000000000000000000000000000000000000000110001000000010001";
        
        
        direction := 3; -- lefto
        -- (0,1) to (2, 3)                                       
        msg1 := "0000000000000000000000000000000000000000000000000001000000110010";
        msg2 := "0000000000000000000000000000010000000000000000000001000000110010";
        msg3 := "0000000000000001000000000000000000000000000000000001000000110010";






        rst <= '1', '0' after 7ns;
        oa <= '0';
        ack_out <= (others =>'0');
        req_in <= (others =>'0');
        data_in <= (others => (others => '0'));
   
        ir <= '0'; 
        
        id <= (others =>'0');
        
        wait for 20ns;
        -- currently in (3,3), wanna go to (0,0)
        id <= msg1;
        ir <= '0', '1' after 30ns;
        
       
        -- we should see something on the output line
        if req_out(direction) /= '1' then
            wait until req_out(direction) = '1';
        end if;
        
        if ia /= '1' then
            wait until ia = '1';
        end if;
        
        ack_out(direction) <= '0','1' after 20ns;

        wait for 100ns;

        
        id <= msg2;
        ir <= '1', '0' after 30ns;

        -- stuck here
        
        if req_out(direction) /= '0' then
            wait until req_out(direction) = '0';
        end if;
        
        if ia /= '0' then
            wait until ia = '0';
        end if;
        
        -- finish;

        ack_out(direction) <= '1', '0' after 20ns;
        
                
        wait for 100ns;
        
        
        -- currently in (3,3), wanna go to (3,0)
        id <= msg3;
        ir <= '0', '1' after 20ns;
        

        if req_out(direction) /= '1' then
            wait until req_out(direction) = '1';
        end if;
        
        if ia /= '1' then
        wait until ia = '1';
        end if;

        ack_out(direction) <= '0','1' after 20ns;
       

        wait for 50ns;
        
    end process;
end architecture;

