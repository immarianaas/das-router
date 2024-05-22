library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.demux;
use work.defs.all;


entity demux5 is
 port ( 
    rst : in std_logic;
    
    in_req  : in  std_logic;
    in_data : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    in_ack  : out std_logic;
    
    inSel_req : in  std_logic;
    inSel_ack : out std_logic;
    selector  : in  std_logic_vector(2 downto 0);
    
    o_straight_req  : out std_logic;
    o_straight_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    o_straight_ack  : in  std_logic;
    
    o_left_req  : out std_logic;
    o_left_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    o_left_ack  : in  std_logic;

    o_right_req  : out std_logic;
    o_right_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    o_right_ack  : in  std_logic;

    o_lefto_req  : out std_logic;
    o_lefto_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    o_lefto_ack  : in  std_logic;

    o_righto_req  : out std_logic;
    o_righto_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
    o_righto_ack  : in  std_logic
    
    );
end demux5;

architecture Behavioral of demux5 is
    signal d1_req,d1_ack : std_logic;
    signal d1_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal d2_1_req,d2_1_ack : std_logic;
    signal d2_1_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal d2_2_req,d2_2_ack : std_logic;
    signal d2_2_data : std_logic_vector(DATA_WIDTH-1 downto 0);


    signal straight_ack, left_ack, lefto_ack, right_ack, righto_ack: std_logic;

begin

straight_ack <= o_straight_ack;-- after 10ns; 
left_ack <= o_left_ack; --  after 10ns; 
lefto_ack <= o_lefto_ack; -- after 10ns; 
right_ack <= o_right_ack; -- after 10ns; 
righto_ack <= o_righto_ack; -- after 10ns; 

demux1 : entity demux
    port map(
    rst => rst,
    
    inA_req => in_req,
    inA_data => in_data,
    inA_ack => in_ack,
    
    inSel_req => inSel_req,
    inSel_ack => inSel_ack,
    selector => selector(0),
    
    -- 1
    outB_req =>  d1_req,
    outB_ack => d1_ack,
    outB_data => d1_data,
    
    -- 0
    outC_req => o_straight_req,
    outC_ack => straight_ack,
    outC_data => o_straight_data
    );
    
demux2: entity demux
    port map(
    rst => rst,
    
    inA_req => d1_req,
    inA_data => d1_data,
    inA_ack => d1_ack,
    
    inSel_req => d1_req,
    inSel_ack => d1_ack,
    selector => selector(1),
    
    -- 1
    outB_req =>  d2_1_req,
    outB_ack => d2_1_ack,
    outB_data => d2_1_data,
    
    
    -- 0
    outC_req => d2_2_req,
    outC_ack => d2_2_ack,
    outC_data => d2_2_data
    );
demux2_1: entity demux
    port map(
    rst => rst,
    
    inA_req => d2_1_req,
    inA_data => d2_1_data,
    inA_ack => d2_1_ack,
    
    inSel_req => d2_1_req,
    inSel_ack => d2_1_ack,
    selector => selector(2),
    
    outB_req =>  o_lefto_req,
    outB_ack => lefto_ack,
    outB_data => o_lefto_data,
    
    outC_req => o_left_req,
    outC_ack => left_ack,
    outC_data => o_left_data
    );
demux2_2: entity demux
    port map(
    rst => rst,
    
    inA_req => d2_2_req,
    inA_data => d2_2_data,
    inA_ack => d2_2_ack,
    
    inSel_req => d2_2_req,
    inSel_ack => d2_2_ack,
    selector => selector(2),
    
    -- 1
    outB_req =>  o_righto_req,
    outB_ack => righto_ack,
    outB_data => o_righto_data,
    
    -- 0
    outC_req => o_right_req,
    outC_ack => right_ack,
    outC_data => o_right_data
    );

end Behavioral;
