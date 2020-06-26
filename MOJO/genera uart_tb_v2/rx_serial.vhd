----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:01 07/16/2018 
-- Design Name: 
-- Module Name:    rx_serial - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity rx_serial is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_serial_input : in  STD_LOGIC;
           data_parallel_out_rx : out  STD_LOGIC_VECTOR(7 downto 0);
           rx_data_ready : out  STD_LOGIC);
end rx_serial;

architecture Behavioral of rx_serial is

signal usb_clk: std_logic;
signal usb_rst_i: std_logic;
signal serial_data :std_logic_vector (8 downto 0);
signal serial_data_r :std_logic_vector (7 downto 0);
signal serial_sync :std_logic_vector (9 downto 0);
signal serial_count :std_logic_vector (2 downto 0);--cambio
signal tx: std_logic;
signal rx: std_logic;

begin

	usb_clk <= clk;
	usb_rst_i <= rst;
	
	tx <= data_serial_input;
	
--	data_parallel_out_rx(0) <= serial_data_r(7);
--	data_parallel_out_rx(1) <= serial_data_r(6);
--	data_parallel_out_rx(2) <= serial_data_r(5);
--	data_parallel_out_rx(3) <= serial_data_r(4);
--	data_parallel_out_rx(4) <= serial_data_r(3);
--	data_parallel_out_rx(5) <= serial_data_r(2);
--	data_parallel_out_rx(6) <= serial_data_r(1);
--	data_parallel_out_rx(7) <= serial_data_r(0);

	data_parallel_out_rx <= serial_data_r;
	

------------
-- SERIAL --
------------

-- TX --

process(USB_CLK, usb_rst_i)
begin
	if usb_rst_i = '1' then
		serial_data(8 downto 0) <= (others => '1');
		serial_data_r(7 downto 0) <= (others => '1');
		serial_sync(9 downto 0) <= "0000000001";
		serial_count(2 downto 0) <= (others => '0');
	elsif USB_CLK'event and USB_CLK = '1' then 
		if (TX = '0' and serial_sync(0) = '1') or serial_sync(0) = '0' then
				serial_count(2 downto 0) <= serial_count(2 downto 0) + 1;
		else
				serial_count(2 downto 0) <= (others => '0');
		end if;
		if serial_count(2 downto 0) = ("011") then
				serial_sync(9 downto 0) <= serial_sync(8 downto 0) & serial_sync(9);
		else
				serial_sync(9 downto 0) <= serial_sync(9 downto 0);
		end if;
		if serial_count(2 downto 0) = ("011") then
				serial_data(8 downto 0) <= TX & serial_data(8 downto 1); -- TX & 
		else
				serial_data(8 downto 0) <= serial_data(8 downto 0);
		end if;
		if serial_count(2 downto 0) = ("101") and serial_sync(9) = '1' then
				serial_data_r(7 downto 0) <= serial_data(8 downto 1);
				rx_data_ready <= '1';
		else
				serial_data_r(7 downto 0) <= serial_data_r(7 downto 0);
				rx_data_ready <= '0';
		end if;
	end if;
end process;


end Behavioral;