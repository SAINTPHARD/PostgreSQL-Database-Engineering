-- ====================================================================
-- ARQUITETURA DO BANCO DE DADOS (DDL)
-- Aqui definimos onde o CRUD vai operar.
-- ====================================================================

DROP TABLE IF EXISTS aluno;

CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    cpf CHAR(11),
    observacao TEXT,
    idade INTEGER,
    dinheiro NUMERIC(10,2),
    altura REAL,
    ativo BOOLEAN,
    data_nascimento DATE,
    hora_aula TIME,
    matriculado_em TIMESTAMP
);