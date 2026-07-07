-- ====================================================================
-- TEMA: Recuperação, Filtragem e Projeção de Dados
-- [CRUD] -> R: READ (Consulta de Dados)
-- CONCEITO: Operadores de Comparação, Predicados de Texto e Apelidos (Aliases)
-- OBJETIVO: Demonstrar técnicas avançadas de extração de relatórios e 
--           segmentação de informações baseadas na tupla "Aluno".
--
-- MODELO DE DADOS
-- • Nível Conceitual: Consulta de dados cadastrais e filtragem de perfis de alunos.
-- • Nível Lógico: Restrição de linhas (Seleção) e limitação de colunas (Projeção) sobre a tabela pai.
-- • Nível Físico: Execução de Query Plans (Planos de Busca) com varredura sequencial (Seq Scan).
--
-- CLASSIFICAÇÃO SQL
-- • DDL: Não aplicável (O esquema estrutural já foi definido anteriormente).
-- • DML: Não aplicável (Não há mutação ou alteração do estado das instâncias).
-- • DQL: SELECT, WHERE, LIKE, AS (Operações puras de consulta e projeção de visões).
-- ====================================================================

-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Projeção de Atributos com Apelidos Relacionais (Aliases)
-- ====================================================================

-- AS (DQL): Define uma "etiqueta" temporária para a coluna na projeção final, limpando o resultado visual.
SELECT nome, idade, matriculado_em AS quando_se_matriculou FROM aluno;


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Seleção por Predicados de Igualdade e Diferença Lógica
-- ====================================================================

-- WHERE = (DQL): Restringe a consulta filtrando apenas a instância com correspondência exata.
SELECT * FROM aluno WHERE nome = 'Diogo';

-- WHERE <> (DQL): Operador ANSI padrão para exclusão lógica (traz todos, exceto o termo especificado).
SELECT * FROM aluno WHERE nome <> 'Diogo';


-- ====================================================================
-- COMPONENTE: SQL DQL (Data Query Language)
-- FOCO: Seleção por Correspondência Parcial (Pattern Matching)
-- ====================================================================

-- LIKE _ (DQL): O caractere curinga "underline" substitui exatamente UM caractere qualquer na string.
SELECT * FROM aluno WHERE nome LIKE '_iogo';

-- LIKE % (DQL): O caractere curinga "porcentagem" substitui ZERO ou MAIS caracteres na string.
-- Busca instâncias cujo atributo textual inicie estritamente com a letra 'D'.
SELECT * FROM aluno WHERE nome LIKE 'D%';

-- Busca instâncias cujo atributo textual termine estritamente com a letra 's'.
SELECT * FROM aluno WHERE nome LIKE '%s';

-- Busca instâncias que possuam a sequência de caracteres informada em qualquer parte da string.
SELECT * FROM aluno WHERE nome LIKE '%i%a';