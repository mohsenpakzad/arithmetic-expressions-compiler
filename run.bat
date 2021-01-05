del AE_Compiler.exe
flex  AE_Compiler.l
bison -d AE_Compiler.y
gcc  -o AE_Compiler lex.yy.c AE_Compiler.tab.c
del lex.yy.c
del AE_Compiler.tab.h
del AE_Compiler.tab.c
.\AE_Compiler.exe