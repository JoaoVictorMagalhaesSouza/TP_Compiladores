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


Entidade criarEntidade (char *tipo, char *id, int escopoGlobal);
void imprimirEntidade(Entidade entidade);
Lista* criarListaVazia();
void inserirInicio(Entidade entidade, Lista *lista, int escopoGlobal);
No* buscarEntidade(char *id, int escopoGlobal, No *inicio); // do v1 escopo = 0 if (vasdas) {do v1; v1 = 1} escopo = 1
void imprimirLista(No *inicio);
void inicializarTabela();
int hashing(char *id); /// A gente vai converter o id para sua soma de inteiros. ASCII.
void insereTabela(char *tipo, char *id, int escopoGlobal);
Entidade* buscarEntidadeTabela(char *id, int escopoGlobal); // v1 1 
void editaEntidade (char *id, int escopoGlobal, char *value);
void exterminaEscopo (int escopo);
void imprimirTabela();
void incrementaEscopo();
void decrementaEscopo();
int analiseSemantica(char *id, char *expressio, int escopoGlobal);

// Estou mudando o nome das funções.  Verificar no .c depois.
 
