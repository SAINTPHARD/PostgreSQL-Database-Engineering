-- ====================================================================
-- CONCEITOS AVANÇADOS DE BANCO DE DADOS (DDL / DML)
-- Estudo das Características de uma Chave Primária (PRIMARY KEY)
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. SEÇÃO DDL - Estrutura da Tabela
-- --------------------------------------------------------------------

-- Garante uma reconstrução limpa do ambiente de testes
DROP TABLE IF EXISTS curso;

CREATE TABLE curso (
    -- Características essenciais da PRIMARY KEY: Ela é implicitamente NOT NULL e UNIQUE.
    -- Trocar "INTEGER NOT NULL UNIQUE" por "INTEGER PRIMARY KEY" obtém o mesmo resultado estrutural.
    id INTEGER PRIMARY KEY,
    nome VARCHAR(122) NOT NULL
);

-- --------------------------------------------------------------------
-- 2. SEÇÃO DML - Testes de Restrições e Validações
-- --------------------------------------------------------------------

-- [ERRO ESPERADO] -> Chave Primária e campos com restrição NOT NULL não aceitam valores nulos.
-- Erro: null value in column "id" or "nome" violates not-null constraint
INSERT INTO curso (id, nome) VALUES (NULL, NULL);
INSERT INTO curso (id, nome) VALUES (1, NULL); 

-- [SUCESSO] -> Registro inserido perfeitamente cumprindo os requisitos.
INSERT INTO curso (id, nome) VALUES (1, 'html');

-- [ERRO ESPERADO] -> Teste de Duplicidade. A Chave Primária barra IDs idênticos.
-- Erro: duplicate key value violates unique constraint "curso_pkey"
INSERT INTO curso (id, nome) VALUES (1, 'Javascript');

-- [SUCESSO] -> Ajustando a chave primária para um valor único (2), o registro é aceito.
INSERT INTO curso (id, nome) VALUES (2, 'Javascript');

-- --------------------------------------------------------------------
-- 3. SEÇÃO DQL - Verificação do Estado dos Dados
-- --------------------------------------------------------------------
SELECT * FROM curso;