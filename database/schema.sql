-- ====================================================================
-- TEMA: Estrutura de Armazenamento Relacional
-- CONCEITO: Criação de Tabelas e Tipos de Dados Básicos
-- OBJETIVO: Definir o esqueleto estrutural inicial onde as instâncias
--           de alunos serão persistidas no banco de dados.
--
-- MODELO DE DADOS
-- • Nível Conceitual: Entidade "Aluno" e seus atributos de identificação.
-- • Nível Lógico: Mapeamento da Entidade em Tabela Relacional com tipos (SERIAL, VARCHAR).
-- • Nível Físico: Alocação de páginas de disco no PostgreSQL para o esquema public.
--
-- CLASSIFICAÇÃO SQL
-- • DDL (Data Definition Language): CREATE TABLE, DROP TABLE (Esquemas)
-- • DML (Data Manipulation Language): Não aplicável neste arquivo
-- • DQL (Data Query Language): Não aplicável neste arquivo
-- ====================================================================

DROP TABLE IF EXISTS aluno;

CREATE TABLE aluno (
    id SERIAL, -- Gera a sequência numérica automática para as tuplas
    nome VARCHAR(255),
    cpf CHAR(11),
    observacao TEXT,
    idade INTEGER,
    dinheiro NUMERIC(10,2),
    altura REAL,
    ativo BOOLEAN,
    data_nascimento DATE,
    hora_aula TIME,
    matriculado_em TIMESTAMP
);