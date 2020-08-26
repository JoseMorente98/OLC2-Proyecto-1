
%lex
%options case-insensitive
number  [0-9]+
decimal {entero}"."{entero}
string  (\"[^"]*\")
%%

\s+                   /* skip whitespace */
"//".*                /* skip comments */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */

{number}                return 'NUMERO'
{decimal}               return 'DECIMAL'
{string}                return 'STRING'
"*"                     return '*'
"/"                     return '/'
"-"                     return '-'
"+"                     return '+'
";"                     return ';'
","                     return ','

"<"                     return '<'
">"                     return '>'
"<="                    return '<='
">="                    return '>='
"=="                    return '=='
"!="                    return '!='
"||"                    return '||'
"&&"                    return '&&'
"!"                     return '!'
"="                     return '='

"("                     return '('
")"                     return ')' 
"{"                     return '{'
"}"                     return '}'
"let"                   return 'LET'
"const"                 return 'CONST'
"if"                    return 'IF'
"else"                  return 'ELSE'
"while"                 return 'WHILE'
"do"                    return 'DO'
"for"                   return 'FOR'
"console"               return 'CONSOLE'
"log"                   return 'LOG'
"break"                 return 'BREAK'
"return"                return 'RETURN'
"function"              return 'FUNCTION'

([a-zA-Z_])[a-zA-Z0-9_ñÑ]*	return 'ID';
<<EOF>>               return 'EOF';
.                     return 'TK_Desconocido';
%%