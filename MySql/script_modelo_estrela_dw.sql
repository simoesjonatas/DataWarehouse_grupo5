CREATE TABLE `TBGenero` (
  `id_genero` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `ds_conteudo` varchar(100),
  `ds_descricao` varchar(500)
);

CREATE TABLE `TBMunicipio` (
  `id_municipio` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `ds_nome_municipio` varchar(100) UNIQUE,
  `ds_descricao` varchar(500)
);

CREATE TABLE `TBComorbidade` (
  `id_comorbidade` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `b_asma` boolean,
  `b_diabetes` boolean,
  `b_cardiopatia` boolean,
  `b_doenca_hematologica` boolean,
  `b_doenca_hepatica` boolean,
  `b_doenca_neurologica` boolean,
  `b_doenca_renal` boolean,
  `b_imunodepressao` boolean,
  `b_obesidade` boolean,
  `b_pneumopatia` boolean,
  `b_puerpera` boolean,
  `b_sindrome_down` boolean,
  `b_outros` boolean
);

CREATE TABLE `TBPesquisa` (
  `id_pesquisa` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `fk_sq_genero` int,
  `fk_sq_municipio` int,
  `fk_sq_comorbidade` int,
  `b_diagnostico_covid` boolean,
  `dt_inicio` datetime,
  `nr_idade` int NOT NULL,
  `b_obito` boolean NOT NULL
);

ALTER TABLE `TBPesquisa` ADD FOREIGN KEY (`fk_sq_genero`) REFERENCES `TBGenero` (`id_genero`);

ALTER TABLE `TBPesquisa` ADD FOREIGN KEY (`fk_sq_municipio`) REFERENCES `TBMunicipio` (`id_municipio`);

ALTER TABLE `TBPesquisa` ADD FOREIGN KEY (`fk_sq_comorbidade`) REFERENCES `TBComorbidade` (`id_comorbidade`);
