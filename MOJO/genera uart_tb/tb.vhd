--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:52:55 06/12/2020
-- Design Name:   
-- Module Name:   Y:/carlos ITEFI/MOJO/genera uart_tb/tb.vhd
-- Project Name:  genera_tb
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ssgdemo
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
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ssgdemo
    PORT(
         entrada: IN std_logic;
			mclk : IN  std_logic;
--         led0 : OUT  std_logic;
         pwm0 : OUT  std_logic;
         pwm1 : OUT  std_logic;
         pwm2 : OUT  std_logic;
         pwm3 : OUT  std_logic;
			pwm4 : OUT  std_logic;
			pwm5 : OUT  std_logic;

         reset : IN  std_logic;
         data_difference : OUT  std_logic_vector(3 downto 0);
         aux_coun : OUT  std_logic_vector(3 downto 0);
			
			data_difference2 : OUT  std_logic_vector(3 downto 0);
         aux_coun2 : OUT  std_logic_vector(3 downto 0);
--         cclkout : OUT  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         rx : IN  std_logic;
--			sigdel:IN std_logic;
--			entrada_xor:IN std_logic;
			dec : out  STD_LOGIC_VECTOR (4 downto 0);
			salida : out  STD_LOGIC_VECTOR (7 downto 0);
         tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal mclk : std_logic := '0';
	signal reset : std_logic := '0';
   signal reset_sync : std_logic_vector(1 downto 0) := (others=>'1');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal rx : std_logic := '0';

 	--Outputs
  -- signal led0 : std_logic;
   signal entrada : std_logic;
	signal pwm0 : std_logic;
   signal pwm1 : std_logic;
   signal pwm2 : std_logic;
   signal pwm3 : std_logic;
   signal pwm4 : std_logic;--:= (others=>'Z');
   signal pwm5 : std_logic;--:= (others=>'Z');

   signal aux_coun : std_logic_vector(3 downto 0);
   signal data_difference : std_logic_vector(3 downto 0);
	signal aux_coun2 : std_logic_vector(3 downto 0);
   signal data_difference2 : std_logic_vector(3 downto 0);
	   signal dec : std_logic_vector(4 downto 0);
	   signal salida : std_logic_vector(7 downto 0);

   signal cclkout : std_logic;
--   signal led : std_logic_vector(7 downto 0);
--   signal avr_rx : std_logic;
--   signal spi_miso : std_logic;
--   signal spi_channel : std_logic_vector(3 downto 0);
   signal txx : std_logic;
   signal entrada_xor : std_logic;
   signal sigdel: std_logic;

   -- Clock period definitions
   constant mclk_period : time := 10 ns;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ssgdemo PORT MAP (
          mclk => mclk,
--        led0 => led0,
          pwm0 => pwm0,
          pwm1 => pwm1,
          pwm2 => pwm2,
          pwm3 => pwm3,
          pwm4 => pwm4,
          pwm5 => pwm5,
			 salida=>salida,
			 entrada=> entrada,
          reset=>reset,
			 data_difference => data_difference,
			 aux_coun => aux_coun,
			 data_difference2 => data_difference2,
			 aux_coun2 => aux_coun2,
--          cclkout => cclkout,
          clk => clk,
          rst => rst,
    dec=>dec,
          rx => rx
--			 sigdel=>sigdel,
--			 entrada_xor=>entrada_xor,
--          txx => txx
        );

--	reset_sync<=reset_sync(reset_sync'high-1 downto 0)& reset_pin when rising_edge(clk);
--	reset => reset_sync(reset_sync'high);
          
   -- Clock process definitions
   mclk_process :process
   begin
		mclk <= '0';
		wait for mclk_period/2;
		mclk <= '1';
		wait for mclk_period/2;
   end process;
 
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		entrada <= '0';
		wait for clk_period/2;
		entrada <= '1';
		wait for clk_period/2;
   end process;
 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '1';
		wait for 100ns;
		rst <= '0';		 
		wait;	

      wait for mclk_period*10;

      -- insert stimulus here 
      
      wait;
   end process;

END;
