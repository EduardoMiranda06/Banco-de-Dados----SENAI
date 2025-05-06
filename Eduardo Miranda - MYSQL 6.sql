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
CREATE TRIGGER atualizar_log_estoque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    INSERT INTO log_estoque (id_produto, quantidade_antiga, quantidade_nova, data_alteracao)
    VALUES (NEW.id, OLD.quantidade, NEW.quantidade, NOW());
END $$

DELIMITER ;

UPDATE produtos SET quantidade = 50 WHERE id = 1;
SELECT * FROM log_estoque;
