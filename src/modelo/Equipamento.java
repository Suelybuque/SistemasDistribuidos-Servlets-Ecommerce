package modelo;

/**
 * Representa um modelo.Equipamento disponível para venda na loja.
 * Esta classe é o Model de dados da nossa aplicação.
 */
public class Equipamento {
    private String id;
    private String nome;
    private String descricao;
    private double preco;
    private int quantidadeEmEstoque; // Necessário para simular o controle de estoque

    // Construtor completo
    public Equipamento(String id, String nome, String descricao, double preco, int quantidadeEmEstoque) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.quantidadeEmEstoque = quantidadeEmEstoque;
    }

    // --- Getters e Setters ---

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public int getQuantidadeEmEstoque() {
        return quantidadeEmEstoque;
    }

    public void setQuantidadeEmEstoque(int quantidadeEmEstoque) {
        this.quantidadeEmEstoque = quantidadeEmEstoque;
    }

    /**
     * Tenta decrementar o estoque após uma compra.
     * @param quantidadeComprada A quantidade a ser removida.
     * @return true se o estoque foi atualizado com sucesso, false caso contrário (estoque insuficiente).
     */
    public boolean decrementarEstoque(int quantidadeComprada) {
        if (this.quantidadeEmEstoque >= quantidadeComprada) {
            this.quantidadeEmEstoque -= quantidadeComprada;
            return true;
        }
        return false;
    }
}
