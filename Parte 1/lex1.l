%{ 

/*codigo colocado aqui aparece no arquivo gerado pelo flex*/ 

# include <stdio.h>
# include <stdlib.h>
# include <string.h>

%} 

/* This tells flex to read only one input file */ 
%option noyywrap 

/* definicoes regulares */ 

delim        [\t\n] 
ws        {delim}+ 
NOME_VARIAVEL [a-zA-Z_][a-zA-Z0-9_]*
DIGITO [0-9]
DIGITOS [0-9]+
DO "do" 
RE "re"
MI "mi"
FA "fa"
SOL "sol"
LA "la"			
SI "si"			

TIPOS {DO}|{RE}|{MI}|{FA}|{SOL}|{LA}|{SI}

TAD_DO {DIGITO}+
TAD_RE {DIGITO}+|(\+{DIGITO}+)|(\-{DIGITO}+)
TAD_MI {DIGITO}+\.{DIGITO}+|\+{DIGITO}+\.{DIGITO}+|\-{DIGITO}+\.{DIGITO}+
TAD_FA {DIGITO}+\.{DIGITO}+|\+{DIGITO}+\.{DIGITO}+|\-{DIGITO}+\.{DIGITO}+
TAD_SOL {DIGITO}+\.{DIGITO}+|\+{DIGITO}+\.{DIGITO}+|\-{DIGITO}+\.{DIGITO}+
TAD_LA "True"|"False"
TAD_SI \"([a-zA-Z0-9:,.;/@\\\(\)\[\]\-\_\!\#\$\%\*\&\+\=\>\<\~ ]*)\"

TADS {TAD_SI}|{TAD_DO}|{TAD_RE}|{TAD_LA}|{TAD_SI}|{TAD_MI}|{TAD_FA}|{TAD_SOL}
TAD_PRIMITIVO  {TADS}|({TAD_PRIMITIVO}","{TADS})
TAD_ACORDE \[(({TADS})",")*\]  
TAD_MAESTRO "*"{TIPOS}[ ]{NOME_VARIAVEL}
TAD_MEDLEY "medley"[ ]{NOME_VARIAVEL}\{\}
TAD_VAZIO "vazio"

FUN_ENTRADA "nota()"
FUN_SAIDA "show()"

PLAY {TIPOS}[ ]"play"[ ]{NOME_VARIAVEL}\(\)\{\}
TESTE "teste"\(({NOME_VARIAVEL}|{TADS}|{TAD_ACORDE}|{TAD_MAESTRO}|{TAD_MEDLEY}|{TAD_VAZIO}|{PLAY})\)

REFERENCIAMENTO {NOME_VARIAVEL}\[{DIGITOS}\]

NUMERO {TAD_DO}|{TAD_RE}|{TAD_MI}
EXPRESSAO_ARITMETICA ({NUMERO}|{NOME_VARIAVEL})(("+"|"-"|"*"|"**"|"/"|"%"|"//"){NUMERO}|{NOME_VARIAVEL})+
EXPRESSAO_RELACIONAL_NUMERICA ({NUMERO}|{NOME_VARIAVEL})("<"|">"|"<="|">="|"==","!=")({NUMERO}|{NOME_VARIAVEL})
EXPRESSAO_RELACIONAL_BOOLEANA ({TAD_LA}|{NOME_VARIAVEL})("=="|"!=")({TAD_LA}|{NOME_VARIAVEL})
EXPRESSAO_LOGICA "~"?({TAD_LA}|{NOME_VARIAVEL})("&"|"|")"~"?({TAD_LA}|{NOME_VARIAVEL}) 
EXPRESSAO_ATRIBUICAO {NOME_VARIAVEL}("="|"+="|"-="|"*="|"/=")({NOME_VARIAVEL}|{TADS}|{PLAY}|{REFERENCIAMENTO}|(EXPRESSAO_ARITMETICA)*)
EXPRESSAO_ATRIBUICAO_UNARIA {NOME_VARIAVEL}("++"|"--")
EXPRESSAO_CASTING "do"\(({NOME_VARIAVEL}|{TAD_RE}|{TAD_MI})\)|"re"\(({NOME_VARIAVEL}|{TAD_DO}|{TAD_MI})\)|"mi"\(({NOME_VARIAVEL}|{TAD_RE}|{TAD_DO})\)|"fa"\(({NOME_VARIAVEL}|{TAD_RE}|{TAD_MI}|{TAD_DO})\)|"sol"\(({NOME_VARIAVEL}|{TAD_RE}|{TAD_MI}|{TAD_DO}|{TAD_FA})\)

EXPRESSAO_RETORNO "eco"[ ]({NOME_VARIAVEL}|{TADS})
EXPRESSAO_PARADA "finale"



LACO_REFRAO "refrao"\(({TIPOS}[ ])?{EXPRESSAO_ATRIBUICAO}[ ];[ ]{EXPRESSAO_RELACIONAL_NUMERICA}[ ];[ ]({EXPRESSAO_ATRIBUICAO_UNARIA}|{EXPRESSAO_ATRIBUICAO})\)\{\}
LACO_BIS "bis"\(({EXPRESSAO_RELACIONAL_NUMERICA}|{EXPRESSAO_RELACIONAL_BOOLEANA}|{EXPRESSAO_LOGICA})\)\{\}

COMANDO_CONDICIONAL_ENSAIO "ensaio"\(({EXPRESSAO_RELACIONAL_NUMERICA}|{EXPRESSAO_RELACIONAL_BOOLEANA}|{EXPRESSAO_LOGICA})\)\{\}
COMANDO_CONDICIONAL_IMPROVISO "improviso"\{\}


DECLARACAO_VARIAVEL ((({TIPOS}|"acorde")[ ]{NOME_VARIAVEL})|{TAD_MAESTRO}|{TAD_MEDLEY})([ ]"="[ ]({TADS}|{TAD_ACORDE}|{TAD_MEDLEY}|{EXPRESSAO_ARITMETICA}|{EXPRESSAO_RELACIONAL_NUMERICA}|{EXPRESSAO_RELACIONAL_BOOLEANA}|{EXPRESSAO_LOGICA}|{EXPRESSAO_ATRIBUICAO_UNARIA}))?






%% 
{ws}        {/*nenhuma acao e nenhum retorno*/}  
{EXPRESSAO_PARADA} {printf("Foi encontrada uma operacao de PARADA DE EXECUCAO. %s \n",yytext);}
{TAD_DO} {printf("Foi encontrado um valor do tipo DO: %s \n",yytext);}
{TAD_RE} {printf("Foi encontrado um valor do tipo RE: %s \n",yytext);}
{TAD_MI} {printf("Foi encontrado um valor do tipo MI: %s \n",yytext);}
{TAD_FA} {printf("Foi encontrado um valor do tipo FA: %s \n",yytext);}
{TAD_SOL} {printf("Foi encontrado um valor do tipo SOL: %s \n",yytext);}
{TAD_LA} {printf("Foi encontrado um valor do tipo LA: %s \n",yytext);}
{TAD_SI} {printf("Foi encontrado um valor do tipo SI: %s \n",yytext);}
{TAD_ACORDE}		{printf("Foi encontado um valor do tipo ACORDE. %s \n",yytext);}
{TAD_MAESTRO} {printf("Foi encontrado um valor do tipo MAESTRO. %s \n", yytext);}
{TAD_VAZIO} {printf("Foi encontrado um valor do tipo VAZIO. %s \n", yytext);}
{FUN_ENTRADA} {printf("Foi encontrado uma FUNCAO DE ENTRADA DE DADOS. %s \n", yytext);}
{FUN_SAIDA} {printf("Foi encontrado uma FUNCAO DE SAIDA DE DADOS. %s \n", yytext);}
{EXPRESSAO_ARITMETICA} {printf("Foi econtrada uma EXPRESSAO ARITMETICA. %s \n",yytext);}
{EXPRESSAO_ATRIBUICAO} {printf("Foi encontrada uma EXPRESSAO DE ATRIBUICAO. %s \n",yytext);}
{EXPRESSAO_RELACIONAL_NUMERICA} {printf("Foi encontrada uma EXPRESSAO RELACIONAL NUMERICA. %s \n",yytext);}
{EXPRESSAO_ATRIBUICAO_UNARIA} {printf("Foi encontrada uma EXPRESSAO DE ATRIBUICAO UNARIA. %s \n",yytext);}
{EXPRESSAO_RELACIONAL_BOOLEANA} {printf("Foi encontrada uma EXPRESSAO RELACIONAL BOOLEANA. %s \n",yytext);}
{EXPRESSAO_CASTING} {printf("Foi encontrada uma EXPRESSAO DE CASTING EXPLICITO. %s \n",yytext);}
{EXPRESSAO_LOGICA} {printf("Foi encontrada uma EXPRESSAO LOGICA. %s \n",yytext);}
{LACO_REFRAO} {printf("Foi encontrado um LACO REFRAO. %s \n",yytext);}
{LACO_BIS} {printf("Foi encontrado um LACO BIS. %s \n",yytext);}
{COMANDO_CONDICIONAL_ENSAIO} {printf("Foi encontrado a condicional ENSAIO. %s \n",yytext);}
{COMANDO_CONDICIONAL_IMPROVISO} {printf("Foi encontrado a condicional IMPROVISO. %s \n",yytext);}
{PLAY} {printf("Foi econtrado a definicao de uma FUNCAO. %s \n",yytext);}
{TESTE} {printf("Foi encontrada a funcao de VERIFICACAO DE TIPOS. %s \n",yytext);}
{REFERENCIAMENTO} {printf("Foi encontrado uma operacao de REFERENCIAMENTO. %s \n",yytext);}
{DECLARACAO_VARIAVEL} {printf("Foi encontrado uma operacao de DECLARACAO DE VARIAVEL. %s \n",yytext);}
{EXPRESSAO_RETORNO} {printf("Foi encontrada uma operacao de RETORNO DE VALOR. %s \n",yytext);}

%% 

/*codigo em C. Foi criado o main, mas podem ser criadas outras funcoes aqui.*/ 

int main(int argc, char *argv[])      
{                             
   ++argv, --argc;  /* skip over program name */                            
if (argc > 0)                               
          yyin = fopen(argv[0], "r");                            
else                                       yyin = stdin;                             
   yylex();      
}
