
-- CRIANDO O DATABASE
CREATE DATABASE IF NOT EXISTS dw_pesquisa;
USE dw_pesquisa;

create table if not exists TBComorbidade
(
	b_outros tinyint(1) null,
	b_sindrome_down tinyint(1) null,
	b_puerpera tinyint(1) null,
	b_pneumopatia tinyint(1) null,
	b_obesidade tinyint(1) null,
	b_imunodepressao tinyint(1) null,
	b_doenca_renal tinyint(1) null,
	b_doenca_neurologica tinyint(1) null,
	b_doenca_hepatica tinyint(1) null,
	b_doenca_hematologica tinyint(1) null,
	b_cardiopatia tinyint(1) null,
	b_diabetes tinyint(1) null,
	b_asma tinyint(1) null,
	id_comorbidade int auto_increment,
	constraint TBComorbidade_id_comorbidade_uindex
		unique (id_comorbidade)
);

alter table TBComorbidade
	add primary key (id_comorbidade);

create table if not exists TBGenero
(
	ds_descricao varchar(500) null,
	ds_conteudo varchar(100) not null,
	id_genero int auto_increment,
	constraint TBGenero_ds_conteudo_uindex
		unique (ds_conteudo),
	constraint TBGenero_id_genero_uindex
		unique (id_genero)
);

alter table TBGenero
	add primary key (id_genero);

create table if not exists TBMunicipio
(
	ds_descricao varchar(500) null,
	ds_nome_municipio varchar(100) not null,
	id_municipio int auto_increment,
	constraint TBMunicipio_id_municipio_uindex
		unique (id_municipio)
);

alter table TBMunicipio
	add primary key (id_municipio);

create table if not exists TBPesquisa
(
	b_obito tinyint(1) null,
	nr_idade int null,
	dt_inicio date null,
	b_diagnostico_covid tinyint(1) null,
	fk_sq_comorbidade int null,
	fk_sq_municipio int null,
	fk_sq_genero int null,
	id_pesquisa int auto_increment,
	constraint TBPesquisa_id_pesquisa_uindex
		unique (id_pesquisa),
	constraint TBPesquisa_TBComorbidade_id_comorbidade_fk
		foreign key (fk_sq_comorbidade) references TBComorbidade (id_comorbidade),
	constraint TBPesquisa_TBGenero_id_genero_fk
		foreign key (fk_sq_genero) references TBGenero (id_genero),
	constraint TBPesquisa_TBMunicipio_id_municipio_fk
		foreign key (fk_sq_municipio) references TBMunicipio (id_municipio)
);

alter table TBPesquisa
	add primary key (id_pesquisa);

create table if not exists tabela_aux
(
	genero varchar(100) null,
	municipio varchar(100) null,
	asma varchar(100) null,
	diabetes varchar(100) null,
	cardiopatia varchar(100) null,
	doenca_hematologica varchar(100) null,
	doenca_hepatica varchar(100) null,
	doenca_neurologica varchar(100) null,
	doenca_renal varchar(100) null,
	imunodepressao varchar(100) null,
	obesidade varchar(100) null,
	pneumopatia varchar(100) null,
	puerpera varchar(100) null,
	sindrome_down varchar(100) null,
	outros varchar(100) null,
	dig_covid varchar(100) null,
	data_inicio varchar(100) null,
	idade int null,
	obito tinyint(1) null,
	id_aux int auto_increment
		primary key
);

create table if not exists tabela_aux2
(
    genero varchar(100) null,
	municipio varchar(100) null,
	asma varchar(100) null,
	diabetes varchar(100) null,
	cardiopatia varchar(100) null,
	doenca_hematologica varchar(100) null,
	doenca_hepatica varchar(100) null,
	doenca_neurologica varchar(100) null,
	doenca_renal varchar(100) null,
	imunodepressao varchar(100) null,
	obesidade varchar(100) null,
	pneumopatia varchar(100) null,
	puerpera varchar(100) null,
	sindrome_down varchar(100) null,
	outros varchar(100) null,
	dig_covid varchar(100) null,
	data_inicio varchar(100) null,
	idade varchar(100) null,
	obito varchar(100) null
);

-- Criando função

create  function DW_EXTRACT_CONFIRMADO(objeto varchar(100)) returns text
BEGIN
        IF objeto in ('CONFIRMADO') THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
END;

-- Criando função

create  function DW_EXTRACT_TXT(objeto varchar(100)) returns text
BEGIN
        #DECLARE info varchar(1000);
        IF objeto IN (NULL,'NULL','null','IGNORADO') THEN
                RETURN NULL;
        ELSEIF objeto in ('SIM') THEN
            RETURN 1;
        ELSEIF objeto in ('NÃO','nao','Não','Nao') THEN
            RETURN 0;
        ELSE
                RETURN NULL;
        END IF;
END;

-- Criando a trigger

create  trigger TBComorbidade_TR_ON_INSERT
	after insert
	on TBComorbidade
	for each row
	BEGIN

    INSERT INTO TBPesquisa(FK_SQ_GENERO, FK_SQ_MUNICIPIO, FK_SQ_COMORBIDADE, B_DIAGNOSTICO_COVID, DT_INICIO, NR_IDADE, B_OBITO)
    SELECT (SELECT id_genero FROM TBGenero WHERE ds_conteudo = genero),
           (SELECT id_municipio FROM TBMunicipio WHERE ds_nome_municipio = municipio ),
           NEW.id_comorbidade,
           DW_EXTRACT_CONFIRMADO(dig_covid),
           str_to_date(data_inicio, "%d/%m/%Y"),
           idade,
           obito
    FROM tabela_aux WHERE id_aux = NEW.id_comorbidade;

END;

