#ifndef tabela_hash.h
#define tabela_hash.h
#define M 9999
typedef struct {
    char *tipo; //do
    int escopo; // 1,2,3
    char *id;
    char *valor; // = 4
} Entidade; // 

typedef struct no {
    TAD tad;
    struct no *proximo;
} No;

typedef struct {
    No *inicio;
    int tam;
} Lista;

// Criando a Tabela Hash
Lista *tabela[M];


Entidade criarEntidade (char *tipo, int escopo, char *valor);
void imprimirEntidade(Entidade entidade);
Lista* criarListaVazia();
void inserirInicio(Entidade entidade, Lista *lista);
Lista* buscarEntidade(int id, No *inicio);
void imprimirLista(No *inicio);
void inicializarTabela();
int hashing(int id); /// A gente vai converter o id para sua soma de inteiros. ASCII.
void insereTabela();
Entidade* buscarEntidadeTabela(int id);
void imprimirTabela();
// Estou mudando o nome das funções.  Verificar no .c depois.
 



#endif
