-- ====================================================================
-- TEMA: Filtragem de Grupos e Agregações
-- CONCEITO: Cláusula HAVING vs WHERE (Filtro Pós-Agregação)
-- OBJETIVO: Demonstrar a diferença fundamental entre WHERE (filtro de tuplas)
--           e HAVING (filtro de grupos agregados), aplicando LEFT JOIN para
--           identificação de lacunas e busca por registros duplicados.
--
-- MODELAGEM DE DADOS
-- • Modelo Conceitual : Identificação de cursos sem matrículas ativas e 
--                       detecção de redundâncias no cadastro de colaboradores.
-- • Modelo Lógico     : Agrupamento por dimensões e filtragem com predicados agregados.
-- • Modelo Físico     : Avaliação de condições HAVING na fase pós-agrupamento 
--                       (Filter sobre HashAggregate no plano de execução).
--
-- CLASSIFICAÇÃO SQL
-- • DDL (Data Definition Language): Não aplicável.
-- • DML (Data Manipulation Language): Não aplicável.
-- • DQL (Data Query Language): SELECT, LEFT JOIN, GROUP BY, HAVING, COUNT.
--
-- Arquivo: 03-agregacao/03_having.sql
-- ====================================================================


-- ====================================================================
-- REGRA DE ENGENHARIA DE DADOS (WHERE vs HAVING)
-- • WHERE  : Filtra LINHAS (tuplas) ANTES de realizar o agrupamento.
--            Não aceita funções de agregação como COUNT(), SUM(), etc.
-- • HAVING : Filtra GRUPOS APÓS a consolidação do GROUP BY.
--            Utilizado exclusivamente com predicados agregados.
-- ====================================================================


-- ====================================================================
-- SQL DQL: Diagnóstico Relacional com LEFT JOIN (Inclusão de Nulos)
-- ====================================================================

-- Visualização completa dos cursos e suas respectivas matrículas (inclusive nulas)
SELECT 
    curso.nome AS curso_nome,
    aluno.nome AS aluno_nome
FROM curso
LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
LEFT JOIN aluno       ON aluno.id = aluno_curso.aluno_id;


-- ====================================================================
-- SQL DQL: Demonstrando a Restrição do WHERE (Falha de Sintaxe)
-- ====================================================================

-- O código abaixo é INVÁLIDO e gerará erro (SQLSTATE 42803) 
-- porque o WHERE tenta avaliar COUNT() antes do agrupamento existir:
/*
SELECT 
    curso.nome,
    COUNT(aluno.id)
FROM curso
LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
LEFT JOIN aluno       ON aluno.id = aluno_curso.aluno_id
WHERE COUNT(aluno.id) = 0
GROUP BY 1;
*/


-- ====================================================================
-- SQL DQL: Filtragem Agregada com HAVING (Cursos Sem e Com Alunos)
-- ====================================================================

-- 1. Identificar exclusivamente cursos sem nenhum aluno matriculado (COUNT = 0)
SELECT 
    curso.nome      AS "Curso sem Alunos",
    COUNT(aluno.id) AS "Total de Alunos"
FROM curso
LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
LEFT JOIN aluno       ON aluno.id = aluno_curso.aluno_id
GROUP BY curso.nome
HAVING COUNT(aluno.id) = 0;

-- 2. Identificar apenas cursos com ao menos um aluno matriculado (COUNT > 0)
SELECT 
    curso.nome      AS "Curso com Alunos",
    COUNT(aluno.id) AS "Total de Alunos"
FROM curso
LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
LEFT JOIN aluno       ON aluno.id = aluno_curso.aluno_id
GROUP BY curso.nome
HAVING COUNT(aluno.id) > 0;


-- ====================================================================
-- SQL DQL: Análise de Duplicidade em Tabelas de Domínio (Funcionários)
-- ====================================================================

-- 3. Mapear nomes duplicados na empresa e a frequência das ocorrências
SELECT 
    nome,
    COUNT(id) AS quantidade_repeticoes
FROM funcionarios
GROUP BY nome
HAVING COUNT(id) > 1;

-- 4. Mapear exclusivamente nomes únicos no cadastro
SELECT 
    nome,
    COUNT(id) AS total_ocorrencias
FROM funcionarios
GROUP BY nome
HAVING COUNT(id) = 1;