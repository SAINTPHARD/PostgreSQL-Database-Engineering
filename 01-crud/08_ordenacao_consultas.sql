-- ====================================================================
-- TEMA: Ordenação e Organização de Consultas Relacionais
-- CONCEITO: Cláusula ORDER BY (Ordenação Simples, Posicional e Múltipla)
-- OBJETIVO:
-- Demonstrar diferentes estratégias de ordenação de consultas SQL,
-- utilizando atributos, índices posicionais e múltiplos critérios,
-- incluindo cenários de ambiguidade em consultas com JOIN.
--
-- MODELAGEM DE DADOS
-- • Modelo Conceitual : Entidades "Aluno", "Curso" e "Funcionário"
--                       utilizadas como domínio das consultas.
-- • Modelo Lógico     : Ordenação das tuplas por um ou mais atributos,
--                       preservando a integridade do conjunto de resultados.
-- • Modelo Físico     : Execução da operação ORDER BY através dos
--                       mecanismos de ordenação do PostgreSQL, utilizando
--                       memória (work_mem) e, quando necessário,
--                       arquivos temporários.
--
-- CLASSIFICAÇÃO SQL
-- • DDL (Data Definition Language): criação da estrutura de apoio.
-- • DML (Data Manipulation Language): inserção das instâncias de teste.
-- • DQL (Data Query Language): consultas, projeções, JOINs e ordenações.
--
-- Arquivo: 02-filtros/05_order_by.sql
-- ====================================================================


-- ====================================================================
-- SQL DQL
-- Estado inicial das instâncias
-- ====================================================================

SELECT *
FROM aluno
ORDER BY id ASC;


-- ====================================================================
-- SQL DDL
-- Criação da estrutura auxiliar para demonstração
-- ====================================================================

DROP TABLE IF EXISTS funcionarios;

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    matricula VARCHAR(10),
    nome VARCHAR(255),
    sobrenome VARCHAR(255)
);


-- ====================================================================
-- SQL DML
-- Inserção das instâncias de teste
-- ====================================================================

INSERT INTO funcionarios (matricula, nome, sobrenome)
VALUES
    ('M001', 'Diogo',     'Mascarenhas'),
    ('M002', 'Vinícius',  'Dias'),
    ('M003', 'Nico',      'Steppat'),
    ('M004', 'João',      'Roberto'),
    ('M005', 'Diogo',     'Mascarenhas'),
    ('M006', 'Alberto',   'Martins');


-- ====================================================================
-- OBSERVAÇÃO
--
-- A cláusula ORDER BY não altera os dados armazenados.
-- Ela apenas define a ordem em que as tuplas serão
-- apresentadas no resultado da consulta.
-- ====================================================================


-- ====================================================================
-- SQL DQL
-- Ordenação por um único atributo
-- ====================================================================

-- Ordenação alfabética (ASC é o comportamento padrão)

SELECT *
FROM funcionarios
ORDER BY nome;


-- Ordenação alfabética decrescente

SELECT *
FROM funcionarios
ORDER BY nome DESC;


-- ====================================================================
-- SQL DQL
-- Ordenação por múltiplos atributos
-- ====================================================================

-- Primeiro ordena pelo nome.
-- Havendo empate, ordena pelo sobrenome.

SELECT *
FROM funcionarios
ORDER BY nome, sobrenome;


-- ====================================================================
-- SQL DQL
-- Ordenação Posicional
-- ====================================================================

-- As posições fazem referência à ordem das colunas retornadas
-- pelo SELECT.
--
-- Neste exemplo:
-- 3 -> nome
-- 4 -> sobrenome
-- 2 -> matrícula
--
-- Apesar de suportada pelo PostgreSQL, esta abordagem reduz a
-- legibilidade e normalmente não é utilizada em projetos reais.

SELECT *
FROM funcionarios
ORDER BY 3,4,2;


-- ====================================================================
-- SQL DQL
-- Ordenação Posicional com critérios mistos
-- ====================================================================

SELECT *
FROM funcionarios
ORDER BY
    4 DESC,
    nome DESC,
    2;


-- ====================================================================
-- SQL DQL
-- Ambiguidade em consultas relacionais
-- ====================================================================

-- SQLSTATE: 42702
--
-- A coluna "nome" existe tanto na tabela ALUNO quanto
-- na tabela CURSO.
--
-- O PostgreSQL não consegue determinar automaticamente
-- qual coluna deverá ser utilizada na ordenação.
--
-- A consulta abaixo gera erro.

-- SELECT
--     aluno.id,
--     aluno.nome,
--     curso.id,
--     curso.nome
-- FROM aluno
-- JOIN aluno_curso
--     ON aluno.id = aluno_curso.aluno_id
-- JOIN curso
--     ON curso.id = aluno_curso.curso_id
-- ORDER BY nome;


-- ====================================================================
-- SQL DQL
-- Resolução da ambiguidade através da qualificação do atributo
-- ====================================================================

SELECT
    aluno.id   AS aluno_id,
    aluno.nome AS "Nome do Aluno",
    curso.id   AS curso_id,
    curso.nome AS "Nome do Curso"
FROM aluno
JOIN aluno_curso
    ON aluno.id = aluno_curso.aluno_id
JOIN curso
    ON curso.id = aluno_curso.curso_id
ORDER BY
    curso.nome ASC,
    aluno.nome ASC;