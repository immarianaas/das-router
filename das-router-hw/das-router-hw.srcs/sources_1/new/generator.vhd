----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 04:24:35 PM
-- Design Name: 
-- Module Name: generator - Behavioral
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
use std.textio.all;
use work.defs.all;
use work.router_mesh_top;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.env.finish;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity generator is
    --Port ( 
    --rst : in std_logic
    --);
end generator;

architecture Behavioral of generator is
    
    type t_bit_matrix is array (0 to 3, 0 to 3) of std_logic;
    type t_data_matrix is array (0 to 3, 0 to 3) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal req_in_sig : t_bit_matrix := (others => (others => '0'));
    signal data_in_sig : t_data_matrix := (others => (others => (others => '0')));
    signal ack_out_sig : t_bit_matrix := (others => (others => '0'));
    
    signal data_out_sig : t_data_matrix;
    signal req_out_sig : t_bit_matrix;
    signal ack_in_sig : t_bit_matrix;
    
    signal rst : std_logic;
    
    file write_output_file : text;
    
    signal data_test : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal req_test, ack_test: std_logic;
    
begin
    file_open(write_output_file, "/home/mar/DTU/das-24/das-router/mesh_output.txt", write_mode);

        mesh: entity router_mesh_top
        port map (
        rst => rst,
      
        data_00_in => data_in_sig(0,0),
        req_00_in => req_in_sig(0,0),
        ack_00_out => ack_out_sig(0,0),
        data_00_out => data_out_sig(0,0),
        req_00_out => req_out_sig(0,0),
        ack_00_in => ack_in_sig(0,0),

        data_01_in => data_in_sig(0,1),
        req_01_in => req_in_sig(0,1),
        ack_01_out => ack_out_sig(0,1),
        data_01_out => data_out_sig(0,1),
        req_01_out => req_out_sig(0,1),
        ack_01_in => ack_in_sig(0,1),

        data_02_in => data_in_sig(0,2),
        req_02_in => req_in_sig(0,2),
        ack_02_out => ack_out_sig(0,2),
        data_02_out => data_out_sig(0,2),
        req_02_out => req_out_sig(0,2),
        ack_02_in => ack_in_sig(0,2),

        data_03_in => data_in_sig(0,3),
        req_03_in => req_in_sig(0,3),
        ack_03_out => ack_out_sig(0,3),
        data_03_out => data_out_sig(0,3),
        req_03_out => req_out_sig(0,3),
        ack_03_in => ack_in_sig(0,3),

        data_10_in => data_in_sig(1,0),
        req_10_in => req_in_sig(1,0),
        ack_10_out => ack_out_sig(1,0),
        data_10_out => data_out_sig(1,0),
        req_10_out => req_out_sig(1,0),
        ack_10_in => ack_in_sig(1,0),

        data_13_in => data_in_sig(1,3),
        req_13_in => req_in_sig(1,3),
        ack_13_out => ack_out_sig(1,3),
        data_13_out => data_out_sig(1,3),
        req_13_out => req_out_sig(1,3),
        ack_13_in => ack_in_sig(1,3),

        data_20_in => data_in_sig(2,0),
        req_20_in => req_in_sig(2,0),
        ack_20_out => ack_out_sig(2,0),
        data_20_out => data_out_sig(2,0),
        req_20_out => req_out_sig(2,0),
        ack_20_in => ack_in_sig(2,0),
        
        data_23_in => data_in_sig(2,3),
        req_23_in => req_in_sig(2,3),
        ack_23_out => ack_out_sig(2,3),
        data_23_out => data_out_sig(2,3),
        req_23_out => req_out_sig(2,3),
        ack_23_in => ack_in_sig(2,3),

        data_30_in => data_in_sig(3,0),
        req_30_in => req_in_sig(3,0),
        ack_30_out => ack_out_sig(3,0),
        data_30_out => data_out_sig(3,0),
        req_30_out => req_out_sig(3,0),
        ack_30_in => ack_in_sig(3,0),

        data_31_in => data_in_sig(3,1),
        req_31_in => req_in_sig(3,1),
        ack_31_out => ack_out_sig(3,1),
        data_31_out => data_out_sig(3,1),
        req_31_out => req_out_sig(3,1),
        ack_31_in => ack_in_sig(3,1),

        data_32_in => data_in_sig(3,2),
        req_32_in => req_in_sig(3,2),
        ack_32_out => ack_out_sig(3,2),
        data_32_out => data_out_sig(3,2),
        req_32_out => req_out_sig(3,2),
        ack_32_in => ack_in_sig(3,2),

        data_33_in => data_in_sig(3,3),
        req_33_in => req_in_sig(3,3),
        ack_33_out => ack_out_sig(3,3),
        data_33_out => data_out_sig(3,3),
        req_33_out => req_out_sig(3,3),
        ack_33_in => ack_in_sig(3,3),
        
        ack_test => ack_test,
        req_test => req_test,
        data_test => data_test

        );
        
        

    
    io1: process is
    variable line_v : line;
    file read_file : text;
    file write_input_file : text;
    variable data : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    variable x,y,dx,dy : integer;
    variable px, py, pdx, pdy: integer; -- previous values
    variable curr_ack_in : t_bit_matrix := (others => (others =>'0')); 

  begin
        
    rst <= '1', '0' after 1ns; -- any value other than 0 will do

    file_open(read_file, "/home/mar/DTU/das-24/das-router/test_1_x10.txt", read_mode);
    file_open(write_input_file, "/home/mar/DTU/das-24/das-router/mesh_input.txt", write_mode);
    
    wait for 5ns; -- this is the minimum (by testing)

    while not endfile(read_file) loop
      readline(read_file, line_v);
      read(line_v, data);
      
    x := to_integer(unsigned(data(VALUE_WIDTH-1 downto VALUE_WIDTH*0)));
    y := to_integer(unsigned(data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1)));
    dx:= to_integer(unsigned(data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2)));
    dy:= to_integer(unsigned(data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3))); 
    
    -- if this is the same input node as before:
    if pdx = dx and pdy = dy then
        wait for 0ns; -- necessary
    end if; 
    
    if ack_in_sig(dx, dy) /= req_in_sig(dx,dy) then
        wait until ack_in_sig(dx, dy) = req_in_sig(dx, dy);
    end if;
    
    -- to start, we put the data on the line and change the request
    data_in_sig(dx, dy) <= data(DATA_WIDTH-1 downto 0);
    req_in_sig(dx, dy) <= not req_in_sig(dx, dy);
    
    -- save data sent and when
    write(line_v, data);
    write(line_v, string'(","));
    write(line_v, time'image(now));
    write(line_v, string'(",(") & integer'image(dx) & string'(",") & integer'image(dy) & string'(")"));
    writeline(write_input_file, line_v);
    
--    -- then we wait for ack on the input
--    if ack_in_sig(dx, dy) /= not curr_ack_in(dx, dy) then
--        wait until ack_in_sig(dx, dy) = not curr_ack_in(dx, dy);
--        curr_ack_in(dx, dy) := not curr_ack_in(dx, dy);
--    end if;
    
    -- save the previous values
    px := x; py := y; pdx := dx; pdy := dy;
    
    
      
    end loop;
    file_close(read_file);
    --finish;
    wait;
  end process;

    io2: process(req_out_sig) is
    variable line_v : line;
    variable data : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    variable x,y,dx,dy : integer;
    variable curr_ack_in : t_bit_matrix := (others => (others =>'0')); 
    
    variable i, j: integer;

  begin

        if req_out_sig'event then
            
            if req_out_sig(0,0)'event then
                    i:=0; j:= 0;
            elsif req_out_sig(0,1)'event then
                    i:=0; j:= 1;
            elsif req_out_sig(0,2)'event then
                    i:=0; j:= 2;
            elsif req_out_sig(0,3)'event then
                    i:=0; j:= 3;
            elsif req_out_sig(1,0)'event then
                    i:=1; j:= 0;
            elsif req_out_sig(1,3)'event then
                    i:=1; j:= 3;
            elsif req_out_sig(2,0)'event then
                    i:=2; j:= 0;
            elsif req_out_sig(2,3)'event then
                    i:=2; j:= 3;
            elsif req_out_sig(3,0)'event then
                    i:=3; j:= 0;
            elsif req_out_sig(3,1)'event then
                    i:=3; j:= 1;
            elsif req_out_sig(3,2)'event then
                    i:=3; j:= 2;
            elsif req_out_sig(3,3)'event then
                    i:=3; j:= 3;
            end if;
    
        
        write(line_v, data_out_sig(i,j));
        write(line_v, string'(","));
        write(line_v, time'image(now));
        write(line_v, string'(",(") & integer'image(i) & string'(",") & integer'image(j) & string'(")"));
        writeline(write_output_file, line_v);
    
    
        assert ack_out_sig(i,j) /= req_out_sig(i,j) report "MAR: SHOULD ONLY HAPPEN 1";

        ack_out_sig(i,j) <= ack_out_sig(i,j), req_out_sig(i,j) after 10ns;
        
    end if;
    
    

    

    
  end process;



--    proc : process
--    begin
  
--      req_in_sig <= (others => (others => '0'));             
--      ack_out_sig <= (others => (others => '0'));            
--      data_in_sig <= (others => (others => (others => '0')));
        
--    rst <= '1', '0' after 7 ns;

--     -- [ dy (0), dx (0), y (3), x (3)];
--    data_in_sig(0,0) <= "0000000000110011";
--    req_in_sig(0,0) <= '0', '1' after 5ns;
    
--    wait until ack_in_sig(0,0) = '1';
    
--    wait until req_out_sig(3,3) = '1';
--    ack_out_sig(3,3) <= '1';
    
    
--    -- we're in (0,3) and want to go to (0,0)
--    data_in_sig(0,3) <= "0011000000000000";
--    req_in_sig(0,3) <= '0', '1' after 20ns;
--    wait until ack_in_sig(0,3) = '1';
--    wait until req_out_sig(0,0) = '1';
--    ack_out_sig(0,0) <= '1';


--    -- we're in (3,3) and want to go to (0,1)
--    data_in_sig(3,3) <= "0011001100010000";
--    req_in_sig(3,3) <= '0', '1' after 20ns;
--    wait until ack_in_sig(3,3) = '1';
--    wait until req_out_sig(0,1) = '1';
--    ack_out_sig(0,1) <= '1';

    
----    -- [ dy (1), dx (0), y (1), x (3)];
----    data_in_sig(0,1) <= "0001000000010011";
----    req_in_sig(0,1) <= '0', '1' after 5ns;
    
----    wait until ack_in_sig(0,1) = '1';
    
----    wait until req_out_sig(3,1) = '1';
----    ack_out_sig(3,1) <= '1';    
--    wait for 50ns;
--    finish;
--   
--    end process proc;
    
    

end Behavioral;


-------------------------------------

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use std.textio.all;
--use work.defs.all;
--use work.generator;

--entity generator_tb is
--end entity;


--architecture tb of generator_tb is
--    signal rst   :  std_logic;
--begin

--    GEN : entity generator 
--    port map (
--        rst
--        );
            
--     process begin
     
--     rst <= '1', '0' after 2ns;
--     wait for 40ns;
     
--     end process;
     
-- end architecture;



