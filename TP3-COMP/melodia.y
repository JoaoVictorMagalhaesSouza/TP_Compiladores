%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;
extern int linha;

%}

%token TIPO ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO LITERAL_VIRGULA LITERAL_RECEBE
%token ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL
%token ARRAY
%start program
%%

program: commands | program commands ;

//commands: declarations | statements ;

commands: declarations;

names: variable | names LITERAL_VIRGULA variable ;

variable: ID | pointer ID | ID array ;

pointer: pointer MULOP | MULOP ;

array: array LCOLCH ICONSTANTE RCOLCH | LCOLCH ICONSTANTE RCOLCH ;

/* DECLARAÇÕES */
declarations: declarations declaration | declaration ;

declaration: TIPO declaration_names EOL //| TIPO names LITERAL_RECEBE expression 
{printf("Houve uma declaracao\n");} ;

declaration_names: declaration_variable | declaration_names LITERAL_VIRGULA declaration_variable ;

declaration_variable: ID | pointer ID | ARRAY ID array ;

/* STATEMENTS */



%%	


void yyerror(char *c){
	printf("Erro %s na linha: %d\n",c,linha);
}

int main(){
	yyparse();
	return 1;

}


