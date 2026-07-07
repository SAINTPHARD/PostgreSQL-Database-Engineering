-- ====================================================================
-- CONCEITOS AVANÇADOS: INTEGRIDADE REFERENCIAL (ON UPDATE CASCADE)
-- Arquivo: 01-crud/07_on_update_cascade.sql
-- ====================================================================

-- 1. Limpar a tabela pivot anterior para aplicar a nova regra
DROP TABLE IF EXISTS aluno_curso;

-- 2. Criar a tabela aplicando o efeito dominó tanto no DELETE quanto no UPDATE
CREATE TABLE aluno_curso (
    aluno_id INTEGER REFERENCES aluno(id) ON DELETE CASCADE ON UPDATE CASCADE,
    curso_id INTEGER REFERENCES curso(id),
    PRIMARY KEY (aluno_id, curso_id)
);

-- 3. Inserir dados de teste para a tabela relacional
-- (Certifique-se de que os IDs de alunos abaixo existam na sua tabela principal)
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES 
(2, 1), 
(3, 1);

-- 4. O Teste do UPDATE CASCADE: Alterando o ID do aluno 2 para 20 na tabela pai
UPDATE aluno 
SET id = 20 
WHERE id = 2;

-- 5. Validação: Veja como o ID na tabela 'aluno_curso' mudou para 20 sozinho!
SELECT * FROM aluno_curso;