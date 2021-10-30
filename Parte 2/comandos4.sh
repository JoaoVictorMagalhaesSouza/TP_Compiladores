bison -dy melodia.y
flex melodia.l
gcc -omelodia lex.yy.c y.tab.c -ll
./melodia < entrada4.txt > saida4.txt
