

%lex
%options case-insensitive
number  [0-9]+
decimal [0-9]+("."[0-9]+)
string  (\"[^"]*\")
%%

\s+                   /* skip whitespace */
"//".*                /* skip comments */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */

{decimal}               return 'DECIMAL'
{number}                return 'NUMERO'
{string}                return 'CADENA'
"*"                     return '*'
"/"                     return '/'
"-"                     return '-'
"+"                     return '+'
";"                     return ';'
":"                     return ':'
","                     return ','
","                     return '.'

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
"["                     return '['
"]"                     return ']'
"}"                     return '}'
"}"                     return '}'


"let"                   return 'LET'
"var"                   return 'VAR'
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
"string"                return 'PR_STRING'
"number"                return 'PR_NUMBER'
"boolean"                return 'PR_BOOLEAN'
"true"                return 'PR_TRUE'
"false"                return 'PR_FALSE'

([a-zA-Z_])[a-zA-Z0-9_ñÑ]*	return 'ID';
<<EOF>>               return 'EOF';
.                     return 'TK_Desconocido';

/lex

%left '||'
%left '&&'
%left '==', '!='
%left '>=', '<=', '<', '>'
%left '+' '-'
%left '*' '/'

%start Init

%%

Init    
    : INSTRUCCIONES EOF 
    {
        return $1;
    } 
;

INSTRUCCIONES
    : INSTRUCCIONES INSTRUCCION{
        $1.push($2);
        $$ = $1;
    }
    | INSTRUCCION{
        $$ = [$1];
    }
;

INSTRUCCION
    : DECLARACION_VAR
    {
        $$ = $1;
    }
    |
    DECLARACION_LET
    {
        $$ = $1;
    }
    |
    DECLARACION_CONST
    {
        $$ = $1;
    }
    |
    DECLARACION_SIN_TIPO
    {
        $$ = $1;
    }
;

DECLARACION_VAR 
    : 'VAR' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'VAR' ID ':' TIPO ARREGLO';'
    {
        $$ = $1;
    }
    |
    'VAR' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'VAR' ID ARREGLO ';'
    {
        $$ = $1;
    }
;

DECLARACION_LET
    : 'LET' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'LET' ID ':' TIPO ARREGLO';'
    {
        $$ = $1;
    }
    |
    'LET' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'LET' ID ARREGLO ';'
    {
        $$ = $1;
    }
;

DECLARACION_CONST
    : 'CONST' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'CONST' ID '=' EXPRESION ';'
    {
        $$ = $1;
    }
;

DECLARACION_SIN_TIPO
    : ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    ID '=' EXPRESION ';'
    {
        $$ = $1;
    }
;

TIPO
    : 'PR_STRING'
    {
        $$ = $1;
    }
    | 'PR_NUMBER'
    { 
        $$ = $1;
    }
    | 'PR_BOOLEAN'
    { 
        $$ = $1;
    }
;

ARREGLO
    : '[' ']'
    {
        $$ = $1;
    }
    | '[' ']' '[' ']'
    { 
        $$ = $1;
    }
    |  /* EPSILON */
    { 
        $$ = null;
    }
;

EXPRESION     
    : IDENTIFICADOR
    {
        $$ = $1;
    }
;

IDENTIFICADOR
    : '(' EXPRESION ')'
    {
        $$ = $1;
    }
    | CADENA
    { 
        $$ = $1;
    }
    | NUMERO
    { 
        $$ = $1;
    }
    | DECIMAL
    { 
        $$ = $1;
    }
    | 'PR_TRUE'
    { 
        $$ = $1;
    }
    | 'PR_FALSE'
    { 
        $$ = $1;
    }
    | ID
    { 
        $$ = $1;
    }
;