<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="modelo.Equipamento" %>
<%@ page import="java.text.NumberFormat" %>
<%
    // A chave do Map deve ser a mesma usada em ListarItensServlet ("catalogo_equipamentos")
 // 1️ Recupera o parâmetro "id" da URL
     String idEquipamentoStr = request.getParameter("id");

     // 2 Recupera o catálogo guardado no contexto da aplicação
     Map<String, Equipamento> catalogo = (Map<String, Equipamento>) application.getAttribute("catalogo");

     // 3 Procura o equipamento pelo ID
     Equipamento equipamento = null;
     if (catalogo != null && idEquipamentoStr != null) {
         equipamento = catalogo.get(idEquipamentoStr);
     }

     // 4 Configuração para formatação monetária
     NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new java.util.Locale("pt", "MZ"));
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comprar Equipamento</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; color: #333; padding: 20px; display: flex; justify-content: center; align-items: center; min-height: 100vh;}
        .container { max-width: 500px; width: 100%; background-color: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        h1 { color: #007bff; text-align: center; margin-bottom: 20px; }
        .item-detail { background-color: #e9ecef; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ced4da; }
        .item-detail p { margin: 5px 0; font-size: 0.9em; }
        .item-detail strong { font-size: 1.1em; color: #495057; }

        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        input:focus { border-color: #007bff; outline: none; box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 10px;
        }
        .btn-submit:hover { background-color: #1e7e34; transform: translateY(-1px); }
        .alert-error { color: #dc3545; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; border-radius: 6px; margin-bottom: 20px; text-align: center;}
    </style>
</head>
<body>
    <div class="container">
        <h1>Formulário de Compra e Entrega</h1>

        <% if (equipamento != null) { %>
            <div class="item-detail">
                <p>Equipamento Selecionado:</p>
                <p><strong><%= equipamento.getNome() %> (<%= equipamento.getId() %>)</strong></p>
                <p>Preço Unitário: <%= currencyFormat.format(equipamento.getPreco()) %> | Estoque: <%= equipamento.getQuantidadeEmEstoque() %></p>
            </div>

            <!-- O formulário envia os dados via POST para a URL /confirmar -->
            <form action="confirmar" method="POST">

                <!-- ID do Item (Campo oculto, mas essencial para a Servlet) -->
                <input type="hidden" name="itemId" value="<%= equipamento.getId() %>">

                <div>
                    <label for="quantidade">Quantidade a Comprar:</label>
                    <!-- Campo "quantidade" é essencial para o doPost() -->
                    <input type="number" id="quantidade" name="quantidade" required min="1" max="<%= equipamento.getQuantidadeEmEstoque() %>" value="1">
                </div>

                <div>
                    <label for="nomeCliente">Nome Completo do Cliente:</label>
                    <input type="text" id="nomeCliente" name="nomeCliente" required>
                </div>

                <div>
                    <label for="enderecoEntrega">Endereço de Entrega (Nampula):</label>
                    <input type="text" id="enderecoEntrega" name="enderecoEntrega" required placeholder="Ex: Av. Eduardo Mondlane, Casa 123">
                </div>

                <div>
                    <label for="numeroCartao">Número do Cartão (Simulação):</label>
                    <!-- Campo "número do cartão" é essencial para o doPost() -->
                    <input type="text" id="numeroCartao" name="numeroCartao" required pattern="\d{16}" title="Deve conter exatamente 16 dígitos numéricos">
                </div>

                <button type="submit" class="btn-submit">Confirmar Compra</button>
            </form>
        <% } else { %>
            <div class="alert-error">
                Equipamento não encontrado ou ID inválido. Por favor, <a href="catalogo" style="color: #9f3a46;">volte ao catálogo</a>.
            </div>
        <% } %>
    </div>
</body>
</html>