----------------------------------------------------------------------------------
-- Engineer:    Gert-Jan Andries <info@gertjanandries.com>
-- Project:     Quadcopter autopilot
-- Description: A testbench for the PWM counter
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY tb_PWM_COUNTER IS
END tb_PWM_COUNTER;

ARCHITECTURE tb OF tb_PWM_COUNTER IS

    COMPONENT PWM_COUNTER
      GENERIC (
                component_clock   : INTEGER := 10_000_000;  --Hz
                pwm_frequency   : INTEGER := 1_000;          --Hz
                output_width    : INTEGER := 16             --Bits
              );

      PORT    (
                cclk       : IN STD_LOGIC;
                reset       : IN STD_LOGIC;
                pwm_in    : IN STD_LOGIC;
                pwm_count : OUT STD_LOGIC_VECTOR (16 - 1 DOWNTO 0)
             );
    END COMPONENT;

    SIGNAL cclk       : STD_LOGIC;
    SIGNAL reset       : STD_LOGIC;
    SIGNAL pwm_in    : STD_LOGIC;
    SIGNAL pwm_count : STD_LOGIC_vector (16 - 1 DOWNTO 0);

    CONSTANT TbPeriod : time := 1 ns;
    SIGNAL TbClock : STD_LOGIC := '0';

    CONSTANT PWMPeriod : time := 10 ns; 
    SIGNAL PWMClock : STD_LOGIC := '0';
	  -- Clock period definitions
    constant CLK_period : time := 10 ns;
 

BEGIN

    dut : PWM_COUNTER
    PORT MAP (cclk       => cclk,
              reset       => reset,
              pwm_in    => PWMClock,
              pwm_count => pwm_count);

    TbClock <= NOT TbClock AFTER TbPeriod/2;
    PWMClock <= NOT PWMClock AFTER PWMPeriod/2;
 --   CLK <= TbClock;
 --  duty_cycle<=b"01111111";
   -- Stimulus process
--    stim_proc: process
--    begin		
--    -- hold reset state for 100 ns.
--		wait for 100 ns;	
--      wait for clock_period*10;
--
--      -- insert stimulus here 
--    
   CLK_process :process
   begin
		cclk <= '0';
		wait for CLK_period/2;
		cclk <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;


      wait;
   end process;

END tb;
