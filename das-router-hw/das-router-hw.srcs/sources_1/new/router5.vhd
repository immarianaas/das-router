

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.click_element;
use work.demux5;
use ieee.numeric_std.all;


--Righto and lefto means right/left oblique :O
entity router5 is
  generic(
    SIDE: in integer range 0 to 3 :=0
    );
  port (
        rst : in std_logic;
        
        ia : out std_logic;
        ir : in  std_logic;
        id : in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        oa_straight : in std_logic;
        oa_left : in std_logic;
        oa_right : in std_logic;
        oa_lefto : in std_logic;
        oa_righto : in std_logic;
        
        or_straight : out std_logic;
        or_left : out std_logic;
        or_right : out std_logic;
        or_lefto : out std_logic;
        or_righto : out std_logic;
        
        od_straight : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_left : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_right : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_lefto : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_righto : out std_logic_vector(DATA_WIDTH-1 downto 0);
        
        --TEMP
--        dxx : out std_logic_vector(VALUE_WIDTH -1 downto 0);
--        dyy : out std_logic_vector(VALUE_WIDTH -1 downto 0);
--        xx  : out std_logic_vector(VALUE_WIDTH -1 downto 0);
--        yy  : out std_logic_vector(VALUE_WIDTH -1 downto 0);
--        datao : out std_logic_vector(DATA_WIDTH -1 downto 0)

        int_req : out std_logic;
        int_ack : out std_logic
         
  );
end router5;

architecture Behavioral of router5 is
    signal x,y,dx,dy : std_logic_vector(VALUE_WIDTH-1 downto 0);
    signal req, ack : std_logic;
    signal processed_data, data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal selector : std_logic_vector(2 downto 0);
    
    signal shady_ack : std_logic;
    
    
    
begin
    
    x <= data(VALUE_WIDTH-1 downto VALUE_WIDTH*0);
    y <= data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1);
    dx <= data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2);
    dy <= data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3); 
    
    processed_data(VALUE_WIDTH-1 downto VALUE_WIDTH*0)<=x;
    processed_data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1) <=y;
    processed_data(DATA_WIDTH-1 downto VALUE_WIDTH*4) <=data(DATA_WIDTH-1 downto VALUE_WIDTH*4);
    
    click: entity click_element
    port map (
        rst => rst,
        in_ack => ia,
        in_req => ir,
        in_data => id,
        out_req => req,
        out_data => data,
        out_ack => shady_ack 
    );
    
    shady_ack <= ack; -- after 20ns;
    int_ack <= shady_ack;
    int_req <= req;
    
    
    N: if SIDE = 0 generate
        -- dx
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x 
        else std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx>x else dx;
        
        -- dy
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy > y else dy;
        selector(0) <= '0' when dx = x else '1'; -- Go straight?
        selector(1) <= '0' when dx > x else '1'; -- Go right?
        selector(2) <= '1' when dy /= y else '0'; -- Go oblique?
    
    end generate;
    
    W: if SIDE = 1 generate
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx > x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y 
        else std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy>y else dy;
        selector(0) <= '0' when dy = y else '1'; -- Go straight?
        selector(1) <= '1' when dy < y else '0'; -- Go right?
        selector(2) <= '1' when dx /= x else '0'; -- Go oblique?
    end generate; 
    
    S: if SIDE = 2 generate -- proprely tested this one 
    
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x 
        else std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx>x else dx;
        
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y else dy;
        selector(0) <= '0' when dx = x else '1'; -- Go straight?
        selector(1) <= '0' when dx < x else '1'; -- Go right?
        selector(2) <= '1' when dy /= y else '0'; -- Go oblique?

    end generate;
    
    E: if SIDE = 3 generate -- also properly tested
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y 
        else std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy>y else dy;
        selector(0) <= '0' when dy = y else '1'; -- Go straight?
        selector(1) <= '1' when dy > y else '0'; -- Go right?
        selector(2) <= '1' when dx /= x else '0'; -- Go oblique
    end generate;    
    
    --dyy <= processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3);
    --dxx <= processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2);
    --yy <= processed_data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1);
    --xx <= processed_data(VALUE_WIDTH*1-1 downto VALUE_WIDTH*0);
    
--    dyy <= dy;
--    dxx <= dx;
--    yy <= y;
--    xx <= x;
--    datao <= data;
------------------ ENDS GENERATE --------------
    
    demux: entity demux5
    port map(
    rst=> rst,
    in_req => req,
    in_ack => ack,
    in_data => processed_data,
    
    inSel_req => req,
    inSel_ack => ack,
    selector => selector,
    
    o_straight_req => or_straight,
    o_straight_data => od_straight,
    o_straight_ack => oa_straight,
    
    o_left_req => or_left,
    o_left_data => od_left,
    o_left_ack => oa_left,
    
    o_right_req => or_right,
    o_right_data => od_right,
    o_right_ack => oa_right,

    o_lefto_req => or_lefto,
    o_lefto_data => od_lefto,
    o_lefto_ack => oa_lefto,

    o_righto_req => or_righto,
    o_righto_data => od_righto,
    o_righto_ack => oa_righto
    );
    
end Behavioral;


----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.router5;

entity router5_tb is 
end entity; 

architecture tb of router5_tb is 
    type t_bit_arr is array (0 to 4) of std_logic;
    type t_data_arr is array (0 to 4) of std_logic_vector(DATA_WIDTH-1 downto 0);
    type t_sel_arr is array (0 to 3) of std_logic;
    signal ack_out : t_bit_arr;
    signal data_out : t_data_arr;
    signal req_out : t_bit_arr;
    signal rst: std_logic;
    signal ia,ir,oa: std_logic;
    signal id : std_logic_vector(DATA_WIDTH-1 downto 0);
    --TEMP
--    signal dxx,dyy,xx,yy : std_logic_vector(VALUE_WIDTH-1 downto 0);
--    signal datao : std_logic_vector(DATA_WIDTH-1 downto 0);

begin 

router: entity router5
generic map(
    SIDE => 2
    )
    port map (
    rst => rst,
    ia => ia,
    ir => ir,
    id => id,
    oa_straight => ack_out(0),
    or_straight => req_out(0),
    od_straight => data_out(0),
    
    oa_left => ack_out(1),
    or_left => req_out(1),
    od_left => data_out(1),
    
    oa_right => ack_out(2),
    or_right => req_out(2),
    od_right => data_out(2),
    
    oa_lefto => ack_out(3),
    or_lefto => req_out(3),
    od_lefto => data_out(3),
    
    oa_righto => ack_out(4),
    or_righto => req_out(4),
    od_righto => data_out(4)
--    dxx => dxx,
--    dyy => dyy,
--    yy => yy,
--    xx => xx,
--    datao => datao
    );
    
    process begin
    
        rst <= '1', '0' after 7ns;
        ack_out <= (others=>'0');
        
        ir <= '0'; oa <= '0';
        id <= (others =>'0');
        id <= "010101010101010101010101010101010101010101010101" & "0000" & "0001" & "0000" & "0010";
        ir <= '0', '1' after 20ns;
        wait until ia = '1';
        wait until req_out(2) = '1';
        
        wait for 50ns;
        
    end process;
end architecture;
        