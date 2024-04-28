-------------------------------------------------------------------------------
-- Title      : Practical exercise
-- Project    :
-------------------------------------------------------------------------------
-- File       : mac.vhd
-- Author     : Hieu D. Bui  <hieubd@vnu.edu.vn>
-- Company    : SIS Lab, VNU UET
-- Created    : 2019-05-17
-- Last update: 2019-05-17
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Design a multiply-and-accumulate (MAC) module
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

ENTITY mac IS

  PORT (
    clk : IN STD_LOGIC;
    rst_n : IN STD_LOGIC;
    ai_in : IN SIGNED(7 DOWNTO 0);
    bi_in : IN SIGNED(7 DOWNTO 0);
    valid_in : IN STD_LOGIC;
    mac_out : OUT SIGNED(18 DOWNTO 0);
    valid_out : OUT STD_LOGIC
  );

END ENTITY mac;

ARCHITECTURE beh OF mac IS
  SIGNAL count_reg : UNSIGNED(2 DOWNTO 0) := (OTHERS => '0');
  SIGNAL accumulate_reg : SIGNED(18 DOWNTO 0);
BEGIN -- ARCHITECTURE beh

  -- two processes below are examples for you
  -- you should change them to your needs

  -- purpose: calculate the MAC
  -- type   : sequential
  -- inputs : clk, rst_n, ai_in, bi_in, valid_in, count_reg
  -- outputs: accumulate_reg
  mac_proc : PROCESS (clk, rst_n) IS
  BEGIN -- PROCESS mac_proc
    IF rst_n = '0' THEN -- asynchronous reset (active low)
      accumulate_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN -- rising clock edge
      IF valid_in = '1' THEN
        accumulate_reg <= accumulate_reg + ai_in * bi_in;
      END IF;
    END IF;
  END PROCESS mac_proc;

  -- purpose: create a counter to track the number of inputs processed
  -- type   : sequential
  -- inputs : clk, rst_n, valid_in
  -- outputs: count_reg
  valid_proc : PROCESS (clk, rst_n) IS
  BEGIN -- PROCESS valid_proc
    IF rst_n = '0' THEN -- asynchronous reset (active low)
      count_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN -- rising clock edge
      IF valid_in = '1' THEN
        IF count_reg = "100" THEN
          count_reg <= "001";
        ELSE
          count_reg <= count_reg + 1;
        END IF;
      END IF;

    END IF;
  END PROCESS valid_proc;
  mac_out <= accumulate_reg;
  -- valid_out depends on conut_reg, you can write your logics here
  valid_out <= '1' WHEN count_reg = "100" ELSE
    '0';
END ARCHITECTURE beh;