-- ====================================================================
-- [CRUD] -> D: DELETE (Remoção de Dados)
-- ====================================================================
-- TEMA: Remoção Física de Dados Relacionais
-- CONCEITO: Exclusão Condicional e Cláusula RETURNING (Delete do CRUD)
-- OBJETIVO: Demonstrar técnicas de remoção de tuplas com validação prévia,
--           uso de chaves primárias e rastreabilidade via RETURNING.
--
-- MODELO DE DADOS
-- • Nível Conceitual: Cancelamento e expurgo de registros de Alunos.
-- • Nível Lógico: Eliminação de tuplas via predicados restritivos (WHERE).
-- • Nível Físico: Marcação de registros como "dead tuples" para o VACUUM.
--
-- CLASSIFICAÇÃO SQL
-- • DDL: Não aplicável.
-- • DML: DELETE FROM (Manipulação para remoção de instâncias).
-- • DQL: SELECT, RETURNING (Consultas acessórias de estado).
-- ====================================================================

-- ====================================================================
-- SQL DQL -> SQL DML: Auditoria Prévia e Remoção por Atributo
-- ====================================================================

-- Validação de segurança antes do expurgo
SELECT * FROM aluno WHERE nome = 'Nico';

-- Execução do expurgo físico das instâncias
DELETE FROM aluno WHERE nome = 'Nico';

-- ====================================================================
-- SQL DML/DQL Híbrido: Remoção com Feedback Visual Instantâneo
-- ====================================================================

-- RETURNING * (DQL): Projeta o estado da tupla destruída para log/auditoria
DELETE FROM aluno WHERE nome = 'Vinícius' RETURNING *;


-- ====================================================================
-- SQL DML: Exclusão Segura via Identificador Único (Chave Primária)
-- ====================================================================

-- Uso do ID (PK): Garante a precisão operacional...
DELETE FROM aluno WHERE id = 3;