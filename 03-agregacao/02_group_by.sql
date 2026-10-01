-- ====================================================================
-- TEMA: Agrupamento de Consultas e Remoção de Duplicatas
-- CONCEITO: Cláusulas DISTINCT e GROUP BY
-- OBJETIVO: Demonstrar técnicas para eliminação de tuplas repetidas e 
--           agrupamento de dimensões para aplicação de funções de agregação.
--
-- MODELAGEM DE DADOS
-- • Modelo Lógico     : Projeção de valores únicos e consolidação de 
--                       métricas relacionais (Ex: total de alunos por curso).
-- • Modelo Físico     : Uso de HashAggregate ou GroupAggregate na memória 
--                       (work_mem) para compilar os agrupamentos.
--
-- CLASSIFICAÇÃO SQL
-- • DQL: SELECT, DISTINCT, GROUP BY, JOIN, COUNT, ORDER BY.
--
-- Arquivo: 03-agregacao/02_group_by.sql
-- ====================================================================


-- ====================================================================
-- SQL DQL: Eliminação de Duplicatas (Sem Agregação)
-- ====================================================================

-- 1. DISTINCT Unidimensional: Retorna apenas nomes únicos.
SELECT DISTINCT nome
FROM funcionarios
ORDER BY nome;

-- 2. DISTINCT Multidimensional: O agrupamento considera a combinação 
-- de nome + sobrenome para determinar a unicidade.
SELECT DISTINCT 
    nome, 
    sobrenome
FROM funcionarios
ORDER BY nome;


-- ====================================================================
-- SQL DQL: Agrupamento com Métricas (GROUP BY)
-- ====================================================================

-- OBSERVAÇÃO ACADÊMICA:
-- O DISTINCT falha se tentarmos adicionar uma função de agregação como COUNT(*).
-- Para calcular métricas sobre dados repetidos, o uso do GROUP BY é obrigatório.

-- 3. Agrupamento Nominativo: Contando as ocorrências por Nome e Sobrenome
SELECT 
    nome,
    sobrenome,
    COUNT(*) AS quantidade_ocorrencias
FROM funcionarios
GROUP BY nome, sobrenome
ORDER BY nome;

-- 4. Agrupamento Posicional: Utiliza o índice das colunas projetadas.
-- (1 -> nome, 2 -> sobrenome)
SELECT 
    nome,
    sobrenome,
    COUNT(*) AS quantidade_ocorrencias
FROM funcionarios
GROUP BY 1, 2
ORDER BY 1;


-- ====================================================================
-- SQL DQL: Agrupamento em Consultas Relacionais Complexas (JOINs)
-- ====================================================================

-- 5. Análise Relacional: Contagem de Alunos Matriculados por Curso
-- Cruzamos 3 tabelas e agrupamos pelo nome do curso (posição 1).
SELECT 
    curso.nome      AS "Nome do Curso",
    COUNT(aluno.id) AS "Total de Alunos"
FROM aluno
JOIN aluno_curso ON aluno.id = aluno_curso.aluno_id
JOIN curso       ON curso.id = aluno_curso.curso_id
GROUP BY 1
ORDER BY 1;