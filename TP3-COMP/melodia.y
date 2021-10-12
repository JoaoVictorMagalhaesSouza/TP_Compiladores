%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
char *s;
extern int linha;

%}

%token TIPO ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO LITERAL_VIRGULA LITERAL_RECEBE PLAY
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

declarations:  declaration declarations| declaration ;

declaration: TIPO declaration_names LITERAL_PONTO_E_VIRGULA |function_def
{printf("Houve uma declaracao\n");};


declaration_names: declaration_variable|declaration_names LITERAL_VIRGULA declaration_variable;

declaration_variable: ID|ACORDE ID array|pointer ID ;

declaration_args: TIPO ID ;

argument_list: declaration_args LITERAL_VIRGULA argument_list | declaration_args |;

expression_list: expression LITERAL_VIRGULA expression_list | expression | ;

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
    LPAREN expression RPAREN |
    function_call|
    casting

    
    {printf("EXPRESSION reconhecida.\n");}
    
;

constant: ICONSTANTE|FCONSTANTE ;//{printf("CONSTANT reconhecida.\n");};

sign: ADDOP|;//{printf("SIGN reconhecida.\n");}; 
/* STATEMENTS */

// MUITAS REDUCOES AQUi
//statements: statements statement|statement ;
statements: statement statements_;
statements_: statement statements_ | ;

statement:
    if_statement | for_statement | while_statement | assigment |  function_call LITERAL_PONTO_E_VIRGULA |
    CONTINUE LITERAL_PONTO_E_VIRGULA | BREAK LITERAL_PONTO_E_VIRGULA | RETURN expression LITERAL_PONTO_E_VIRGULA | declaration
    //{printf("STATEMENT reconhecido\n");}
;

if_statement: IF LPAREN expression RPAREN tail else_part{printf("BLOCO IF\n");};

//if_statement: IF LPAREN expression RPAREN tail else_if_part else_part{printf("BLOCO IF\n");};
// Tivemos problemas nessa parte: nossa suspeita é que esteja relacionado à recursão mais a esquerda.
else_if_part: ELSE IF LPAREN expression RPAREN tail else_if_part_ | ;
else_if_part_: ELSE IF LPAREN expression RPAREN tail else_if_part_ | ;


else_part: ELSE tail | /* empty */ ; 

for_statement: FOR LPAREN expression LITERAL_PONTO_E_VIRGULA expression LITERAL_PONTO_E_VIRGULA expression RPAREN tail {printf("BLOCO FOR\n");} ;

while_statement: WHILE LPAREN expression RPAREN tail {printf("BLOCO WHILE\n");};
// Definicao de funcao:

function_def: TIPO PLAY ID LPAREN argument_list RPAREN tail {printf("DEFINICAO FUNCAO reconhecida\n");};
function_call: ID LPAREN expression_list RPAREN {printf("CHAMADA FUNCAO reconhecida\n");};

casting: TIPO LPAREN expression_list RPAREN {printf("CASTING reconhecido\n");};

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


