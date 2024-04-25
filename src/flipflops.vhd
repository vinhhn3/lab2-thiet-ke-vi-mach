LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY flipflops IS
  
  PORT (
    clk : IN  STD_LOGIC;
    d   : IN  STD_LOGIC;
    qa  : OUT STD_LOGIC;
    qb  : OUT STD_LOGIC;
    qc  : OUT STD_LOGIC);

END ENTITY flipflops;

ARCHITECTURE beh OF flipflops IS

BEGIN  -- ARCHITECTURE beh

  ffa: PROCESS (clk, d) IS 
  BEGIN  -- PROCESS ffa
    IF clk = '1' THEN
      qa <= d;
    END IF;
  END PROCESS ffa;

  ffb: PROCESS (clk) IS
  BEGIN  -- PROCESS ffb
    IF rising_edge(clk) THEN
      qb <= d;
    END IF;
  END PROCESS ffb;

  ffc: PROCESS (clk) IS
  BEGIN  -- PROCESS ffc
    IF falling_edge(clk) THEN 
      qc <= d;
    END IF;
  END PROCESS ffc;

END ARCHITECTURE beh;
