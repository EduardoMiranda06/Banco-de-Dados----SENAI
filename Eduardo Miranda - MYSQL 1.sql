create database escola1;
Use escola1;

create table CURSO (
CODCURSO char(3) PRIMARY KEY not null,
NOME char(30),
MENSALIDADE decimal(10,2)
);

create table ALUNO (
RA char (9) not null PRIMARY KEY,
RG char (9)not null,
NOME char(30),
CODCURSO char (3),
FOREIGN KEY (CODCURSO) REFERENCES CURSO (CODCURSO)
);

create table DISCIPLINA (
CodDisc char(5) not null,
NOME char(100),
CODCURSO char(3),
NroCreditos int,
PRIMARY KEY (CodDisc),
FOREIGN KEY (CODCURSO) REFERENCES CURSO (CODCURSO)
);

create table BOLETIM (
RA char (9) not null,
CodDisc CHAR (5) not null ,
NOTA DECIMAL (10,2),
PRIMARY KEY ( RA, CodDisc),
foreign key (RA) REFERENCES aluno(RA),
foreign key (CodDisc) REFERENCES disciplina(CodDisc)
);

insert into CURSO VALUES (
'AS', 'Analise de sistemas',1000
);
insert into CURSO VALUES (
'CC','Ciencia da Computaçao',950
);
insert into CURSO VALUES (
'SI','Sistemas de Informação',800
);

INSERT INTO ALUNO VALUES
('123', '12345', 'BIANCA MARIA PEDROSA', 'AS'),
('212', '21234', 'TATIANE CITTON', 'AS'),
('221', '22145', 'ALEXANDRE PEDROSA', 'CC'),
('231', '23144', 'ALEXANDRE MONTEIRO', 'CC'),
('321', '32111', 'MARCIA RIBEIRO', 'CC'),
('661', '66123', 'JUSSARA MARANDOLA', 'SI'),
('765', '76512', 'WALTER RODRIGUES', 'SI');

INSERT INTO DISCIPLINA values
('BD','BANCO DE DADOS','CC',4);
INSERT INTO DISCIPLINA values
('BDA','BANCO DE DADOS AVANÇADOS','CC',6);
INSERT INTO DISCIPLINA values
('BDOO','BANCO DE DADOS O OBJETOS','SI',4);
INSERT INTO DISCIPLINA values
('BDS','SISTEMAS DE BANCO DE DADOS','AS',4);
INSERT INTO DISCIPLINA values
('DBD','DESENVOLVIMENTO DE BANCO DE DADOS','SI',6);
INSERT INTO DISCIPLINA values
('IBD','INTRODUÇÃO A BANCO DE DADOS','AS',2);

INSERT INTO BOLETIM values
('123','BDS',10);
INSERT INTO BOLETIM values
('212','IBD',7.5);
INSERT INTO BOLETIM values
('231','BD',9);
INSERT INTO BOLETIM values
('231','BDA',9.6);
INSERT INTO BOLETIM values
('661','DBD',8);
INSERT INTO BOLETIM values
('765','DBD',6);
DESCRIBE DISCIPLINA;
DESCRIBE BOLETIM;


