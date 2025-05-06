create database loja;
use loja;
CREATE TABLE Cliente (
cliente_id INT PRIMARY KEY,
nome VARCHAR(100),
cpf CHAR(11),
email VARCHAR(100),
telefone VARCHAR(15)
);


CREATE TABLE Produto (
produto_id INT PRIMARY KEY,
nome VARCHAR(100),
preco DECIMAL(10,2),
estoque INT
);


CREATE TABLE Vendedor (
vendedor_id INT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100),
salario DECIMAL(10,2)
);

CREATE TABLE Venda (
venda_id INT PRIMARY KEY,
cliente_id INT,
vendedor_id INT,
data_venda DATE,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES
Cliente(cliente_id),
FOREIGN KEY (vendedor_id) REFERENCES
Vendedor(vendedor_id)
);

CREATE TABLE ItemVenda (
item_id INT PRIMARY KEY,
venda_id INT,
produto_id INT,
quantidade INT,
preco_unitario DECIMAL(10,2),
FOREIGN KEY (venda_id) REFERENCES
Venda(venda_id),
FOREIGN KEY (produto_id) REFERENCES
Produto(produto_id)
);

SELECT * FROM CLIENTE;

DESCRIBE CLIENTE;

insert INTO CLIENTE VALUES 


