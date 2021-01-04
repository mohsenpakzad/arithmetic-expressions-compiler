del AE_Compiler.exe
bison -d AE_Compiler.y
flex  AE_Compiler.l
gcc  -o AE_Compiler lex.yy.c AE_Compiler.tab.c
.\AE_Compiler.exe
del lex.yy.c
del AE_Compiler.tab.h
del AE_Compiler.tab.c