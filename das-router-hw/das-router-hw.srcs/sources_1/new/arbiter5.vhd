----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2024 09:23:27 AM
-- Design Name: 
-- Module Name: arbiter5 - Behavioral
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
USE work.arbiter;
use work.click_element;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity arbiter5 is
    PORT (
        rst : IN STD_LOGIC;
        -- Channel A
        inA_req   : in  std_logic;
        inA_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inA_ack   : out std_logic;
        -- Channel B
        inB_req   : in std_logic;
        inB_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inB_ack   : out std_logic;
        -- Channel C
        inC_req   : in std_logic;
        inC_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inC_ack   : out std_logic;
        -- Channel D
        inD_req   : in std_logic;
        inD_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inD_ack   : out std_logic;
        -- Channel E
        inE_req   : in std_logic;
        inE_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        inE_ack   : out std_logic;
        -- Output channel
        out_req  : out std_logic;
        out_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
        out_ack  : in  std_logic
    );
end arbiter5;

architecture Behavioral of arbiter5 is

    SIGNAL mid1_req, mid1_ack: STD_LOGIC;
    SIGNAL mid1_data: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    
    SIGNAL mid2_req, mid2_ack: STD_LOGIC;
    SIGNAL mid2_data: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    
    SIGNAL mid3_req, mid3_ack: STD_LOGIC;
    SIGNAL mid3_data: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    
    SIGNAL end_req, end_ack: STD_LOGIC;
    SIGNAL end_data: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);


begin

    arbiter1 : ENTITY arbiter PORT MAP (
        rst => rst,
        inA_req => inA_req,
        inA_data => inA_data,
        inA_ack => inA_ack,
        inB_req => inC_req,
        inB_data => inC_data,
        inB_ack => inC_ack,
        outC_req => mid1_req,
        outC_data => mid1_data,
        outC_ack => mid1_ack
    );

    arbiter2 : ENTITY arbiter PORT MAP (
        rst => rst,
        inA_req => inB_req,
        inA_data => inB_data,
        inA_ack => inB_ack,
        inB_req => inD_req,
        inB_data => inD_data,
        inB_ack => inD_ack,
        outC_req => mid2_req,
        outC_data => mid2_data,
        outC_ack => mid2_ack
    );

    arbiter3 : ENTITY arbiter PORT MAP (
        rst => rst,
        inA_req => mid1_req,
        inA_data => mid1_data,
        inA_ack => mid1_ack,
        inB_req => inE_req,
        inB_data => inE_data,
        inB_ack => inE_ack,
        outC_req => mid3_req,
        outC_data => mid3_data,
        outC_ack => mid3_ack
    );

    arbiter4 : ENTITY arbiter PORT MAP (
        rst => rst,
        inA_req => mid3_req,
        inA_data => mid3_data,
        inA_ack => mid3_ack,
        inB_req => mid2_req,
        inB_data => mid2_data,
        inB_ack => mid2_ack,
        outC_req => end_req,
        outC_data => end_data,
        outC_ack => end_ack
    );


    click: entity click_element 
    port map (
        rst => rst,
        
        in_ack => end_ack,
        in_req => end_req,
        in_data => end_data,
        -- Output channel
        out_req => out_req,
        out_data => out_data,
        out_ack => out_ack
    );

    

end Behavioral;



----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use work.arbiter5;

entity arbiter5_tb is
signal rst : std_logic;
signal inA_req, inB_req, inC_req, inD_req, inE_req, out_req : std_logic;
signal inA_ack, inB_ack, inC_ack, inD_ack, inE_ack, out_ack : std_logic;
signal inA_data, inB_data, inC_data, inD_data, inE_data, out_data : std_logic_vector(DATA_WIDTH-1 downto 0);
end entity;

architecture tb of arbiter5_tb is
-- internal signals
begin


a3 : entity arbiter5    
    port map (
        rst => rst,
        
        inA_req => inA_req,
        inA_data => inA_data,
        inA_ack => inA_ack,
        
        inB_req => inB_req,
        inB_data => inB_data,
        inB_ack => inB_ack,
        
        inC_req => inC_req,
        inC_data => inC_data,
        inC_ack => inC_ack,
                
        inD_req => inD_req,
        inD_data => inD_data,
        inD_ack => inD_ack,
                
        inE_req => inE_req,
        inE_data => inE_data,
        inE_ack => inE_ack,
        
        out_req => out_req,
        out_data => out_data,
        out_ack => out_ack
    );

    process begin
    
    inA_req <= '0'; inB_req <= '0'; inC_req <= '0'; inD_req <= '0'; inE_req <= '0';
    inB_data <= (others => '0');
    inC_data <= (others => '0');
    inD_data <= (others => '0');
    inE_data <= (others => '0');

    out_ack <= '0';
    
    rst <= '1', '0' after 7ns;

    inA_data <= "0001000100010001";
    inA_req <= '0', '1' after 20ns;
    
    wait until out_req = '1';
    
    out_ack <= '1';
    
    wait for 50ns;
    
--    inA_data <= (others => '0');
--    inB_data <= "0010001000100010";
--    inB_req <= '0', '1' after 20ns;

--    wait for 20ns;
    
--    inB_data <= (others => '0');
--    inC_data <= "0011001100110011";
--    inC_req <= '0', '1' after 20ns;

--    wait for 20ns;

    
    
    
    end process;
    
end architecture;


