-- Inserindo os dados

INSERT INTO tabela_aux
    (
     obesidade, obito, idade, data_inicio, dig_covid, outros
     , sindrome_down, puerpera, pneumopatia, imunodepressao
     , doenca_renal, doenca_neurologica, doenca_hepatica
     , doenca_hematologica, cardiopatia, diabetes, asma
     , municipio, genero
    )
    select obesidade
    , obito
    , idade
    , data_inicio
    , dig_covid
    , outros
    , sindrome_down
    , puerpera
    , pneumopatia
    , imunodepressao
    , doenca_renal
    , doenca_neurologica
    , doenca_hepatica
    , doenca_hematologica
    , cardiopatia
    , diabetes
    , asma
    , municipio
    , genero 
    FROM tabela_aux2 ;

INSERT INTO TBGenero(ds_conteudo)
SELECT
    DISTINCT genero
FROM tabela_aux
    WHERE genero is not null;

INSERT INTO TBMunicipio(ds_nome_municipio)
SELECT
    DISTINCT municipio
FROM tabela_aux
    WHERE municipio is not null;

-- Tirando a tabela auxiliar 2
drop table tabela_aux2;

-- Inserindo dados nas tabelas

INSERT INTO TBComorbidade (b_asma,
                           b_diabetes
                           , b_cardiopatia
                           , b_doenca_hematologica
                           , b_doenca_hepatica
                           , b_doenca_neurologica
                           , b_doenca_renal
                           , b_imunodepressao
                           , b_obesidade
                           , b_pneumopatia
                           , b_puerpera
                           , b_sindrome_down
                           , b_outros)
SELECT
       DW_EXTRACT_TXT(asma)
     , DW_EXTRACT_TXT(diabetes)
     , DW_EXTRACT_TXT(cardiopatia)
     , DW_EXTRACT_TXT(doenca_hematologica)
     , DW_EXTRACT_TXT(doenca_hepatica)
     , DW_EXTRACT_TXT(doenca_neurologica)
     , DW_EXTRACT_TXT(doenca_renal)
     , DW_EXTRACT_TXT(imunodepressao)
     , DW_EXTRACT_TXT(obesidade)
     , DW_EXTRACT_TXT(pneumopatia)
     , DW_EXTRACT_TXT(puerpera)
     , DW_EXTRACT_TXT(sindrome_down)
     , DW_EXTRACT_TXT(outros)
FROM tabela_aux;

-- Tirando a tabela auxiliar

DROP TRIGGER IF EXISTS TBComorbidade_TR_ON_INSERT;

DROP TABLE tabela_aux;