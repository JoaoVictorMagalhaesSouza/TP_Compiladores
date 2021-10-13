%{

void yyerror(char *c);
#include "y.tab.h"
#include "string.h" 
#include "stdio.h"
#include "stdlib.h"
#include "tabela_hash.h" // Para modificarmos escopo, etc.
int linha = 1; 
char tipo[100];
char id[100];
char value[100];


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
allsymbols     		[ -~]
DIGIT 			[0-9]

ICONSTANTE 		"0"|[0-9]{DIGIT}*
FCONSTANTE 		"0"|{DIGIT}*"."{DIGIT}+
STRING 			\"{allsymbols}*\"


%%
#.*

{TIPOS} 				{return TIPO;}		

"ensaio"				{ return IF; }
"improviso"				{ printf("%s\n",yytext);return ELSE; }
"bis"					{ return WHILE; }
"refrao"				{ return FOR; }
"continue"				{ return CONTINUE; }
"finale"				{ return BREAK; }
"void"					{ return VOID; }
"eco"					{ return RETURN; }
"acorde"				{ return ACORDE; }
"play"					{ return PLAY; }

{ID}		 			{strcpy(id,yytext);return ID; }	

{ICONSTANTE}				{return ICONSTANTE; }
{FCONSTANTE}				{return FCONSTANTE; }

{STRING}				{return STRING; }



"("					{ printf("%s\n",yytext);return LPAREN; }
")"					{ printf("%s\n",yytext);return RPAREN; }
"["					{ return LCOLCH; }
"]"					{ return RCOLCH; }
"{"					{ printf("%s\n",yytext);return LCHAV; }
"}"					{ printf("%s\n",yytext);return RCHAV; }
";"					{ return LITERAL_PONTO_E_VIRGULA;} /// Aqui que vamos mandar a sentença p/ tabela 
"."					{ return LITERAL_PONTO; }
","					{ return LITERAL_VIRGULA; }
"="|"-="|"+="|"/="|"*="		{printf("%s\n",yytext);return LITERAL_RECEBE; }

"+"|"-"				{return ADDOP; }
"=="|"~="				{ return EQOP; }
"&"					{ return ANDOP; }
"|"					{ return OROP; }
"~"					{ return NOTOP; }
">"|"<"|">="|"<="			{ return RELOP; }
"++"|"--"				{ return INCR; }
"*"					{ return MULOP; }
"**"					{ return POWOP; }
"%"					{ return RESTOP; }
"/"|"//"				{ return DIVOP; } 


\n 					{ linha +=1;}
.




%%
int yywrap() {
	return 1;	
}
