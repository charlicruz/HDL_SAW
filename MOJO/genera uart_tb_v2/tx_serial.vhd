----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:54 07/16/2018 
-- Design Name: 
-- Module Name:    tx_serial - Behavioral 
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

entity tx_serial is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_parallel_in_tx : in  STD_LOGIC_VECTOR (7 downto 0);
           data_serial_out : out  STD_LOGIC;
           tx_ready : out  STD_LOGIC;
           tx_start : in  STD_LOGIC);
end tx_serial;

architecture Behavioral of tx_serial is

signal usb_clk: std_logic;
signal usb_rst_i: std_logic;
signal serial_data_rx :std_logic_vector (9 downto 0);
signal serial_sync_rx :std_logic_vector (9 downto 0);
signal serial_count_rx :std_logic_vector (2 downto 0);--cambio
signal rx: std_logic;

begin

	usb_clk <= clk;
	usb_rst_i <= rst;

	data_serial_out <= rx;
	

------------
-- SERIAL --
------------


-- RX -- En realidad aquí es TX (Gustavo)

RX <= serial_data_rx(9);--_rx(0);

process(USB_CLK, usb_rst_i)
begin
	if usb_rst_i = '1' then
		serial_data_rx(9 downto 0) <= (others => '1');
		serial_sync_rx(9 downto 0) <= "0000000001";
		serial_count_rx(2 downto 0) <= (others => '0');
	elsif USB_CLK'event and USB_CLK = '1' then 
	   if serial_sync_rx(0) = '0' then
			serial_count_rx(2 downto 0) <= serial_count_rx(2 downto 0) + 1;
		else
			serial_count_rx(2 downto 0) <= (others => '0');
		end if;
		if serial_count_rx(2 downto 0) = ("111") then
				serial_sync_rx(9 downto 0) <= serial_sync_rx(8 downto 0) & serial_sync_rx(9);
		elsif tx_start = '0' then--elsif RD_EN(0) = '0' then
				serial_sync_rx(9 downto 0) <= "0000000010";
		end if;
		if serial_count_rx(2 downto 0) = ("111") then
				serial_data_rx(9 downto 0) <= serial_data_rx(8 downto 0) & '1'; -- TX & 
		elsif tx_start = '0' then--elsif RD_EN(0) = '0' then
				--serial_data_rx(9 downto 0) <= '0' & usb_dat_o(0) & usb_dat_o(1) & usb_dat_o(2) & usb_dat_o(3) & usb_dat_o(4) & usb_dat_o(5) & usb_dat_o(6) & usb_dat_o(7) & '1';
				--serial_data_rx(9 downto 0) <= '0' & data_parallel_in_tx & '1';
				serial_data_rx(9 downto 0) <= '0' &
														 data_parallel_in_tx(0) &
														 data_parallel_in_tx(1) &
														 data_parallel_in_tx(2) &
														 data_parallel_in_tx(3) &
														 data_parallel_in_tx(4) &
														 data_parallel_in_tx(5) &
														 data_parallel_in_tx(6) &
														 data_parallel_in_tx(7) &
														 '1';
		end if;
	end if;
end process;

	tx_ready <= serial_sync_rx(0);


end Behavioral;

