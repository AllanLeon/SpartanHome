----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:37:25 12/13/2016 
-- Design Name: 
-- Module Name:    CtrlLogic - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CtrlLogic is
		Port ( H1 : in  STD_LOGIC_VECTOR (3 downto 0);
           H2 : in  STD_LOGIC_VECTOR (3 downto 0);
           M1 : in  STD_LOGIC_VECTOR (3 downto 0);
           M2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           E : inout  STD_LOGIC;
           RS : out  STD_LOGIC;
           RW : out  STD_LOGIC;
           SF_CE0 : out  STD_LOGIC;
           DB : out  STD_LOGIC_VECTOR (3 downto 0);
           alarm : out  STD_LOGIC;
           lights : out  STD_LOGIC;
           music : out  STD_LOGIC);
end CtrlLogic;

architecture Behavioral of CtrlLogic is
	type states is (FI1A,FI1B,FI2A,FI2B,FI3A,FI3B,BOR1,BOR2,CONT1,CONT2,MOD1,MOD2,
						 sp1_row,sp1_col,sp2_row,sp2_col,sp3_row,sp3_col,sp4_row,sp4_col,sp5_row,sp5_col,
						 hour1_row,hour1_col,hour2_row,hour2_col,colon1_row,colon1_col,
						 min1_row,min1_col,min2_row,min2_col,LCDL2_row,LCDL2_col,
						 f1_row,f1_col,u1_row,u1_col,n1_row,n1_col,c1_row,c1_col,i1_row,i1_col,o1_row,o1_col,n2_row,n2_col,
						 colon2_row,colon2_col,sp6_row,sp6_col,
						 l1_row,l1_col,u2_row,u2_col,c2_row,c2_col,e1_row,e1_col,s1_row,s1_col,
						 a1_row,a1_col,l2_row,l2_col,a2_row,a2_col,r1_row,r1_col,m1_row,m1_col,a3_row,a3_col,
						 m2_row,m2_col,u3_row,u3_col,s2_row,s2_col,i2_row,i2_col,c3_row,c3_col,a4_row,a4_col,
						 bar1_row,bar1_col,bar2_row,bar2_col,bar3_row,bar3_col,bar4_row,bar4_col,
						 bar5_row,bar5_col,bar6_row,bar6_col,r1,r2);
	signal pr_status,nx_status:states;
	signal tmpLights, tmpAlarm, tmpMusic : std_logic;
	signal selHr1_row, selHr1_col, selHr2_row, selHr2_col : std_logic_vector(3 downto 0) := "0000";
	signal selMn1_row, selMn1_col, selMn2_row, selMn2_col : std_logic_vector(3 downto 0) := "0000";

begin
	SF_CE0 <='1';

	clock: process (clk)   -- DIVISOR DE FRECUENCIA DE 50 MHz a 500 Hz
		variable count:integer range 0 to 100000:=0;
	begin
		if (clk'event and clk='1') then
			if (count < 100000) then
				count:=count + 1;
			else
				count := 0;
			end if;	 
			if (count < 50000) then
				E <= '0';
			else
				E <= '1';
			end if;
		end if;
	end process clock;
	
	verifier : process(H1, H2, M1, M2)
	begin
		if (H1>="0001") and (H2>="1001")	and (M1>="0000") and (M2>="0000")
		 and (H1<="0010") and (H2<="0010") and (M1<="0101") and (M2<="1001") then	--lights @ 19:00-22:59
			lights <= '1';
			tmpLights <= '1';
			alarm <= '0';
			tmpAlarm <= '0';
			music <= '0';
			tmpAlarm <= '0';
		elsif (H1="0000") and (H2="0110") and (M1="0011") and (M2="0000") then	--alarm @ 06:30
			lights <= '0';
			tmpLights <= '0';
			alarm <= '1';
			tmpAlarm <= '1';
			music <= '0';
			tmpMusic <= '0';
		elsif (H1>="0001") and (H2>="1001") and (M1>="0000") and (M2>="0000")
		 and (H1<="0010") and (H2<="0010") and (M1<="0101") and (M2<="1001") then	--music @ 12:30-13:29
			lights <= '0';
			tmpLights <= '0';
			alarm <= '0';
			tmpAlarm <= '0';
			music <= '1';
			tmpMusic <= '1';
		else
			lights <= '0';
			tmpLights <= '0';
			alarm <= '0';
			tmpAlarm <= '0';
			music <= '0';			
			tmpMusic <= '0';			
		end if;
	end process verifier;

	define_h1: process (H1)
	begin
		case H1 is
			when "0000" =>
				selHr1_row <= "0011"; -- $30 (0)
				selHr1_col <= "0000"; 
			when "0001" =>
				selHr1_row <= "0011"; -- $31 (1)
				selHr1_col <= "0001"; 
			when "0010" =>
				selHr1_row <= "0011"; -- $32 (2)
				selHr1_col <= "0010"; 
			when others =>
				selHr1_row <= "0010"; -- $24 ($)
				selHr1_col <= "0100"; 
		end case;
	end process define_h1;

	define_h2: process (H2)
	begin
		case H2 is
			when "0000" =>
				selHr2_row <= "0011"; -- $30 (0)
				selHr2_col <= "0000"; 
			when "0001" =>
				selHr2_row <= "0011"; -- $31 (1)
				selHr2_col <= "0001"; 
			when "0010" =>
				selHr2_row <= "0011"; -- $32 (2)
				selHr2_col <= "0010"; 
			when "0011" =>
				selHr2_row <= "0011"; -- $33 (3)
				selHr2_col <= "0011"; 
			when "0100" =>
				selHr2_row <= "0011"; -- $34 (4)
				selHr2_col <= "0100"; 
			when "0101" =>
				selHr2_row <= "0011"; -- $35 (5)
				selHr2_col <= "0101"; 
			when "0110" =>
				selHr2_row <= "0011"; -- $36 (6)
				selHr2_col <= "0110"; 
			when "0111" =>
				selHr2_row <= "0011"; -- $37 (7)
				selHr2_col <= "0111"; 
			when "1000" =>
				selHr2_row <= "0011"; -- $38 (8)
				selHr2_col <= "1000"; 
			when "1001" =>
				selHr2_row <= "0011"; -- $39 (9)
				selHr2_col <= "1001"; 
			when others =>
				selHr2_row <= "0010"; -- $24 ($)
				selHr2_col <= "0100"; 
		end case;
	end process define_h2;

	define_m1: process (M1)
	begin
		case M1 is
			when "0000" =>
				selMn1_row <= "0011"; -- $30 (0)
				selMn1_col <= "0000"; 
			when "0001" =>
				selMn1_row <= "0011"; -- $31 (1)
				selMn1_col <= "0001"; 
			when "0010" =>
				selMn1_row <= "0011"; -- $32 (2)
				selMn1_col <= "0010"; 
			when "0011" =>
				selMn1_row <= "0011"; -- $33 (3)
				selMn1_col <= "0011"; 
			when "0100" =>
				selMn1_row <= "0011"; -- $34 (4)
				selMn1_col <= "0100"; 
			when "0101" =>
				selMn1_row <= "0011"; -- $35 (5)
				selMn1_col <= "0101"; 
			when others =>
				selMn1_row <= "0010"; -- $24 ($)
				selMn1_col <= "0100"; 
		end case;
	end process define_m1;

	define_m2: process (M2)
	begin
		case M2 is
			when "0000" =>
				selMn2_row <= "0011"; -- $30 (0)
				selMn2_col <= "0000"; 
			when "0001" =>
				selMn2_row <= "0011"; -- $31 (1)
				selMn2_col <= "0001"; 
			when "0010" =>
				selMn2_row <= "0011"; -- $32 (2)
				selMn2_col <= "0010"; 
			when "0011" =>
				selMn2_row <= "0011"; -- $33 (3)
				selMn2_col <= "0011"; 
			when "0100" =>
				selMn2_row <= "0011"; -- $34 (4)
				selMn2_col <= "0100"; 
			when "0101" =>
				selMn2_row <= "0011"; -- $35 (5)
				selMn2_col <= "0101"; 
			when "0110" =>
				selMn2_row <= "0011"; -- $36 (6)
				selMn2_col <= "0110"; 
			when "0111" =>
				selMn2_row <= "0011"; -- $37 (7)
				selMn2_col <= "0111"; 
			when "1000" =>
				selMn2_row <= "0011"; -- $38 (8)
				selMn2_col <= "1000"; 
			when "1001" =>
				selMn2_row <= "0011"; -- $39 (9)
				selMn2_col <= "1001"; 
			when others =>
				selMn2_row <= "0010"; -- $24 ($)
				selMn2_col <= "0100"; 
		end case;
	end process define_m2;

	SEC_machine: process(E, rst)  --- PARTE SECUENCIAL DE LA MAQUINA DE ESTADOS
	begin
		if(E'event and E='1') then
			if(rst='1') then
				pr_status <= FI1A;
			else	
				pr_status <= nx_status;
			end if;
		end if; 
	end process SEC_machine;

	COMB_machine: process (pr_status, selHr1_row, selHr1_col, selHr2_row, selHr2_col, selMn1_row, selMn1_col,
						selMn2_row, selMn2_col, tmpLights, tmpAlarm, tmpMusic) --- PARTE COMBINATORIA DE LA MAQUINA DE ESTADOS
	begin
		case pr_status is
			when FI1A =>      ----- INICIO código $28 SELECCIÓM DEL BUS DE 4 BITS 
				RS <='0'; RW<='0';
				DB <="0010";
				nx_status <= FI1B;
			when FI1B =>
				RS <='0'; RW<='0';
				DB <="1000";
				nx_status <= FI2A;
			when FI2A =>
				RS <='0'; RW<='0';
				DB <="0010";
				nx_status <= FI2B;
			when FI2B =>
				RS <='0'; RW<='0';
				DB <="1000";
				nx_status <= FI3A;
			when FI3A =>
				RS <='0'; RW<='0';
				DB <="0010";
				nx_status <= FI3B;
			when FI3B =>
				RS <='0'; RW<='0';
				DB <="1000";       ----- FIN código $28 SELECCIÓM DEL BUS DE 4 BITS
				nx_status <= BOR1;
			when BOR1 =>       ----- INICIO código $01 BORRA LA PANTALLA Y CURSOR A CASA
				RS <='0'; RW<='0';
				DB <="0000";
				nx_status <= BOR2;
			when BOR2 =>
				RS <='0'; RW<='0';
				DB <="0001";       ----- FIN código $01 BORRA LA PANTALLA Y CURSOR A CASA 
				nx_status <= CONT1;
			when CONT1 =>      ----- INICIO código $0C ACTIVA LA PANTALLA
				RS <='0'; RW<='0';
				DB <="0000";
				nx_status <= CONT2;
			when CONT2 =>
				RS <='0'; RW<='0';
				DB <="1100";       ----- FIN código $0C ACTIVA LA PANTALLA
				nx_status <= MOD1;
			when MOD1 =>       ----- INICIO código $06 INCREMENTA CURSOR EN LA PANTALLA 
				RS <='0'; RW<='0';
				DB <="0000";
				nx_status <= MOD2;
			when MOD2 =>
				RS <='0'; RW<='0';
				DB <="0110";       ----- FIN código $06 INCREMENTA CURSOR EN LA PANTALLA 
				nx_status <=sp1_row;
			when sp1_row =>		----- INICIO código $20 ESCRIBE EL CARACTER " " (1)
				RS <='1'; RW<='0';
				DB <="0010";
				nx_status <= sp1_col;
			when sp1_col =>
				RS <='1'; RW<='0';
				DB <="0000";		----- FIN código $20 ESCRIBE EL CARACTER " " (1)
				nx_status <= sp2_row;
			when sp2_row =>		----- INICIO código $20 ESCRIBE EL CARACTER " " (2)
				RS <='1'; RW<='0';
				DB <="0010";
				nx_status <= sp2_col;
			when sp2_col =>
				RS <='1'; RW<='0';
				DB <="0000";		----- FIN código $20 ESCRIBE EL CARACTER " " (2)
				nx_status <= sp3_row;
			when sp3_row =>		----- INICIO código $20 ESCRIBE EL CARACTER " " (3)
				RS <='1'; RW<='0';
				DB <="0010";
				nx_status <= sp3_col;
			when sp3_col =>
				RS <='1'; RW<='0';
				DB <="0000";		----- FIN código $20 ESCRIBE EL CARACTER " " (3)
				nx_status <= sp4_row;
			when sp4_row =>		----- INICIO código $20 ESCRIBE EL CARACTER " " (4)
				RS <='1'; RW<='0';
				DB <="0010";
				nx_status <= sp4_col;
			when sp4_col =>
				RS <='1'; RW<='0';
				DB <="0000";		----- FIN código $20 ESCRIBE EL CARACTER " " (4)
				nx_status <= sp5_row;
			when sp5_row =>		----- INICIO código $20 ESCRIBE EL CARACTER " " (5)
				RS <='1'; RW<='0';
				DB <="0010";
				nx_status <= sp5_col;
			when sp5_col =>
				RS <='1'; RW<='0';
				DB <="0000";		----- FIN código $20 ESCRIBE EL CARACTER " " (5)
				nx_status <= hour1_row;
			when hour1_row =>		----- INICIO código $XX PRIMER DIGITO HORA
				RS <='1'; RW<='0';
				DB <= selHr1_row;
				nx_status <= hour1_col;
			when hour1_col =>
				RS <='1'; RW<='0';
				DB <= selHr1_col;		----- FIN código $XX PRIMER DIGITO HORA
				nx_status <= hour2_row;
			when hour2_row =>		----- INICIO código $XX SEGUNDO DIGITO HORA
				RS <='1'; RW<='0';
				DB <= selHr2_row;
				nx_status <= hour2_col;
			when hour2_col =>
				RS <='1'; RW<='0';
				DB <= selHr2_col;		----- FIN código $XX SEGUNDO DIGITO HORA
				nx_status <= colon1_row;
			when colon1_row =>		----- INICIO código $3A ESCRIBE EL CARACTER ":"
				RS <='1'; RW<='0';
				DB <="0011";
				nx_status <= colon1_col;
			when colon1_col =>
				RS <='1'; RW<='0';
				DB <="1010";		----- FIN código $3A ESCRIBE EL CARACTER ":"
				nx_status <= min1_row;
			when min1_row =>		----- INICIO código $XX PRIMER DIGITO MINUTO
				RS <='1'; RW<='0';
				DB <= selMn1_row;
				nx_status <= min1_col;
			when min1_col =>
				RS <='1'; RW<='0';
				DB <= selMn1_col;		----- FIN código $XX PRIMER DIGITO MINUTO
				nx_status <= min2_row;
			when min2_row =>		----- INICIO código $XX SEGUNDO DIGITO MINUTO
				RS <='1'; RW<='0';
				DB <= selMn2_row;
				nx_status <= min2_col;
			when min2_col =>
				RS <='1'; RW<='0';
				DB <= selMn2_col;		----- FIN código $XX SEGUNDO DIGITO MINUTO
				nx_status <= LCDL2_row;
			when LCDL2_row =>      ----- INICIO código $C0 COMIENZA LINEA 2
				RS <='0'; RW<='0';
				DB <="1100";
				nx_status <= LCDL2_col;
			when LCDL2_col =>
				RS <='0'; RW<='0';
				DB <="0000";       ----- FIN código $C0 COMIENZA LINEA 2
				nx_status <= f1_row;
			when f1_row =>		----- INICIO código $46 ESCRIBE EL CARACTER "F"
				RS <='1'; RW<='0';
				DB <="0100";
				nx_status <= f1_col;
			when f1_col =>
				RS <='1'; RW<='0';
				DB <="0110";		----- FIN código $46 ESCRIBE EL CARACTER "F"
				nx_status <= u1_row;
			when u1_row =>		----- INICIO código $75 ESCRIBE EL CARACTER "u"
				RS <='1'; RW<='0';
				DB <="0111";
				nx_status <= u1_col;
			when u1_col =>
				RS <='1'; RW<='0';
				DB <="0101";		----- FIN código $75 ESCRIBE EL CARACTER "u"
				nx_status <= n1_row;
			when n1_row =>		----- INICIO código $6E ESCRIBE EL CARACTER "n"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= n1_col;
			when n1_col =>
				RS <='1'; RW<='0';
				DB <="1110";		----- FIN código $6E ESCRIBE EL CARACTER "n"
				nx_status <= c1_row;
			when c1_row =>		----- INICIO código $63 ESCRIBE EL CARACTER "c"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= c1_col;
			when c1_col =>
				RS <='1'; RW<='0';
				DB <="0011";		----- FIN código $63 ESCRIBE EL CARACTER "c"
				nx_status <= i1_row;
			when i1_row =>		----- INICIO código $69 ESCRIBE EL CARACTER "i"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= i1_col;
			when i1_col =>
				RS <='1'; RW<='0';
				DB <="1001";		----- FIN código $69 ESCRIBE EL CARACTER "i"
				nx_status <= o1_row;
			when o1_row =>		----- INICIO código $6F ESCRIBE EL CARACTER "o"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= o1_col;
			when o1_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $6F ESCRIBE EL CARACTER "o"
				nx_status <= n2_row;
			when n2_row =>		----- INICIO código $6E ESCRIBE EL CARACTER "n"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= n2_col;
			when n2_col =>
				RS <='1'; RW<='0';
				DB <="1110";		----- FIN código $6E ESCRIBE EL CARACTER "n"
				nx_status <= colon2_row;
			when colon2_row =>		----- INICIO código $3A ESCRIBE EL CARACTER ":"
				RS <='1'; RW<='0';
				DB <="0011";
				nx_status <= colon2_col;
			when colon2_col =>
				RS <='1'; RW<='0';
				DB <="1010";		----- FIN código $3A ESCRIBE EL CARACTER ":"
				nx_status <=sp6_row;
			when sp6_row =>		----- INICIO código $20 ESCRIBE EL CARACTER " " (6)
				RS <='1'; RW<='0';
				DB <="0010";
				nx_status <= sp6_col;
			when sp6_col =>
				RS <='1'; RW<='0';
				DB <="0000";		----- FIN código $20 ESCRIBE EL CARACTER " " (6)
				if (tmpLights = '1') then
					nx_status <= l1_row;
				elsif (tmpAlarm = '1') then
					nx_status <= a1_row;
				elsif (tmpMusic = '1') then
					nx_status <= m2_row;
				else
					nx_status <= bar1_row;
				end if;
			
			-- Luces
			when l1_row =>		----- INICIO código $4C ESCRIBE EL CARACTER "L"
				RS <='1'; RW<='0';
				DB <="0100";
				nx_status <= l1_col;
			when l1_col =>
				RS <='1'; RW<='0';
				DB <="1100";		----- FIN código $4C ESCRIBE EL CARACTER "L"
				nx_status <= u2_row;
			when u2_row =>		----- INICIO código $75 ESCRIBE EL CARACTER "u"
				RS <='1'; RW<='0';
				DB <="0111";
				nx_status <= u2_col;
			when u2_col =>
				RS <='1'; RW<='0';
				DB <="0101";		----- FIN código $75 ESCRIBE EL CARACTER "u"
				nx_status <= c2_row;
			when c2_row =>		----- INICIO código $63 ESCRIBE EL CARACTER "c"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= c2_col;
			when c2_col =>
				RS <='1'; RW<='0';
				DB <="0011";		----- FIN código $63 ESCRIBE EL CARACTER "c"
				nx_status <= e1_row;
			when e1_row =>		----- INICIO código $65 ESCRIBE EL CARACTER "e"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= e1_col;
			when e1_col =>
				RS <='1'; RW<='0';
				DB <="0101";		----- FIN código $65 ESCRIBE EL CARACTER "e"
				nx_status <= s1_row;
			when s1_row =>		----- INICIO código $73 ESCRIBE EL CARACTER "s"
				RS <='1'; RW<='0';
				DB <="0111";
				nx_status <= s1_col;
			when s1_col =>
				RS <='1'; RW<='0';
				DB <="0011";		----- FIN código $73 ESCRIBE EL CARACTER "s"
				nx_status <= r1;

			-- Alarma
			when a1_row =>		----- INICIO código $41 ESCRIBE EL CARACTER "A"
				RS <='1'; RW<='0';
				DB <="0100";
				nx_status <= a1_col;
			when a1_col =>
				RS <='1'; RW<='0';
				DB <="0001";		----- FIN código $41 ESCRIBE EL CARACTER "A"
				nx_status <= l2_row;
			when l2_row =>		----- INICIO código $6C ESCRIBE EL CARACTER "l"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= l2_col;
			when l2_col =>
				RS <='1'; RW<='0';
				DB <="1100";		----- FIN código $6C ESCRIBE EL CARACTER "l"
				nx_status <= a2_row;
			when a2_row =>		----- INICIO código $61 ESCRIBE EL CARACTER "a"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= a2_col;
			when a2_col =>
				RS <='1'; RW<='0';
				DB <="0001";		----- FIN código $61 ESCRIBE EL CARACTER "a"
				nx_status <= r1_row;
			when r1_row =>		----- INICIO código $72 ESCRIBE EL CARACTER "r"
				RS <='1'; RW<='0';
				DB <="0111";
				nx_status <= r1_col;
			when r1_col =>
				RS <='1'; RW<='0';
				DB <="0010";		----- FIN código $72 ESCRIBE EL CARACTER "r"
				nx_status <= m1_row;
			when m1_row =>		----- INICIO código $6D ESCRIBE EL CARACTER "m"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= m1_col;
			when m1_col =>
				RS <='1'; RW<='0';
				DB <="1101";		----- FIN código $6D ESCRIBE EL CARACTER "m"
				nx_status <= a3_row;
			when a3_row =>		----- INICIO código $61 ESCRIBE EL CARACTER "a"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= a3_col;
			when a3_col =>
				RS <='1'; RW<='0';
				DB <="0001";		----- FIN código $61 ESCRIBE EL CARACTER "a"
				nx_status <= r1;

			-- Musica
			when m2_row =>		----- INICIO código $4D ESCRIBE EL CARACTER "M"
				RS <='1'; RW<='0';
				DB <="0100";
				nx_status <= m2_col;
			when m2_col =>
				RS <='1'; RW<='0';
				DB <="1101";		----- FIN código $4D ESCRIBE EL CARACTER "M"
				nx_status <= u3_row;
			when u3_row =>		----- INICIO código $75 ESCRIBE EL CARACTER "u"
				RS <='1'; RW<='0';
				DB <="0111";
				nx_status <= u3_col;
			when u3_col =>
				RS <='1'; RW<='0';
				DB <="0101";		----- FIN código $75 ESCRIBE EL CARACTER "u"
				nx_status <= s2_row;
			when s2_row =>		----- INICIO código $73 ESCRIBE EL CARACTER "s"
				RS <='1'; RW<='0';
				DB <="0111";
				nx_status <= s2_col;
			when s2_col =>
				RS <='1'; RW<='0';
				DB <="0011";		----- FIN código $73 ESCRIBE EL CARACTER "s"
				nx_status <= i2_row;
			when i2_row =>		----- INICIO código $69 ESCRIBE EL CARACTER "i"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= i2_col;
			when i2_col =>
				RS <='1'; RW<='0';
				DB <="1001";		----- FIN código $69 ESCRIBE EL CARACTER "i"
				nx_status <= c3_row;
			when c3_row =>		----- INICIO código $63 ESCRIBE EL CARACTER "c"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= c3_col;
			when c3_col =>
				RS <='1'; RW<='0';
				DB <="0011";		----- FIN código $63 ESCRIBE EL CARACTER "c"
				nx_status <= a4_row;
			when a4_row =>		----- INICIO código $61 ESCRIBE EL CARACTER "a"
				RS <='1'; RW<='0';
				DB <="0110";
				nx_status <= a4_col;
			when a4_col =>
				RS <='1'; RW<='0';
				DB <="0001";		----- FIN código $61 ESCRIBE EL CARACTER "a"
				nx_status <= r1;

			-- None
			when bar1_row =>		----- INICIO código $5F ESCRIBE EL CARACTER "_" (1)
				RS <='1'; RW<='0';
				DB <="0101";
				nx_status <= bar1_col;
			when bar1_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $5F ESCRIBE EL CARACTER "_" (1)
				nx_status <= bar2_row;
			when bar2_row =>		----- INICIO código $5F ESCRIBE EL CARACTER "_" (2)
				RS <='1'; RW<='0';
				DB <="0101";
				nx_status <= bar2_col;
			when bar2_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $5F ESCRIBE EL CARACTER "_" (2)
				nx_status <= bar3_row;
			when bar3_row =>		----- INICIO código $5F ESCRIBE EL CARACTER "_" (3)
				RS <='1'; RW<='0';
				DB <="0101";
				nx_status <= bar3_col;
			when bar3_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $5F ESCRIBE EL CARACTER "_" (3)
				nx_status <= bar4_row;
			when bar4_row =>		----- INICIO código $5F ESCRIBE EL CARACTER "_" (4)
				RS <='1'; RW<='0';
				DB <="0101";
				nx_status <= bar4_col;
			when bar4_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $5F ESCRIBE EL CARACTER "_" (4)
				nx_status <= bar5_row;
			when bar5_row =>		----- INICIO código $5F ESCRIBE EL CARACTER "_" (5)
				RS <='1'; RW<='0';
				DB <="0101";
				nx_status <= bar5_col;
			when bar5_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $5F ESCRIBE EL CARACTER "_" (5)
				nx_status <= bar6_row;
			when bar6_row =>		----- INICIO código $5F ESCRIBE EL CARACTER "_" (6)
				RS <='1'; RW<='0';
				DB <="0101";
				nx_status <= bar6_col;
			when bar6_col =>
				RS <='1'; RW<='0';
				DB <="1111";		----- FIN código $5F ESCRIBE EL CARACTER "_" (6)
				nx_status <= r1;

			when r1 =>
				RS <='0'; RW<='0';
				DB <="1000";
				nx_status <= r2;
			when r2 =>
				RS <='0'; RW<='0';
				DB <="0000";      
				nx_status <= sp1_row;
		end case;
	end process COMB_machine;

end Behavioral;
