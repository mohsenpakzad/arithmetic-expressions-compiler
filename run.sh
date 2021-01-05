#! /bin/bash
rm AE_Compiler.exe
flex  AE_Compiler.l
bison -d AE_Compiler.y
gcc  -o AE_Compiler.out lex.yy.c AE_Compiler.tab.c
rm lex.yy.c
rm AE_Compiler.tab.h
rm AE_Compiler.tab.c
./AE_Compiler