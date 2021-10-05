%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;

%}

%token TIPOS NOME_VARIAVEL EOL
%token PONTO_VIRGULA VIRGULA
%start PROGRAMA
%%

PROGRAMA: PROGRAMA DECLARACAO EOL;
	|

NOMES: NOME_VARIAVEL|NOMES VIRGULA NOME_VARIAVEL;
DECLARACAO:TIPOS NOMES PONTO_VIRGULA{	
	printf("Declaracao de variavel(variaveis) sem atribuicao OK.\n");
	};
%%	


void yyerror(char *c){
	printf("Erro : %s\n",c);
}

int main(){
	yyparse();
	return 1;

}


