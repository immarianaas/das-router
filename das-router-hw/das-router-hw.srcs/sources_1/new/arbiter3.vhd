----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2024 09:23:27 AM
-- Design Name: 
-- Module Name: arbiter3 - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity arbiter3 is
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
        -- Output channel
        out_req  : out std_logic;
        out_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
        out_ack  : in  std_logic
    );
end arbiter3;

architecture Behavioral of arbiter3 is

    SIGNAL mid_req, mid_ack: STD_LOGIC;
    SIGNAL mid_data: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);

begin

    arbiter1 : ENTITY arbiter PORT MAP (
        rst => rst,
        inA_req => inA_req,
        inA_data => inA_data,
        inA_ack => inA_ack,
        inB_req => inB_req,
        inB_data => inB_data,
        inB_ack => inB_ack,
        outC_req => mid_req,
        outC_data => mid_data,
        outC_ack => mid_ack
    );

    arbiter2 : ENTITY arbiter PORT MAP (
        rst => rst,
        inA_req => inC_req,
        inA_data => inC_data,
        inA_ack => inC_ack,
        inB_req => mid_req,
        inB_data => mid_data,
        inB_ack => mid_ack,
        outC_req => out_req,
        outC_data => out_data,
        outC_ack => out_ack
    );

end Behavioral;