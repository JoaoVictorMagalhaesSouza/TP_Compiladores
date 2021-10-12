#include <stdio.h>
#include <stdlib.h>
#include "tabela_hash.h"
/*Ideia: Ao abrir um "{" e "}" estamos delimitando blocos (escopo). 
Dessa forma, sempre que formos acessar uma variável posteriormente, acessaremos de acordo a variavel global "escopo".
Por exemplo: int a = 2; if (1) {a = 3;} Aqui temos o escopo global (a=2) e o escopo local(a=3).
Enquanto estivermos dentro de if(1), nossa variavel global vale 1. Depois de saírmos, ela vale 0.

Sintetizando:
	1) Variável "escopo" começa em 0.
	2) Ao identificarmos "{" incrementamos ela via função ("incrementaEscopo");
	3) Ao identificarmos "}" decrementamos ela via função ("decrementaEscopo");
*/


// Implementações dos métodos
// cria e retorna um tipo pessoa
Entidade criarEntidade (char *tipo,  char *valor, char *id){
	Entidade e;
	e.tipo = tipo;
	e.escopo = escopoGlobal;
	e.valor = valor;
	e.id = id;
	//escopoGlobal++; O escopo está incrementando
	return e;
	
}
/*
Pessoa criarPessoa() {
    Pessoa p;
    printf("Digite o nome da pessoa: ");
    scanf("%*c");
    fgets(p.nome, 50, stdin);
    printf("Digite a matricula: ");
    scanf("%d", &p.matricula);
    return p;
}

// imprime uma pessoa
void imprimirPessoa(Pessoa p) {
    printf("\tNome: %s\tMatricula: %d\n", p.nome, p.matricula);
}

//-------------------------------- início funções lista -------------------------
// cria uma lista vazia e retorna seu endereço na memória
Lista* criarLista() {
    Lista *l = malloc(sizeof(Lista));
    l->inicio = NULL;
    l->tam = 0;
    return l;
}


    //inserir no início da lista
    //PARÂMETROS
    //p - nova pessoa a ser inserida
    //*lista - endereço de uma lista encadeada.

void inserirInicio(Pessoa p, Lista *lista) {
    No *no = malloc(sizeof(No));
    no->pessoa = p;
    no->proximo = lista->inicio;
    lista->inicio = no;
    lista->tam++;
}

// busca um elemento na lista
Lista* buscarNo(int mat, No *inicio) {

    while(inicio != NULL) {
        if(inicio->pessoa.matricula == mat)
            return inicio;
        else
            inicio = inicio->proximo;
    }
    return NULL;// matricula não encontrada
}

void imprimirLista(No *inicio) {
    while(inicio != NULL) {
        imprimirPessoa(inicio->pessoa);
        inicio = inicio->proximo;
    }
}
//---------------------------------- fim funções lista -------------------------

//--------------------------- início funções tabela hash -----------------------
// inicializa a tabela com uma lista vazia em cada posição do vetor
void inicializar(){
    int i;
    for(i = 0; i < M; i++)
        tabela[i] = criarLista();
}

// função de espalhamento
int funcaoEspalhamento(int mat){
    return mat % M;
}

// cria uma pessoa e a insere na tabela
void inserTabela(){
    Pessoa pes = criarPessoa();
    int indice = funcaoEspalhamento(pes.matricula);
    inserirInicio(pes, tabela[indice]);
}

// busca uma pessoa. Seu retorno é um endereço ou NULL
Pessoa* buscarPessoaTabela(int mat){
    int indice = funcaoEspalhamento(mat);
    No *no = buscarNo(mat, tabela[indice]->inicio);
    if(no)
        return &no->pessoa;
    else
        return NULL;
}

// imprimir tabela
void imprimirTabela(){
    int i;
    printf("\n---------------------TABELA-------------------------\n");
    for(i = 0; i < M; i++){
        printf("%d Lista tamanho: %d\n", i, tabela[i]->tam);
        imprimirLista(tabela[i]->inicio);
    }
    printf("---------------------FIM TABELA-----------------------\n");
}

*/
int main() {
    Entidade e = criarEntidade("do","15","v1");
    Entidade e2 = criarEntidade("fa","+15","v2");
    printf("%s %d %s %s\n",e.tipo,e.escopo,e.valor,e.id);
    printf("%s %d %s %s\n",e2.tipo,e2.escopo,e2.valor,e2.id);
    return 0;
}
