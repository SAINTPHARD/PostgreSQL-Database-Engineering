-- ====================================================================
-- [CRUD] -> U: UPDATE (Atualização de Dados)
-- ====================================================================
-- TEMA: Modificação de Estados de Dados
-- CONCEITO: Atualização Restrita, Mutabilidade e a Cláusula RETURNING
-- OBJETIVO: Demonstrar técnicas de alteração de atributos em instâncias 
--           específicas e o uso do RETURNING para otimização de tráfego de rede.
--
-- MODELO DE DADOS
-- • Nível Conceitual: Alteração cadastral, retificações e movimentações de saldo de Alunos.
-- • Nível Lógico: Mutação de valores de colunas em tuplas selecionadas via predicado (WHERE).
-- • Nível Físico: Gravação de novas versões de linhas em disco via MVCC (Multi-Version Concurrency Control).
--
-- CLASSIFICAÇÃO SQL
-- • DDL: Não aplicável (A estrutura da tabela não sofre alterações em suas definições).
-- • DML: UPDATE ... SET (Manipulação/Mutação direta dos estados das instâncias).
-- • DQL: Cláusula RETURNING (Incorporação reativa de projeção de dados no mesmo ciclo).
-- ====================================================================

-- ====================================================================
-- COMPONENTE: SQL DML (Data Manipulation Language)
-- FOCO: Atualização Cadastral Completa Substitutiva
-- ====================================================================

-- UPDATE (DML): Modifica as instâncias existentes.
-- SET (DML): Especifica quais colunas receberão novos valores na tupla.
-- WHERE (DQL): REQUISITO CRÍTICO DE SEGURANÇA! Restringe a mutação estritamente ao ID 1.
UPDATE aluno SET 
    nome = 'Nico Silva', 
    cpf = '11987654000', 
    observacao = 'Teste 2', 
    idade = 38, 
    dinheiro = 15.23, 
    altura = 1.90, 
    ativo = FALSE, 
    data_nascimento = '1981-11-15', 
    hora_aula = '11:00:00', 
    matriculado_em = '2021-01-02 15:00:00' 
WHERE id = 1;


-- ====================================================================
-- COMPONENTE: SQL DML/DQL Híbrido
-- FOCO: Atualização Condicional com Auditoria de Estado Completo
-- ====================================================================

-- RETURNING * (DQL): Instancia uma projeção imediata de todas as colunas da tupla modificada.
-- Nota Acadêmica: Elimina a necessidade de disparar um comando SELECT subsequente na aplicação.
UPDATE aluno SET 
    ativo = TRUE, 
    observacao = 'Matrícula reativada pelo financeiro' 
WHERE id = 1 
RETURNING *;


-- ====================================================================
-- COMPONENTE: SQL DML/DQL Híbrido
-- FOCO: Atualização com Projeção Customizada e Renomeação Lógica
-- ====================================================================

-- RETURNING + AS (DQL): Projeta apenas os atributos necessários pós-mutação usando pseudônimos.
UPDATE aluno SET 
    dinheiro = 50.00 
WHERE id = 1 
RETURNING nome, dinheiro AS saldo_atualizado;