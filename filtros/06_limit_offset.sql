-- ====================================================================
-- TEMA: Paginação e Limitação de Resultados
-- CONCEITO: Cláusulas LIMIT e OFFSET
-- OBJETIVO:
-- Demonstrar técnicas para limitar a quantidade de linhas retornadas
-- por uma consulta e implementar paginação de resultados utilizando
-- as cláusulas LIMIT e OFFSET.
--
-- MODELAGEM DE DADOS
-- • Modelo Conceitual : Segmentação de grandes conjuntos de dados para
--                       facilitar consultas e visualização de relatórios.
-- • Modelo Lógico     : Restrição do número de tuplas retornadas e
--                       deslocamento do ponto inicial da consulta.
-- • Modelo Físico     : Redução do volume de dados enviados ao cliente.
--                       Em grandes volumes, valores elevados de OFFSET
--                       podem aumentar o custo da consulta.
--
-- CLASSIFICAÇÃO SQL
-- • DDL (Data Definition Language): Não aplicável.
-- • DML (Data Manipulation Language): Não aplicável.
-- • DQL (Data Query Language): SELECT, ORDER BY, LIMIT e OFFSET.
--
-- Arquivo: 02-filtros/06_limit_offset.sql
-- ====================================================================


-- ====================================================================
-- OBSERVAÇÃO
--
-- LIMIT e OFFSET são amplamente utilizados para implementar paginação
-- em aplicações. Entretanto, para tabelas muito grandes, valores altos
-- de OFFSET podem reduzir o desempenho da consulta, pois o PostgreSQL
-- ainda precisa percorrer as linhas ignoradas antes de retornar o
-- resultado solicitado.
-- ====================================================================


-- ====================================================================
-- SQL DQL
-- Limitação direta do conjunto de resultados (LIMIT)
-- ====================================================================

-- Retorna apenas as cinco primeiras linhas da consulta.

SELECT *
FROM funcionarios
LIMIT 5;


-- ====================================================================
-- SQL DQL
-- Ordenação antes da Limitação (ORDER BY + LIMIT)
-- ====================================================================

-- O PostgreSQL executa primeiro a ordenação dos registros
-- e somente depois aplica o LIMIT.

SELECT *
FROM funcionarios
ORDER BY nome
LIMIT 5;


-- ====================================================================
-- SQL DQL
-- Paginação utilizando OFFSET
-- ====================================================================

-- OFFSET define quantas linhas serão ignoradas antes do
-- início do retorno da consulta.

-- Exemplo 1
-- Ignora a primeira linha e retorna as cinco seguintes.

SELECT *
FROM funcionarios
ORDER BY id
LIMIT 5 OFFSET 1;


-- Exemplo 2
-- OFFSET 0 indica que nenhuma linha será ignorada.

SELECT *
FROM funcionarios
ORDER BY id
LIMIT 5 OFFSET 0;


-- Exemplo 3
-- Ignora as duas primeiras linhas e inicia o retorno
-- a partir da terceira.

SELECT *
FROM funcionarios
ORDER BY id
LIMIT 5 OFFSET 2;


-- Exemplo 4
-- Ignora as três primeiras linhas da consulta.
-- Caso o número de linhas restantes seja menor que o LIMIT,
-- apenas as linhas disponíveis serão retornadas.

SELECT *
FROM funcionarios
ORDER BY id
LIMIT 5 OFFSET 3;