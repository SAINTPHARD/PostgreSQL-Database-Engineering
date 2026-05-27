# PostgreSQL - Estudos e Práticas de CRUD

Este repositório foi desenvolvido para organizar, consolidar e documentar todo o meu aprendizado prático em bancos de dados relacionais com o **PostgreSQL**, utilizando o **pgAdmin 4** durante as aulas da Pós-Graduação na PUC-Rio.

A arquitetura do projeto foi estruturada de forma profissional, separando a definição física do banco de dados (esquema) das manipulações lógicas do cotidiano (operações de CRUD).

---

## Estrutura do Repositório

O projeto está organizado na seguinte árvore de diretórios:

```text
PostgreSQL-Estudos/
│
├── README.md           # Documentação e guia do projeto
│
├── database/
│   └── schema.sql      # Definição da estrutura do banco (DDL)
│
├── 01-crud/            # Scripts operacionais mapeados pelo ciclo CRUD
│   ├── insert.sql      # Operações de Escrita / Criação (DML - Create)
│   ├── select.sql      # Operações de Leitura / Consulta (DQL - Read)
│   ├── update.sql      # Operações de Atualização / Modificação (DML - Update)
│   └── delete.sql      # Operações de Exclusão / Remoção (DML - Delete)
│
└── imagens/            # Capturas de tela e evidências de execução das aulas