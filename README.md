# PostgreSQL - Laboratório de Banco de Dados Relacional

[cite_start]Este repositório foi desenvolvido para consolidar, organizar e documentar a implementação prática de modelação de bases de dados relacionais, manipulação estruturada de dados (CRUD) e otimização de consultas utilizando o **PostgreSQL** e o **pgAdmin 4**.

O projeto foi estruturado como um laboratório pessoal para consolidar conhecimentos em bancos de dados relacionais, documentar boas práticas e servir como referência para futuras implementações e estudos na área de engenharia de dados e desenvolvimento de software.

[cite_start]A arquitetura do projeto separa estritamente a definição física da base de dados (esquema DDL) das manipulações lógicas, filtros e associações complexas (DML/DQL).

---

##  Objetivos da Iniciativa

* [cite_start]**Modelação Relacional Avançada:** Aplicação de técnicas de normalização de tabelas, chaves primárias compostas e chaves estrangeiras.

* [cite_start]**Consistência na Infraestrutura:** Utilização de restrições físicas nativas no PostgreSQL (`NOT NULL`, `UNIQUE`, `CHECK`) para blindar as regras de negócio antes que estas cheguem à aplicação.

* [cite_start]**Domínio do Ciclo CRUD:** Implementação de transações eficientes de criação, leitura, atualização e eliminação lógica/física de dados.

* [cite_start]**Cruzamento Complexo de Dados (JOINs):** Unificação de fontes de dados utilizando múltiplos tipos de junções para relatórios e pesquisas de alta performance.

* [cite_start]**Alinhamento com o Ecossistema Java:** Compreensão de como a modelação física interage com mapeamentos ORM, prevenindo gargalos clássicos de desempenho.

---

##  Estrutura do Projeto

O diretório do projeto foi estruturado de forma modular para demonstração de boas práticas de organização:

```text
postgresql-Database-Engineering/
│
[cite_start]├── README.md               # Documentação técnica e guia do ecossistema 
│
├── database/
[cite_start]│   └── schema.sql          # Estruturação e definição física das tabelas (DDL) 
│
[cite_start]├── 01-crud/                # Ciclo de vida operacional dos dados (DML/DQL) 
[cite_start]│   ├── insert.sql          # Transações de escrita e persistência (Create) 
[cite_start]│   ├── select.sql          # Consultas básicas e leitura de dados (Read) 
[cite_start]│   ├── update.sql          # Modificação e atualização de estados (Update) 
[cite_start]│   └── delete.sql          # Limpeza e eliminações de dados (Delete) 
│
[cite_start]├── 02-filtros/             # Segmentação e filtros de pesquisa 
[cite_start]│   ├── where.sql           # Cláusulas de restrição lógica condicional 
[cite_start]│   ├── like.sql            # Buscas de texto aproximadas 
[cite_start]│   └── operadores.sql      # Operadores relacionais e lógicos
│
[cite_start]├── 03-modelagem/           # Arquitetura e restrições estruturais das tabelas 
[cite_start]│   ├── primary-key.sql     # Definição e unicidade física de registos 
[cite_start]│   ├── foreign-key.sql     # Integridade referencial entre entidades 
[cite_start]│   └── relacionamento-n-n.sql # Resolução de tabelas associativas 
│
[cite_start]└── imagens/                # Evidências e capturas de ecrã das execuções técnicas

 
Tecnologias Utilizadas
	* SGBD: PostgreSQL 
	* Interface: pgAdmin 4 
	* Linguagem: SQL (ANSI & Dialeto PostgreSQL) 
	* Controle de Versão: Git & GitHub 
	
Conceitos Praticados
	
	1. Modelagem e Integridade de Dados.
		Restrições Estruturais: Definição física de PRIMARY KEY e integridade referencial robusta por meio de FOREIGN KEY.
		Consistência de Esquema: Aplicação de restrições rígidas usando NOT NULL e UNIQUE.
		Estruturas de Associação: Resolução física de relacionamentos Muitos-para-Muitos (N:N) e manutenção de Integridade Referencial.
	
	2. Manipulação de Dados (CRUD.
		Transações: Fluxos de persistência (INSERT), 
		Consultas e leituras (SELECT), 
		Atualizações de estados (UPDATE) e 
		Remoções físicas (DELETE).
	
	3. Filtros e Consultas Avançadas.
		Cláusulas Condicionais: Filtragem de registros via WHERE.
		Pattern Matching: Buscas textuais aproximadas estruturadas com LIKE e NOT LIKE.
		Expressões Lógicas: Utilização de Operadores Relacionais, Operadores Lógicos e organização de colunas com Alias (AS).
	
	4. Operações de Junção (JOINs. 
		INNER JOIN: Recuperação de dados com correspondência estrita.
		LEFT JOIN: Preservação completa da entidade da esquerda com dados opcionais na direita.
		RIGHT JOIN: Preservação completa da entidade da direita.
		FULL JOIN: Junção total para auditoria e mapeamento de dados órfãos.
		CROSS JOIN: Produto cartesiano para cruzamento de matrizes completas de dados.☕ Relação com o Ecossistema JavaOs conceitos praticados neste repositório possuem aplicação direta no desenvolvimento de APIs e sistemas backend utilizando Spring Boot, Spring Data JPA e Hibernate.Abaixo está o mapeamento conceitual entre as tecnologias:PostgreSQL (Camada Física)Java / JPA (Camada Lógica)Finalidade TécnicaPRIMARY KEY@IdIdentificador único da entidade em memória.SERIAL / BIGSERIAL@GeneratedValueDelegação da estratégia de autoincremento para o banco.FOREIGN KEY@JoinColumnMapeamento físico da chave de relacionamento.JOIN / INNER JOINRelacionamentos entre EntidadesCruzamento de dados de tabelas relacionadas.Tabela Associativa@ManyToManyEstrutura física intermediária para associar registros N:N.aluno_curso@JoinTableCustomização e mapeamento lógico da tabela associativa.Estes conceitos são fundamentais para a construção de aplicações escaláveis, consistentes e bem estruturadas.🚀 Como Executar1. Criar o Banco de DadosInstancie e execute o serviço do PostgreSQL localmente ou em um container Docker.2. Executar o Script de EstruturaExecute o script de criação física do esquema para erguer as tabelas e relacionamentos:Bashdatabase/schema.sql

3. Executar os Exemplos: 
	Navegue pelas pastas e execute os scripts operacionais de forma sequencial de acordo com o assunto desejado:
		01-crud/: Transações básicas do ciclo de vida dos dados.
		02-filtros/: Condicionais e formatação de buscas textuais.
		03-modelagem/: Compreensão e testes das restrições e relacionamentos estruturais.
	A execução sequencial permite acompanhar perfeitamente a evolução dos conceitos e compreender a aplicação prática de cada recurso. 
	
	Habilidades Desenvolvidas : 
		Este projeto contribui para a consolidação e demonstração prática de competências em:
			Engenharia de Consultas SQL e SGBD PostgreSQL
			Modelagem Relacional e Garantia de Integridade de Dados
			Arquitetura de Software Backend voltada à integração com Spring Data JPA e Hibernate
			Versionamento profissional de código com Git & GitHub
			Escrita de Documentação Técnica e Organização Estruturada de Projetos 
	