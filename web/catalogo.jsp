<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="modelo.Equipamento" %>
<%@ page import="java.text.NumberFormat" %>
<%
    // Recupera a lista de equipamentos que foi colocada na requisição pela Servlet
    Collection<Equipamento> equipamentos = (Collection<Equipamento>) request.getAttribute("equipamentos");
    // Formato de moeda para exibição
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new java.util.Locale("pt", "MZ"));
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Equipamentos de TI</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #e9ecef; color: #333; padding: 20px; }
        .container { max-width: 1000px; margin: 0 auto; background-color: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h1 { color: #007bff; text-align: center; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f8f9fa; color: #495057; font-weight: 600; }
        tr:hover { background-color: #f1f1f1; }
        .buy-button {
            display: inline-block;
            padding: 8px 15px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 0.9em;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .buy-button:hover { background-color: #1e7e34; }
        .stock-low { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Catálogo de Equipamentos de TI (Nampula)</h1>
        <p>Preços em meticais (MT). Clique em "Comprar" para preencher o formulário de pedido e entrega.</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Descrição</th>
                    <th>Preço (MT)</th>
                    <th>Estoque</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
                <% if (equipamentos != null) {
                    for (Equipamento equipamento : equipamentos) {
                %>
                    <tr>
                        <td><%= equipamento.getId() %></td>
                        <td><strong><%= equipamento.getNome() %></strong></td>
                        <td><%= equipamento.getDescricao() %></td>
                        <td><%= currencyFormat.format(equipamento.getPreco()) %></td>
                        <td class="<%= equipamento.getQuantidadeEmEstoque() < 10 ? "stock-low" : "" %>">
                            <%= equipamento.getQuantidadeEmEstoque() %>
                        </td>
                        <td>
                            <!-- O link 'Comprar' levará ao formulário de compra (próximo passo) -->
                            <a href="form_compra.jsp?id=<%= equipamento.getId() %>" class="buy-button">
                                Comprar
                            </a>
                        </td>
                    </tr>
                <%  }
                } else { %>
                    <tr>
                        <td colspan="6">Nenhum equipamento encontrado no catálogo.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <p style="text-align: center;"><a href="index.html" style="color: #007bff;">Voltar à Página Inicial</a></p>
    </div>
</body>
</html>
