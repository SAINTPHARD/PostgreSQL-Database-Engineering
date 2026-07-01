-- =========================================================================
-- REPOSITÓRIO DE ESTUDOS: POSTGRESQL PARA BACKEND JAVA (ESTUDO DE JOINS)
-- Autor: Robedson SAINT PHARD
-- Objetivo: Praticar relacionamentos Many-To-Many e tipos de junções (JOINs)
-- =========================================================================

-- -------------------------------------------------------------------------
-- 1. ESTRUTURAÇÃO DO BANCO DE DADOS (DDL)
-- -------------------------------------------------------------------------

-- Limpeza prévia para garantir um ambiente limpo e IDs sequenciais consistentes
TRUNCATE TABLE aluno_curso CASCADE;
DROP TABLE IF EXISTS aluno_curso CASCADE;
DROP TABLE IF EXISTS aluno CASCADE;
DROP TABLE IF EXISTS curso CASCADE;

-- Tabela de Alunos (Equivalente à entidade @Entity Aluno no Java)
CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    observacao TEXT,
    idade INTEGER,
    dinheiro NUMERIC(10,2),
    altura NUMERIC(3,2),
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Cursos (Equivalente à entidade @Entity Curso no Java)
CREATE TABLE curso (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela Intermediária de Matrículas (Mapeamento @ManyToMany no JPA)
CREATE TABLE aluno_curso (
    aluno_id INTEGER REFERENCES aluno(id) ON DELETE CASCADE,
    curso_id INTEGER REFERENCES curso(id) ON DELETE CASCADE,
    PRIMARY KEY (aluno_id, curso_id)
);

-- -------------------------------------------------------------------------
-- 2. POPULANDO O BANCO DE DADOS (DML)
-- -------------------------------------------------------------------------

-- Inserindo Alunos
INSERT INTO aluno (nome, cpf, idade) VALUES ('Diogo', '12345678901', 25);
INSERT INTO aluno (nome, cpf, idade) VALUES ('Vinícius', '98765432100', 30);
INSERT INTO aluno (nome, cpf, idade) VALUES ('Nico', '11122233344', 28); -- Aluno sem curso matriculado
INSERT INTO aluno (nome) VALUES ('João');                                 -- Aluno para teste de CROSS JOIN

-- Inserindo Cursos
INSERT INTO curso (nome) VALUES ('HTML');
INSERT INTO curso (nome) VALUES ('Javascript');
INSERT INTO curso (nome) VALUES ('CSS'); -- Curso sem nenhum aluno matriculado

-- Vinculando Matrículas (aluno_id, curso_id)
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1, 1); -- Diogo no HTML
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2, 1); -- Vinícius no HTML
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2, 2); -- Vinícius no Javascript

-- -------------------------------------------------------------------------
-- 3. CONSULTAS PRÁTICAS E TIPOS DE JUNÇÃO (DQL)
-- -------------------------------------------------------------------------

-- A. INNER JOIN (Retorna apenas correspondências exatas de alunos matriculados)
SELECT aluno.nome as "Nome do Aluno", curso.nome as "Nome do Curso"
FROM aluno
INNER JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
INNER JOIN curso ON curso.id = aluno_curso.curso_id;

-- B. LEFT JOIN (Enfatiza a tabela da esquerda: traz TODOS os alunos, inclusive o Nico)
SELECT aluno.nome as "Nome do Aluno", curso.nome as "Nome do Curso"
FROM aluno
LEFT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
LEFT JOIN curso ON curso.id = aluno_curso.curso_id;

-- C. RIGHT JOIN (Enfatiza a tabela da direita: traz TODOS os cursos, inclusive o CSS sem alunos)
SELECT aluno.nome as "Nome do Aluno", curso.nome as "Nome do Curso"
FROM aluno
RIGHT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
RIGHT JOIN curso ON curso.id = aluno_curso.curso_id;

-- D. FULL JOIN (Traz todos os alunos e todos os cursos, preenchendo com NULL onde faltar dado)
SELECT aluno.nome as "Nome do Aluno", curso.nome as "Nome do Curso"
FROM aluno
FULL JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
FULL JOIN curso ON curso.id = aluno_curso.curso_id;

-- E. CROSS JOIN (Produto Cartesiano: multiplica cada aluno por cada curso cadastrado)
SELECT aluno.nome as "Nome do Aluno", curso.nome as "Nome do Curso"
FROM aluno
CROSS JOIN curso;