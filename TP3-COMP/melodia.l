%{

void yyerror(char *c);
#include "y.tab.h"
#include "string.h" 
#include "stdio.h"
#include "stdlib.h"
int linha = 2;

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
#.*					{ escreve_arquivo(yytext); }

{TIPOS} 				{ escreve_arquivo(yytext); return TIPO;}		

"ensaio"				{ escreve_arquivo(yytext); return IF; }
"improviso"				{ escreve_arquivo(yytext); printf("%s\n",yytext); return ELSE; }
"bis"					{ escreve_arquivo(yytext); return WHILE; }
"refrao"				{ escreve_arquivo(yytext); return FOR; }
"continue"				{ escreve_arquivo(yytext); return CONTINUE; }
"finale"				{ escreve_arquivo(yytext); return BREAK; }
"void"					{ escreve_arquivo(yytext); return VOID; }
"eco"					{ escreve_arquivo(yytext); return RETURN; }
"acorde"				{ escreve_arquivo(yytext); return ACORDE; }
"play"					{ escreve_arquivo(yytext); return PLAY; }

{ID}		 			{ escreve_arquivo(yytext); printf("%s\n",yytext); return ID; }	

{ICONSTANTE}				{ escreve_arquivo(yytext); printf("%s\n",yytext); return ICONSTANTE; }
{FCONSTANTE}				{ escreve_arquivo(yytext); return FCONSTANTE; }

{STRING}				{ escreve_arquivo(yytext); return STRING; }



"("					{ escreve_arquivo(yytext); printf("%s\n",yytext); return LPAREN; }
")"					{ escreve_arquivo(yytext); printf("%s\n",yytext); return RPAREN; }
"["					{ escreve_arquivo(yytext); return LCOLCH; }
"]"					{ escreve_arquivo(yytext); return RCOLCH; }
"{"					{ escreve_arquivo(yytext); printf("%s\n",yytext); return LCHAV; }
"}"					{ escreve_arquivo(yytext); printf("%s\n",yytext); return RCHAV; }
";"					{ escreve_arquivo(yytext); return LITERAL_PONTO_E_VIRGULA;}
"."					{ escreve_arquivo(yytext); return LITERAL_PONTO; }
","					{ escreve_arquivo(yytext); return LITERAL_VIRGULA; }
"="|"-="|"+="|"/="|"*="			{ escreve_arquivo(yytext); printf("%s\n",yytext);return LITERAL_RECEBE; }

"+"|"-"					{ escreve_arquivo(yytext); return ADDOP; }
"=="|"~="				{ escreve_arquivo(yytext); return EQOP; }
"&"					{ escreve_arquivo(yytext); return ANDOP; }
"|"					{ escreve_arquivo(yytext); return OROP; }
"~"					{ escreve_arquivo(yytext); return NOTOP; }
">"|"<"|">="|"<="			{ escreve_arquivo(yytext); return RELOP; }
"++"|"--"				{ escreve_arquivo(yytext); return INCR; }
"*"					{ escreve_arquivo(yytext); return MULOP; }
"**"					{ escreve_arquivo(yytext); return POWOP; }
"%"					{ escreve_arquivo(yytext); return RESTOP; }
"/"|"//"				{ escreve_arquivo(yytext); return DIVOP; } 


\n 					{ escreve_arquivo(yytext); char stringNum[20]; sprintf(stringNum,"%d",linha); escreve_arquivo(stringNum); linha +=1;}
.




%%
int yywrap() {
	return 1;	
}

void escreve_arquivo(char *texto){
	FILE *pont_arq;
	pont_arq = fopen("impresso.txt", "a");
	fprintf(pont_arq, "%s ", texto);
	fclose(pont_arq);
}
