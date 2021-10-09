%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;
extern int linha;

%}

%token TIPO ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO LITERAL_VIRGULA LITERAL_RECEBE
%token ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL ACORDE POWOP RESTOP



%left ID ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP ACORDE POWOP RESTOP






%start program
%%


program: commands|program commands;

commands: declarations | statements ;

//commands: declarations;

//names: variable | names LITERAL_VIRGULA variable ;

variable: ID | pointer ID | ID array  {printf("VARIAVEL identificada\n");};

pointer: pointer MULOP | MULOP ;

array: array LCOLCH ICONSTANTE RCOLCH | LCOLCH ICONSTANTE RCOLCH ;//{printf("arriei\n");};

/* DECLARAÇÕES */

declarations:  declaration declarations| declaration;

declaration: TIPO declaration_names LITERAL_PONTO_E_VIRGULA
{printf("Houve uma declaracao\n");};


declaration_names: declaration_variable|declaration_names LITERAL_VIRGULA declaration_variable;

declaration_variable: ID|ACORDE ID array|pointer ID ;

/* EXPRESSIONS */
expression:
	variable|
    sign constant|
    expression POWOP expression|    
    expression MULOP expression|
    expression DIVOP expression|
    expression ADDOP expression|
    expression INCR|
    INCR expression|
    expression OROP expression|
    expression ANDOP expression|    
    expression RESTOP expression|
    NOTOP expression|
    expression EQOP expression|
    expression RELOP expression| 
    LPAREN expression RPAREN
    
    {printf("EXPRESSION reconhecida.\n");}
    
;
constant: ICONSTANTE|FCONSTANTE ;//{printf("CONSTANT reconhecida.\n");};

sign: ADDOP|;//{printf("SIGN reconhecida.\n");}; 
/* STATEMENTS */

// MUITAS REDUCOES AQUi
statements: statements statement| statement ;

statement:
    if_statement | for_statement | while_statement | assigment |
    CONTINUE LITERAL_PONTO_E_VIRGULA | BREAK LITERAL_PONTO_E_VIRGULA | RETURN LITERAL_PONTO_E_VIRGULA
    //{printf("STATEMENT reconhecido\n");}
;

if_statement: IF LPAREN expression RPAREN tail else_if_part else_part {printf("BLOCO IF\n");};

else_if_part: 
    else_if_part ELSE IF LPAREN expression RPAREN tail  |
    ELSE IF LPAREN expression RPAREN tail  |
    /* empty */
; 
else_part: ELSE tail | /* empty */ ; 

for_statement: FOR LPAREN expression LITERAL_PONTO_E_VIRGULA expression LITERAL_PONTO_E_VIRGULA expression RPAREN tail ;

while_statement: WHILE LPAREN expression RPAREN tail ;

tail: statement | LCHAV statements RCHAV{printf("TAIL reconhecido\n");};

assigment: variable LITERAL_RECEBE expression LITERAL_PONTO_E_VIRGULA{printf("ASSIGNMENT reconhecido\n");}; 

// ensaio (2>3) a = 3
%%	


void yyerror(char *c){
	printf("Erro %s na linha: %d\n",c,linha);
}

int main(){
	yyparse();
	return 1;

}


