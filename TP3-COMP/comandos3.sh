bison -dy melodia.y
flex melodia.l
gcc -omelodia lex.yy.c y.tab.c -ll -lm  tabela_hash.c tabela_hash.h
./melodia < entrada3.txt
