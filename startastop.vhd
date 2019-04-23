library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    


entity startastop is
    port (   
        setiny_i : in std_logic;   -- input clock signal
        prepinac : in std_logic ;   -- command input signal from the button
    	  setiny_o : out std_logic
		  );
end startastop;


architecture Behavioral of startastop is
--    signal s_pom  : std_logic; --pomocna promenna, ktere se prirazuje 0 nebo 1
--    signal s_next : std_logic;   
--  
	 
begin
--p_prepinac: process(prepinac)
--begin
--            if falling_edge(prepinac) then
--                s_pom <= s_next;            -- update register value
--        end if;
--        end process;
--   
    
    setiny_o <= setiny_i when( prepinac ='0') else           -- update register value
                              '0';
    
--    s_next <= '0' when (s_pom = '1') else 
--                        '1';
end Behavioral;
