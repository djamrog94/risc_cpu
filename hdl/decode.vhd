--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: decode.vhd
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

use IEEE.std_logic_1164.all;

entity decode is
port (
	I_clk : in std_logic;
    I_dataInst : in std_logic_vector(15 downto 0);
    I_en : in std_logic;
    O_selA : out std_logic_vector(2 downto 0);
    O_selB : out std_logic_vector(2 downto 0);
    O_selD : out std_logic_vector(2 downto 0);
    O_dataIMM : out std_logic_vector(15 downto 0);
    O_regDwe : out std_logic;
    O_aluop : out std_logic_vector(4 downto 0)
);
end decode;
architecture rtl of decode is
	signal signal_name1 : std_logic; -- example
	signal signal_name2 : std_logic_vector(1 downto 0) ; -- example

begin
    process(I_clk)
    begin
        if rising_edge(I_clk) and I_en = '1' then
            O_selA <= I_dataInst(7 downto 5);
            O_selB <= I_dataInst(4 downto 2);
            O_selD <= I_dataInst(11 downto 9);
            O_dataIMM <= I_dataInst(7 downto 0) & I_dataInst(7 downto 0);
            O_aluop <= I_dataInst(15 downto 12) & I_dataInst(8);

            case I_dataInst(15 downto 12) is
                when "0111" =>
                    O_regDwe <= '0';
                when "1100" =>
                    O_regDwe <= '0';
                when "1101" =>
                    O_regDwe <= '0';
                when others =>
                    O_regDwe <= '1';
            end case;
        end if;
    end process;

end rtl;
