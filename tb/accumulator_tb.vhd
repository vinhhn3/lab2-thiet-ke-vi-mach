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
    WHILE now < 1000 ns LOOP
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
    -- Test case 1: reset_n = 0
    rst_n <= '0';
    enable <= '1';
    data_in <= to_signed(30, 8);
    WAIT FOR 20 ns;
    ASSERT accumulator_out = to_signed(0, 12)
    REPORT "Test case 1 failed: reset_n = 0"
      SEVERITY error;

    -- Test case 2: enable = 0
    rst_n <= '1';
    enable <= '0';
    data_in <= to_signed(30, 8);
    WAIT FOR 20 ns;
    ASSERT accumulator_out = to_signed(0, 12)
    REPORT "Test case 2 failed: enable = 0"
      SEVERITY error;

    -- Test case 3: data_in = 0
    rst_n <= '1';
    enable <= '1';
    data_in <= to_signed(0, 8);
    WAIT FOR 20 ns;
    ASSERT accumulator_out = to_signed(0, 12)
    REPORT "Test case 3 failed: data_in = 0"
      SEVERITY error;

    -- Test case 4: set = 1 to test data_in = accumulator = 30
    rst_n <= '1';
    enable <= '1';
    set <= '1';
    data_in <= to_signed(30, 8);
    WAIT UNTIL clk = '1';
    WAIT FOR 2 ns;
    ASSERT accumulator_out = to_signed(30, 12)
    REPORT "Test case 4 failed: set = 1"
      SEVERITY error;

    -- Test case 5: Test accumulator for each clock cycle
    rst_n <= '1';
    enable <= '1';
    set <= '0';
    data_in <= to_signed(30, 8);
    WAIT UNTIL clk = '1';
    WAIT FOR 5 ns;
    REPORT "accumulator_out: " & INTEGER'image(to_integer(accumulator_out));
    ASSERT accumulator_out = to_signed(60, 12);
    REPORT "Test case 5 failed: Test accumulator for each clock cycle"
      SEVERITY error;
    REPORT "END ACCUMULATOR_TB PROCESS";
    WAIT;
  END PROCESS;

END;