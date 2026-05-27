-- ====================================================================
-- [CRUD] -> R: READ (Consulta de Dados)
-- Subgrupo do SQL: DQL (Data Query Language)
-- ====================================================================

-- Leitura com Apelidos (Aliases)
SELECT nome, idade, matriculado_em AS quando_se_matriculou FROM aluno;

-- Filtros de Igualdade e Diferença
SELECT * FROM aluno WHERE nome = 'Diogo';
SELECT * FROM aluno WHERE nome <> 'Diogo';

-- Buscas com LIKE e Curingas (_ e %)
SELECT * FROM aluno WHERE nome LIKE '_iogo';
SELECT * FROM aluno WHERE nome LIKE 'D%';
SELECT * FROM aluno WHERE nome LIKE '%s';
SELECT * FROM aluno WHERE nome LIKE '%i%a';