%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;
extern int linha;

%}

%token TIPO ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO LITERAL_VIRGULA LITERAL_RECEBE
%token ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL

%start program
%%

//program: declarations statements ;

/*FORMA CORRETA (ACHO): dessa forma podemos ter declaracoes e statementes (comandos) sem ter que ter só declarações no começo

program: commands ;
command: declarations | statements

*/

program: declarations ; //adicionar statements na frente do declarations, mas ai temos o problema relatado em [1] (comentário da linha 37)

declarations: declarations declaration | declaration ;

declaration: TIPO names EOL {printf("Houve uma declaracao\n");} ;

names: variable | names LITERAL_VIRGULA variable ;

variable: ID | pointer ID ; // | ID array ;

pointer: pointer MULOP | MULOP ;

/// Continuar em statements e array (verificar a forma de fazer):
/// [1] Depois fazer alterações necessarias: da forma que está podemos apenas fazer declarações no começo (faz todas delcarações, depois os comandos/statements) 
;

/*
programa: programa declaracao EOL;
	|

constante: ICONSTANTE|FCONSTANTE|STRING;
nomes: ID|nomes LITERAL_VIRGULA ID; 

declaracao : declaracao_sem_atrb|declaracao_com_atrb; 
declaracao_sem_atrb:TIPOS nomes LITERAL_PONTO_E_VIRGULA{  //do a,b,c; | re c,d; Mudar aqui depois 
	printf("Declaracao de variavel(variaveis) sem atribuicao.\n");
	};
declaracao_com_atrb: TIPOS ID LITERAL_RECEBE constante{	// do a = 2
	printf("Declaracao de variavel(variaveis) com atribuicao.\n");
};*/
%%	


void yyerror(char *c){
	printf("Erro %s na linha: %d\n",c,linha);
}

int main(){
	yyparse();
	return 1;

}


