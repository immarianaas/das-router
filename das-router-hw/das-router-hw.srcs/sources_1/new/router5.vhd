

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.click_element;
use work.demux5;
use std.env.finish;
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
        od_righto : out std_logic_vector(DATA_WIDTH-1 downto 0)
         
  );
end router5;

architecture Behavioral of router5 is
    signal x,y,dx,dy : std_logic_vector(VALUE_WIDTH-1 downto 0);
    signal req, ack : std_logic;
    signal processed_data, data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal selector : std_logic_vector(2 downto 0);
begin
    x <= data(VALUE_WIDTH-1 downto VALUE_WIDTH*0);
    y <= data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1);
    dx <= data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2);
    dy <= data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3); 
    
    processed_data(VALUE_WIDTH-1 downto VALUE_WIDTH*0)<=x;
    processed_data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1) <=y;
    
    click: entity click_element
    port map (
        rst => rst,
        in_ack => ia,
        in_req => ir,
        in_data => id,
        out_req => req,
        out_data => data,
        out_ack => ack
    );
    
-- TODO: DOUBLE CHECK the data logic, just if the minus and plus is correct
-- TODO: DOUBLE CHECK SELECTOR, main idea was to reverse direction on selector N/S and E/W
-- TODO: SELECTION BASED ON GOING LEFT, double check this is true
    N: if SIDE = 0 generate
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x 
        else std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx>x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy > y else dy;
        selector(0) <= '0' when dx = x else '1'; -- Go straight?
        selector(1) <= '0' when dx < x else '1'; -- Go left?
        selector(2) <= '0' when dy = y else '1'; -- Go oblique?
    
    end generate;
    
    W: if SIDE = 1 generate
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx > x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y 
        else std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy>y else dy;
        selector(0) <= '0' when dy = y else '1'; -- Go straight?
        selector(1) <= '0' when dy > y else '1'; -- Go left?
        selector(2) <= '0' when dx = x else '1'; -- Go oblique?
    end generate; 
    
    S: if SIDE = 2 generate
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x 
        else std_logic_vector(unsigned(dx) - unsigned(ONE)) when dx>x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y else dy;
        selector(0) <= '0' when dx = x else '1'; -- Go straight?
        selector(1) <= '0' when dx > x else '1'; -- Go left?
        selector(2) <= '0' when dy = y else '1'; -- Go oblique?
    
    end generate;
    
    E: if SIDE = 3 generate
        processed_data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2) <= std_logic_vector(unsigned(dx) + unsigned(ONE)) when dx < x else dx;
        processed_data(VALUE_WIDTH*4-1 downto VALUE_WIDTH*3) <= std_logic_vector(unsigned(dy) + unsigned(ONE)) when dy < y 
        else std_logic_vector(unsigned(dy) - unsigned(ONE)) when dy>y else dy;
        selector(0) <= '0' when dy = y else '1'; -- Go straight?
        selector(1) <= '0' when dy < y else '1'; -- Go left?
        selector(2) <= '0' when dx = x else '1'; -- Go oblique
    end generate;    
------------------ ENDS GENERATE --------------    
    demux: entity demux5
    port map(
    rst=> rst,
    in_req => ir,
    in_ack => ia,
    in_data => id,
    
    inSel_req => ir,
    inSel_ack => ia,
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
