<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Recupera os atributos definidos pela ConfirmarCompraServlet
    Boolean sucesso = (Boolean) request.getAttribute("sucesso");
    String mensagem = (String) request.getAttribute("mensagem");

    // Define cores e ícones com base no sucesso
    String corFundo = sucesso != null && sucesso ? "#d4edda" : "#f8d7da";
    String corBorda = sucesso != null && sucesso ? "#c3e6cb" : "#f5c6cb";
    String corTexto = sucesso != null && sucesso ? "#155724" : "#721c24";
    String titulo = sucesso != null && sucesso ? "Sucesso na Compra!" : "Erro na Compra!";
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= titulo %></title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; color: #333; padding: 20px; display: flex; justify-content: center; align-items: center; min-height: 100vh;}
        .result-box {
            max-width: 600px;
            width: 100%;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            text-align: center;
            background-color: <%= corFundo %>;
            border: 1px solid <%= corBorda %>;
        }
        h1 { color: <%= corTexto %>; margin-bottom: 20px; font-size: 1.8em; }
        pre {
            white-space: pre-wrap; /* Mantém a formatação com quebras de linha */
            text-align: left;
            padding: 15px;
            border-radius: 6px;
            background-color: rgba(255, 255, 255, 0.7);
            border: 1px dashed <%= corTexto %>;
            color: #333;
            margin-bottom: 30px;
        }
        .action-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 1em;
            transition: background-color 0.3s;
        }
        .action-link:hover { background-color: #0056b3; }

        .stock-check-link {
            margin-top: 15px;
            display: block;
            color: #555;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="result-box">
        <h1><%= titulo %></h1>

        <!-- Exibe a mensagem formatada pela Servlet -->
        <pre><%= mensagem %></pre>

        <a href="index.html" class="action-link">Voltar à Página Inicial</a>

        <% if (sucesso != null && sucesso) { %>
            <!-- Se a compra foi bem sucedida, sugere verificar o catálogo atualizado -->
            <a href="catalogo" class="stock-check-link">Verificar o estoque atualizado</a>
        <% } %>
    </div>
</body>
</html>
