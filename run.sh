#! /bin/bash
rm AE_Compiler
flex  AE_Compiler.l
bison -d AE_Compiler.y
gcc  -o AE_Compiler lex.yy.c AE_Compiler.tab.c phrase.c
rm lex.yy.c
rm AE_Compiler.tab.h
rm AE_Compiler.tab.c
./AE_Compiler