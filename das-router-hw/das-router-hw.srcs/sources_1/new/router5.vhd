

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.click_element;
use std.env.finish;
use ieee.numeric_std.all;


entity router5 is
  generic(
    SIDE: in integer range 0 to 3 :=0
    );
  port (
        rst : in std_logic;
        
        ia : out std_logic;
        ir : in  std_logic;
        id : in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        oa_A : in std_logic;
        oa_B : in std_logic;
        oa_C : in std_logic;
        oa_D : in std_logic;
        oa_E : in std_logic;
        
        or_A : out std_logic;
        or_B : out std_logic;
        or_C : out std_logic;
        or_D : out std_logic;
        or_E : out std_logic;
        
        od_A : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_B : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_C : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_D : out std_logic_vector(DATA_WIDTH-1 downto 0);
        od_E : out std_logic_vector(DATA_WIDTH-1 downto 0)
         
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
    --TODO input 5way DEMUX
end Behavioral;
