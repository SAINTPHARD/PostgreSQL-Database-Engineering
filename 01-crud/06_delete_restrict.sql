-- ====================================================================
-- ESTUDO DE RESTRIÇÕES: ON DELETE RESTRICT (COMPORTAMENTO PADRÃO)
-- Arquivo: 01-crud/06_delete_restrict.sql
-- ====================================================================

-- 1. Visualizar o estado atual dos alunos
SELECT * FROM public.aluno ORDER BY id ASC;

-- 2. Limpar a tabela antiga e aplicar a restrição RESTRICT explicitamente
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

-- [ERRO ESPERADO] -> Tentar deletar o Diogo (ID 1) vai falhar!
-- Como ele está matriculado, o ON DELETE RESTRICT barra a operação por segurança.
DELETE FROM aluno WHERE id = 1;

-- 3. Consulta estruturada cruzando os nomes com JOIN
SELECT 
    aluno.nome as "Nome do Aluno",
    curso.nome as "Nome do Curso"
FROM aluno
JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
JOIN curso       ON curso.id            = aluno_curso.curso_id;

-- 4. Verificação final da lista de alunos
SELECT * FROM aluno;