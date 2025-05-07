CREATE DATABASE EmpresaBD;
USE EmpresaBD;

CREATE TABLE produtos (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
quantidade INT ); 

CREATE TABLE log_estoque (
id_log INT AUTO_INCREMENT PRIMARY KEY,
id_produto INT,
quantidade_antiga INT,
quantidade_nova INT,
data_alteracao DATETIME
);

DELIMITER $$

CREATE TRIGGER registrar_alteracao_estoque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    -- Verifica se a quantidade foi alterada
    IF OLD.quantidade <> NEW.quantidade THEN
        -- Insere o registro na tabela de log
        INSERT INTO log_estoque (id_produto, quantidade_antiga, quantidade_nova, data_alteracao)
        VALUES (OLD.id, OLD.quantidade, NEW.quantidade, NOW());
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION get_quantidade_produto(produto_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE qtd INT;

    -- Busca a quantidade atual do produto
    SELECT quantidade INTO qtd FROM produtos WHERE id = produto_id;

    RETURN qtd;
END $$

DELIMITER ;
SELECT get_quantidade_produto(1) AS quantidade_em_estoque;


DELIMITER $$

CREATE PROCEDURE atualiza_quantidade(IN p_id INT, IN p_nova_quantidade INT)
BEGIN
    -- Atualiza a quantidade do produto na tabela produtos
    UPDATE produtos SET quantidade = p_nova_quantidade WHERE id = p_id;

    -- Retorna uma mensagem de sucesso
    SELECT 'Produto atualizado com sucesso' AS mensagem;
END $$

DELIMITER ;
CALL atualiza_quantidade(1, 50);



UPDATE produtos SET quantidade = 50 WHERE id = 1;
SELECT * FROM log_estoque;
