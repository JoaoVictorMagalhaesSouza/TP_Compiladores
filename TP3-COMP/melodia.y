%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;

%}

%token TIPOS NOME_VARIAVEL EOL

%%

PROGRAMA: PROGRAMA DECLARACAO EOL;
	|

DECLARACAO:
	TIPOS NOME_VARIAVEL{
	
	
	
	printf("Declaracao de variavel sem atribuicao OK.\n");
	}
%%	


void yyerror(char *c){
	printf("Erro : %s\n",c);
}

int main(){
	yyparse();
	return 1;

}


