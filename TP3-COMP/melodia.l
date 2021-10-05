%{

void yyerror(char *c);
#include "y.tab.h"
#include "string.h" 
#include "stdio.h"
#include "stdlib.h"
int linha = 1; 

%}



DO "do" 
RE "re"
MI "mi"
FA "fa"
SOL "sol"
LA "la"			
SI "si"			

ID	 		[a-zA-Z_][a-zA-Z0-9_]*
TIPOS 			{DO}|{RE}|{MI}|{FA}|{SOL}|{LA}|{SI}
allsymbols     	[ -~]
DIGIT 			[0-9]

ICONSTANTE 		["0"|[0-9]{DIGIT}*
FCONSTANTE 		"0"|{DIGIT}*"."{DIGIT}+
STRING 		\"{allsymbols}*\"



%%

{TIPOS} 				{ return TIPOS;}
{ID}		 			{ return ID; }			

"ensaio"				{ return IF; }
"improviso"				{ return ELSE; }
"bis"					{ return WHILE; }
"refrao"				{ return FOR; }
"continue"				{ return CONTINUE; }
"finale"				{ return BREAK; }
"void"					{ return VOID; }
"eco"					{ return RETURN; }

{ICONSTANTE}				{ return ICONSTANTE; }
{FCONSTANTE}				{ return FCONSTANTE; }
{STRING}				{ return STRING; }


"("					{ return LPAREN; }
")"					{ return RPAREN; }
"]"					{ return LCOLCH; }
"["					{ return RCOLCH; }
"{"					{ return LCHAV; }
"}"					{ return RCHAV; }
";"					{ return LITERAL_PONTO_E_VIRGULA; }
"."					{ return LITERAL_PONTO; }
","					{ return LITERAL_VIRGULA; }
"="					{ return LITERAL_RECEBE; }

"+"|"-"				{ return ADDOP; }
"=="|"~="				{ return EQOP; }
"&"					{ return ANDOP; }
"|"					{ return OROP; }
"~"					{ return NOTOP; }
">"|"<"|">="|"<="			{ return RELOP; }
"++"|"--"				{ return INCR; }
"*"					{ return MULOP; }
"/"					{ return DIVOP; }


\n 					{ return EOL; linha +=1;}
. ;






%%
int yywrap() {
	return 1;	
}
