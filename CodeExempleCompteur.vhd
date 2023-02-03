signal clk_xHz: std_logic;

signal compteur_indice : integer range 0 to xxx; 

-- partie compteur présent 
	CMPT_ETAT_PRESENT : process(CLK_1_8MHZ)
		begin 
			-- MAJ de tous les compteur -- 
			if ((CLK_1_8MHZ'event) and (CLK_1_8MHZ = '1')) then 
				cpt_p_xHZ <= cpt_f_xHZ;
			end if; 
	end process; 


-- partie compteur futur 
CMPT_ETAT_FUTUR_xHZ : process(cpt_p_xHZ)
	begin 
		if (cpt_p_xHZ >= VAL_MAX_COMPTEUR_1HZ) then
			cpt_f_xHZ <= (others => '0');				-- remise à 0 
		else 
			cpt_f_xHZ <= cpt_p_xHZ + 1;  				-- incrémentation 
		end if; 
end process; 

-- partie génération siganl clock 
	CLK_1HZ_50P : process (CLK_1_8MHZ)
		begin 
			-- synchronisation sur la clock pour éviter des effets -- 
			if rising_edge(CLK_1_8MHZ) then 
				if (cpt_p_xHZ <= VAL_MAX_COMPTEUR_xHZ_DIV2) then 
					clk_xHz <= '0'; 
				else 
					clk_xHz <= '1';
				end if; 
			end if; 
	end process; 
