library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 15;
          addrWidth: natural := 8
    );
   port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0);
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture assincrona of memoriaROM is

  type blocoMemoria is array(0 TO 2**addrWidth - 1) of std_logic_vector(dataWidth-1 DOWNTO 0);

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
  begin
      -- Palavra de Controle = 
      -- Inicializa os endereços:
      tmp(0) := x"0" & "00" & '0' & x"00";	-- NOP
tmp(1) := x"4" & "00" & '0' & x"01";	-- LDI REG0 $1
tmp(2) := x"5" & "00" & '0' & x"0A";	-- STA REG0 Val1
tmp(3) := x"4" & "01" & '0' & x"0A";	-- LDI REG1 $10
tmp(4) := x"5" & "01" & '0' & x"0B";	-- STA REG1 Val10
tmp(5) := x"C" & "00" & '0' & x"0A";	-- CLT REG0 Val1
tmp(6) := x"D" & "00" & '0' & x"0A";	-- JLT @10	
tmp(7) := x"C" & "00" & '0' & x"0B";	-- CLT REG0 Val10
tmp(8) := x"D" & "00" & '0' & x"0C";	-- JLT @12	
tmp(9) := x"6" & "00" & '0' & x"00";	-- JMP @0	
tmp(10) := x"0" & "00" & '0' & x"00";	-- NOP
tmp(11) := x"A" & "00" & '0' & x"00";	-- RET
tmp(12) := x"0" & "00" & '0' & x"00";	-- NOP
tmp(13) := x"5" & "00" & '1' & x"20";	-- STA REG0 HEX0
tmp(14) := x"A" & "00" & '0' & x"00";	-- RET
                 

      return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;
