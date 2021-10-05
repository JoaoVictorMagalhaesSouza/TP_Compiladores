%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;

%}

%token TIPOS NOME_VARIAVEL EOL
%token LITERAL_PONTO_E_VIRGULA LITERAL_VIRGULA LITERAL_RECEBE
%token CONSTANTE
%start PROGRAMA
%%

PROGRAMA: PROGRAMA DECLARACAO EOL;
	|

NOMES: NOME_VARIAVEL|NOMES LITERAL_VIRGULA NOME_VARIAVEL; 

DECLARACAO : DECLARACAO_SEM_ATRB|DECLARACAO_COM_ATRB; 

DECLARACAO_SEM_ATRB:TIPOS NOMES LITERAL_PONTO_E_VIRGULA{  //do a,b,c; | re c,d; Mudar aqui depois 
	printf("Declaracao de variavel(variaveis) sem atribuicao.\n");
	};
	
DECLARACAO_COM_ATRB: TIPOS NOME_VARIAVEL LITERAL_RECEBE CONSTANTE{	// do a = 2
	printf("Declaracao de variavel(variaveis) com atribuicao.\n");
};
%%	


void yyerror(char *c){
	printf("Erro : %s\n",c);
}

int main(){
	yyparse();
	return 1;

}


