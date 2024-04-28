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
  COMPONENT mac
    PORT (
      clk : IN STD_LOGIC;
      rst_n : IN STD_LOGIC;
      ai_in : IN SIGNED(7 DOWNTO 0);
      bi_in : IN SIGNED(7 DOWNTO 0);
      valid_in : IN STD_LOGIC;
      mac_out : OUT SIGNED(18 DOWNTO 0);
      valid_out : OUT STD_LOGIC
    );
  END COMPONENT;
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
  DUT : mac
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
  -- rst_n <= '1' AFTER 5 * PERIOD + PERIOD/3;
  -- waveform generation
  WaveGen_Proc : PROCESS
  BEGIN
    -- set default input signals at reset
    ai_in <= to_signed(0, ai_in'LENGTH);
    bi_in <= to_signed(0, bi_in'LENGTH);
    valid_in <= '0';

    WAIT FOR 15 ns;

    -- Test case 1: ai_in = 2, bi_in = 3, valid_in = '1'
    ai_in <= to_signed(2, 8);
    bi_in <= to_signed(3, 8);
    valid_in <= '1';
    rst_n <= '1';

    WAIT UNTIL rising_edge(clk);
    WAIT FOR 2 ns;
    -- 1 cycle, it should be 6
    ASSERT mac_out = to_signed(6, 19) REPORT "Test case 1 failed" SEVERITY error;
    -- Another cycle, it should be 12
    WAIT UNTIL rising_edge(clk);
    WAIT FOR 2 ns;
    ASSERT mac_out = to_signed(12, 19) REPORT "Test case 1 failed" SEVERITY error;
    -- Another cycle, it should be 18
    WAIT UNTIL rising_edge(clk);
    WAIT FOR 2 ns;
    ASSERT mac_out = to_signed(18, 19) REPORT "Test case 1 failed" SEVERITY error;
    -- Another cycle, it should be 24
    -- valid_out = 1
    WAIT UNTIL rising_edge(clk);
    WAIT FOR 2 ns;
    ASSERT mac_out = to_signed(24, 19) REPORT "Test case 1 failed" SEVERITY error;
    ASSERT valid_out = '1' REPORT "Test case 1 failed" SEVERITY error;
    -- Waiting for 4 cycles, mac_out = 48
    -- valid_out = 1
    WAIT FOR 4 * PERIOD;
    ASSERT mac_out = to_signed(48, 19) REPORT "Test case 1 failed" SEVERITY error;
    ASSERT valid_out = '1' REPORT "Test case 1 failed" SEVERITY error;
    -- Test case 2: valid_in = '0', keep mac_out = 48, valid_out = 1
    valid_in <= '0';
    WAIT UNTIL rising_edge(clk);
    WAIT FOR 2 ns;
    ASSERT mac_out = to_signed(48, 19) REPORT "Test case 2 failed" SEVERITY error;
    ASSERT valid_out = '1' REPORT "Test case 2 failed" SEVERITY error;

    -- Test case 3: reset_n = 0, mac_out = 0, valid_out = 0
    rst_n <= '0';
    WAIT FOR 2 ns;
    ASSERT mac_out = to_signed(0, 19) REPORT "Test case 3 failed" SEVERITY error;
    ASSERT valid_out = '0' REPORT "Test case 3 failed" SEVERITY error;
    REPORT "END OF SIMULATION MAC TB" SEVERITY NOTE;
    WAIT;
  END PROCESS WaveGen_Proc;

END ARCHITECTURE beh;

-------------------------------------------------------------------------------

CONFIGURATION mac_tb_beh_cfg OF mac_tb IS
  FOR beh
  END FOR;
END mac_tb_beh_cfg;

-------------------------------------------------------------------------------