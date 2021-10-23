%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *c);
int yylex(void);
char *s;
extern int linha;

void imprimeCodigoFonte();

%}
%union {char *string;};
//do a ; declaração
//a


%token <string> TIPO  ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN <string> ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO  LITERAL_VIRGULA  LITERAL_RECEBE PLAY
%token <string> ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL  ACORDE POWOP RESTOP



%left assignment
%right IADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL ACORDE POWOP RESTOP
%right TIPO ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO LITERAL_VIRGULA LITERAL_RECEBE PLAY

%type <string> declaration_names declaration function_def declaration_variable pointer variable expression constant sign casting   function_call expression_list 

%start program


%%


program: commands|program commands;

commands: declarations | statements ;

variable: ID | pointer ID | ID array ;

pointer: pointer MULOP | MULOP ;

array: array LCOLCH ICONSTANTE RCOLCH | LCOLCH ICONSTANTE RCOLCH ;

/* DECLARAÇÕES */

declarations:  declaration|declaration declarations;

declaration: TIPO declaration_names LITERAL_PONTO_E_VIRGULA {printf("Declaration: %s %s\n",$1,$2);}
|function_def ;


declaration_names: declaration_variable|declaration_names LITERAL_VIRGULA declaration_variable;

declaration_variable: ID|ACORDE ID array|pointer ID ;

declaration_args: TIPO ID ;

argument_list: declaration_args LITERAL_VIRGULA argument_list | declaration_args |;

expression_list: expression LITERAL_VIRGULA expression_list {$$ = strcat(strcat($1,$2),$3);} | expression | {$$ = "";};

/* EXPRESSIONS */
expression:
	
    sign constant{$$ =$2;}|
    expression POWOP expression{$$ = strcat(strcat($1,$2),$3);}|    
    expression MULOP expression{$$ = strcat(strcat($1,$2),$3);}|
    expression DIVOP expression{$$ = strcat(strcat($1,$2),$3);}|
    expression ADDOP expression{$$ = strcat(strcat($1,$2),$3);}|
    expression INCR{$$ = strcat($1,$2);}| 
    INCR expression{$$ = strcat($1,$2);}|
    expression OROP expression{$$ = strcat(strcat($1,$2),$3);}|
    expression ANDOP expression{$$ = strcat(strcat($1,$2),$3);}|    
    expression RESTOP expression{$$ = strcat(strcat($1,$2),$3);}|
    NOTOP expression{$$ = strcat($1,$2);}|
    expression EQOP expression{$$ = strcat(strcat($1,$2),$3);}|
    expression RELOP expression{$$ = strcat(strcat($1,$2),$3);}| 
    LPAREN expression RPAREN {$$ = strcat(strcat($1,$2),$3);}|
    variable{printf("Cai em Variable\n");}|
    function_call|
    casting    
;

constant: ICONSTANTE|FCONSTANTE {printf("     Cai em Constant: %s\n",$1);} ;

sign: ADDOP|{$$ = "";};


/* STATEMENTS */

statements: statement statements_;
statements_: statement statements_ | ;

statement:
    if_statement | for_statement | while_statement | assigment |  function_call LITERAL_PONTO_E_VIRGULA |
    CONTINUE LITERAL_PONTO_E_VIRGULA | BREAK LITERAL_PONTO_E_VIRGULA | RETURN expression LITERAL_PONTO_E_VIRGULA | declaration
;

if_statement: IF LPAREN expression RPAREN tail else_part;

else_part: ELSE tail | ; 

for_statement: FOR LPAREN expression LITERAL_PONTO_E_VIRGULA expression LITERAL_PONTO_E_VIRGULA expression RPAREN tail ;

while_statement: WHILE LPAREN expression RPAREN tail ;

// Definicao de funcao:

function_def: TIPO PLAY ID LPAREN argument_list RPAREN tail ;
function_call: ID LPAREN expression_list RPAREN {$$ = strcat(strcat(strcat($1,$2),$3),$4);};

casting: TIPO LPAREN expression_list RPAREN ;

tail: statement | LCHAV statements RCHAV ;

assigment: variable LITERAL_RECEBE expression LITERAL_PONTO_E_VIRGULA {printf("Assigment: %s %s %s %s\n",$1,$2,$3,$4);}; 


%%	


void yyerror(char *c){
	printf("Erro %s na linha: %d\n",c,linha);
	imprimeCodigoFonte();
	printf("\nPrograma sintaticamente incorreto proximo a linha %d!\n", linha-1);
	exit(1);
}

void imprimeCodigoFonte(){
	FILE *pont_arq;
	pont_arq = fopen("impresso.txt", "r");
	char linha[100]; 
	
	while (!feof(pont_arq)){
		fgets(linha, 100 , pont_arq);
		printf("%s", linha);
	}
	
	fclose(pont_arq);
}

int main(){
	FILE *pont_arq;
	pont_arq = fopen("impresso.txt", "w");
	fprintf(pont_arq, "%s ", " 1 ");
	fclose(pont_arq);
	yyparse();
	
	imprimeCodigoFonte();
	printf("\nPrograma sintaticamente correto!\n");
	printf("\n");
	return 1;
}

 
