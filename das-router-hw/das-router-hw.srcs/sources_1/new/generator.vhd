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
    
    type t_bit_matrix is array (0 to 99, 0 to 99) of std_logic;
    type t_data_matrix is array (0 to 99, 0 to 99) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal req_in_sig : t_bit_matrix := (others => (others => '0'));
    signal data_in_sig : t_data_matrix := (others => (others => (others => '0')));
    signal ack_out_sig : t_bit_matrix := (others => (others => '0'));
    
    signal data_out_sig : t_data_matrix;
    signal req_out_sig : t_bit_matrix;
    signal ack_in_sig : t_bit_matrix;
    
    signal rst : std_logic;
    
    file write_output_file : text;
    
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

	data_04_in => data_in_sig(0,4),
	req_04_in => req_in_sig(0,4),
	ack_04_out => ack_out_sig(0,4),
	data_04_out => data_out_sig(0,4),
	req_04_out => req_out_sig(0,4),
	ack_04_in => ack_in_sig(0,4),

	data_05_in => data_in_sig(0,5),
	req_05_in => req_in_sig(0,5),
	ack_05_out => ack_out_sig(0,5),
	data_05_out => data_out_sig(0,5),
	req_05_out => req_out_sig(0,5),
	ack_05_in => ack_in_sig(0,5),

	data_06_in => data_in_sig(0,6),
	req_06_in => req_in_sig(0,6),
	ack_06_out => ack_out_sig(0,6),
	data_06_out => data_out_sig(0,6),
	req_06_out => req_out_sig(0,6),
	ack_06_in => ack_in_sig(0,6),

	data_07_in => data_in_sig(0,7),
	req_07_in => req_in_sig(0,7),
	ack_07_out => ack_out_sig(0,7),
	data_07_out => data_out_sig(0,7),
	req_07_out => req_out_sig(0,7),
	ack_07_in => ack_in_sig(0,7),

	data_08_in => data_in_sig(0,8),
	req_08_in => req_in_sig(0,8),
	ack_08_out => ack_out_sig(0,8),
	data_08_out => data_out_sig(0,8),
	req_08_out => req_out_sig(0,8),
	ack_08_in => ack_in_sig(0,8),

	data_09_in => data_in_sig(0,9),
	req_09_in => req_in_sig(0,9),
	ack_09_out => ack_out_sig(0,9),
	data_09_out => data_out_sig(0,9),
	req_09_out => req_out_sig(0,9),
	ack_09_in => ack_in_sig(0,9),

	data_10_in => data_in_sig(1,0),
	req_10_in => req_in_sig(1,0),
	ack_10_out => ack_out_sig(1,0),
	data_10_out => data_out_sig(1,0),
	req_10_out => req_out_sig(1,0),
	ack_10_in => ack_in_sig(1,0),

	data_19_in => data_in_sig(1,9),
	req_19_in => req_in_sig(1,9),
	ack_19_out => ack_out_sig(1,9),
	data_19_out => data_out_sig(1,9),
	req_19_out => req_out_sig(1,9),
	ack_19_in => ack_in_sig(1,9),

	data_20_in => data_in_sig(2,0),
	req_20_in => req_in_sig(2,0),
	ack_20_out => ack_out_sig(2,0),
	data_20_out => data_out_sig(2,0),
	req_20_out => req_out_sig(2,0),
	ack_20_in => ack_in_sig(2,0),

	data_29_in => data_in_sig(2,9),
	req_29_in => req_in_sig(2,9),
	ack_29_out => ack_out_sig(2,9),
	data_29_out => data_out_sig(2,9),
	req_29_out => req_out_sig(2,9),
	ack_29_in => ack_in_sig(2,9),

	data_30_in => data_in_sig(3,0),
	req_30_in => req_in_sig(3,0),
	ack_30_out => ack_out_sig(3,0),
	data_30_out => data_out_sig(3,0),
	req_30_out => req_out_sig(3,0),
	ack_30_in => ack_in_sig(3,0),

	data_39_in => data_in_sig(3,9),
	req_39_in => req_in_sig(3,9),
	ack_39_out => ack_out_sig(3,9),
	data_39_out => data_out_sig(3,9),
	req_39_out => req_out_sig(3,9),
	ack_39_in => ack_in_sig(3,9),

	data_40_in => data_in_sig(4,0),
	req_40_in => req_in_sig(4,0),
	ack_40_out => ack_out_sig(4,0),
	data_40_out => data_out_sig(4,0),
	req_40_out => req_out_sig(4,0),
	ack_40_in => ack_in_sig(4,0),

	data_49_in => data_in_sig(4,9),
	req_49_in => req_in_sig(4,9),
	ack_49_out => ack_out_sig(4,9),
	data_49_out => data_out_sig(4,9),
	req_49_out => req_out_sig(4,9),
	ack_49_in => ack_in_sig(4,9),

	data_50_in => data_in_sig(5,0),
	req_50_in => req_in_sig(5,0),
	ack_50_out => ack_out_sig(5,0),
	data_50_out => data_out_sig(5,0),
	req_50_out => req_out_sig(5,0),
	ack_50_in => ack_in_sig(5,0),

	data_59_in => data_in_sig(5,9),
	req_59_in => req_in_sig(5,9),
	ack_59_out => ack_out_sig(5,9),
	data_59_out => data_out_sig(5,9),
	req_59_out => req_out_sig(5,9),
	ack_59_in => ack_in_sig(5,9),

	data_60_in => data_in_sig(6,0),
	req_60_in => req_in_sig(6,0),
	ack_60_out => ack_out_sig(6,0),
	data_60_out => data_out_sig(6,0),
	req_60_out => req_out_sig(6,0),
	ack_60_in => ack_in_sig(6,0),

	data_69_in => data_in_sig(6,9),
	req_69_in => req_in_sig(6,9),
	ack_69_out => ack_out_sig(6,9),
	data_69_out => data_out_sig(6,9),
	req_69_out => req_out_sig(6,9),
	ack_69_in => ack_in_sig(6,9),

	data_70_in => data_in_sig(7,0),
	req_70_in => req_in_sig(7,0),
	ack_70_out => ack_out_sig(7,0),
	data_70_out => data_out_sig(7,0),
	req_70_out => req_out_sig(7,0),
	ack_70_in => ack_in_sig(7,0),

	data_79_in => data_in_sig(7,9),
	req_79_in => req_in_sig(7,9),
	ack_79_out => ack_out_sig(7,9),
	data_79_out => data_out_sig(7,9),
	req_79_out => req_out_sig(7,9),
	ack_79_in => ack_in_sig(7,9),

	data_80_in => data_in_sig(8,0),
	req_80_in => req_in_sig(8,0),
	ack_80_out => ack_out_sig(8,0),
	data_80_out => data_out_sig(8,0),
	req_80_out => req_out_sig(8,0),
	ack_80_in => ack_in_sig(8,0),

	data_89_in => data_in_sig(8,9),
	req_89_in => req_in_sig(8,9),
	ack_89_out => ack_out_sig(8,9),
	data_89_out => data_out_sig(8,9),
	req_89_out => req_out_sig(8,9),
	ack_89_in => ack_in_sig(8,9),

	data_90_in => data_in_sig(9,0),
	req_90_in => req_in_sig(9,0),
	ack_90_out => ack_out_sig(9,0),
	data_90_out => data_out_sig(9,0),
	req_90_out => req_out_sig(9,0),
	ack_90_in => ack_in_sig(9,0),

	data_91_in => data_in_sig(9,1),
	req_91_in => req_in_sig(9,1),
	ack_91_out => ack_out_sig(9,1),
	data_91_out => data_out_sig(9,1),
	req_91_out => req_out_sig(9,1),
	ack_91_in => ack_in_sig(9,1),

	data_92_in => data_in_sig(9,2),
	req_92_in => req_in_sig(9,2),
	ack_92_out => ack_out_sig(9,2),
	data_92_out => data_out_sig(9,2),
	req_92_out => req_out_sig(9,2),
	ack_92_in => ack_in_sig(9,2),

	data_93_in => data_in_sig(9,3),
	req_93_in => req_in_sig(9,3),
	ack_93_out => ack_out_sig(9,3),
	data_93_out => data_out_sig(9,3),
	req_93_out => req_out_sig(9,3),
	ack_93_in => ack_in_sig(9,3),

	data_94_in => data_in_sig(9,4),
	req_94_in => req_in_sig(9,4),
	ack_94_out => ack_out_sig(9,4),
	data_94_out => data_out_sig(9,4),
	req_94_out => req_out_sig(9,4),
	ack_94_in => ack_in_sig(9,4),

	data_95_in => data_in_sig(9,5),
	req_95_in => req_in_sig(9,5),
	ack_95_out => ack_out_sig(9,5),
	data_95_out => data_out_sig(9,5),
	req_95_out => req_out_sig(9,5),
	ack_95_in => ack_in_sig(9,5),

	data_96_in => data_in_sig(9,6),
	req_96_in => req_in_sig(9,6),
	ack_96_out => ack_out_sig(9,6),
	data_96_out => data_out_sig(9,6),
	req_96_out => req_out_sig(9,6),
	ack_96_in => ack_in_sig(9,6),

	data_97_in => data_in_sig(9,7),
	req_97_in => req_in_sig(9,7),
	ack_97_out => ack_out_sig(9,7),
	data_97_out => data_out_sig(9,7),
	req_97_out => req_out_sig(9,7),
	ack_97_in => ack_in_sig(9,7),

	data_98_in => data_in_sig(9,8),
	req_98_in => req_in_sig(9,8),
	ack_98_out => ack_out_sig(9,8),
	data_98_out => data_out_sig(9,8),
	req_98_out => req_out_sig(9,8),
	ack_98_in => ack_in_sig(9,8),

	data_99_in => data_in_sig(9,9),
	req_99_in => req_in_sig(9,9),
	ack_99_out => ack_out_sig(9,9),
	data_99_out => data_out_sig(9,9),
	req_99_out => req_out_sig(9,9),
	ack_99_in => ack_in_sig(9,9)

	);

    io1: process is
    variable line_v : line;
    file read_file : text;
    file write_input_file : text;
    variable data : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    variable x,y,dx,dy : integer;
    variable px, py, pdx, pdy: integer; -- previous values
    variable curr_ack_in : t_bit_matrix := (others => (others =>'0')); 

    variable curr_rst : std_logic := '1';
    variable first_time : boolean := true;
     
  begin
        
    rst <= curr_rst, not curr_rst after 1ns; -- any value other than 0 will do
    curr_rst := not curr_rst;
    
    wait for 5ns; -- this is the minimum (by testing)

    file_open(read_file, "/home/mar/DTU/das-24/das-router/test_1_x100.txt", read_mode);
    -- file_open(read_file, "/home/mar/DTU/das-24/das-router/test_2_x1000.txt", read_mode);
    file_open(write_input_file, "/home/mar/DTU/das-24/das-router/mesh_input.txt", write_mode);
    

    while not endfile(read_file) loop
      readline(read_file, line_v);
      read(line_v, data);
      
    x := to_integer(unsigned(data(VALUE_WIDTH-1 downto VALUE_WIDTH*0)));
    y := to_integer(unsigned(data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1)));
    dx:= to_integer(unsigned(data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2)));
    dy:= to_integer(unsigned(data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3))); 
    
    if (x /= px or y /= py or dx /= pdx or dy /= pdy) and not first_time then
        wait for 1000ms; -- wait for a while so that we are sure that the message gets through
        rst <= '1', '0' after 10ns;
        wait for 15ns; -- doesn's matter
    end if;
    
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
    write(line_v, string'(",(") & integer'image(dx) & string'(".") & integer'image(dy) & string'(")"));
    writeline(write_input_file, line_v);
    
--    -- then we wait for ack on the input
--    if ack_in_sig(dx, dy) /= not curr_ack_in(dx, dy) then
--        wait until ack_in_sig(dx, dy) = not curr_ack_in(dx, dy);
--        curr_ack_in(dx, dy) := not curr_ack_in(dx, dy);
--    end if;
    
    -- save the previous values
    px := x; py := y; pdx := dx; pdy := dy;
    first_time := false;
    
    
      
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
    
procedure handle_output_transition(
        i : Integer;
        j : Integer
        ) is 
begin
        write(line_v, data_out_sig(i,j));
        write(line_v, string'(","));
        write(line_v, time'image(now));
        write(line_v, string'(",(") & integer'image(i) & string'(".") & integer'image(j) & string'(")"));
        writeline(write_output_file, line_v);
        ack_out_sig(i,j) <= req_out_sig(i,j);
end procedure;


begin

	if req_out_sig'event then
    
	if req_out_sig(0,0)'event then
		i:=0; j:= 0;
		handle_output_transition(0,0);
	end if;

	if req_out_sig(0,1)'event then
		i:=0; j:= 1;
		handle_output_transition(0,1);
	end if;

	if req_out_sig(0,2)'event then
		i:=0; j:= 2;
		handle_output_transition(0,2);
	end if;

	if req_out_sig(0,3)'event then
		i:=0; j:= 3;
		handle_output_transition(0,3);
	end if;

	if req_out_sig(0,4)'event then
		i:=0; j:= 4;
		handle_output_transition(0,4);
	end if;

	if req_out_sig(0,5)'event then
		i:=0; j:= 5;
		handle_output_transition(0,5);
	end if;

	if req_out_sig(0,6)'event then
		i:=0; j:= 6;
		handle_output_transition(0,6);
	end if;

	if req_out_sig(0,7)'event then
		i:=0; j:= 7;
		handle_output_transition(0,7);
	end if;

	if req_out_sig(0,8)'event then
		i:=0; j:= 8;
		handle_output_transition(0,8);
	end if;

	if req_out_sig(0,9)'event then
		i:=0; j:= 9;
		handle_output_transition(0,9);
	end if;

	if req_out_sig(1,0)'event then
		i:=1; j:= 0;
		handle_output_transition(1,0);
	end if;

	if req_out_sig(1,9)'event then
		i:=1; j:= 9;
		handle_output_transition(1,9);
	end if;

	if req_out_sig(2,0)'event then
		i:=2; j:= 0;
		handle_output_transition(2,0);
	end if;

	if req_out_sig(2,9)'event then
		i:=2; j:= 9;
		handle_output_transition(2,9);
	end if;

	if req_out_sig(3,0)'event then
		i:=3; j:= 0;
		handle_output_transition(3,0);
	end if;

	if req_out_sig(3,9)'event then
		i:=3; j:= 9;
		handle_output_transition(3,9);
	end if;

	if req_out_sig(4,0)'event then
		i:=4; j:= 0;
		handle_output_transition(4,0);
	end if;

	if req_out_sig(4,9)'event then
		i:=4; j:= 9;
		handle_output_transition(4,9);
	end if;

	if req_out_sig(5,0)'event then
		i:=5; j:= 0;
		handle_output_transition(5,0);
	end if;

	if req_out_sig(5,9)'event then
		i:=5; j:= 9;
		handle_output_transition(5,9);
	end if;

	if req_out_sig(6,0)'event then
		i:=6; j:= 0;
		handle_output_transition(6,0);
	end if;

	if req_out_sig(6,9)'event then
		i:=6; j:= 9;
		handle_output_transition(6,9);
	end if;

	if req_out_sig(7,0)'event then
		i:=7; j:= 0;
		handle_output_transition(7,0);
	end if;

	if req_out_sig(7,9)'event then
		i:=7; j:= 9;
		handle_output_transition(7,9);
	end if;

	if req_out_sig(8,0)'event then
		i:=8; j:= 0;
		handle_output_transition(8,0);
	end if;

	if req_out_sig(8,9)'event then
		i:=8; j:= 9;
		handle_output_transition(8,9);
	end if;

	if req_out_sig(9,0)'event then
		i:=9; j:= 0;
		handle_output_transition(9,0);
	end if;

	if req_out_sig(9,1)'event then
		i:=9; j:= 1;
		handle_output_transition(9,1);
	end if;

	if req_out_sig(9,2)'event then
		i:=9; j:= 2;
		handle_output_transition(9,2);
	end if;

	if req_out_sig(9,3)'event then
		i:=9; j:= 3;
		handle_output_transition(9,3);
	end if;

	if req_out_sig(9,4)'event then
		i:=9; j:= 4;
		handle_output_transition(9,4);
	end if;

	if req_out_sig(9,5)'event then
		i:=9; j:= 5;
		handle_output_transition(9,5);
	end if;

	if req_out_sig(9,6)'event then
		i:=9; j:= 6;
		handle_output_transition(9,6);
	end if;

	if req_out_sig(9,7)'event then
		i:=9; j:= 7;
		handle_output_transition(9,7);
	end if;

	if req_out_sig(9,8)'event then
		i:=9; j:= 8;
		handle_output_transition(9,8);
	end if;

	if req_out_sig(9,9)'event then
		i:=9; j:= 9;
		handle_output_transition(9,9);
	end if;

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



