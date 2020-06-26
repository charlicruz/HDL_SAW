library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use work.myPaquete.all;
  

entity ssgdemo is
	Port (	mclk	:	in		std_logic;
				led0	:	out	std_logic;
				pwm0		:	out	std_logic;
				pwm1		:	out	std_logic;
				pwm2		:	out	std_logic;
				pwm3		:	out	std_logic;
				reset : in std_logic;
--				cntr2	:	out		std_logic_vector (1 downto 0);
				
			--	mclkout :	out	std_logic;
				cclkout:	out	std_logic;
				clk,rst : in  STD_LOGIC;
			   led : out  STD_LOGIC_VECTOR (7 downto 0);
			   spi_ss,spi_mosi,spi_sck,avr_tx,avr_rx_busy : in STD_LOGIC;
			   avr_rx  : out STD_LOGIC :='0';
			   spi_miso: out STD_LOGIC :='0';
			   spi_channel : out STD_LOGIC_VECTOR (3 downto 0):=B"0000"
				);
end ssgdemo;

architecture Behaivioral of ssgdemo is
signal clkdiv	:		std_logic_vector(28 downto 0);
signal cntr0	:		std_logic_vector(6 downto 0);
signal cntr1	:		std_logic_vector(6 downto 0);
signal cntr2	:		std_logic_vector(6 downto 0);
signal cntr3	:		std_logic_vector(6 downto 0);--nuevo
signal cntrv	:		std_logic_vector(6 downto 0);
signal pwmclk	:		std_logic;
signal cclk		:		std_logic;
signal cntclk	:		std_logic;

--signal cclkout	:		std_logic;
--signal mclkout	:		std_logic;

signal cnt 		: 		UNSIGNED(6 downto 0);
signal pwmv		:		std_logic;
signal contador : STD_LOGIC_VECTOR (26 downto 0) :=B"000000000000000000000000000";  --Hex 50M=2FAF080
signal leds     : STD_LOGIC_VECTOR (7 downto  0) :=B"00000000";

component CLKMIX is
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;

  -- Clock out ports
  CLK_OUT1          : out    std_logic
 );
end component;

begin
  u1: CLKMIX port map
   (-- Clock in ports
    CLK_IN1 => mclk,
    -- Clock out ports
    CLK_OUT1 => cclk);
	 
	process (cclk)
			begin
				if cclk='1' and cclk'event then
					clkdiv <= clkdiv + 1;
				end if;
	end process;
	
	
--	cclkout <= cclk;
--	mclkout <= mclk;
 

	pwmclk <= clkdiv(4);
	cntclk <= clkdiv (24);
	led0   <= clkdiv(10);
	process (cntclk)
			begin
			if cntclk = '1' and cntclk'event then -- duty
						cntr0 <= cntr0 + 1;
						cntrv <= cntrv + 1;
						cntr1 <= "0000001";
						cntr2 <= "0000001";
						cntr3 <= "0000010";
				end if;
		end process;
	
	
	process (pwmclk, reset) begin
        if reset = '0' then
            cnt <= (others => '0');
        elsif rising_edge(pwmclk) then
            if cnt = 99 then -- 320MHz /2 = 160MHz / 99 = 1.62MHz
                cnt <= (others => '0');				 
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
		
		pwmv <= '1' when (cnt < UNSIGNED(cntrv)) else '0';
		pwm0 <= '1' when (cnt < UNSIGNED(cntr0)) else '0';
		pwm1 <= '1' when (cnt < UNSIGNED(cntr1)) else '0';
	   pwm3 <= '1' when (cnt < UNSIGNED(cntr3)) else '0';
		
	process(pwmv) begin
		if pwmv = '0' and cnt < UNSIGNED(cntr2) then
			pwm2 <= '1';			
		else
			pwm2 <= '0';
		
		end if;
	end process;

end Behaivioral;
		