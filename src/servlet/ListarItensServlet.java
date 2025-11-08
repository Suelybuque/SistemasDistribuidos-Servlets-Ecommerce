package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelo.Equipamento; // Importa o Model modelo.Equipamento

/**
 * Servlet responsável por inicializar a base de dados dinâmica (Map)
 * e listar o catálogo de equipamentos.
 */

public class ListarItensServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // A 'base de dados' dinâmica: Map estático compartilhado.
    // Key: ID do equipamento (String), Value: modelo.Equipamento
    private static Map<String, Equipamento> catalogoEquipamentos;

    /**
     * Método init() - Executado uma única vez na inicialização da Servlet.
     * Utilizado para popular o catálogo, simulando a leitura de uma base de dados.
     */
    @Override
    public void init() throws ServletException {
        super.init();

        // Inicializa o Map e cria as instâncias de modelo.Equipamento
        catalogoEquipamentos = new HashMap<>();

        // Criação das instâncias dos equipamentos (Dados Fictícios)
        catalogoEquipamentos.put("CPU001", new Equipamento("CPU001", "Desktop Workstation", "Processador i7, 32GB RAM, SSD 1TB", 35000.00, 15));
        catalogoEquipamentos.put("LAP005", new Equipamento("LAP005", "Notebook Ultra-fino", "Core i5, 8GB RAM, Leve e Portátil", 18500.00, 25));
        catalogoEquipamentos.put("MON010", new Equipamento("MON010", "Monitor LED 27 polegadas", "Resolução 4K, ideal para design", 7200.00, 50));
        catalogoEquipamentos.put("ROU022", new Equipamento("ROU022", "Roteador Gigabit Dual Band", "Alta velocidade e cobertura para empresas", 2100.00, 10));

        // Armazena o catálogo no contexto da aplicação (ServletContext) para que
        // a ConfirmarCompraServlet também possa acessá-lo.
        getServletContext().setAttribute("catalogo", catalogoEquipamentos);

        System.out.println("Catálogo de Equipamentos inicializado no Contexto da Aplicação.");
    }

    /**
     * Método doGet() - Responsável por listar os itens do catálogo
     * e encaminhar o usuário para a página de visualização.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Recupera o catálogo do contexto (onde foi armazenado no init())
        Map<String, Equipamento> catalogo = (Map<String, Equipamento>)
                getServletContext().getAttribute("catalogo");

        // 2. Define o catálogo como um atributo da requisição
        request.setAttribute("equipamentos", catalogo.values());

        // 3. Encaminha a requisição para a página HTML/JSP do catálogo
        // O Forward é crucial, pois mantém o objeto 'request' e seus atributos.
        request.getRequestDispatcher("/catalogo.jsp").forward(request, response);
    }
}
