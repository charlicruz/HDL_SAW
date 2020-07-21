--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:48:57 07/15/2020
-- Design Name:   
-- Module Name:   Y:/carlos ITEFI/ITEFI-PROYECTOS/HDL_SAW/MOJO/genera_clock/tb_PWM_GENERATOR.vhd
-- Project Name:  genera
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PWM_GENERATOR
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_PWM_GENERATOR IS
END tb_PWM_GENERATOR;
 
ARCHITECTURE behavior OF tb_PWM_GENERATOR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PWM_GENERATOR
    PORT(
         cclk : IN  std_logic;
         reset : IN  std_logic;
         enable : IN  std_logic;
         duty_cycle : IN  std_logic_vector(7 downto 0);
         pwm_out : OUT  std_logic_vector(0 downto 0);
         pwm_inverse_out : OUT  std_logic_vector(0 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal cclk : std_logic := '0';
   signal reset : std_logic := '0';
   signal enable : std_logic := '0';
   signal duty_cycle : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pwm_out : std_logic_vector(0 downto 0);
   signal pwm_inverse_out : std_logic_vector(0 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
	constant CLK_period : time := 10 ns;
   CONSTANT TbPeriod : time := 1 ns;
   SIGNAL TbClock : STD_LOGIC := '0';
   CONSTANT PWMPeriod : time := 10 ns; 
   SIGNAL PWMClock : STD_LOGIC := '0';

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PWM_GENERATOR PORT MAP (
          cclk => cclk,
          reset => reset,
          enable => enable,
          duty_cycle => duty_cycle,
          pwm_out => pwm_out,
          pwm_inverse_out => pwm_inverse_out
        );

   -- Clock process definitions
--   clock_process :process
--   begin
--		clock <= '0';
--		wait for clock_period/2;
--		clock <= '1';
--		wait for clock_period/2;
--   end process;
   TbClock <= NOT TbClock AFTER TbPeriod/2;
   PWMClock <= NOT PWMClock AFTER PWMPeriod/2;
   cclk <= TbClock;
 --  duty_cycle<=b"01111111";
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      enable <= '1';
		duty_cycle <= b"01111111"; -- 50% duty cycle
      wait for clock_period*10;

      -- insert stimulus here 
      wait;
   end process;

END;
