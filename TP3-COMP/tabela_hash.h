#ifndef tabela_hash
#define tabela_hash
#endif

#define M 150
typedef struct {
    char *tipo; 
    int escopo; 
    int has_value; 
    char *id;
    char *valor; 
} Entidade; // 

typedef struct no {
    Entidade entidade;
    struct no *proximo;
} No;

typedef struct {
    No *inicio;
    int tam;
} Lista;

// Criando a Tabela Hash
Lista *tabela[M];
int escopoGlobal = 0;

Entidade criarEntidade (char *tipo, char *id);
void imprimirEntidade(Entidade entidade);
Lista* criarListaVazia();
void inserirInicio(Entidade entidade, Lista *lista);
No* buscarEntidade(char *id, int escopo, No *inicio); // do v1 escopo = 0 if (vasdas) {do v1; v1 = 1} escopo = 1
void imprimirLista(No *inicio);
void inicializarTabela();
int hashing(char *id); /// A gente vai converter o id para sua soma de inteiros. ASCII.
void insereTabela(char *tipo, char *id);
Entidade* buscarEntidadeTabela(char *id, int escopo); // v1 1 
void editaEntidade (char *id, int escopo, char *value);
void imprimirTabela();
void incrementaEscopo();
void decrementaEscopo();
// Estou mudando o nome das funções.  Verificar no .c depois.
 
