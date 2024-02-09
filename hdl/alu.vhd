--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: alu.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS250T> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
library work;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tpu_constants.all;

entity alu is
port (
    I_clk : in std_logic;
    I_en : in std_logic;
    I_dataA : in std_logic_vector(15 downto 0);
    I_dataB : in std_logic_vector(15 downto 0);
    I_dataDwe : in std_logic;
    I_aluop : in std_logic_vector(4 downto 0);
    I_PC : in std_logic_vector(15 downto 0);
    I_dataIMM : in std_logic_vector(15 downto 0);

    O_dataResult : OUT std_logic_vector(15 downto 0);
    O_dataWriteReg : OUT std_logic;
    O_shouldBranch : OUT std_logic
);
end alu;
architecture architecture_alu of alu is
	signal s_result : std_logic_vector(17 downto 0) := (others => '0'); -- example
	signal s_shouldBranch : std_logic := '0';
begin
    process(I_clk, I_en)
    begin
        if rising_edge(I_clk) and I_en = '1' then
            O_dataWriteReg <= I_dataDwe;
            case I_aluop(4 downto 1) is
                when OPCODE_ADD =>
                if I_aluop(0) = '0' then
                    s_result(16 downto 0) <= std_logic_vector(unsigned('0' & I_dataA) + unsigned('0' & I_dataB));
                else
                    s_result(16 downto 0) <= std_logic_vector(signed(I_dataA(15) & I_dataA) + signed(I_dataB(15) & I_dataB));
                end if;
                s_shouldBranch <= '0';
                when others =>
                s_result <= "00" & X"FEFE";
            end case;
        end if;
    end process;
    O_dataResult <= s_result(16 downto 0);
    O_shouldBranch <= s_shouldBranch;

end architecture_alu;
