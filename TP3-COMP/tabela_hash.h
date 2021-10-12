#ifndef tabela_hash
#define tabela_hash
#endif

#define M 9999
typedef struct {
    char *tipo; //do
    int escopo; // 1,2,3
    char *id;
    char *valor; // = 4 // podemos usar atoi() e atof() depois para converter esse valor.
} Entidade; // 

typedef struct no {
    Entidade e;
    struct no *proximo;
} No;

typedef struct {
    No *inicio;
    int tam;
} Lista;

// Criando a Tabela Hash
Lista *tabela[M];
int escopoGlobal = 0;

Entidade criarEntidade (char *tipo, char *valor, char *id);
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
void incrementaEscopo();
void decrementaEscopo();
// Estou mudando o nome das funções.  Verificar no .c depois.
 
