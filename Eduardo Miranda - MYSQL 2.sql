-- CRIAR BASE DE DADOS
CREATE DATABASE CarrosBD;

-- ACESSAR A BASE DE DADOS QUE SERÁ USADA
USE CarrosBD;

-- DELETAR A BASE DE DADOS 
DROP DATABASE CarrosBD;

-- CRIAR TABELAS
CREATE TABLE carros (
    id INT(10) NOT NULL,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    ano INT,
    valor DECIMAL(10,2),
    cor VARCHAR(100),
    numero_vendas INT(10),
    PRIMARY KEY (id)
);

CREATE TABLE proprietario (
    id INT(10) NOT NULL,
    nome VARCHAR(100),
    id_carro INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_carro) REFERENCES carros(id) -- Referenciando a tabela correta (carros)
);

CREATE TABLE historico_preco (
    id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_modificacao DATETIME,
    id_carro INT NOT NULL,
    valor_anterior FLOAT,
    valor_novo FLOAT,
    FOREIGN KEY (id_carro) REFERENCES carros(id) -- Adicionando a relação com a tabela carros
);

-- ALTERAÇÕES NA TABELA PROPRIETARIO
ALTER TABLE proprietario ADD idade INT(3) NOT NULL;
ALTER TABLE proprietario DROP COLUMN idade;

-- CONSULTA DADOS DA TABELA CARROS
-SELECT * FROM carros;marca

--------------------------------

---------------------------------

--------------------------------


-- INSERINDO DADOS NA TABELA "carros"
INSERT INTO carros VALUES 
(1, 'Fiat', 'Marea', 1999, 15450.00, 'Vermelho', 50000),
(2, 'Fiat', 'Uno', 1985, 12500.00, 'Verde', 100000),
(3, 'Ford', 'Escort', 1978, 13240.00, 'Azul', 500000),
(4, 'Chevrolet', 'Chevette', 1980, 14650.00, 'Preto', 6500000),
(6, 'Chevrolet', 'Meriva', 2009, 35650.00, 'Prata', 240000),
(5,'Fiat','Palip','2014','37650.00','Preto','620000'),
(7, 'Ford', 'EcoSport', 2020, 75000.00, 'Preto', 490000),
(8, 'Fiat', 'Mobi', 2022, 70000.00, 'Vermelho', 480000),
(9, 'Renault', 'Kwid', 2023, 72000.00, 'Verde', 350000),
(10, 'Toyota', 'Etios', 2021, 69000.00, 'Prata', 480000),
(11, 'Fiat', 'Mobi', 2024, 80000.00, 'Preto', 5000);



-- INSERINDO DADOS NA TABELA "proprietario"
INSERT INTO proprietario VALUES 
(1, 'Jessica', 1),
(2, 'Carol', 3),
(3, 'Caique', 1);

-- ATUALIZANDO OS VALORES NA TABELA "carros"
UPDATE carros 
SET valor = 170000 
WHERE marca = 'Chevrolet';

---------------------------------

---------------------------------

--------------------------------

DELIMITER $$

CREATE FUNCTION calculaDesconto(valor DECIMAL(10,2), desconto DECIMAL(5,2))
-- Criação da função: A palavra-chave CREATE FUNCTION define uma nova função chamada calculaDesconto. Ela recebe dois parâmetros:
-- valor: o preço original, do tipo DECIMAL(10,2), que pode ter até 10 dígitos no total, com 2 casas decimais.
-- desconto: a porcentagem de desconto, do tipo DECIMAL(5,2), que pode ter até 5 dígitos no total, com 2 casas decimais.

RETURNS DECIMAL(10,2)
-- Tipo de retorno: Aqui especificamos que a função retorna um valor do tipo DECIMAL(10,2), ou seja, o preço com o desconto aplicado, com no máximo 10 dígitos e 2 casas decimais.

READS SQL DATA
-- Atributo da função: Indica que a função apenas lê dados, sem fazer alterações no banco de dados.
-- Isso é importante para o MySQL saber que esta função não altera os dados existentes (somente faz cálculos).

BEGIN
-- Início do corpo da função: O BEGIN define o início do corpo da função, onde a lógica da função será implementada.

    RETURN valor - (valor * desconto / 100);
-- Retorno da função: Aqui está a lógica principal da função. A função retorna o valor final após aplicar o desconto:
-- valor * desconto / 100 calcula o valor do desconto com base no percentual fornecido.
-- valor - (valor * desconto / 100) subtrai o valor do desconto do valor original, resultando no preço final com o desconto aplicado.

END$$
-- Fim da função: END finaliza o bloco da função e $$ é o delimitador que indica o fim da instrução SQL completa.

DELIMITER ;
-- Restauração do delimitador padrão: Aqui o delimitador é restaurado para o padrão (;), para que as próximas instruções SQL possam ser finalizadas corretamente.

SELECT marca, valor, calculaDesconto(valor, 20) AS preco_com_desconto
FROM carros;
-- A consulta seleciona os campos marca e valor da tabela carros.
-- Também usa a função calculaDesconto para calcular o preço com desconto de 20% (calculaDesconto(valor, 20)) para cada carro.
-- O resultado desse cálculo é retornado com o alias preco_com_desconto, mostrando o valor final após o desconto.


-- *******************************************************


-- CALCULO DE VENDAS GERAIS POR MARCA
DELIMITER $$

CREATE FUNCTION valorTotalVendasPorMarca(marca_param VARCHAR(10000))
RETURNS DECIMAL(50,2) -- Define que o retorno será do tipo DECIMAL com até 50 dígitos e 2 casas decimais.
-- -- Indica que a função vai apenas ler dados do banco, ou seja, não fará nenhuma alteração.
READS SQL DATA
BEGIN
-- -- Declara uma variável local chamada 'total', que armazenará o valor total calculado.
    DECLARE total DECIMAL(50,2);
-- Faz uma consulta na tabela 'carros', multiplicando o valor do carro pelo número de vendas
-- e somando o resultado para a marca fornecida no parâmetro 'marca_param'.
-- O resultado da soma total é armazenado na variável 'total'.
    SELECT SUM(valor * numero_Vendas) INTO total
    FROM carros
    WHERE marca = marca_param;
-- Retorna o valor armazenado em 'total', que é o total das vendas calculadas.
    RETURN total;
END$$

DELIMITER ;

-- Faz uma consulta chamando a função criada com o parâmetro 'Fiat' 
-- e exibe o total das vendas dessa marca com o alias 'total_vendas'.
SELECT valorTotalVendasPorMarca('Fiat') AS total_vendas;


-- Contar o Número de Carros por Modelo
DELIMITER $$

CREATE FUNCTION contarCarrosPorModelo(modelo_param VARCHAR(100))
RETURNS INT 
READS SQL DATA

BEGIN
    DECLARE contagem INT;  -- Declara uma variável local chamada 'contagem', que armazenará o resultado da contagem dos carros.
 -- Faz uma consulta na tabela 'carros', contando quantos registros existem onde o modelo do carro
    -- corresponde ao valor do parâmetro 'modelo_param'. O resultado é armazenado na variável 'contagem'.   
    SELECT COUNT(*) INTO contagem
    FROM carros
    WHERE modelo = modelo_param;
    
    RETURN contagem;
END$$

DELIMITER ;
-- Faz uma consulta chamando a função 'contarCarrosPorModelo' com o parâmetro 'Mobi' 
-- e exibe o resultado da contagem de carros desse modelo, com o alias 'quantidade'.
SELECT contarCarrosPorModelo('Mobi') AS quantidade;


-- Nome do proprietario 

DELIMITER $$

CREATE FUNCTION nomeProprietario(id_carro_param INT)
RETURNS VARCHAR(100)
READS SQL DATA

BEGIN
    DECLARE nome_proprietario VARCHAR(100);
-- Faz uma consulta na tabela 'proprietario', buscando o nome do proprietário que tenha o 'id'
    -- igual ao valor do parâmetro 'id_carro_param'. O nome encontrado será armazenado na variável 'nome_proprietario'.    
    SELECT nome INTO nome_proprietario
    FROM proprietario
    WHERE id = id_carro_param;
    
    RETURN nome_proprietario;
END$$

DELIMITER ;
-- Faz uma consulta chamando a função 'nomeProprietario' com o parâmetro 3 (id do carro) 
-- e exibe o nome do proprietário com o alias 'nome_proprietario'.
SELECT nomeProprietario(3) AS nome_proprietario;


---------------------------------

---------------------------------

--------------------------------

SELECT * FROM tb_proprietario AS P
INNER JOIN tb_carros AS C
ON P.id_carro = C.id;


-- RIGHT JOIN
-- todos os registros da minha segunda tabela (direita) sejam retornas, 
-- mesmo que não haja similaridade na primeira tabela (esquerda) 
-- NULL
SELECT * FROM tb_proprietario 
RIGHT JOIN tb_carros
ON tb_proprietario.id_carro = tb_carros.id;

-- LEFT JOIN
-- Vai me retornar todos os registros da primeira tabela (esquerda)
-- mais as similaridades da segunda tabela (direita)
SELECT * FROM tb_carros AS C
LEFT JOIN tb_proprietario AS P
ON C.id = P.id_carro;

-- UNION 
-- Combinação dos dois Joins (Right e Left)
SELECT * FROM tb_proprietario AS P
LEFT JOIN tb_carros AS C
ON P.id_carro = C.id
UNION
SELECT * FROM tb_proprietario AS P
RIGHT JOIN tb_carros AS C
ON C.id = P.id_carro
WHERE P.id_carro IS NULL;

SELECT * FROM tb_proprietario;
SELECT * FROM tb_carros;



---------------------------------

---------------------------------

--------------------------------




USE bd_carro;
-- ****** PROCEDURE *********
-- Procedimentos: Quando você precisa executar um bloco de código complexo que pode envolver múltiplas operações, alterações de dados, e lógica de controle.
-- Procedimek
DELIMITER $$

-- ******* Crie uma stored procedure que insira um novo carro na tabela carros, fornecendo os valores da marca, modelo, ano, valor, cor e número de vendas
DELIMITER $$

CREATE PROCEDURE InserirCarro (
	IN p_id INT,
    IN p_marca VARCHAR(100), -- parametros de entrada 
    IN p_modelo VARCHAR(100), -- IN entrada / OUT saida
    IN p_ano INT,
    IN p_valor DECIMAL(10,2),
    IN p_cor VARCHAR(100),
    IN p_numero_vendas INT
)
BEGIN
    INSERT INTO tb_carros (id, marca, modelo, ano, valor, cor, numero_vendas)
    VALUES (p_id, p_marca, p_modelo, p_ano, p_valor, p_cor, p_numero_vendas);
END $$

DELIMITER ;

CALL InserirCarro('10', 'Toyota', 'Corolla', '2021', '95000.00', 'Branco', '50');

SELECT * FROM tb_carros;


-- ********* Crie uma stored procedure que atualize o valor de um carro na tabela carros, baseado no ID do carro, e insira o histórico dessa modificação na tabela historico_preco.
DELIMITER $$

CREATE PROCEDURE AtualizarValorCarro (IN p_id_carro INT, IN p_valor_novo DECIMAL(10,2))
BEGIN
    DECLARE v_valor_atual DECIMAL(10,2);
    
    -- Obter o valor atual do carro
    SELECT valor INTO v_valor_atual FROM tb_carros WHERE id = p_id_carro;

    -- Atualizar o valor do carro
    UPDATE tb_carros 
    SET valor = p_valor_novo 
    WHERE id = p_id_carro;

    -- Inserir o histórico da modificação de preço
    INSERT INTO historico_preco (data_modificacao, id_carro, valor_anterior, valor_novo)
    VALUES (NOW(), p_id_carro, v_valor_atual, p_valor_novo);
END $$

DELIMITER ;

CALL AtualizarValorCarro(1, 85000.00);

SELECT * FROM tb_carros;
SELECT * FROM historico_preco;