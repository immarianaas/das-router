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

    proc : process
    
--    variable req_in : t_bit_matrix := (others => (others => '0')); 
--    variable ack_out : t_bit_matrix := (others => (others => '0')); 
--    variable req_out : t_bit_matrix := (others => (others => '0')); 
--    variable ack_in : t_bit_matrix := (others => (others => '0')); 
--    variable data_in : t_data_matrix := (others => (others => (others =>'0')));
--    variable data_out : t_data_matrix := (others => (others => (others =>'0')));
     
    begin
    
--    req_in_sig <= req_in;
--    data_in_sig <= data_in;
--    ack_out_sig <= ack_out;
    
--    data_out := data_out_sig;
--    ack_in := ack_in_sig;
--    req_out := ack_out_sig;

      req_in_sig <= (others => (others => '0'));             
      ack_out_sig <= (others => (others => '0'));            
      data_in_sig <= (others => (others => (others => '0')));
        
        

    
    rst <= '1', '0' after 7 ns;

    -- [ dy (0), dx (0), y (3), x (3)];
    data_in_sig(0,0) <= "0000000000110011";
    req_in_sig(0,0) <= '0', '1' after 20ns;
    wait until ack_in_sig(0,0) = '1';
    
    wait until req_out_sig(3,3) = '1';
    ack_out_sig(3,3) <= '1';
    
    
    -- were in (0,0) and want to go to (0,3)
    data_in_sig(0,0) <= "0000000000110000";
    req_in_sig(0,0) <= '1', '0' after 20ns;
    wait until ack_in_sig(0,0) = '0';
    wait until req_out_sig(0,3) = '1';
    ack_out_sig(0,3) <= '1';

    

    
    
    
    
    wait for 50ns;
    finish;
    
    end process proc;
    
    
--    p_read : process(rstb,clk)
    
--    constant NUM_COL                : integer := 2;   -- number of column of file
--    type t_integer_array       is array(integer range <> )  of integer;
--    file test_vector                : text open read_mode is "file_name.txt";
--    variable row                    : line;
--    variable v_data_read            : t_integer_array(1 to NUM_COL);
--    variable v_data_row_counter     : integer := 0;
--    begin
    
--        if(rstb='0') then -- 1
--            v_data_row_counter     := 0;
--            v_data_read            := (others=> -1);
--            i_op1                  <= (others=>'0');
--            i_op2                  <= (others=>'0');
            
--        elsif(rising_edge(clk)) then -- 1
        
--            if(ena = '1') then  -- external enable signal --2
        
--                -- read from input file in "row" variable
--                if(not endfile(test_vector)) then -- 3
--                    v_data_row_counter := v_data_row_counter + 1;
--                    readline(test_vector,row);
--                end if; -- 3
                
--                -- read integer number from "row" variable in integer array
--                for kk in 1 to NUM_COL loop
--                    read(row,v_data_read(kk));
--                end loop;
--                value1_std_logic_8_bit    <= conv_std_logic_vector(v_data_read(1),8);
--                value2_std_logic_8_bit    <= conv_std_logic_vector(v_data_read(2),8);
--            end if; -- 2
--        end if; -- 1
--    end process p_read;

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



