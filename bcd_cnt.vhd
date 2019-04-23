library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;   

entity bcd_cnt is
    port (
        clk_i   : in std_logic;    -- input clock signal 
        reset : in std_logic;     -- input reset signal
                                   

        carry_o : out std_logic;   -- output carry_up signal    
        bcd_o : out std_logic_vector(3 downto 0)  -- output BCD signal
    );
end bcd_cnt;


architecture Behavioral of bcd_cnt is
    signal s_reg  : std_logic_vector(3 downto 0);
    signal s_next : std_logic_vector(3 downto 0);
    
begin
    p_bcd_cnt: process(reset, clk_i)
    begin
            if reset = '0' then           -- asynchronous reset
                s_reg <= (others => '0');   -- clear all bits in register
            elsif rising_edge(clk_i) then
                s_reg <= s_next;            -- update register value
            end if;
    end process p_bcd_cnt;

 
    s_next <= "0000" when (s_reg = "1001")
              else s_reg + 1;
  
    bcd_o <= s_reg;
    carry_o <= '0' when s_reg = "1001" else  
                 '1';
end Behavioral;
