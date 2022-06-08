--================================================================================
-- 
-- Company: Universidade Federal do Espírito Santo
-- Engineer: Lohane Gonçalves Diogo
-- Create Date: 7 de junho de 2022
-- Project Name: AND
-- FPGA: ALTERA Cyclone II - EP2C5T144C8
-- Description: Simulador de porta lógica AND
--
--================================================================================

-- Bibliotecas
library IEEE;                           -- Biblioteca base
use IEEE.std_logic_1164.all;            -- Adotando padrão 1164

-- Entidade
entity portAnd is port (
    A :  in std_logic;				    -- Entrada digital
    B :  in std_logic;				    -- Entrada digital
    S : out std_logic                   -- Saída digital
);
end portAnd;

-- Arquitatura
architecture hardware of portAnd is
begin                                   -- Inicia o hardware
    S <= A and B;                       -- "S" recebe operação AND entre "A" e "B"
end hardware;