-- ====================================================================
-- PRATICA DE RESTRIÇÕES: ON DELETE RESTRICT (COMPORTAMENTO PADRÃO)
-- Arquivo: 01-crud/06_delete_restrict.sql
-- ====================================================================

-- ====================================================================
-- TEMA: Integridade Referencial Restrita
-- CONCEITO: Comportamento Padrão ON DELETE RESTRICT
-- OBJETIVO: Demonstrar o mecanismo de segurança que impede a exclusão 
--           de registros pais que possuem dependências ativas em tabelas filhas.
--
-- MODELO DE DADOS
-- • Nível Conceitual: Restrição de exclusão de Alunos com vínculos ativos em Cursos.
-- • Nível Lógico: Aplicação da restrição de integridade referencial RESTRICT na FK.
-- • Nível Físico: Validação transacional de restrições de chaves pelo motor do Postgres.
--
-- CLASSIFICAÇÃO SQL
-- • DDL: CREATE TABLE, DROP TABLE (Definição estrutural do esquema).
-- • DML: DELETE FROM (Simulação e teste de manipulação de instâncias).
-- • DQL: SELECT, JOIN (Consulta e auditoria visual dos estados dos dados).
-- ====================================================================

-- ====================================================================
-- SQL DQL: Estado Inicial das Instâncias
-- ====================================================================

SELECT * FROM public.aluno ORDER BY id ASC;


-- ====================================================================
-- SQL DDL: Definição do Esquema Lógico com Restrição RESTRICT
-- ====================================================================

DROP TABLE IF EXISTS aluno_curso;

CREATE TABLE aluno_curso (
    aluno_id INTEGER,
    curso_id INTEGER,
    PRIMARY KEY (aluno_id, curso_id),

    FOREIGN KEY (aluno_id)
        REFERENCES aluno (id)
        ON DELETE RESTRICT, -- Mantém a segurança: impede deletar o aluno se houver matrícula

    FOREIGN KEY (curso_id)
        REFERENCES curso (id)
);


-- ====================================================================
-- SQL DML: Simulação de Violação de Chave Estrangeira
-- ====================================================================

-- [ERRO ESPERADO] -> O Postgres barrará a operação devido à amarração ativa na tabela filha.
DELETE FROM aluno WHERE id = 1;


-- ====================================================================
-- SQL DQL: Consulta Estruturada e Visão Relacional Resultante
-- ====================================================================

-- Projeção unificada via Junção de Tabelas (JOIN)
SELECT 
    aluno.nome as "Nome do Aluno",
    curso.nome as "Nome do Curso"
FROM aluno
JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
JOIN curso       ON curso.id            = aluno_curso.curso_id;

-- Auditoria final da tabela pai
SELECT * FROM aluno;