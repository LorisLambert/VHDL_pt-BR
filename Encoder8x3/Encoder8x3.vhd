--================================================================================
-- 
-- Company: Universidade Federal do Espírito Santo
-- Engineer: Lohane Gonçalves Diogo
-- Create Date: 7 de junho de 2022
-- Project Name: Encoder8x3
-- FPGA: Nexys A7 Artix-7
-- Description: Codificador com prioridade programável 8:3
--
--================================================================================

-- Bibliotecas
library IEEE;                           -- Biblioteca base
use IEEE.std_logic_1164.all;            -- Adotando padrão 1164

-- Entidade
entity Encoder8x3 is port (
    r : in std_logic_vector (7 downto 0);          -- Entrada digital
    c : in std_logic_vector (2 downto 0);          -- Entrada digital
    code : out std_logic_vector (2 downto 0);      -- Saída digital
    active : out std_logic                         -- Saída digital
);
end Encoder8x3;

-- Arquitatura
architecture behavioral of Encoder8x3 is
	signal mask, lower_r, upper_r : std_logic_vector (7 downto 0);
    signal lower_code, upper_code : std_logic_vector (2 downto 0);
    signal lower_active : std_logic;        
begin

    -- Máscara
    process(c)
    begin
        if (c="000") then
            mask <= "00000001";
        elsif (c="001")then
            mask <= "00000011";
        elsif (c="010")then
            mask <= "00000111";
        elsif (c="011")then
            mask <= "00001111";
        elsif (c="100")then
            mask <= "00011111";
        elsif (c="101")then
            mask <= "00111111";
        elsif (c="110")then
            mask <= "01111111";
        else
            mask <= "11111111";
        end if;
    end process;

    -- Bloco que gera o lower_r
    lower_r <= r and mask;

    -- Bloco que gera o upper_r
    upper_r <= r and (not mask);

    -- Codificador de prioridade fixa superior
    process(upper_r)
    begin
        if (upper_r(7)='1') then
            upper_code <= "111";
        elsif (upper_r(6)='1')then
            upper_code <= "110";
        elsif (upper_r(5)='1')then
            upper_code <= "101";
        elsif (upper_r(4)='1')then
            upper_code <= "100";
        elsif (upper_r(3)='1')then
            upper_code <= "011";
        elsif (upper_r(2)='1')then
            upper_code <= "010";
        elsif (upper_r(1)='1')then
            upper_code <= "001";
        else
            upper_code <= "000";
        end if;
    end process;

    -- Codificador de prioridade fixa inferior
    process(lower_r)
    begin
        if (lower_r(7)='1') then
            lower_code <= "111";
        elsif (lower_r(6)='1')then
            lower_code <= "110";
        elsif (lower_r(5)='1')then
            lower_code <= "101";
        elsif (lower_r(4)='1')then
            lower_code <= "100";
        elsif (lower_r(3)='1')then
            lower_code <= "011";
        elsif (lower_r(2)='1')then
            lower_code <= "010";
        elsif (lower_r(1)='1')then
            lower_code <= "001";
        else
            lower_code <= "000";
        end if;
    end process;

    -- Bloco que gera o lower_active 
    lower_active <= lower_r(7) or lower_r(6) or lower_r(5) or lower_r(4) or 
                    lower_r(3) or lower_r(2) or lower_r(1) or lower_r(0);

    -- Bloco MUX 2:1 de 3 bits para gerar code
    code <= upper_code when lower_active = '0' else lower_code;

    -- Bloco que gera a saída active 
    active <= r(7) or r(6) or r(5) or r(4) or r(3) or r(2) or r(1) or r(0);

end behavioral;