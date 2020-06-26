----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:44:27 06/12/2020 
-- Design Name: 
-- Module Name:    tb_ssgdemo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ssgdemo is
end tb_ssgdemo;

architecture tb of tb_ssgdemo is


component generador_pulso
Port (	mclk	:	in		std_logic;
				led0	:	out	std_logic;
				pwm0		:	out	std_logic;
				pwm1		:	out	std_logic;
				pwm2		:	out	std_logic;
				pwm3		:	out	std_logic;
				reset : in std_logic;
				data_difference : out STD_LOGIC_VECTOR (3 downto 0);--std_logic;
--				cntr2	:	out		std_logic_vector (1 downto 0);
				
			--	mclkout :	out	std_logic;
				cclkout:	out	std_logic;
				clk,rst : in  STD_LOGIC;
			   led : out  STD_LOGIC_VECTOR (7 downto 0);
			   --spi_ss,spi_mosi,spi_sck,avr_tx,avr_rx_busy : in STD_LOGIC;
			   --avr_rx  : out STD_LOGIC :='0';
			   --spi_miso: out STD_LOGIC :='0';
			   --spi_channel : out STD_LOGIC_VECTOR (3 downto 0):=B"0000";
				rx    : in std_logic;
				tx : out std_logic
				);
				
end component;

signal mclk_s	:	std_logic;
signal led0_s	:	std_logic;
signal pwm0_s		:		std_logic; 
signal pwm1_s		:		std_logic;
signal pwm2_s	:		std_logic;
signal pwm3_s		:	std_logic;
signal reset_s : std_logic;
signal data_difference_s :  STD_LOGIC_VECTOR (3 downto 0);--std_logic;
--				cntr2	:	out		std_logic_vector (1 downto 0);
				
			--	mclkout :	out	std_logic;
signal cclkout_s:		std_logic;
signal clk,rst_s : STD_LOGIC;
signal led_s:   STD_LOGIC_VECTOR (7 downto 0);
signal rx_s   :  std_logic;
signal tx_s :  std_logic;

begin 

	ssgdemo: generador_pulso
		Port Map (
			pwm0 => pwm0_s,	
			mclk	=>mclk_s,
			led0=>	led0_s,
			pwm0=>		pwm0_s,
			pwm1=>		pwm1_s,
			pwm2=>		pwm2_s,
			pwm3=>		pwm3_s,
			reset => reset_s,
			data_difference => data_difference_s,
			cclkout=>cclkout_s,
			clk=>clk_s,
			rst =>rst_s, 
			led=>led_s,
			rx    =>rx_s,
			tx =>tx_s		
	);

end tb;

