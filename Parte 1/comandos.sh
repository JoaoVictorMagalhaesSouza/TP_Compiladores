flex lex1.l
gcc -omelodia lex.yy.c -ll
./melodia < entrada1.txt > saida1.txt
