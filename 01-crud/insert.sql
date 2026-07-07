-- ====================================================================
-- [CRUD] -> C: CREATE (Inserção de Dados)
-- ====================================================================
-- TEMA: Manipulação de Dados Relacionais
-- CONCEITO: Inserção de Registros e Carga em Lote (Create do CRUD)
-- OBJETIVO: Demonstrar técnicas de escrita atômica, inserção massiva 
--           (Bulk Insert) e persistência reativa com campos SERIAL.

-- ====================================================================
-- SQL DML: Inserção Atômica / Individual de Registro
-- ====================================================================

INSERT INTO aluno (nome, cpf, observacao, idade, dinheiro, altura, ativo, data_nascimento, hora_aula, matriculado_em) 
VALUES ('Augusto', '12345678901', 'Aluno destaque do curso de SQL', 25, 100.50, 1.75, TRUE, '1999-05-15', '19:30:00', '2024-02-08 10:00:00');


-- ====================================================================
-- SQL DML: Inserção em Massa / Bloco (Bulk Insert de Alta Performance)
-- ====================================================================

INSERT INTO aluno (nome, cpf, observacao, idade, dinheiro, altura, ativo, data_nascimento, hora_aula, matriculado_em) 
VALUES 
('Diogo', '12345678901', 'Aluno matriculado no módulo 1', 35, 100.50, 1.81, TRUE, '1989-02-10', '17:30:00', '2024-02-08 10:10:00'),
('Vinícius', '98765432100', 'Aluno transferido de outra unidade', 22, 250.00, 1.75, TRUE, '2002-11-20', '19:00:00', '2024-02-08 11:30:00'),
('Nico', '11122233344', 'Interesse em cursos avançados', 28, 50.00, 1.70, FALSE, '1996-07-05', '08:00:00', '2024-02-08 14:00:00');


-- ====================================================================
-- SQL DML: Cargas Rápidas Minimistas para Testes Estruturais
-- ====================================================================

INSERT INTO aluno (nome) 
VALUES 
('Vinícius Dias'), 
('Nico Steppat'), 
('João Roberto'), 
('Diego');
