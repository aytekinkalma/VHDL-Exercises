library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_vending_machine is
--  Port ( );
end tb_vending_machine;

architecture Behavioral of tb_vending_machine is

component vending_machine is 
port ( 
 clk          :in std_logic;
 rst          :in std_logic;
 para_in      :in std_logic;
 para         :in std_logic_vector(4 downto 0);
 
 urun_hazir   :out std_logic;
 para_ustu_out    :out std_logic
 );
 end component;
 
signal clk              :std_logic;
signal rst              :std_logic;
signal para_in          :std_logic;
signal para             :std_logic_vector(4 downto 0);

signal urun_hazir       : std_logic;
signal para_ustu_out    : std_logic;

constant clock_period:  time:=20ns;
begin
clock_process:process
begin
clk<='0';
wait for clock_period/2;
clk<='1';
wait for clock_period/2;
end process;

uut:vending_machine port map(
 clk              => clk          ,
 rst              => rst          ,
 para_in          => para_in      ,
 para             => para         ,
                 
 urun_hazir       => urun_hazir   ,
 para_ustu_out    => para_ustu_out
);

stim_proo:process
begin 
rst<='1';
para_in<='0';
para<=(others=>'0');
wait for 100ns;
rst<='0';
wait for clock_period*2;

para_in<='1';
para<="00001";
wait for clock_period;
para<="00101";
wait for clock_period;
para<="01010";
wait for clock_period;
para_in<='0';
wait for clock_period*15;

para_in<='1';
para<="00001";
wait for clock_period;
para<="00001";
wait for clock_period;
para<="00101";
wait for clock_period;
para_in<='0';
wait for clock_period*15;

para_in<='1';
para<="00101";
wait for clock_period;
para<="00001";
wait for clock_period;
para<="00001";
wait for clock_period;
para<="00101";
wait for clock_period;
para_in<='0';
wait for clock_period*15;

para_in<='1';
para<="01010";
wait for clock_period;
para<="00101";

para_in<='0';
wait for clock_period*15;
wait;


end process;
end Behavioral;
