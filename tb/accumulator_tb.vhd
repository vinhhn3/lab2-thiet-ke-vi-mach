-------------------------------------------------------------------------------
-- Title      : Testbench for design "accumulator"
-- Project    :
-------------------------------------------------------------------------------
-- File       : accumulator_tb.vhd
-- Author     : Hieu D. Bui  <hieubd@vnu.edu.vn>
-- Company    : SIS Lab, VNU UET
-- Created    : 2019-05-17
-- Last update: 2019-05-17
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2019 SIS Lab, VNU UET
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-17  1.0      Hieu D. Bui     Created
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-------------------------------------------------------------------------------

ENTITY accumulator_tb IS

END ENTITY accumulator_tb;

-------------------------------------------------------------------------------

ARCHITECTURE beh OF accumulator_tb IS

  CONSTANT PERIOD : TIME := 10 NS;
  -- component ports
  SIGNAL clk : STD_LOGIC := '1';
  SIGNAL rst_n : STD_LOGIC := '0';
  SIGNAL set : STD_LOGIC;
  SIGNAL data_in : SIGNED(7 DOWNTO 0);
  SIGNAL enable : STD_LOGIC;
  SIGNAL accumulator_out : SIGNED(11 DOWNTO 0);

BEGIN -- ARCHITECTURE beh

  -- component instantiation
  DUT : ENTITY work.accumulator
    PORT MAP(
      clk => clk,
      rst_n => rst_n,
      set => set,
      data_in => data_in,
      enable => enable,
      accumulator_out => accumulator_out);

  -- clock generation
  clk <= NOT clk AFTER PERIOD/2;
  rst_n <= '1' AFTER 5 * PERIOD + PERIOD/3;
  -- waveform generation
  WaveGen_Proc : PROCESS
  BEGIN
    -- set default input signals at reset
    set <= '0';
    data_in <= to_signed(0, data_in'LENGTH);
    enable <= '0';
    WAIT UNTIL rst_n = '1';
    WAIT UNTIL rising_edge(clk);
    WAIT FOR PERIOD/3;
    -- insert signal assignments here
    -- put your single here
    -- for example
    -- set <= '1';
    -- data_in <= to_signed(-1, data_in'LENGTH);
    -- enable <= '0';
    -- WAIT UNTIL rising_edge(clk);
    -- WAIT FOR PERIOD/3;
    -- set <= '0';
    -- data_in <= (OTHERS => '0');
    -- enable <= '0';
    -- WAIT UNTIL rising_edge(clk);
    -- WAIT FOR PERIOD/3;
    REPORT "END OF SIMULATION" SEVERITY NOTE;
    WAIT;
  END PROCESS WaveGen_Proc;

END ARCHITECTURE beh;

-------------------------------------------------------------------------------

CONFIGURATION accumulator_tb_beh_cfg OF accumulator_tb IS
  FOR beh
  END FOR;
END accumulator_tb_beh_cfg;

-------------------------------------------------------------------------------