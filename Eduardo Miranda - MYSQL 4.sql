-- Criar base de dados
CREATE DATABASE CarrosBD;
USE CarrosBD;

-- Criar tabelas
CREATE TABLE carros (
    id INT(10) NOT NULL AUTO_INCREMENT,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    ano INT,
    valor DECIMAL(10,2),
    cor VARCHAR(100),
    numero_vendas INT(10),
    PRIMARY KEY (id)
);

CREATE TABLE proprietario (
    id INT(10) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    id_carro INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_carro) REFERENCES carros(id)
);

CREATE TABLE historico_preco (
    id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_modificacao DATETIME,
    id_carro INT NOT NULL,
    valor_anterior FLOAT,
    valor_novo FLOAT,
    FOREIGN KEY (id_carro) REFERENCES carros(id)
);

CREATE TABLE funcionarios (
nome VARCHAR (100),
RG INT, 
salario INT,
email VARCHAR (100)
);

-- Selecionar todos os carros
SELECT * FROM carros;

-- Inserir registros na tabela carros
INSERT INTO carros (marca, modelo, ano, valor, cor, numero_vendas) VALUES
    ('Fiat', 'Marea', 1999, 15450.00, 'Vermelho', 50000),
    ('Fiat', 'Uno', 1985, 12500.00, 'Verde', 100000),
    ('Ford', 'Escort', 1978, 13240.00, 'Azul', 500000),
    ('Chevrolet', 'Chevette', 1980, 14650.00, 'Preto', 6500000),
    ('Fiat', 'Palio', 2014, 37650.00, 'Preto', 620000),
    ('Chevrolet', 'Meriva', 2009, 35650.00, 'Prata', 240000),
    ('Ford', 'EcoSport', 2020, 75000.00, 'Preto', 490000),
    ('Fiat', 'Mobi', 2022, 70000.00, 'Vermelho', 480000),
    ('Renault', 'Kwid', 2023, 72000.00, 'Verde', 350000),
    ('Toyota', 'Etios', 2021, 69000.00, 'Prata', 480000),
    ('Fiat', 'Mobi', 2024, 80000.00, 'Preto', 5000);

-- Inserir registros na tabela proprietario
INSERT INTO proprietario (nome, id_carro) VALUES
    ('Jessica', 1),
    ('Carol', 3),
    ('Caique', 1);

-- Inserir dados dos funcionarios
-- Inserir funcionários
INSERT INTO funcionarios (nome, salario) VALUES
    ('Rainel', 3000),
    ('Luciana', 3000),
    ('Elian', 3000);

-- Exercício 1: Procedimento para listar funcionários
DELIMITER $$
CREATE PROCEDURE lista_funcionarios()
BEGIN
    SELECT nome FROM funcionarios;
END $$

DELIMITER ;
CALL lista_funcionarios();

-- Exercício 2: Função para calcular salário anual
DELIMITER $$

CREATE FUNCTION salario_anual(salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE sal_anual DECIMAL(10,2);

    SET sal_anual = salario * 13;
    
    RETURN sal_anual;
END $$

DELIMITER ;

-- Exercício 3 
DELIMITER $$

CREATE PROCEDURE inserir_funcionario(
    IN p_nome VARCHAR(100),
    IN p_salario DECIMAL(10,2)
)
BEGIN
    INSERT INTO funcionarios (nome, salario)
    VALUES (p_nome, p_salario);
END $$

DELIMITER ;
CALL inserir_funcionario('Giovana', 3000)

-- Exercício 4

CREATE VIEW view_funcionarios_salarios AS
SELECT nome, salario
FROM funcionarios;

SELECT * FROM view_funcionarios_salarios;



-- Atualizar valores de carros da marca Chevrolet
-- UPDATE carros SET valor = 170000 WHERE marca = 'Chevrolet';
