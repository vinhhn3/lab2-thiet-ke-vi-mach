-------------------------------------------------------------------------------
-- Title      : Practical exercise
-- Project    : 
-------------------------------------------------------------------------------
-- File       : accumulator.vhd
-- Author     : Hieu D. Bui  <hieubd@vnu.edu.vn>
-- Company    : SIS Lab, VNU UET
-- Created    : 2019-05-17
-- Last update: 2019-05-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Design an accumulator in VHDL
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

ENTITY accumulator IS

  PORT (
    clk             : IN  STD_LOGIC;
    rst_n           : IN  STD_LOGIC;
    set             : IN  STD_LOGIC;
    data_in         : IN  SIGNED(7 DOWNTO 0);
    enable          : IN  STD_LOGIC;
    accumulator_out : OUT SIGNED(11 DOWNTO 0));

END ENTITY accumulator;

ARCHITECTURE beh OF accumulator IS
  SIGNAL accumulator_reg : SIGNED(11 DOWNTO 0);
BEGIN  -- ARCHITECTURE beh

  -- the line below is purely for example purpose
  -- You must change it to your need
  -- purpose: Accumulator description
  -- type   : sequential
  -- inputs : clk, rst_n, set, enable, data_in
  -- outputs: accumulator_reg
  accumulator_proc : PROCESS (clk, rst_n) IS
  BEGIN  -- PROCESS accumulator_proc
    IF rst_n = '0' THEN                 -- asynchronous reset (active low)
      accumulator_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN         -- rising clock edge

    END IF;
  END PROCESS accumulator_proc;

  accumulator_out <= accumulator_reg;
END ARCHITECTURE beh;
