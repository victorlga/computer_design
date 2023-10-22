library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logicaDesvio is

    port (entrada_flagequal : in std_logic;
			 entrada_flaglower : in std_logic;
			 entrada_jeq : in std_logic;
			 entrada_jmp : in std_logic;
			 entrada_ret : in std_logic;
			 entrada_jsr : in std_logic;
			 entrada_jlt : in std_logic;
			 saida : out std_logic_vector(1 downto 0)
        );
end entity;

architecture comportamento of logicaDesvio is

begin
	-- saida(0) = 1 se for para desviar e 0 se for para continuar.
	-- Deve desviar se for um jump, se for um jeq e a flag_igual estiver setada, se for um jlt e a flag_lower estiver setada ou se for um jsr
	saida(0) <= entrada_jmp or (entrada_jeq and entrada_flagequal) or entrada_jsr or (entrada_flaglower and entrada_jlt);
	-- saida(1) = 1 se for para retornar para ultimo endereco + 1 antes do desvio 
	-- e 0 se for para continuar
	saida(1) <= entrada_ret;
end architecture;