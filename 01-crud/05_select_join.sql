-- ====================================================================
-- CONCEITOS AVANÇADOS: RELACIONAMENTO MUITOS PARA MUITOS (N:N)
-- Arquivo: 01-crud/05_select_join.sql
-- ====================================================================

-- REGRA DO NEGÓCIO:
-- -> Um Aluno pode se matricular em VÁRIOS Cursos.
-- -> Um Curso pode ter VÁRIOS Alunos.
-- -> Solução: Criar a tabela intermediária "aluno_curso" (tabela pivô).

-- --------------------------------------------------------------------
-- 1. SEÇÃO DDL - Estrutura Física e Limpeza
-- --------------------------------------------------------------------

-- Sempre remova a tabela intermediária primeiro para não quebrar as Foreign Keys
DROP TABLE IF EXISTS aluno_curso;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS curso;

-- Tabela Base 1: Alunos
CREATE TABLE aluno (
    id SERIAL PRIMARY KEY, -- Chave Primária (Identidade do Aluno)
    nome VARCHAR(255)
);

-- Tabela Base 2: Cursos
CREATE TABLE curso (
    id INTEGER PRIMARY KEY, -- Chave Primária (Identidade do Curso)
    nome VARCHAR(122) NOT NULL
);

-- Tabela Intermediária: Conecta Aluno com Curso
CREATE TABLE aluno_curso (
    -- REFERENCES: Garante que o ID digitado aqui exista na tabela original
    aluno_id INTEGER REFERENCES aluno(id),
    curso_id INTEGER REFERENCES curso(id),
    
    -- PRIMARY KEY Composta: Impede que o mesmo aluno se matricule 2 vezes no mesmo curso
    PRIMARY KEY (aluno_id, curso_id)
);

-- --------------------------------------------------------------------
-- 2. SEÇÃO DML - Carga de Dados para Testes
-- --------------------------------------------------------------------

-- Cadastrando os Alunos (IDs gerados automaticamente: 1, 2 e 3)
INSERT INTO aluno (nome) VALUES ('Diogo'), ('Vinícius'), ('Nico');

-- Cadastrando os Cursos
INSERT INTO curso (id, nome) VALUES 
(1, 'PostgreSQL Avançado'),
(2, 'Git e GitHub');

-- Criando os Vínculos (Matrículas)
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES 
(1, 1), -- Diogo (1) matriculado em PostgreSQL (1)
(2, 1); -- Vinícius (2) matriculado em PostgreSQL (1)

-- --------------------------------------------------------------------
-- 3. SEÇÃO DQL - Extração de Relatórios com Junções (JOIN)
-- --------------------------------------------------------------------

-- O JOIN conecta as tabelas usando as pontes (aluno_id e curso_id)
SELECT
    aluno.nome AS aluno, -- Apelido para a coluna de resultado ficar limpa
    curso.nome AS curso
FROM aluno
JOIN aluno_curso ON aluno.id = aluno_curso.aluno_id -- Cruza Aluno com a Matrícula
JOIN curso       ON curso.id = aluno_curso.curso_id; -- Cruza a Matrícula com o Curso