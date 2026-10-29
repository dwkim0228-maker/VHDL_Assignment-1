library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--entity
entity led_letters is
    port (
        en : in std_logic;
        dat : in std_logic_vector(3 downto 0);
        display : out std_logic_vector(7 downto 0)
    );
end entity led_letters;

--architecture
-- 7-segment display bit order: (a, b, c, d, e, f, g, dp), active-high
architecture bhv of led_letters is
begin
    process(en, dat)
    begin
        if en = '0' then
            display <= "ZZZZZZZZ";
        else
            case dat is
                -- Sequential selection 0000 to 0101 for letters a, b, c, d, f, g
                when "0000" => display <= "11101110"; -- 'A' / 'a' (a,b,c,e,f,g)
                when "0001" => display <= "00111110"; -- 'b'       (c,d,e,f,g)
                when "0010" => display <= "10011100"; -- 'C' / 'c' (a,d,e,f)
                when "0011" => display <= "01111010"; -- 'd'       (b,c,d,e,g)
                when "0100" => display <= "10001110"; -- 'F' / 'f' (a,e,f,g)
                when "0101" => display <= "11110110"; -- 'g'       (a,b,c,d,f,g)
                -- Also support hex code inputs (A, B, C, D, F, G)
                when "1010" => display <= "11101110"; -- 'A'
                when "1011" => display <= "00111110"; -- 'b'
                when "1100" => display <= "10011100"; -- 'C'
                when "1101" => display <= "01111010"; -- 'd'
                when "1111" => display <= "10001110"; -- 'F'
                when "0110" => display <= "11110110"; -- 'g'
                when others => display <= "00000000";
            end case;
        end if;
    end process;
end architecture bhv;
