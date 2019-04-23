library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity clknasetiny is
port(
        clk_i : in std_logic;
        setiny_o : out std_logic
			
     );
end clknasetiny;

architecture Behavioral of clknasetiny is
    signal poc : std_logic_vector(16-1 downto 0);
    signal poc_next : std_logic_vector(16-1 downto 0); --16 bitu protoze mame 4 segmenty o 4 bitech[0-9], kde max hodnota je 0101[9]
    
begin

    p_clknasetiny: process(clk_i)
    begin
        if rising_edge(clk_i) then
            poc <= poc_next ;           --pri nabezne hrane se pricte jednicka
        end if;
           
    end process p_clknasetiny;
    
    poc <= "0000000000000000" when (poc = "0000000011001000") else --0000000001100011 je binarne 99
                    poc + 1;
    
     setiny_o <= '0' when (poc = "0000000011001000") else  --kdyz je pocet 99, tak 
              '1' ; 
    
end Behavioral;

