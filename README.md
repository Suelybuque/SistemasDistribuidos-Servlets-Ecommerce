# SistemasDistribuidos-Servlets-Ecommerce

## Trabalho Prático | Loja Online de Equipamentos com Java Servlets

Este projeto foi desenvolvido como parte da avaliação da disciplina de **Sistemas Distribuídos** e implementa um sistema básico de comércio eletrónico (E-commerce) utilizando a arquitetura de Servlets Java.

O objetivo é resolver o problema de uma empresa de TI em Nampula, criando um mecanismo tecnológico para a visualização de catálogo e processamento de compras online.

## ⚙️ Funcionalidades Implementadas

- **Listagem de Catálogo (doGet):** Um Servlet **ListalTSServlet** utiliza o método **doGet()** para carregar os dados dos equipamentos (simulados através de um **Map** no método **init()**) e gerar dinamicamente a página HTML do catálogo.

- **Formulário de Compra:** Interface HTML para recolha de todos os dados necessários (**ID do item, quantidade, nome, endereço de entrega e número de cartão**).

- **Processamento de Compra (doPost):** Um Servlet de Confirmação **ConfirmacaoCompraServlet** utiliza o método **doPost()** para receber e processar os dados submetidos pelo cliente.

## 💻 Tecnologias

- **Linguagem:** Java  
- **Componentes Web:** Servlets (**javax.servlet / jakarta.servlet**)  
- **Container Web:** Apache Tomcat  
- **Estrutura do Projeto:** Padrão Web Application (utilizando **web.xml** para mapeamento)

## 📝 Fluxograma de Dados (DFD)

O fluxo de dados detalhado (**GET para consulta, POST para transação**) pode ser encontrado no nosso relatório detalhado.



**Disciplina:** Sistemas Distribuídos  
**Data:** Outubro de 2025
