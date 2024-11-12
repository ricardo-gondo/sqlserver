/*
Migracao - Converter csv (separado por ;) em xml para registro
*/
SELECT  
 xmlcol.value('/DADO[02]','VARCHAR(MAX)')   USU_CODIGO
,xmlcol.value('/DADO[04]','VARCHAR(MAX)')   USU_DT_INICIO
,xmlcol.value('/DADO[05]','VARCHAR(MAX)')   USU_DT_FIM
,xmlcol.value('/DADO[06]','VARCHAR(MAX)')   USU_EMAIL
,xmlcol.value('/DADO[09]','VARCHAR(MAX)')   LOG_CODIGO
,xmlcol.value('/DADO[10]','VARCHAR(MAX)')   LOG_DATA
FROM
	(
		SELECT 
			LINHA
			,DADOS
			,CAST('<DADO>' +REPLACE(DADOS,';','</DADO><DADO>')+'</DADO>' AS XML) AS xmlcol
		INTO TABELA_MIGRACAO	
	  FROM TABELA_CSV 
	) AS TABE
/*
--origem (;)
DADOS
0000;123456;1;2024-03-20 00:00:00.000;4000-01-01 00:00:00.000;MARIA@HOTMAIL.COM;3;2024-03-26 13:49:57.000;ADMINISTRADOR;GRUPO
0000;123457;1;2024-03-21 00:00:00.000;4000-01-01 00:00:00.000;JOAO@GMAIL.COM;3;2024-03-26 14:26:22.000;ADMINISTRADOR;GRUPO

--destino (xml)
<DADO>0000</DADO><DADO>123456</DADO><DADO>1</DADO><DADO>2024-03-20 00:00:00.000</DADO><DADO>4000-01-01 00:00:00.000</DADO><DADO>MARIA@HOTMAIL.COM</DADO><DADO>3</DADO><DADO>2024-03-26 13:49:57.000</DADO><DADO>ADMINISTRADOR</DADO><DADO>GRUPO</DADO>
<DADO>0000</DADO><DADO>123457</DADO><DADO>1</DADO><DADO>2024-03-21 00:00:00.000</DADO><DADO>4000-01-01 00:00:00.000</DADO><DADO>JOAO@GMAIL.COM</DADO><DADO>3</DADO><DADO>2024-03-26 14:26:22.000</DADO><DADO>ADMINISTRADOR</DADO><DADO>GRUPO</DADO>

--formatado (convertido para )
USU_CODIGO	USU_DT_INICIO	USU_DT_FIM	USU_EMAIL	LOG_CODIGO	LOG_DATA
123456	2024-03-20 00:00:00.000	4000-01-01 00:00:00.000	MARIA@HOTMAIL.COM	ADMINISTRADOR	2024-03-26 13:49:57.000
123457	2024-03-21 00:00:00.000	4000-01-01 00:00:00.000	JOAO@GMAIL.COM	ADMINISTRADOR	2024-03-26 14:26:22.000
*/
