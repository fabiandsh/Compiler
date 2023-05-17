%{
#include <stdio.h>
#include "parser.tab.h"
%}
identifier [_a-zA-Z][_a-zA-Z0-9]*
float [0-9]+\.[0-9]*
int [0-9]+ 
char "'"[^\n']"'" 
comentBig "/\*"(.|\n)*"*/" 
coment  "//"(.)*  
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
{identifier}                { yylval.strval = strdup(yytext); return IDENTIFIER; }
{float}                     { yylval.floatval = atof(yytext); return FLOAT_VALUE; }
{int}                       { yylval.intval = atoi(yytext); return INT_VALUR; }
{char}                      { yylval.charval = yytext[1]; return CHAR_VALUE; }
{comentBig}                 {/* Ignorar comentarios */}
{coment}                    {/* Ignorar comentarios de una sola línea */}
.                           { fprintf(stderr, "Error léxico: Carácter desconocido '%c'\n", yytext[0]); }
%%

int yywrap(){return 1;}