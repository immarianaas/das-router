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
    
    signal req_in_sig : t_bit_matrix;
    signal data_in_sig : t_data_matrix;
    signal ack_out_sig : t_bit_matrix;
    
    signal data_out_sig : t_data_matrix;
    signal req_out_sig : t_bit_matrix;
    signal ack_in_sig : t_bit_matrix;
    
    signal rst : std_logic;
    
begin

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
        ack_33_in => ack_in_sig(3,3)

        );
        
        
    io: process is
    variable line_v : line;
    file read_file : text;
    file write_file : text;
    variable data : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    variable x,y,dx,dy : integer;

  begin
    req_in_sig <= (others => (others => '0'));             
    ack_out_sig <= (others => (others => '0'));            
    data_in_sig <= (others => (others => (others => '0')));
        
    rst <= '1', '0' after 7 ns;

    file_open(read_file, "/home/mar/DTU/das-24/das-router/data_in.txt", read_mode);
    file_open(write_file, "/home/mar/DTU/das-24/das-router/data_out.txt", write_mode);
    while not endfile(read_file) loop
      readline(read_file, line_v);
      read(line_v, data);
      report "1) The value of 'data' is " & integer'image(to_integer(unsigned(data)));

      
      write(line_v, data);
      writeline(write_file, line_v);
      
      
    x := to_integer(unsigned(data(VALUE_WIDTH-1 downto VALUE_WIDTH*0)));
    y := to_integer(unsigned(data(VALUE_WIDTH*2-1 downto VALUE_WIDTH*1)));
    dx:= to_integer(unsigned(data(VALUE_WIDTH*3-1 downto VALUE_WIDTH*2)));
    dy:= to_integer(unsigned(data( VALUE_WIDTH*4-1 downto VALUE_WIDTH*3))); 
    
    
    report "2) The value of 'data' is " & integer'image(to_integer(unsigned(data)));
    report "value 'x'=" & integer'image(x) & "; 'y'=" & integer'image(y);
    report "value 'dx'=" & integer'image(dx) & "; 'dy'=" & integer'image(dy);


    -- to start, we put the data on the line
    data_in_sig(dx, dy) <= data(DATA_WIDTH-1 downto 0);
    
    -- then we toggle the request signal TODO: not sure about the 10ns
    --req_in_sig(dx, dy) <= req_in_sig(dx, dy), not req_in_sig(dx, dy) after 10ns;
    req_in_sig(dx, dy) <= '0', '1' after 20ns;
    
    -- then we wait for ack on the input TODO: change this to be a toggle too!!!
    wait until ack_in_sig(dx, dy) = '1';
    
    -- (just for testing purposes) wait until the request out comes out
    -- if we keep this TODO change to toggle!
    wait until req_out_sig(x, y) = '1';
    ack_out_sig(x,y) <= '1';
  
      
    wait for 20ns;
      
    end loop;
    file_close(read_file);
    finish;
    wait;
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



