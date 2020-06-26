--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use work.myPaquete.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ssgdemo is
GENERIC(
		clk_freq		:	INTEGER		:= 50_000_000;	--frequency of system clock in Hertz
		baud_rate	:	INTEGER		:= 19_200;		--data link baud rate in bits/second
		os_rate		:	INTEGER		:= 16;			--oversampling rate to find center of receive bits (in samples per baud period)
		d_width		:	INTEGER		:= 8; 			--data bus width
		parity		:	INTEGER		:= 1;				--0 for no parity, 1 for parity
		parity_eo	:	STD_LOGIC	:= '0');			--'0' for even, '1' for odd parity
	
	Port (	entrada : in std_logic;
	         mclk	:	in		std_logic;
			--	led0	:	out	std_logic;
		--		pwm0		:	out	std_logic;
				pwm1		:	out	std_logic;
				pwm2		:	out	std_logic;
		--		pwm3		:	out	std_logic;
				pwm4		:	out	std_logic;
				pwm5		:	out	std_logic;   
				pwm6				:	out	std_logic;				
			--	seleccion_mux : in std_logic_vector(7 down to 0);
			--	reset : in std_logic;
			--	rst : in std_logic;
				aux_coun : out STD_LOGIC_VECTOR (3 downto 0);--std_logic;
				data_difference : out STD_LOGIC_VECTOR (3 downto 0);--std_logic;
--				cntr2	:	out		std_logic_vector (1 downto 0);
				aux_coun2 : out STD_LOGIC_VECTOR (3 downto 0);--std_logic;
				data_difference2 : out STD_LOGIC_VECTOR (3 downto 0);--std_logic;
			--	mclkout :	out	std_logic;
				cclkout:	out	std_logic;
				clk,reset : in  STD_LOGIC;
			   led : out  STD_LOGIC_VECTOR (7 downto 0);
				dec : out  STD_LOGIC_VECTOR (4 downto 0);
	--		   spi_ss,spi_mosi,spi_sck,avr_tx,avr_rx_busy : in STD_LOGIC;
				
				--sigdel: out std_logic;
--				sigdel:IN std_logic;
--			   entrada_xor:IN std_logic;
		--		seleccion_mux: in std_logic_vector (1 downto 0);
				signal2: out std_logic;
			   salida: out  STD_LOGIC_VECTOR (7 downto 0);
--		spi_miso		: out std_logic;
--		spi_mosi		: in  std_logic;
--		spi_sck			: in  std_logic;
--		spi_ss			: in  std_logic;
--		spi_channel		: out std_logic_vector(3 downto 0);
--
--		tx				: out std_logic;
--		rx				: in  std_logic;
----
--		channel			: in  std_logic_vector(3 downto 0);
--		new_sample		: out std_logic;
--		sample			: out std_logic_vector(9 downto 0);
--		sample_channel	: out std_logic_vector(3 downto 0);
--
--		tx_data			: in  std_logic_vector(7 downto 0);
--		new_tx_data		: in  std_logic;
--		tx_busy			: out std_logic;
--		tx_block		: in  std_logic;
--		rx_data			: out std_logic_vector(7 downto 0);
--		new_rx_data		: out std_logic
--clk		:	IN		STD_LOGIC;										--system clock
	--	reset_n	:	IN		STD_LOGIC;										--ascynchronous reset
		tx_ena	:	IN		STD_LOGIC;										--initiate transmission
		--tx_data	:	IN		STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
		rx			:	IN		STD_LOGIC;										--receive pin
		rx_busy	:	OUT	STD_LOGIC;										--data reception in progress
		rx_error	:	OUT	STD_LOGIC;										--start, parity, or stop bit error detected
		rx_data	:	OUT	STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);	--data received
		tx_busy	:	OUT	STD_LOGIC;  									--transmission in progress
		tx			:	OUT	STD_LOGIC

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
signal seleccion_mux : std_logic_vector (2 downto 0):=(others=>'0');
signal cnt 		: 		UNSIGNED(6 downto 0);
signal pwmv		:		std_logic;
signal contador : STD_LOGIC_VECTOR (26 downto 0) :=B"000000000000000000000000000";  --Hex 50M=2FAF080
--signal leds     : STD_LOGIC_VECTOR (7 downto  0) :=B"00000000";
signal aux_count : STD_LOGIC_VECTOR (3 downto  0) :=B"0000";--std_logic;-- := '0';
signal entrada_xor : std_logic := '0';	
signal sigDel : std_logic:= '0';
signal count_xor : STD_LOGIC_VECTOR (3 downto  0):=B"0000";--std_logic;
signal aux_count2 : STD_LOGIC_VECTOR (3 downto  0) :=B"0000";--std_logic;-- := '0';
signal entrada_xor2 : std_logic := '0';	
signal sigDel2 : std_logic:= '0';
signal count_xor2 : STD_LOGIC_VECTOR (3 downto  0);--:=B"0000";--std_logic;
signal digit    : std_logic;
signal segments : STD_LOGIC_VECTOR (7 downto  0);--:=B"0000";--std_logic;
signal auxiliar1    : std_logic;
signal predeterminado1    : std_logic;

signal clk_18432_s : std_logic                    := '0';
signal data_s      : std_logic_vector(7 downto 0) := x"00";
signal in_valid_s  : std_logic                    := '1';
signal out_valid_s : std_logic                    := '1';
signal accept_s    : std_logic                    := '1';
signal tx_s : std_logic                    := '0';
signal rx_s    : std_logic                    := '0';	
signal temporal: STD_LOGIC;
signal temporal2: STD_LOGIC;
signal temporal3: STD_LOGIC;
signal tempo: STD_LOGIC;
signal pwm0: STD_LOGIC;
signal pwm3: STD_LOGIC;
--signal pwm5: STD_LOGIC;
--signal pwm6: STD_LOGIC;

signal conta: integer range 0 to 124999 := 0;
signal mux_out: STD_LOGIC;
signal salidaff1: STD_LOGIC;--_vector (3 downto 0);
signal salidaff2: STD_LOGIC;
signal salidaff3: STD_LOGIC;
signal salidaff4: STD_LOGIC;
signal salidaff5: STD_LOGIC;
signal salidaff6: STD_LOGIC;
signal salidaff7: STD_LOGIC;

signal b:std_logic_vector(3 downto 0);
signal p:std_logic_vector(4 downto 0); 

-------
signal ready			: std_logic;
signal n_rdy			: std_logic;
signal spi_done			: std_logic;
signal spi_dout			: std_logic_vector(7 downto 0);
signal tx_m				: std_logic;
signal spi_miso_m		: std_logic;
signal spi_miso_en_m	: std_logic;
signal byte_ct_d, byte_ct_q					: std_logic;
signal sample_d, sample_q					: std_logic_vector(9 downto 0);
signal new_sample_d, new_sample_q			: std_logic;
signal sample_channel_d, sample_channel_q	: std_logic_vector(3 downto 0);
signal data_in_s			: std_logic_vector(7 downto 0);

	TYPE 		tx_machine IS(idle, transmit);										--tranmit state machine data type
	TYPE 		rx_machine IS(idle, receive);											--receive state machine data type
	SIGNAL	tx_state				:	tx_machine;										--transmit state machine
	SIGNAL	rx_state				:	rx_machine;										--receive state machine
	SIGNAL	baud_pulse			:	STD_LOGIC := '0';								--periodic pulse that occurs at the baud rate
	SIGNAL	os_pulse				:	STD_LOGIC := '0'; 							--periodic pulse that occurs at the oversampling rate
	SIGNAL	parity_error		:	STD_LOGIC;										--receive parity error flag
	SIGNAL	rx_parity			:	STD_LOGIC_VECTOR(d_width DOWNTO 0);		--calculation of receive parity
	SIGNAL	tx_parity			:	STD_LOGIC_VECTOR(d_width DOWNTO 0);  	--calculation of transmit parity
	SIGNAL	rx_buffer			:	STD_LOGIC_VECTOR(parity+d_width DOWNTO 0) := (OTHERS => '0');  	--values received
	SIGNAL	tx_buffer			:	STD_LOGIC_VECTOR(parity+d_width+1 DOWNTO 0) := (OTHERS => '1');	--values to be transmitted


constant c_CLKS_PER_BIT : integer := 87;
 constant c_BIT_PERIOD : time := 8680 ns;
   
  signal r_CLOCK     : std_logic                    := '0';
  signal r_TX_DV     : std_logic                    := '0';
  signal r_TX_BYTE   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_TX_SERIAL : std_logic;
  signal w_TX_DONE   : std_logic;
  signal w_RX_DV     : std_logic;
  signal w_RX_BYTE   : std_logic_vector(7 downto 0);
  signal r_RX_SERIAL : std_logic := '1';
 
  -- Test Bench uses a 10 MHz Clock
  -- Want to interface to 115200 baud UART
  -- 10000000 / 115200 = 87 Clocks Per Bit.
 
  
component CLKMIX is
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic
 );
end component;  
--
component clk_18432 is
port 
 (clk   : in std_logic;
  reset : in std_logic;
  clk_18432 : out std_logic);
end component clk_18432;

component uart_tx is
port 
	(clk      : in std_logic;   
	reset    : in std_logic;
   data_in  : in std_logic_vector(7 downto 0);
	in_valid : in std_logic;
	tx        : out std_logic;
   accept_in : out std_logic);
end component uart_tx;

component uart_rx is
port 
	(clk   : in std_logic;
    reset : in std_logic;
    rx    : in std_logic;
    data_out  : out std_logic_vector(7 downto 0);
    out_valid : out std_logic);
end component uart_rx;

-- component uart_tx is
--    generic (
--      g_CLKS_PER_BIT : integer := 115   -- Needs to be set correctly
--      );
--    port (
--      i_clk       : in  std_logic;
--      i_tx_dv     : in  std_logic;
--      i_tx_byte   : in  std_logic_vector(7 downto 0);
--      o_tx_active : out std_logic;
--      o_tx_serial : out std_logic;
--      o_tx_done   : out std_logic
--      );
--  end component uart_tx;
-- 
--  component uart_rx is
--    generic (
--      g_CLKS_PER_BIT : integer := 115   -- Needs to be set correctly
--      );
--    port (
--      i_clk       : in  std_logic;
--      i_rx_serial : in  std_logic;
--      o_rx_dv     : out std_logic;
--      o_rx_byte   : out std_logic_vector(7 downto 0)
--      );
--  end component uart_rx;

begin
--
--  -- Instantiate UART transmitter
--  uart_tx : UART_TX2
--    generic map (
--      g_CLKS_PER_BIT => c_CLKS_PER_BIT
--      )
--    port map (
--      i_clk       => r_CLOCK,
--      i_tx_dv     => r_TX_DV,
--      i_tx_byte   => r_TX_BYTE,
--      o_tx_active => open,
--      o_tx_serial => w_TX_SERIAL,
--      o_tx_done   => w_TX_DONE
--      );
-- 
--  -- Instantiate UART Receiver
--  uart_rx : UART_RX2
--    generic map (
--      g_CLKS_PER_BIT => c_CLKS_PER_BIT
--      )
--    port map (
--      i_clk       => r_CLOCK,
--      i_rx_serial => r_RX_SERIAL,
--      o_rx_dv     => w_RX_DV,
--      o_rx_byte   => w_RX_BYTE
--      );
-- 
--  r_CLOCK <= not r_CLOCK after 50 ns;
--   
	
	
	
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
	
--	
--n_rdy <= NOT ready;
--
--cclk_detector : entity work.cclk_detector
--	port map (
--		clk		=> clk,
--		rst		=> rst,
--		cclk	=> cclk,
--		ready	=> ready
--	);
--
--spi_slave	: entity work.spi_slave
--	port map (
--		clk		=> clk,
--		rst		=> n_rdy,
--		ss		=> spi_ss,
--		mosi	=> spi_mosi,
--		miso	=> spi_miso_m,
--		miso_en	=> spi_miso_en_m,
--		sck		=> spi_sck,
--		done	=> spi_done,
--		din		=> "11111111",
--		dout	=> spi_dout
--	);
--	
--serial_rx	: entity work.serial_rx
--	generic map (
--		CLK_PER_BIT	=> 100,
--		CTR_SIZE	=> 7
--	)
--	port map (
--		clk			=> clk,
--		rst			=> rst,
--		rx			=> rx,
--		data		=> rx_data,
--		new_data	=> new_rx_data
--	);
----
--serial_tx	: entity work.serial_tx
--	generic map (
--		CLK_PER_BIT	=>	100,
--		CTR_SIZE	=>	7
--	)
--	port map (
--		clk			=> clk,
--		reset			=>reset,--rst
--		tx			=> tx_m,
--		tx_block	=> tx_block,
--		busy		=> tx_busy,
--		data		=> tx_data,
--		new_data	=> new_tx_data
--	);

--
--new_sample		<= new_sample_q;
--sample			<= sample_q;
--sample_channel	<= sample_channel_q;

--	cclkout <= cclk;
--	mclkout <= mclk;

	pwmclk <= clkdiv(4);
	cntclk <= clkdiv (24);
--	led0   <= clkdiv(10);
	

--	señal1: process(clk,rst)
--	begin
--		if rising_edge(clk) then
--			if (rst='1') then
--				auxiliar1 <= '0';
--				aux_count <= (others=>'0');
--			elsif rising_edge(entrada) then
--				if (contador=124999) then
--				auxiliar1 <= not(temporal1);
--				aux_count <= 0);
--			else
--				aux_count <= aux_count+'1';
--			end if;
--		end if;
--	end process;
--		
--	señal1: process(clk,rst,aux_count)
--	begin
--		if rising_edge(clk) then
--			if (rst='1') then
--				auxiliar1 <= '0';
--				aux_count <= (others=>'0');
--			elsif (aux_count=predeterminado1) then
--				auxiliar1 <= not auxiliar1;
--				aux_count <= (others=>'0');
--			else
--				aux_count <= aux_count+'1';
--			end if;
--		end if;
--	end process;
---------------------------------
--
--	avr_comb	: process(ready, channel, byte_ct_q, sample_q, sample_channel_q, spi_miso_m, spi_miso_en_m, spi_ss, spi_done, spi_dout, tx_m)
--begin
--	if ready = '1' then
--		if spi_miso_en_m = '1' then
--			spi_miso	<= spi_miso_m;
--		else
--			spi_miso	<= 'Z';
--		end if;
--		spi_channel <= channel;
--		tx			<= tx_m;
--	else
--		spi_channel <= "ZZZZ";
--		spi_miso	<= 'Z';
--		tx			<= 'Z';
--	end if;
--
--	byte_ct_d		<= byte_ct_q;
--	sample_d		<= sample_q;
--	new_sample_d	<= '0';
--	sample_channel_d <= sample_channel_q;
--
--	if spi_ss = '1' then
--		byte_ct_d <= '0';
--	end if;
--
--	if spi_done = '1' then
--		if byte_ct_q = '0' then
--			sample_d(7 downto 0)	<= spi_dout;
--			byte_ct_d				<= '1';
--		else
--			sample_d(9 downto 8)	<= spi_dout(1 downto 0);
--			sample_channel_d		<= spi_dout(7 downto 4);
--			byte_ct_d				<= '1';
--			new_sample_d			<= '1';
--		end if;
--	end if;
--end process avr_comb;
--
--avr_seq: process (clk, n_rdy)
--begin
--	if n_rdy = '1' then
--		byte_ct_q		<= '0';
--		sample_q		<= (others => '0');
--		new_sample_q	<= '0';
--	elsif rising_edge(clk) then
--		byte_ct_q		<= byte_ct_d;
--		sample_q		<= sample_d;
--		new_sample_q	<= new_sample_d;
--
--		sample_channel_q	<= sample_channel_d;
--	end if;
--end process avr_seq;


	process (cntclk)
			begin
			if cntclk = '1' and cntclk'event then -- duty
						cntr0 <= cntr0 + 1;
						cntrv <= cntrv + 1;
						cntr1 <= "0000001";--0000001
						cntr2 <= "0001001";--0000001
						cntr3 <= "0000101";--0000010
				end if;
		end process;
	
	 process (reset, pwmclk) begin --clk por pwmclk
        if (reset = '1') then
            temporal <= '0';
				 temporal2 <= '0';
            conta <= 0;
        elsif rising_edge(pwmclk) then
            if (conta =99) then--124999 tenia 200
                temporal <= NOT(temporal);
					 temporal2 <= temporal after 2800ns;
					 temporal3 <= temporal after 1200ns;
                conta <= 0;
            else
                conta <= conta+1;
            end if;
        end if;
    end process;
    
	 
	 pwm4<=temporal;
    pwm5 <= temporal2;
	 pwm6<=temporal3;
	
    process(seleccion_mux,temporal,salidaff1,salidaff2,salidaff3,salidaff4,salidaff5,salidaff6,salidaff7)
	 begin
		case seleccion_mux is
			when "000" => mux_out<=temporal;
			when "001" => mux_out<=salidaff1;
			when "010" => mux_out<=salidaff2;
			when "011" => mux_out<=salidaff3;
			when "100" => mux_out<=salidaff4;
			when "101" => mux_out<='0';--salidaff5;
			when "110" => mux_out<=salidaff6; 
			when "111" => mux_out<=salidaff7;
			when others=> mux_out<='0';
		end case;
	 end process;
	 --pwm3<=mux_out;
	 
	process(pwmclk, reset) begin
        if reset = '0' then
            cnt <= (others => '0');
				tempo <= '0';
        elsif rising_edge(pwmclk) then
            if cnt = 99 then --99 then -- 320MHz /2 = 160MHz / 99 = 1.62MHz
                tempo <= NOT(tempo);
					 cnt <= (others => '0');				 
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
		
	 pwmv <= '1' when (cnt < UNSIGNED(cntrv)) else '0';
	 pwm0 <= '1' when (cnt < UNSIGNED(cntr0)) else '0';
	 pwm1 <= '1' when (cnt < UNSIGNED(cntr1)) else '0';
	 pwm3 <= '1'  when (cnt < UNSIGNED(cntr3))  else '0';
		
	process(pwmv) begin
		if pwmv = '0' and cnt < UNSIGNED(cntr1) then
			pwm2 <= '1';			
		else
			pwm2 <= '0';
		
		end if;
	end process;
   entrada_xor<=pwm0 xor pwm3;--temporal2;
	--entrada_xor<=temporal xor temporal2;--temporal2;
	entrada_xor2<=temporal xor temporal3;
	
	sigDel<=temporal;
	contador_xor:process(pwmclk,entrada_xor,sigDel)
	begin
			if falling_edge(pwmclk) then
				if entrada_xor='1' then
					aux_count<= aux_count+1;
				elsif ( entrada_xor='0' and sigDel='1') then
					count_xor<=aux_count;
					aux_count<=(others=>'0');
				end if;
				if entrada_xor2='1' then
					aux_count2<= aux_count2+1;
				elsif ( entrada_xor2='0' and sigDel2='1') then
					count_xor2<=aux_count2;
					aux_count2<=(others=>'0');
				end if;
		--	sigDel<=entrada_xor;
		--	sigDel2<=entrada_xor2;

			end if;
	end process;
   aux_coun<= aux_count;
	aux_coun2<= aux_count2;

	data_difference2 <= aux_count;
   data_difference <= count_xor;
	
b<=aux_count;

binbcd4:process(b,p)
begin
p(4)<= (b(3) and b(2)) or (b(3) and b(1));
p(3)<= (b(3) and not b(2) and not b(1)); 
p(2)<= (not b(3) and b(2)) or (b(2) and b(1)); 
p(1)<= (b(3) and b(2) and not b(1)) or (not b(3) and b(1));-- and b(1));
p(0)<= b(0);
end process;
dec<=p;

 process(p)
	 begin
		case p is
			when "00000" => segments<="11000000";
			when "00001" => segments<="11111001";
			when "00010" => segments<="10100100";
			when "00011" => segments<="10110000";
			when "00100" => segments<="11000000";
			when "00101" => segments<="10011001";
			when "00110" => segments<="10010010"; 
			when "00111" => segments<="10000011";
			when "01000" => segments<="11111000";
			when "01001" => segments<="10011000";
			when others  => segments<="11111111";
		end case;
	 end process;
salida<=segments;
in_valid_s <= accept_s and out_valid_s;
--    
--    clk_gen : clk_18432 port map (clk   => pwmclk,
--                                  reset => reset,
--
--                                  clk_18432 => clk_18432_s);
--
--    tx_0 : uart_tx port map (clk      => clk_18432_s,
--                             reset    => reset,
--                             data_in  => data_s,--segments
--                             in_valid => in_valid_s,
--
--                             tx        => tx,
--                             accept_in => accept_s);
--
--    rx_0 : uart_rx port map (clk   => clk_18432_s,
--                             reset => reset,
--                             rx    => rx,
--
--                             data_out  => data_s,
--                             out_valid => out_valid_s); 

--
-- UART_TX_INST : uart_tx
----    generic map (
----      g_CLKS_PER_BIT => c_CLKS_PER_BIT
----      )
--    port map (
--      i_clk       => r_CLOCK,
--      i_tx_dv     => r_TX_DV,
--      i_tx_byte   => r_TX_BYTE,
--      o_tx_active => open,
--      o_tx_serial => w_TX_SERIAL,
--      o_tx_done   => w_TX_DONE
--      );
-- 
--  -- Instantiate UART Receiver
--  UART_RX_INST : uart_rx
----    generic map (
----      g_CLKS_PER_BIT => c_CLKS_PER_BIT
----      )
--    port map (
--      i_clk       => r_CLOCK,
--      i_rx_serial => r_RX_SERIAL,
--      o_rx_dv     => w_RX_DV,
--      o_rx_byte   => w_RX_BYTE
--      );
		

	--generate clock enable pulses at the baud rate and the oversampling rate
	PROCESS(reset, clk)
		VARIABLE count_baud	:	INTEGER RANGE 0 TO clk_freq/baud_rate-1 := 0;			--counter to determine baud rate period
		VARIABLE count_os		:	INTEGER RANGE 0 TO clk_freq/baud_rate/os_rate-1 := 0;	--counter to determine oversampling period
	BEGIN
		IF(reset = '0') THEN											--asynchronous reset asserted
			baud_pulse <= '0';												--reset baud rate pulse
			os_pulse <= '0';													--reset oversampling rate pulse
			count_baud := 0;													--reset baud period counter
			count_os := 0;														--reset oversampling period counter
		ELSIF(clk'EVENT AND clk = '1') THEN
			--create baud enable pulse
			IF(count_baud < clk_freq/baud_rate-1) THEN			--baud period not reached
				count_baud := count_baud + 1;								--increment baud period counter
				baud_pulse <= '0';											--deassert baud rate pulse
			ELSE																--baud period reached
				count_baud := 0;												--reset baud period counter
				baud_pulse <= '1';											--assert baud rate pulse
				count_os := 0;													--reset oversampling period counter to avoid cumulative error
			END IF;
			--create oversampling enable pulse
			IF(count_os < clk_freq/baud_rate/os_rate-1) THEN	--oversampling period not reached
				count_os := count_os + 1;									--increment oversampling period counter
				os_pulse <= '0';												--deassert oversampling rate pulse		
			ELSE																--oversampling period reached
				count_os := 0;													--reset oversampling period counter
				os_pulse <= '1';												--assert oversampling pulse
			END IF;
		END IF;
	END PROCESS;

	--receive state machine
	PROCESS(reset, clk)
			VARIABLE rx_count	:	INTEGER RANGE 0 TO parity+d_width+2 := 0;		--count the bits received
			VARIABLE	os_count	:	INTEGER RANGE 0 TO os_rate-1 := 0;				--count the oversampling rate pulses
	BEGIN
		IF(reset = '0') THEN																--asynchronous reset asserted
			os_count := 0;																			--clear oversampling pulse counter
			rx_count := 0;																			--clear receive bit counter
			rx_busy <= '0';																		--clear receive busy signal
			rx_error <= '0';																		--clear receive errors
			rx_data <= (OTHERS => '0');														--clear received data output
			rx_state <= idle;																		--put in idle state
		ELSIF(clk'EVENT AND clk = '1' AND os_pulse = '1') THEN  					--enable clock at oversampling rate
			CASE rx_state IS
				WHEN idle =>																		--idle state
					rx_busy <= '0';																	--clear receive busy flag
					IF(rx = '0') THEN 																--start bit might be present
						IF(os_count < os_rate/2) THEN													--oversampling pulse counter is not at start bit center
							os_count := os_count + 1;														--increment oversampling pulse counter
							rx_state <= idle;																	--remain in idle state
						ELSE																					--oversampling pulse counter is at bit center
							os_count := 0;																		--clear oversampling pulse counter
							rx_count := 0;																		--clear the bits received counter
							rx_busy <= '1';																	--assert busy flag
							rx_state <= receive;																--advance to receive state
						END IF;
					ELSE																					--start bit not present
						os_count := 0;																		--clear oversampling pulse counter
						rx_state <= idle;																	--remain in idle state
					END IF;
				WHEN receive =>																	--receive state
					IF(os_count < os_rate-1) THEN													--not center of bit
						os_count := os_count + 1;														--increment oversampling pulse counter
						rx_state <= receive;																--remain in receive state
					ELSIF(rx_count < parity+d_width) THEN										--center of bit and not all bits received
						os_count := 0;  																	--reset oversampling pulse counter		
						rx_count := rx_count + 1;														--increment number of bits received counter
						rx_buffer <= rx & rx_buffer(parity+d_width DOWNTO 1);					--shift new received bit into receive buffer
						rx_state <= receive;																--remain in receive state
					ELSE																					--center of stop bit
						rx_data <= rx_buffer(d_width DOWNTO 1);									--output data received to user logic
						rx_error <= rx_buffer(0) OR parity_error OR NOT rx;					--output start, parity, and stop bit error flag
						rx_busy <= '0';																	--deassert received busy flag
						rx_state <= idle;																	--return to idle state
					END IF;
			END CASE;
		END IF;
	END PROCESS;
		
	--receive parity calculation logic
	rx_parity(0) <= parity_eo;
	rx_parity_logic: FOR i IN 0 to d_width-1 GENERATE
		rx_parity(i+1) <= rx_parity(i) XOR rx_buffer(i+1);
	END GENERATE;
	WITH parity SELECT  --compare calculated parity bit with received parity bit to determine error
		parity_error <= 	rx_parity(d_width) XOR rx_buffer(parity+d_width) WHEN 1,	--using parity
								'0' WHEN OTHERS;														--not using parity
		
	--transmit state machine
	PROCESS(reset, clk)
		VARIABLE tx_count		:	INTEGER RANGE 0 TO parity+d_width+3 := 0;  --count bits transmitted
	BEGIN
		IF(reset = '0') THEN																--asynchronous reset asserted
			tx_count := 0;																			--clear transmit bit counter
			tx <= '1';																				--set tx pin to idle value of high
			tx_busy <= '1';																		--set transmit busy signal to indicate unavailable
			tx_state <= idle;																		--set tx state machine to ready state
		ELSIF(clk'EVENT AND clk = '1') THEN
			CASE tx_state IS
				WHEN idle =>																	--idle state
					IF(tx_ena = '1') THEN														--new transaction latched in
						tx_buffer(d_width+1 DOWNTO 0) <=  segments & '0' & '1';			--latch in data for transmission and start/stop bits
						IF(parity = 1) THEN															--if parity is used
							tx_buffer(parity+d_width+1) <= tx_parity(d_width);					--latch in parity bit from parity logic
						END IF;
						tx_busy <= '1';																--assert transmit busy flag
						tx_count := 0;																	--clear transmit bit count
						tx_state <= transmit;														--proceed to transmit state
					ELSE																				--no new transaction initiated
						tx_busy <= '0';																--clear transmit busy flag
						tx_state <= idle;																--remain in idle state
					END IF;
				WHEN transmit =>																--transmit state
					IF(baud_pulse = '1') THEN													--beginning of bit
						tx_count := tx_count + 1;													--increment transmit bit counter
						tx_buffer <= '1' & tx_buffer(parity+d_width+1 DOWNTO 1);			--shift transmit buffer to output next bit
					END IF;
					IF(tx_count < parity+d_width+3) THEN									--not all bits transmitted
						tx_state <= transmit;														--remain in transmit state
					ELSE																				--all bits transmitted
						tx_state <= idle;																--return to idle state
					END IF;
			END CASE;
			tx <= tx_buffer(0);																--output last bit in transmit transaction buffer
		END IF;
	END PROCESS;	
	
	--transmit parity calculation logic
	tx_parity(0) <= parity_eo;
	tx_parity_logic: FOR i IN 0 to d_width-1 GENERATE
		tx_parity(i+1) <= tx_parity(i) XOR segments(i);
	END GENERATE;

end Behaivioral;
		