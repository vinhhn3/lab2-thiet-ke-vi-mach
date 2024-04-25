-------------------------------------------------------------------------------
-- Title      : Testbench for design "mac"
-- Project    :
-------------------------------------------------------------------------------
-- File       : mac_tb.vhd
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
-- 2019-05-17  1.0      Hieu D. Bui	Created
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-------------------------------------------------------------------------------

ENTITY mac_tb IS

END ENTITY mac_tb;

-------------------------------------------------------------------------------

ARCHITECTURE beh OF mac_tb IS

  CONSTANT PERIOD : TIME := 10 NS;
  -- component ports
  SIGNAL clk : STD_LOGIC := '1';
  SIGNAL rst_n : STD_LOGIC := '0';
  SIGNAL ai_in : SIGNED(7 DOWNTO 0);
  SIGNAL bi_in : SIGNED(7 DOWNTO 0);
  SIGNAL valid_in : STD_LOGIC;
  SIGNAL mac_out : SIGNED(18 DOWNTO 0);
  SIGNAL valid_out : STD_LOGIC;

BEGIN -- ARCHITECTURE beh

  -- component instantiation
  DUT : ENTITY work.mac
    PORT MAP(
      clk => clk,
      rst_n => rst_n,
      ai_in => ai_in,
      bi_in => bi_in,
      valid_in => valid_in,
      mac_out => mac_out,
      valid_out => valid_out);

  -- clock generation
  Clk <= NOT Clk AFTER PERIOD/2;
  rst_n <= '1' AFTER 5 * PERIOD + PERIOD/3;
  -- waveform generation
  WaveGen_Proc : PROCESS
  BEGIN
    -- set default input signals at reset
    ai_in <= to_signed(0, ai_in'LENGTH);
    bi_in <= to_signed(0, bi_in'LENGTH);
    valid_in <= '0';
    WAIT UNTIL rst_n = '1';
    WAIT UNTIL rising_edge(clk);
    WAIT FOR PERIOD/3;
    -- insert signal assignments here
    -- put your single here
    -- for example
    -- ai_in <= to_signed(0, data_in'LENGTH);
    -- bi_in <= to_signed(0, data_in'LENGTH);
    -- valid_in <= '1';
    -- WAIT UNTIL rising_edge(clk);

    -- WAIT FOR PERIOD/3;
    -- ai_in <= to_signed(0, data_in'LENGTH);
    -- bi_in <= to_signed(0, data_in'LENGTH);
    -- valid_in <= '1';
    -- WAIT UNTIL rising_edge(clk);
    -- WAIT FOR PERIOD/3;

    REPORT "END OF SIMULATION" SEVERITY NOTE;
    WAIT;
  END PROCESS WaveGen_Proc;

END ARCHITECTURE beh;

-------------------------------------------------------------------------------

CONFIGURATION mac_tb_beh_cfg OF mac_tb IS
  FOR beh
  END FOR;
END mac_tb_beh_cfg;

-------------------------------------------------------------------------------