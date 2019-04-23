library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity top is
port(
    -- Global input signals at CPLD expansion board
    btn_i : in std_logic_vector(1 downto 0);
  sw_i: in std_logic_vector(1 downto 0);
   

    -- Global input signals at Coolrunner-II board
    clk_i : in std_logic;   -- on-board jumper JP1 select 10 kHz clock
	 hodiny_i: in std_logic;

    -- Global output signals at Coolrunner-II board
    disp_sseg_o : out std_logic_vector(6 downto 0);
    disp_digit_o : out std_logic_vector(3 downto 0));
    
end top;


architecture Behavioral of top is
    signal setiny1 : std_logic;
    signal setiny2 : std_logic;
    signal data_0 : std_logic_vector(3 downto 0);
    signal data_1 : std_logic_vector(3 downto 0);
    signal data_2 : std_logic_vector(3 downto 0);
    signal data_3 : std_logic_vector(3 downto 0);
    signal carry_1 : std_logic;
    signal carry_2 : std_logic;
    signal carry_3 : std_logic;
    signal carry_4 : std_logic;
    signal carry_5 : std_logic;
	 


   
begin
    
    

    PREVOD : entity work.clknasetiny
		port map (
		clk_i =>  clk_i,
--	   clk_i => setiny1,
		setiny_o => setiny1
		);
		STARTASTOP : entity work.startastop
			port map (
	     setiny_i => setiny1,
        setiny_o => setiny2,
        prepinac => sw_i(0)   
	   
		);	
        

    SETINY : entity work.bcd_cnt
        port map (                     
            clk_i => setiny2,
            carry_o => carry_1,
            bcd_o => data_0,
            reset => btn_i(0)
        );
	
    DESETINY : entity work.bcd_cnt
        port map (                     
            clk_i => carry_1,
            carry_o => carry_2,
            bcd_o => data_1,
            reset => btn_i(0)
        );
    SEKUNDY : entity work.bcd_cnt
        port map (                     
            clk_i => carry_3,
            carry_o => carry_4,
            bcd_o => data_2,
            reset => btn_i(0)
        );
    DESITKY : entity work.bcd_cnt
        port map (                     
            clk_i => carry_4,
            carry_o => carry_5,
            bcd_o => data_3,
            reset => btn_i(0)
        );	 
      
    
       
    DISP_MUX : entity work.disp_mux
        port map(
            data3_i => data_3,
            data2_i => data_2,
            data1_i => data_1,
            data0_i => data_0,
            clk_i =>  clk_i,  
            sseg_o => disp_sseg_o,
            an_o => disp_digit_o
            );
			
--	 clk_i => propojeni
         
    
   
    carry_3 <= '0' when(carry_1 = '0' and carry_2 = '0') else         
                  '1'; 


end Behavioral;
