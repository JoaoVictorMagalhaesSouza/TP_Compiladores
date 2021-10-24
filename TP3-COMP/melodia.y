%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabela_hash.h"
#include <math.h>
void yyerror(char *c);
int yylex(void);
char *s;
extern int linha;
int escopoGlobal = 0;

void imprimeCodigoFonte();

%}
%union {char *string;};
//do a ; declaração
//a


%token <string> TIPO  ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN <string> ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO  LITERAL_VIRGULA  LITERAL_RECEBE PLAY
%token <string> ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL  ACORDE POWOP RESTOP



%left assignment
%right ADDOP EQOP ANDOP OROP NOTOP RELOP INCR MULOP DIVOP EOL ACORDE POWOP RESTOP
%right TIPO ID IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN ICONSTANTE FCONSTANTE STRING LPAREN RPAREN LCOLCH RCOLCH LCHAV RCHAV LITERAL_PONTO_E_VIRGULA LITERAL_PONTO LITERAL_VIRGULA LITERAL_RECEBE PLAY

%type <string> declaration_names declaration function_def declaration_variable pointer variable expression constant sign casting   function_call expression_list argument_list tail declaration_args array statement if_statement for_statement while_statement assigment

%start program


%%


program: commands|program commands;

commands: declarations | statements ;

variable: ID | pointer ID | ID array ;

pointer: pointer MULOP | MULOP ;

array: array LCOLCH ICONSTANTE RCOLCH | LCOLCH ICONSTANTE RCOLCH ;

/* DECLARAÇÕES */

declarations:  declaration|declaration declarations;

declaration: TIPO declaration_names LITERAL_PONTO_E_VIRGULA {insereTabela($1,$2,escopoGlobal); imprimirTabela();}
|function_def {printf("Declaracao de funcao: %s\n",$1);} ;


declaration_names: declaration_variable|declaration_names LITERAL_VIRGULA declaration_variable{$$ = strcat(strcat($1,$2),$3);};

declaration_variable: ID|ACORDE ID array{$$ = strcat(strcat($1,$2),$3);}|pointer ID {$$ = strcat($1,$2);};

declaration_args: TIPO ID {$$ = strcat($1,$2);};

argument_list: declaration_args LITERAL_VIRGULA argument_list {$$ = strcat(strcat($1,$2),$3);}| declaration_args | {$$ = "";};

expression_list: expression LITERAL_VIRGULA expression_list {$$ = strcat(strcat($1,$2),$3);} | expression | {$$ = "";};

/* EXPRESSIONS */
expression:
	// LPAREN expression RPAREN {$$ = $2;}| // a = 2+5*3
    sign constant{
    		if (strcmp("-",$1)==0){
    			char aux[50];sprintf(aux, "%g", -atof($2)); $$ = aux;
    		}else{
    			char aux[50];sprintf(aux, "%g", atof($2)); $$ = aux;
    		
    		}
    			
    		
    		
    
    }| // +2; -2;; 2
    expression POWOP expression{char aux[50];double pot = pow(atof($1),atof($3));sprintf(aux, "%g", pot); $$ = aux;}|    
    expression MULOP expression{char aux[50];sprintf(aux, "%g", (atof($1)*atof($3))); $$ = aux;}|
    expression DIVOP expression{char aux[50];sprintf(aux, "%g", (atof($1)/atof($3))); $$ = aux;}|
    expression ADDOP expression{char aux[50];sprintf(aux, "%g", (atof($1)+atof($3))); $$ = aux;}| //a++ a--
    expression INCR{if (strcmp($2,"++")==0){
    		    char aux[50];sprintf(aux, "%g", (atof($1)+1)); $$ = aux;
    		    }
		    else{
		    	char aux[50];sprintf(aux, "%g", (atof($1)-1)); $$ = aux;
		    }
	}| 
    INCR expression{if (strcmp($1,"++")==0){
    		    char aux[50];sprintf(aux, "%g", (atof($2)+1)); $$ = aux;
    		    }
		    else{
		    	char aux[50];sprintf(aux, "%g", (atof($2)-1)); $$ = aux;
		    }
	}|
    expression OROP expression{char aux[50];sprintf(aux, "%d", (atoi($1)||atoi($3))); $$ = aux;}|
    expression ANDOP expression{char aux[50];sprintf(aux, "%d", (atoi($1)&&atoi($3))); $$ = aux;}|    
    expression RESTOP expression{char aux[50];sprintf(aux, "%d", (atoi($1)%atoi($3))); $$ = aux;}|
    NOTOP expression{char aux[50];sprintf(aux, "%d", (!atof($2))); $$ = aux;}|
    expression EQOP expression{
    				
    				if(strcmp("==",$2)==0){
    					char aux[50];sprintf(aux, "%d", (atof($1)==atof($3))); $$ = aux;
    					}
    					
    				if(strcmp("~=",$2)==0){
    					char aux[50];sprintf(aux, "%d", (atof($1)!=atof($3))); $$ = aux;
    					}
    					
    					
    
    
    
    
    
    }|
    expression RELOP expression{
    				
    				if(strcmp("<",$2)==0){
    					char aux[50];sprintf(aux, "%d", (atof($1)<atof($3))); $$ = aux;
    					}
    				else if(strcmp(">",$2)==0){
    					char aux[50];sprintf(aux, "%d", (atof($1)>atof($3))); $$ = aux;
    					}
    				if(strcmp("<=",$2)==0){
    					char aux[50];sprintf(aux, "%d", (atof($1)<=atof($3))); $$ = aux;
    					}
    				if(strcmp(">=",$2)==0){
    					char aux[50];sprintf(aux, "%d", (atof($1)>=atof($3))); $$ = aux;
    					}
    				
    
    
    }| 
    
    variable |
    function_call|
    casting    
;

constant: ICONSTANTE|FCONSTANTE ;

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

assigment: variable LITERAL_RECEBE expression LITERAL_PONTO_E_VIRGULA {editaEntidade($1,escopoGlobal,$3);imprimirTabela();}; 


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
	inicializarTabela();
	//printf("Var Global: %d\n",escopoGlobal);
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

 
