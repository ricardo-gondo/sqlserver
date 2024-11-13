/*
Importar xml para tabela
*/
-- raiz
DECLARE @XML XML = 
'
<raiz xmlns:h="http://www.raiz.gov.br/schema/evt/estado/v_S_01_00_00">
  <estado codEstado="PR" desEstado="PARANA">
    <cidade>
      <codCidade>001</codCidade>
      <desCidade>CURITIBA</desCidade>
    </cidade>
    <cidade>
      <codCidade>002</codCidade>
      <desCidade>CORNELIO</desCidade>
    </cidade> 
  </estado>
  <estado codEstado="SP" desEstado="SAO PAULO">
    <cidade codCidade="001" desCidade="LINS">
    </cidade>
  </estado>
</raiz>
'
SELECT
    estado.campo.value('@codEstado','varchar(100)') AS codEstado
    ,estado.campo.value('@desEstado','varchar(100)') AS desEstado
    --
    ,cidade.campo.value('(codCidade/text())[1]', 'CHAR(20)' ) AS codCidade
    ,cidade.campo.value('(desCidade/text())[1]', 'CHAR(20)' ) AS desCidade    
    --
    ,cidade.campo.value('@codCidade','varchar(100)') AS codCidade
    ,cidade.campo.value('@desCidade','varchar(100)') AS desCidade
--INTO TABELA_XML2DBF
FROM
    -- estado
    @XML.nodes('/raiz/estado') AS estado(campo)	
    -- cidade
    CROSS APPLY estado.campo.nodes('cidade') AS cidade(campo)
		