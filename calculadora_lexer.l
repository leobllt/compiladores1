/*
 * Lexer para uma calculadora avançada
*/

/* Reconhecimento de tokens para a calculadora */
%option noyywrap nodefault yylineno

%{
#include "calculadora_header.h"
#include "calculadora_parser.tab.h"
%}

/* Expoente float */
EXP ([Ee][-+]?[0-9]+)

%%

"+" |      
"-" |
"*" |
"/" |
"=" |
"," |
";" |
"(" |
")"             { return yytext[0]; } /* Operadores de caracter unico */


">"             { yylval.fn = 1; return CMP; }  /* Operadores de comparacao, todos sao token CMP */
"<"             { yylval.fn = 2; return CMP; }
"<>"            { yylval.fn = 3; return CMP; }
"=="            { yylval.fn = 4; return CMP; }
">="            { yylval.fn = 5; return CMP; }
"<="            { yylval.fn = 6; return CMP; }

"and"           { return AND; } /* Operadores lógicos*/
"or"            { return OR; }

"if"            { return IF; }  /* Palavras-chave */
"then"          { return THEN; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"for"           { return FOR; }
"do"            { return DO; }
"let"           { return LET; }


"sqrt"          { yylval.fn = B_sqrt; return FUNC; }  /* funcoes pre-definidas */
"exp"           { yylval.fn = B_exp; return FUNC; }
"log"           { yylval.fn = B_log; return FUNC; }
"print"         { yylval.fn = B_print; return FUNC; }


[a-zA-Z][a-zA-Z0-9]* { yylval.s = lookup(yytext); return NAME; } /* Nomes */


[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; } /* Números */

\n+              { return EOL; } /* Quebra de linha */

"//".*          { /* ignora */ }


[ \t]           { /* ignora */ }  /* Espaços em branco */


\\\n            { printf("c> "); }  /* Continuação de linha com barra invertida */



.               { yyerror("Caractere desconhecido %c\n", *yytext); } /* Qualquer outro caractere inválido */
