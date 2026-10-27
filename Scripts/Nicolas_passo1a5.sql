-- ============================================================
-- SISTEMA DE GESTAO OMNICHANNEL
-- PASSOS 1 A 5 EM UM UNICO SCRIPT
-- ATENCAO: apaga e recria omnichannel_db
-- ============================================================

DROP DATABASE IF EXISTS omnichannel_db;

CREATE DATABASE omnichannel_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE omnichannel_db;

-- ============================================================
-- PASSO 1: CRIACAO DAS TABELAS
-- ============================================================

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    data_nascimento DATE,
    tipo_cliente VARCHAR(30),
    endereco VARCHAR(150)
) ENGINE=InnoDB;

CREATE TABLE Loja (
    id_loja INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150),
    cidade VARCHAR(80),
    estado VARCHAR(50),
    telefone VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50),
    marca VARCHAR(50),
    estoque_minimo INT DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_loja INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja)
) ENGINE=InnoDB;

CREATE TABLE item_pedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
) ENGINE=InnoDB;

CREATE TABLE Estoques (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    id_loja INT NOT NULL,
    quantidade_atual INT DEFAULT 0,
    quantidade_minima INT DEFAULT 0,
    localizacao VARCHAR(100),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja),
    UNIQUE (id_produto, id_loja)
) ENGINE=InnoDB;

CREATE TABLE pagamentos (
    id_pagamentos INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    forma_pagamento VARCHAR(50),
    data_pagamento DATETIME,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    status_pagamento VARCHAR(30),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
) ENGINE=InnoDB;

CREATE TABLE Auditoria_preco (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    preco_antigo DECIMAL(10,2) NOT NULL,
    preco_novo DECIMAL(10,2) NOT NULL,
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario_responsavel VARCHAR(100),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
) ENGINE=InnoDB;

-- ============================================================
-- PASSO 2: CARGOS, USUARIOS E PERMISSOES
-- Pode exigir privilegios administrativos no MariaDB/MySQL.
-- ============================================================

CREATE ROLE IF NOT EXISTS 'role_atendente';
CREATE ROLE IF NOT EXISTS 'role_gerencia';

GRANT SELECT, INSERT
ON omnichannel_db.Clientes TO 'role_atendente';

GRANT SELECT
ON omnichannel_db.Produto TO 'role_atendente';

GRANT SELECT, INSERT
ON omnichannel_db.Pedido TO 'role_atendente';

GRANT SELECT, INSERT
ON omnichannel_db.item_pedido TO 'role_atendente';

GRANT SELECT, INSERT, UPDATE, DELETE
ON omnichannel_db.* TO 'role_gerencia';

CREATE USER IF NOT EXISTS 'atendente_omni'@'localhost'
IDENTIFIED BY 'TroqueEstaSenha123!';

CREATE USER IF NOT EXISTS 'gerente_omni'@'localhost'
IDENTIFIED BY 'TroqueEstaSenha456!';

GRANT 'role_atendente' TO 'atendente_omni'@'localhost';
GRANT 'role_gerencia' TO 'gerente_omni'@'localhost';

SET DEFAULT ROLE 'role_atendente'
FOR 'atendente_omni'@'localhost';

SET DEFAULT ROLE 'role_gerencia'
FOR 'gerente_omni'@'localhost';

-- ============================================================
-- PASSO 3: INSERCAO DE DADOS
-- ============================================================

INSERT INTO Clientes
(nome, email, telefone, data_nascimento, tipo_cliente, endereco)
VALUES
('Carlos Silva', 'carlos@email.com', '81999991001', '1995-04-12', 'VIP', 'Rua A, Recife'),
('Mariana Souza', 'mariana@email.com', '81999991002', '1998-08-20', 'Comum', 'Rua B, Recife'),
('Joao Santos', 'joao@email.com', '81999991003', '2000-02-15', 'Comum', 'Rua C, Olinda'),
('Ana Oliveira', 'ana@email.com', '81999991004', '1992-11-30', 'VIP', 'Rua D, Jaboatao'),
('Pedro Costa', 'pedro@email.com', '81999991005', '1999-06-05', 'Comum', 'Rua E, Recife');

INSERT INTO Loja
(nome, endereco, cidade, estado, telefone)
VALUES
('Loja Recife Centro', 'Rua do Sol, 100', 'Recife', 'PE', '8130001001'),
('Loja Boa Viagem', 'Av. Boa Viagem, 200', 'Recife', 'PE', '8130001002'),
('Loja Olinda', 'Rua do Carmo, 300', 'Olinda', 'PE', '8130001003'),
('Loja Jaboatao', 'Av. Central, 400', 'Jaboatao', 'PE', '8130001004'),
('Loja Paulista', 'Rua Principal, 500', 'Paulista', 'PE', '8130001005');

INSERT INTO Produto
(nome, descricao, preco, categoria, marca, estoque_minimo)
VALUES
('Notebook', 'Notebook para trabalho', 2500.00, 'Informatica', 'TechPlus', 5),
('Mouse', 'Mouse USB optico', 50.00, 'Acessorios', 'Click', 10),
('Teclado', 'Teclado USB ABNT2', 100.00, 'Acessorios', 'Digit', 10),
('Monitor', 'Monitor LED 24 polegadas', 800.00, 'Informatica', 'Vision', 3),
('Headset', 'Headset com microfone', 150.00, 'Audio', 'SoundMax', 5);

INSERT INTO Estoques
(id_produto, id_loja, quantidade_atual, quantidade_minima, localizacao)
VALUES
(1, 1, 20, 5, 'Prateleira A'),
(2, 2, 50, 10, 'Prateleira B'),
(3, 3, 30, 10, 'Prateleira C'),
(4, 4, 15, 3, 'Prateleira D'),
(5, 5, 25, 5, 'Prateleira E');

INSERT INTO Pedido
(id_cliente, id_loja, data_pedido, valor_total, status)
VALUES
(1, 1, '2026-10-01 10:00:00', 2550.00, 'Pago'),
(2, 2, '2026-10-02 11:30:00', 250.00, 'Pago'),
(3, 3, '2026-10-03 14:00:00', 800.00, 'Pago'),
(4, 4, '2026-10-04 15:20:00', 300.00, 'Pendente'),
(5, 5, '2026-10-05 16:45:00', 100.00, 'Pago');

INSERT INTO item_pedido
(id_pedido, id_produto, quantidade, preco_unitario, subtotal)
VALUES
(1, 1, 1, 2500.00, 2500.00),
(1, 2, 1, 50.00, 50.00),
(2, 2, 3, 50.00, 150.00),
(2, 3, 1, 100.00, 100.00),
(3, 4, 1, 800.00, 800.00);

INSERT INTO pagamentos
(id_pedido, forma_pagamento, data_pagamento, valor_pagamento, status_pagamento)
VALUES
(1, 'Cartao', '2026-10-01 10:10:00', 2550.00, 'Aprovado'),
(2, 'PIX', '2026-10-02 11:35:00', 250.00, 'Aprovado'),
(3, 'Dinheiro', '2026-10-03 14:10:00', 800.00, 'Aprovado'),
(4, 'Cartao', NULL, 300.00, 'Pendente'),
(5, 'PIX', '2026-10-05 16:50:00', 100.00, 'Aprovado');

-- ============================================================
-- PASSO 4: PROCEDURE, TRIGGER, VIEW E INDICE
-- ============================================================

DELIMITER //

CREATE PROCEDURE sp_processar_venda(
    IN p_id_cliente INT,
    IN p_id_loja INT,
    IN p_id_produto INT,
    IN p_quantidade INT,
    IN p_forma_pagamento VARCHAR(50)
)
BEGIN
    DECLARE v_estoque INT DEFAULT NULL;
    DECLARE v_preco DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_quantidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade deve ser maior que zero';
    END IF;

    START TRANSACTION;

    SELECT quantidade_atual
    INTO v_estoque
    FROM Estoques
    WHERE id_produto = p_id_produto
      AND id_loja = p_id_loja
    FOR UPDATE;

    IF v_estoque IS NULL OR v_estoque < p_quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estoque insuficiente ou inexistente';
    END IF;

    SELECT preco
    INTO v_preco
    FROM Produto
    WHERE id_produto = p_id_produto;

    SET v_total = v_preco * p_quantidade;

    INSERT INTO Pedido
    (id_cliente, id_loja, valor_total, status)
    VALUES
    (p_id_cliente, p_id_loja, v_total, 'Pago');

    SET v_id_pedido = LAST_INSERT_ID();

    INSERT INTO item_pedido
    (id_pedido, id_produto, quantidade, preco_unitario, subtotal)
    VALUES
    (v_id_pedido, p_id_produto, p_quantidade, v_preco, v_total);

    UPDATE Estoques
    SET quantidade_atual = quantidade_atual - p_quantidade
    WHERE id_produto = p_id_produto
      AND id_loja = p_id_loja;

    INSERT INTO pagamentos
    (id_pedido, forma_pagamento, data_pagamento,
     valor_pagamento, status_pagamento)
    VALUES
    (v_id_pedido, p_forma_pagamento, NOW(), v_total, 'Aprovado');

    COMMIT;
END //

CREATE TRIGGER trg_auditar_preco
AFTER UPDATE ON Produto
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO Auditoria_preco
        (id_produto, preco_antigo, preco_novo, usuario_responsavel)
        VALUES
        (OLD.id_produto, OLD.preco, NEW.preco, CURRENT_USER());
    END IF;
END //

DELIMITER ;

CREATE OR REPLACE VIEW vw_relatorio_vendas AS
SELECT
    p.id_pedido,
    c.nome AS cliente,
    l.nome AS loja,
    p.data_pedido,
    p.valor_total,
    p.status
FROM Pedido p
INNER JOIN Clientes c ON p.id_cliente = c.id_cliente
INNER JOIN Loja l ON p.id_loja = l.id_loja;

CREATE INDEX idx_pedido_data ON Pedido(data_pedido);

-- ============================================================
-- PASSO 5: TESTES
-- ============================================================

-- Conferir dados cadastrados
SELECT * FROM Clientes;
SELECT * FROM Loja;
SELECT * FROM Produto;
SELECT * FROM Estoques;
SELECT * FROM Pedido;
SELECT * FROM item_pedido;
SELECT * FROM pagamentos;
SELECT * FROM Auditoria_preco;

-- Conferir usuarios e permissoes
SHOW GRANTS FOR 'atendente_omni'@'localhost';
SHOW GRANTS FOR 'gerente_omni'@'localhost';

-- Conferir relatorio e indice
SELECT * FROM vw_relatorio_vendas;
SHOW INDEX FROM Pedido;

-- Testar uma venda: cliente 1 compra 2 mouses na loja 2.
-- Resultado esperado: total de R$ 100,00 e estoque do mouse reduzido de 50 para 48.
CALL sp_processar_venda(1, 2, 2, 2, 'PIX');

SELECT * FROM Pedido ORDER BY id_pedido DESC LIMIT 1;
SELECT * FROM item_pedido ORDER BY id_item_pedido DESC LIMIT 1;
SELECT * FROM pagamentos ORDER BY id_pagamentos DESC LIMIT 1;
SELECT * FROM Estoques WHERE id_produto = 2 AND id_loja = 2;

-- Testar auditoria: o preco do mouse passa de R$ 50,00 para R$ 55,00.
UPDATE Produto SET preco = 55.00 WHERE id_produto = 2;
SELECT * FROM Auditoria_preco;

-- Testar o plano de consulta
EXPLAIN
SELECT *
FROM Pedido
WHERE data_pedido >= '2026-10-01';

-- FIM DO SCRIPT
