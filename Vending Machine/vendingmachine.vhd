library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity vending_machine is 
port ( 
 clk          :in std_logic;
 rst          :in std_logic;
 para_in   :in std_logic;
 para         :in std_logic_vector(4 downto 0);
 
 urun_hazir   :out std_logic;
 para_ustu_out    :out std_logic
 );
 end entity;
 
 architecture arch of vending_machine is 
 
 type state_type is( IDLE,PARA_GIRIS,URUN_TESLIM,PARA_USTU);
 signal state            :state_type;
 
 -- process signal;
 signal toplam_para      :std_logic_vector(4 downto 0);
 signal eksik_para_flag  :std_logic;
 signal fiyat          :std_logic_vector(4 downto 0);
 
 
 -----=><= 
 begin 
 process (clk,rst)
 begin 
 fiyat<="01010";
 if(rst='1') then 
 state           <= IDLE;
 toplam_para     <= (others=>'0');
 urun_hazir      <= '0';
 para_ustu_out       <= '0';
 eksik_para_flag <='0';
 elsif(rising_edge(clk)) then 
 case state is 
 when   IDLE        =>
 toplam_para     <= (others=>'0');
 urun_hazir      <= '0';
 para_ustu_out       <= '0';
 eksik_para_flag <='0';
 
 if (para_in='1') then 
 state <=PARA_GIRIS;
 toplam_para <=toplam_para+para;
 else 
 state <=IDLE;
 end if;
 
 
 when   PARA_GIRIS  =>
 
 if (para_in='1') then 
 state <=PARA_GIRIS;
 toplam_para <=toplam_para+para;  --toplam para miktarini guncelle
 else 
if (toplam_para>=fiyat) then 
state<=URUN_TESLIM;

else 
state<= PARA_USTU;
eksik_para_flag <='1';
end if;
end if;
 
 when   URUN_TESLIM =>
 toplam_para<=toplam_para-fiyat;
 urun_hazir<='1';
 state<=PARA_USTU;
 when   PARA_USTU   =>
 eksik_para_flag<='0';
 if(toplam_para/="00000") then 
 toplam_para<=toplam_para-"00001";
 para_ustu_out<='1';
 state<=PARA_USTU;
 else 
 state<=IDLE;
 para_ustu_out<='0';
 end if;
 
 when others        =>
 state           <= IDLE;
 toplam_para     <= (others=>'0');
 urun_hazir      <= '0';
 para_ustu_out       <= '0';
 eksik_para_flag <='0';
 
 end case;
 
 end if; 
 end process;
 
 
 end architecture;
