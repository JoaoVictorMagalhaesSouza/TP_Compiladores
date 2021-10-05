%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;

%}

%token TIPOS NOME_VARIAVEL EOL
%token LITERAL_PONTO_E_VIRGULA LITERAL_VIRGULA LITERAL_RECEBE
%start PROGRAMA
%%

PROGRAMA: PROGRAMA DECLARACAO EOL;
	| 
	|

NOMES: NOME_VARIAVEL|NOMES LITERAL_VIRGULA NOME_VARIAVEL; //do a,b,c ; re c,d

DECLARACAO : DECLARACAO_SEM_ATRB|DECLARACAO_COM_ATRB;

DECLARACAO_SEM_ATRB:TIPOS NOMES LITERAL_PONTO_E_VIRGULA{	
	printf("Declaracao de variavel(variaveis) sem atribuicao OK.\n");
	};
	
DECLARACAO_COM_ATRB: TIPO NOME_VARIAVEL LITERAL_RECEBE
%%	


void yyerror(char *c){
	printf("Erro : %s\n",c);
}

int main(){
	yyparse();
	return 1;

}


