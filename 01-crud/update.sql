-- ====================================================================
-- [CRUD] -> U: UPDATE (Atualização de Dados)
-- Subgrupo do SQL: DML (Data Manipulation Language)
-- ====================================================================

-- Atualização Cadastral Completa por ID
UPDATE aluno SET 
    nome = 'Nico Silva', cpf = '11987654000', observacao = 'Teste 2', idade = 38, 
    dinheiro = 15.23, altura = 1.90, ativo = FALSE, data_nascimento = '1981-11-15', 
    hora_aula = '11:00:00', matriculado_em = '2021-01-02 15:00:00' 
WHERE id = 1;

-- Atualização Condicional retornando os dados modificados
UPDATE aluno SET ativo = TRUE, observacao = 'Matrícula reativada pelo financeiro' 
WHERE id = 1 
RETURNING *;

-- Atualização com Projeção Customizada no RETURNING
UPDATE aluno SET dinheiro = 50.00 
WHERE id = 1 
RETURNING nome, dinheiro AS saldo_atualizado;