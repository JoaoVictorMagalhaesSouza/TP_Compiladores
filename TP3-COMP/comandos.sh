bison -dy melodia.y
flex melodia.l
gcc -omelodia lex.yy.c y.tab.c -ll tabela_hash.c tabela_hash.h
./melodia < entrada.txt
