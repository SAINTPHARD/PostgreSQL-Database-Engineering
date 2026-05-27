-- ====================================================================
-- [CRUD] -> D: DELETE (Remoção de Dados)
-- Subgrupo do SQL: DML (Data Manipulation Language)
-- ====================================================================

-- Validação Prévia antes da Remoção por Nome
SELECT * FROM aluno WHERE nome = 'Nico';
DELETE FROM aluno WHERE nome = 'Nico';

-- Remoção com Histórico Retornado (RETURNING)
DELETE FROM aluno WHERE nome = 'Vinícius' RETURNING *;

-- Exclusão Segura usando a Chave Primária (ID)
DELETE FROM aluno WHERE id = 3;