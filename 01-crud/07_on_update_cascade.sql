-- ====================================================================
-- TEMA: Integridade Referencial
-- CONCEITO: ON UPDATE CASCADE (Propagação por Efeito Dominó)
-- OBJETIVO: Demonstrar como uma alteração na Chave Primária (PK) da tabela 
--           pai é propagada automaticamente para a tabela filha através 
--           da restrição de integridade referencial.
--
-- GLOSSÁRIO DE TERMINOLOGIAS ACADÉMICAS:
-- • SQL DDL (Data Definition Language) -> Manipula o ESQUEMA / ESTRUTURA (Ex: CREATE, DROP).
-- • SQL DML (Data Manipulation Language) -> Manipula as INSTÂNCIAS / TUPLAS (Ex: INSERT, UPDATE).
-- • SQL DQL (Data Query Language) -> Cria PROJEÇÕES / VISÕES dos estados dos dados (Ex: SELECT).
-- • INSTÂNCIA / TUPLA -> O registo real (a linha) persistido em uma tabela.
-- • ESQUEMA -> A definição lógica, metadados e regras que estruturam o banco.
-- ====================================================================


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Auditoria do Estado Inicial das Instâncias (Leitura das Tuplas Atuais)
-- ====================================================================

SELECT * FROM aluno ORDER BY id;
SELECT * FROM curso ORDER BY id;
SELECT * FROM aluno_curso;


-- ====================================================================
-- COMPONENTE: SQL DDL (Data Definition Language)
-- FOCO: Definição do Esquema Lógico do Relacionamento N:N (Mapeamento de Regras)
-- ====================================================================

-- DROP (DDL): Modifica o esquema eliminando a estrutura pré-existente
DROP TABLE IF EXISTS aluno_curso;

-- CREATE TABLE (DDL): Define um novo esquema estrutural com restrições automatizadas
CREATE TABLE aluno_curso (

    aluno_id INTEGER
        REFERENCES aluno(id)         -- CHAVE ESTRANGEIRA (FK): Cria o elo referencial com a tabela pai
        ON UPDATE CASCADE            -- GATILHO DE ATUALIZAÇÃO: Propaga alterações de ID automaticamente
        ON DELETE CASCADE,           -- GATILHO DE EXCLUSÃO: Remove dependências se o pai for apagado

    curso_id INTEGER
        REFERENCES curso(id),        -- CHAVE ESTRANGEIRA (FK): Elo referencial com a tabela curso

    PRIMARY KEY (aluno_id, curso_id) -- CHAVE PRIMÁRIA COMPOSTA: Garante a unicidade do relacionamento
);


-- ====================================================================
-- COMPONENTE: SQL DML (Data Manipulation Language)
-- FOCO: População e Inserção de Novas Instâncias no Banco de Dados
-- ====================================================================

-- INSERT (DML): Cria novas instâncias (tuplas) baseadas nos IDs existentes nas tabelas fortes
INSERT INTO aluno_curso (aluno_id, curso_id)
VALUES
    (2, 1), -- Instância ligando Aluno 2 ao Curso 1
    (3, 2); -- Instância ligando Aluno 3 ao Curso 2


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Projeção de Estado Pré-Alteração (Cruzamento de Dados via JOIN)
-- ====================================================================

SELECT
    aluno.id   AS aluno_id,
    aluno.nome AS aluno,
    curso.id   AS curso_id,
    curso.nome AS curso
FROM aluno
JOIN aluno_curso
    ON aluno.id = aluno_curso.aluno_id
JOIN curso
    ON curso.id = aluno_curso.curso_id
ORDER BY aluno.id;


-- ====================================================================
-- COMPONENTE: SQL DML (Data Manipulation Language)
-- FOCO: Simulação de Anomalia de Alteração na Entidade Pai (Forte)
-- ====================================================================

-- UPDATE (DML): Modifica o estado de uma tupla específica.
-- Nota Académica: Graças ao ON UPDATE CASCADE definido no DDL, esta alteração 
-- disparará uma reação em cadeia automática, protegendo o banco contra dados órfãos.
UPDATE aluno
SET id = 20
WHERE id = 2;


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Validação do Novo Estado da Instância na Tabela Pai
-- ====================================================================

SELECT * FROM aluno ORDER BY id;


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Auditoria de Propagação Automática na Tabela Filha (Fraca)
-- ====================================================================

-- Verificação da integridade: O 'aluno_id' mudou de 2 para 20 de forma reativa.
SELECT * FROM aluno_curso;


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Projeção de Estado Pós-Alteração (Resultado Final do Relacionamento)
-- ====================================================================

SELECT
    aluno.id   AS aluno_id,
    aluno.nome AS aluno,
    curso.id   AS curso_id,
    curso.nome AS curso
FROM aluno
JOIN aluno_curso
    ON aluno.id = aluno_curso.aluno_id
JOIN curso
    ON curso.id = aluno_curso.curso_id
ORDER BY aluno.id;