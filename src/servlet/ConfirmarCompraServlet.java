package servlet;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelo.Equipamento;

/**
 * Servlet responsável por processar o formulário de compra (método POST),
 * confirmar os dados, atualizar o estoque (Map) e gerar a resposta final.
 */
public class ConfirmarCompraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Método doPost() - Recebe os dados do formulário de compra.
     * Este método é invocado quando o cliente clica em 'Confirmar Compra'.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Recupera o catálogo (a "base de dados" dinâmica) do contexto da aplicação.
        // O catálogo foi populado no init() da ListarItensServlet.
        Map<String, Equipamento> catalogo = (Map<String, Equipamento>)
                getServletContext().getAttribute("catalogo");

        // 2. Extrai os parâmetros obrigatórios do formulário
        String itemId = request.getParameter("itemId");
        String quantidadeStr = request.getParameter("quantidade");
        String nomeCliente = request.getParameter("nomeCliente");
        String enderecoEntrega = request.getParameter("enderecoEntrega");
        String numeroCartao = request.getParameter("numeroCartao");

        // Variável para armazenar mensagens de erro/sucesso
        String mensagem = "";
        boolean sucesso = false;

        try {
            // Conversão e Validação da Quantidade
            int quantidadeComprada = Integer.parseInt(quantidadeStr);

            // Validação de campos
            if (itemId == null || itemId.isEmpty() || nomeCliente.isEmpty() || enderecoEntrega.isEmpty() || numeroCartao.isEmpty()) {
                mensagem = "Erro: Todos os campos são obrigatórios.";
            } else if (quantidadeComprada <= 0) {
                mensagem = "Erro: A quantidade deve ser maior que zero.";
            } else if (catalogo == null || !catalogo.containsKey(itemId)) {
                mensagem = "Erro: modelo.Equipamento com ID " + itemId + " não encontrado no catálogo.";
            } else {
                Equipamento equipamento = catalogo.get(itemId);

                // 3. Verifica o estoque
                if (equipamento.getQuantidadeEmEstoque() < quantidadeComprada) {
                    mensagem = "Erro: Estoque insuficiente! Apenas " + equipamento.getQuantidadeEmEstoque() + " unidades disponíveis de " + equipamento.getNome() + ".";
                } else {
                    // 4. Lógica de Compra e Atualização do Estoque
                    equipamento.decrementarEstoque(quantidadeComprada);

                    // Monta a mensagem de sucesso
                    double valorTotal = quantidadeComprada * equipamento.getPreco();
                    mensagem = String.format(
                            "Compra Realizada com Sucesso!%n%n" +
                                    "Item: %s (x%d)%n" +
                                    "Valor Total: %.2f MT%n" +
                                    "Cliente: %s%n" +
                                    "Endereço para Entrega: %s%n" +
                                    "O seu pedido será processado e entregue em Nampula em breve. Obrigado!",
                            equipamento.getNome(),
                            quantidadeComprada,
                            valorTotal,
                            nomeCliente,
                            enderecoEntrega
                    );
                    sucesso = true;

                    // Opcional: Persistir o catalogo atualizado no contexto
                    getServletContext().setAttribute("catalogo", catalogo);
                }
            }
        } catch (NumberFormatException e) {
            mensagem = "Erro de Formato: A quantidade deve ser um número válido.";
        } catch (Exception e) {
            mensagem = "Erro inesperado ao processar a compra: " + e.getMessage();
            e.printStackTrace();
        }

        // 5. Exibe a página de resultado (Sucesso ou Erro)
        request.setAttribute("sucesso", sucesso);
        request.setAttribute("mensagem", mensagem);

        // Encaminha para a View de resultado
        request.getRequestDispatcher("/resultado_compra.jsp").forward(request, response);
    }
}
