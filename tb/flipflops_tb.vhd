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
  COMPONENT flipflops
    PORT (
      clk : IN STD_LOGIC;
      d : IN STD_LOGIC;
      qa : OUT STD_LOGIC;
      qb : OUT STD_LOGIC;
      qc : OUT STD_LOGIC
    );
  END COMPONENT;
  -- component ports
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL d : STD_LOGIC;
  SIGNAL qa : STD_LOGIC;
  SIGNAL qb : STD_LOGIC;
  SIGNAL qc : STD_LOGIC;

  CONSTANT clk_cycle : TIME := 20 NS;
BEGIN -- ARCHITECTURE test

  -- component instantiation
  DUT : flipflops
  PORT MAP(
    clk => clk,
    d => d,
    qa => qa,
    qb => qb,
    qc => qc
  );
  -- Define clock cycle constant
  -- clock generation

  clk_process : PROCESS
  BEGIN
    WHILE now < 1000 ns LOOP
      clk <= '0';
      WAIT FOR clk_cycle / 2;
      clk <= '1';
      WAIT FOR clk_cycle / 2;
    END LOOP;
    WAIT;
  END PROCESS clk_process;

  test_cases : PROCESS
  BEGIN
    -- test cases for ffa
    d <= '0';
    WAIT FOR 2 * clk_cycle;
    IF (clk = '1') THEN
      ASSERT (qa = '0') REPORT "FFA: qa = 0" SEVERITY ERROR;
    END IF;

    d <= '1';
    WAIT FOR 2 * clk_cycle;
    IF (clk = '1') THEN
      ASSERT (qa = d) REPORT "FFA: qa = 1" SEVERITY ERROR;
    END IF;

    d <= '0';
    WAIT UNTIL clk = '1';
    WAIT FOR 5 ns;
    ASSERT (qb = d) REPORT "FFB: qb = 0" SEVERITY ERROR;

    d <= '1';
    WAIT UNTIL clk = '1';
    WAIT FOR 5 ns;
    ASSERT (qb = d) REPORT "FFB: qb = 1" SEVERITY ERROR;

    d <= '0';
    WAIT UNTIL clk = '0';
    WAIT FOR 5 ns;
    ASSERT (qc = d) REPORT "FFC: qc = 0" SEVERITY ERROR;

    d <= '1';
    WAIT UNTIL clk = '0';
    WAIT FOR 5 ns;
    ASSERT (qc = '1') REPORT "FFC: qc = 1" SEVERITY ERROR;

    REPORT "END TEST CASES" SEVERITY NOTE;
    WAIT;
  END PROCESS test_cases;
END ARCHITECTURE test;

-------------------------------------------------------------------------------

CONFIGURATION flipflops_tb_test_cfg OF flipflops_tb IS
  FOR test
  END FOR;
END flipflops_tb_test_cfg;

-------------------------------------------------------------------------------