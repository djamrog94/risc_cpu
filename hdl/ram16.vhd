--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: ram16.vhd
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
use ieee.numeric_std.all;

entity ram16 is
port (
    I_clk : in std_logic;
    I_we : in std_logic;
    I_addr : in std_logic_vector(15 downto 0);
    I_data : in std_logic_vector(15 downto 0);
    O_data : out std_logic_vector(15 downto 0)
);
end ram16;

architecture architecture_ram16 of ram16 is

type store_t is array (0 to 31) of std_logic_vector(15 downto 0);
signal ram_16: store_t := (others => X"0000");

begin
    process(I_clk)
    begin
        if rising_edge(I_clk) then
            if I_we = '1' then
                ram_16(to_integer(unsigned(I_addr(5 downto 0)))) <= I_data;
            else
                O_data <= ram_16(to_integer(unsigned(I_addr(5 downto 0))));
            end if;

        end if;
    end process;
end architecture_ram16;
