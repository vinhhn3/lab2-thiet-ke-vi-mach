-------------------------------------------------------------------------------
-- Title      : Testbench for design "flipflops"
-- Project    :
-------------------------------------------------------------------------------
-- File       : flipflops_tb.vhd
-- Author     : Hieu D. Bui  <Hieu D. Bui@>
-- Company    : SISLAB, VNU-UET
-- Created    : 2017-11-23
-- Last update: 2017-11-23
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2017 SISLAB, VNU-UET
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-11-23  1.0      Hieu D. Bui     Created
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-------------------------------------------------------------------------------

ENTITY flipflops_tb IS

END ENTITY flipflops_tb;

-------------------------------------------------------------------------------

ARCHITECTURE test OF flipflops_tb IS

  -- component ports
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL d : STD_LOGIC;
  SIGNAL qa : STD_LOGIC;
  SIGNAL qb : STD_LOGIC;
  SIGNAL qc : STD_LOGIC;

  CONSTANT clk_cycle : TIME := 20 NS;
BEGIN -- ARCHITECTURE test

  -- component instantiation
  DUT : ENTITY work.flipflops
    PORT MAP(
      clk => clk,
      d => d,
      qa => qa,
      qb => qb,
      qc => qc);

  -- Define clock cycle constant
  -- clock generation

  clk <= NOT clk AFTER 10 NS;

  -- waveform generation
  WaveGen_Proc : PROCESS
  BEGIN
    -- insert signal assignments here
    d <= '0';
    WAIT FOR 5 NS;
    d <= '1';
    WAIT FOR 3 NS;
  END PROCESS WaveGen_Proc;

  TestCases_ffa : PROCESS IS
  BEGIN
    IF (clk = '1') THEN
      ASSERT (qa = d) REPORT "Test case ffa failed" SEVERITY error;
    END IF;
    REPORT "END TESTCASES_FFA" SEVERITY NOTE;
    WAIT;
  END PROCESS TestCases_ffa;

  TestCases_ffb : PROCESS (clk) IS
  BEGIN
    IF rising_edge(clk) THEN
      ASSERT (qb = d) REPORT "Test case ffb failed. qb: " & STD_LOGIC'image(qb) & " d: " & STD_LOGIC'image(d) SEVERITY error;
    ELSE
    END IF;
    REPORT "END TESTCASES_FFb" SEVERITY NOTE;
  END PROCESS TestCases_ffb;

  TestCases_ffc : PROCESS (clk) IS
  BEGIN
    IF falling_edge(clk) THEN
      ASSERT (qc = d) REPORT "Test case ffc failed" SEVERITY error;
    ELSE
    END IF;
    REPORT "END TESTCASES_FFc" SEVERITY NOTE;
  END PROCESS TestCases_ffc;

END ARCHITECTURE test;

-------------------------------------------------------------------------------

CONFIGURATION flipflops_tb_test_cfg OF flipflops_tb IS
  FOR test
  END FOR;
END flipflops_tb_test_cfg;

-------------------------------------------------------------------------------