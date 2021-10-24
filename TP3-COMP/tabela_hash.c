#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabela_hash.h"
/*Ideia: Ao abrir um "{" e "}" estamos delimitando blocos (escopo). 
Dessa forma, sempre que formos acessar uma variável posteriormente, acessaremos de acordo a variavel global "escopo".
Por exemplo: int a = 2; if (1) {a = 3;} Aqui temos o escopo global (a=2) e o escopo local(a=3).
Enquanto estivermos dentro de if(1), nossa variavel global vale 1. Depois de saírmos, ela vale 0.

Sintetizando:
	1) Variável "escopo" começa em 0.
	2) Ao identificarmos o token"{" incrementamos ela(escopo) via função ("incrementaEscopo");
	3) Ao identificarmos o token "}" decrementamos ela via função ("decrementaEscopo");
*/
// do a ;


// Implementações dos métodos
// cria e retorna um tipo pessoa
Entidade criarEntidade (char *tipo, char *id, int escopoGlobal){
	Entidade e;
	e.tipo = tipo;
	e.escopo = escopoGlobal; 
	e.has_value = 0;
	e.valor = NULL; // Inicialmente as variaveis não possuem valors
	e.id = id;
	//escopoGlobal++; O escopo está incrementando
	return e;
	
}



// imprime uma Entidade
void imprimirEntidade(Entidade e){
    printf("* ID:%s \t | \t Tipo:%s \t | \t Valor:%s \t | \t Escopo:%d *\n",e.id,e.tipo,e.valor,e.escopo);
}

//-------------------------------- início funções lista -------------------------
// cria uma lista vazia e retorna seu endereço na memória
Lista* criarListaVazia() {
    Lista *l = malloc(sizeof(Lista));
    l->inicio = NULL;
    l->tam = 0;
    return l;
}


    //inserir no início da lista
    //PARÂMETROS
    //p - nova pessoa a ser inserida
    //*lista - endereço de uma lista encadeada.

void inserirInicio(Entidade e, Lista *lista, int escopoGlobal) {
    No *no = malloc(sizeof(No));
    no->entidade = e;
    no->proximo = lista->inicio;
    lista->inicio = no;
    lista->tam++; // Contabilizando o tamanho da lista.
}

// busca um elemento na lista
No* buscarEntidade(char* id, int escopo, No *inicio) {

    while(inicio != NULL) {
    	//printf("%d == %d ?          %s == %s?\n",inicio->entidade.escopo,escopo,inicio->entidade.id,id);
        if((inicio->entidade.escopo == escopo) && (strcmp(id,inicio->entidade.id)==0)){
        	
            return inicio;
            }
        else{
        	
        	
            inicio = inicio->proximo;
            
            }
    }
    return NULL;// entidade não encontrada
}
void exterminaEscopo (int escopo){
	int i;
	//Lista *aux;
	No *noaux;
	for (i=0;i<150;i++){
		noaux = tabela[i]->inicio;
		while (noaux != NULL){
			if (noaux->entidade.escopo == escopo) noaux->entidade.id = "";		
		noaux = noaux->proximo;
		}
				
	}


}

void imprimirLista(No *inicio) {
    while(inicio != NULL) {
        imprimirEntidade(inicio->entidade);
        inicio = inicio->proximo;
    }
}

//---------------------------------- fim funções lista -------------------------

//--------------------------- início funções tabela hash -----------------------
// inicializa a tabela com uma lista vazia em cada posição do vetor
void inicializarTabela(){
    int i;
    for(i = 0; i < M; i++)
        tabela[i] = criarListaVazia();
}

// função de espalhamento
int hashing(char *id){
    int ID_int = 0;
    int aux;
    int i;
    for (i=0; i<strlen(id);i++){
    	aux = id[i];
    	ID_int += aux;
    }
    return ID_int % M;
}

// cria uma entidade e a insere na tabela
void insereTabela(char *tipo, char *id, int escopoGlobal){ // do a
    Entidade e1 = criarEntidade(tipo,id,escopoGlobal);
    int indice = hashing(e1.id);
    inserirInicio(e1, tabela[indice], escopoGlobal);
}

// busca uma entidade. Seu retorno é um endereço ou NULL
Entidade* buscarEntidadeTabela(char *id, int escopo){
    int indice = hashing(id);
    printf("Index: %d\n",indice);
    int escopoAux;
    escopoAux = escopo;
    // Procurando uma variavel em todos os escopos menores que o atual.
    while (escopoAux >= 0){
    	printf("%d %s\n",escopoAux,id);
    	No *no = buscarEntidade(id,escopoAux, tabela[indice]->inicio);
    	printf("Escopo de busca: %d\n",escopoAux);
    	if(no)
        	return &no->entidade;
        else
        	escopoAux--;
    }
     return NULL;
}

// imprimir tabela
void imprimirTabela(){
    int i;
    printf("\n| ----------------------- TABELA DE SIMBOLOS ---------------------------- |\n");
    for(i = 0; i < M; i++){
        //printf("%d Lista tamanho: %d\n", i, tabela[i]->tam);
        imprimirLista(tabela[i]->inicio);
    }
    printf("| ----------------------------- FIM TABELA --------------------------------- |\n");
}
void editaEntidade (char *id, int escopo, char *value){
	
	
	Entidade *aux = buscarEntidadeTabela(id,escopo);

	if (aux){		
		aux->valor = value;
		aux->has_value = 1;
	
	}
	

}
// do a;
// ensaio (a>b) { do b; a=1;} -> percorre a lista e id = null p/ todos os caras daquele escopo
// do c;
// ensaio (b>c) { b = 1; } 

// 1o - Pesquisar se tá na tabela;
// 2o - Se tiver, modifica;
	


/*
int main() {
    //Entidade e = criarEntidade("do","15","v1");
    //Entidade e2 = criarEntidade("fa","+15","v2");
    //printf("Tipo da variavel:%s Escopo:%d Valor:%s ID:%s\n",e.tipo,e.escopo,e.valor,e.id);
    //printf("Tipo da variavel:%s Escopo:%d Valor:%s ID:%s\n",e2.tipo,e2.escopo,e2.valor,e2.id);
    //imprimirEntidade(e);
    //imprimirEntidade(e2);
    
    int op;
    char id[100];
    //char valor[100];
    char tipo[100];
    char value[100];
    Entidade *e;
    Lista *lista;
    inicializarTabela();
    int escopo_aux;
    char id_aux[100];
   
    do {
        printf("\n0 - Sair\n1 - Inserir\n2 - Buscar\n3 - Editar\n4 - Imprimir tabela\n");
        scanf("%d", &op);
        switch(op) {
        case 0:
            printf("saindo...\n");
            break;
        case 1:
            printf("Digite o ID: ");
            scanf("%s",id);
            //scanf("%s",valor);
            printf("Digite o tipo: ");
            scanf("%s",tipo);
            insereTabela(tipo,id);
            break;
        case 2:
            printf("Qual o ID e escopo a ser buscado ? \n");
            scanf("%s",id_aux);
            scanf("%d", &escopo_aux);
            
            e = buscarEntidadeTabela(id_aux,escopo_aux);
            if(e) {
                printf("Entidade encontrada: ID: %s\t Escopo: %d\t Valor: %s\n", e->id, e->escopo, e->valor);
                //imprimirLista(lista);
            } else
                printf("Entidade nao contrada!\n");
            break;
        case 3:
             printf("Digite o ID: ");
             scanf("%s",id_aux);
             printf("Digite o escopo: ");
             scanf("%d", &escopo_aux);
             printf("Digite o novo valor: ");
             scanf("%s",value);
             editaEntidade(id_aux,escopo_aux,value);
             break;
             
             
        	
        case 4:
            imprimirTabela();
            break;
        default:
            printf("Opcao invalida!\n");
        }
    } while(op != 0);
	
	
    return 0;
}
*/

