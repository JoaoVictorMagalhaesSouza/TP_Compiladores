%{

void yyerror(char *c);
#include "y.tab.h"
#include "string.h" 
#include "stdio.h"
#include "stdlib.h"

%}





DO "do" 
RE "re"
MI "mi"
FA "fa"
SOL "sol"
LA "la"			
SI "si"			

NOME_VARIAVEL [a-zA-Z_][a-zA-Z0-9_]*
TIPOS {DO}|{RE}|{MI}|{FA}|{SOL}|{LA}|{SI}

LITERAL_PONTO_E_VIRGULA ";"
LITERAL_VIRGULA ","
LITERAL_RECEBE "="
%%
{LITERAL_VIRGULA} {return LITERAL_VIRGULA; }
{LITERAL_PONTO_E_VIRGULA} { return LITERAL_PONTO_E_VIRGULA;}

{TIPOS} { 
	return TIPOS;}
{NOME_VARIAVEL} {
	return NOME_VARIAVEL;
}

\n {return EOL;}

. ;






%%
int yywrap() {
	return 1;	
}
