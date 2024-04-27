LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY accumulator_tb IS
END ENTITY accumulator_tb;

ARCHITECTURE behavior OF accumulator_tb IS
  -- Component declaration for the Unit Under Test (UUT)
  COMPONENT accumulator
    PORT (
      clk : IN STD_LOGIC;
      rst_n : IN STD_LOGIC;
      set : IN STD_LOGIC;
      data_in : IN SIGNED(7 DOWNTO 0);
      enable : IN STD_LOGIC;
      accumulator_out : OUT SIGNED(11 DOWNTO 0)
    );
  END COMPONENT;

  -- Inputs
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL rst_n : STD_LOGIC := '1';
  SIGNAL set : STD_LOGIC := '0';
  SIGNAL data_in : SIGNED(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL enable : STD_LOGIC := '0';

  -- Outputs
  SIGNAL accumulator_out : SIGNED(11 DOWNTO 0);

  -- Clock period definitions
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut : accumulator PORT MAP(
    clk => clk,
    rst_n => rst_n,
    set => set,
    data_in => data_in,
    enable => enable,
    accumulator_out => accumulator_out
  );

  -- Clock process definitions
  clk_process : PROCESS
  BEGIN
    WHILE now < 200 ns LOOP
      clk <= '0';
      WAIT FOR clk_period / 2;
      clk <= '1';
      WAIT FOR clk_period / 2;
    END LOOP;
    WAIT;
  END PROCESS;

  -- Stimulus process
  stimulus_proc : PROCESS
  BEGIN
    -- Test case 1: Basic Functionality Test
    rst_n <= '1'; -- Release reset
    set <= '0'; -- Ensure set is deasserted
    enable <= '1'; -- Enable accumulator

    data_in <= to_signed(10, 8); -- Input data
    WAIT FOR 20 ns; -- Wait for a clock cycle
    ASSERT accumulator_out /= to_signed(10, 12)
    REPORT "Test case 1 failed: Basic Functionality Test"
      SEVERITY error;

    -- Test case 2: Reset Test
    rst_n <= '0'; -- Assert reset
    WAIT FOR 20 ns; -- Wait for a clock cycle
    ASSERT accumulator_out = to_signed(0, 12)
    REPORT "Test case 2 failed: Reset Test"
      SEVERITY error;

    -- Test case 3: Disable Accumulator Test
    enable <= '0'; -- Disable accumulator
    data_in <= to_signed(20, 8); -- Input data
    WAIT FOR 20 ns; -- Wait for a clock cycle
    ASSERT accumulator_out /= to_signed(20, 12)
    REPORT "Test case 3 failed: Disable Accumulator Test"
      SEVERITY error;

    -- Test case 4: Set Test
    set <= '1'; -- Assert set
    data_in <= to_signed(30, 8); -- Input data
    WAIT FOR 20 ns; -- Wait for a clock cycle
    ASSERT accumulator_out /= to_signed(30, 12)
    REPORT "Test case 4 failed: Set Test"
      SEVERITY error;

    -- Test case 5: Accumulator Overflow Test
    data_in <= to_signed(4096, 8); -- Input data that causes overflow
    WAIT FOR 20 ns; -- Wait for a clock cycle
    ASSERT accumulator_out = to_signed(0, 12)
    REPORT "Test case 5 failed: Accumulator Overflow Test"
      SEVERITY error;

    WAIT;
  END PROCESS;

END;