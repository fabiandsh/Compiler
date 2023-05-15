%{
#include <stdio.h>
#include "parser.tab.h"
%}
:
%%
[ \t\n]                      /* Ignorar espacios en blanco */
"if"                        { return IF; }
"else"                      { return ELSE; }
"while"                     { return WHILE; }
"for"                       { return FOR; }
"do"                        { return DO; }
"return"                    { return RETURN; }
"int"                       { return INT; }
"float"                     { return FLOAT; }
"double"                    { return DOUBLE; }
"char"                      { return CHAR; }
"void"                      { return VOID; }
"("                         { return LPAR; }
")"                         { return RPAR; }
"{"                         { return LBRACE; }
"}"                         { return RBRACE; }
";"                         { return SEMICOLON; }
","                         { return COMMA; }
"+"                         { return PLUS; }
"-"                         { return MINUS; }
"*"                         { return TIMES; }
"/"                         { return DIVIDE; }
"="                         { return ASSIGN; }
"<"                         { return LT; }
"<="                        { return LE; }
">"                         { return GT; }
">="                        { return GE; }
"=="                        { return EQ; }
"!="                        { return NE; }
[_a-zA-Z][_a-zA-Z0-9]*      { yylval.strval = strdup(yytext); return IDENTIFIER; }
[0-9]+\.[0-9]*([eE][+-]?[0-9]+)? { yylval.floatval = atof(yytext); return FLOAT_LITERAL; }
[0-9]+                      { yylval.intval = atoi(yytext); return INT_LITERAL; }
"'"[^\n']"'"                { yylval.charval = yytext[1]; return CHAR_LITERAL; }
"/*"([^*]|\n|\*[^/])*"*/"   /* Ignorar comentarios */
"//"(.)*                    /* Ignorar comentarios de una sola línea */
.                           { fprintf(stderr, "Error léxico: Carácter desconocido '%c'\n", yytext[0]); }
%%

