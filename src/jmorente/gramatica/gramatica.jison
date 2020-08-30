

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
"%"                     return '%'
"^"                    return '^'
";"                     return ';'
":"                     return ':'
","                     return ','
"."                     return '.'

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


"let"                   return 'PR_LET'
"var"                   return 'PR_VAR'
"const"                 return 'PR_CONST'
"if"                    return 'PR_IF'
"else"                  return 'PR_ELSE'
"switch"                return 'PR_SWITCH'
"default"               return 'PR_DEFAULT'
"case"                  return 'PR_CASE'
"while"                 return 'PR_WHILE'
"do"                    return 'PR_DO'
"for"                   return 'PR_FOR'
"console"               return 'PR_CONSOLE'
"log"                   return 'PR_LOG'
"break"                 return 'PR_BREAK'
"continue"              return 'PR_CONTINUE'
"return"                return 'PR_RETURN'
"function"              return 'PR_FUNCTION'
"string"                return 'PR_STRING'
"number"                return 'PR_NUMBER'
"boolean"               return 'PR_BOOLEAN'
"true"                  return 'PR_TRUE'
"false"                 return 'PR_FALSE'
"of"                    return 'PR_OF'
"in"                    return 'PR_IN'

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
%left '%' '^'
%left '!'

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
    |
    BREAK
    {
        $$ = $1;
    }
    |
    CONTINUE
    {
        $$ = $1;
    }
    |
    RETURN
    {
        $$ = $1;
    }
    |
    IF
    {
        $$ = $1;
    }
    |
    SWITCH
    {
        $$ = $1;
    }
    |
    WHILE
    {
        $$ = $1;
    }
    |
    DOWHILE
    {
        $$ = $1;
    }
    |
    FOR
    {
        $$ = $1;
    }
    |
    CONSOLE
    {
        $$ = $1;
    }
;

DECLARACION_VAR 
    : 'PR_VAR' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'PR_VAR' ID ':' TIPO ARREGLO';'
    {
        $$ = $1;
    }
    |
    'PR_VAR' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'PR_VAR' ID ARREGLO ';'
    {
        $$ = $1;
    }
;

DECLARACION_LET
    : 'PR_LET' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'PR_LET' ID ':' TIPO ARREGLO';'
    {
        $$ = $1;
    }
    |
    'PR_LET' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'PR_LET' ID ARREGLO ';'
    {
        $$ = $1;
    }
;

DECLARACION_CONST
    : 'PR_CONST' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = $1;
    }
    |
    'PR_CONST' ID '=' EXPRESION ';'
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
    : EXPRESION '+' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '-' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '*' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '/' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '%' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '^' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '<' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '<=' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '>' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '>=' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '==' EXPRESION
    {
        $$ = $1
    } 
    |
    EXPRESION '!=' EXPRESION
    {
        $$ = $1
    }
    |
    EXPRESION '&&' EXPRESION
    {
        $$ = $1
    }
    |
    EXPRESION '||' EXPRESION
    {
        $$ = $1
    }
    |
    '!' EXPRESION
    {
        $$ = $1
    }
    |
    EXPRESION '+' '+'
    {
        $$ = $1
    }
    |
    EXPRESION '-' '-'
    {
        $$ = $1
    }
    |
    IDENTIFICADOR
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

BREAK 
    : 'PR_BREAK'  ';'
    {
        $$ = $1;
    }
;

CONTINUE 
    : 'PR_CONTINUE'  ';'
    {
        $$ = $1;
    }
;

RETURN 
    : 'PR_RETURN'  ';'
    {
        $$ = $1;
    }
    | 'PR_RETURN' EXPRESION ';'
    {
        $$ = $1;
    }
;

IF 
    : 'PR_IF' '(' EXPRESION ')' SENTENCIA ELSEIF
    {
        $$ = $1;
    }
;

SENTENCIA 
    : '{' INSTRUCCIONES '}'
    {
        $$ = $1;
    }
    | '{' '}'
    {
        $$ = $1;
    }
;

ELSEIF 
    : 'PR_ELSE' SENTENCIA
    {
        $$ = $1;
    }
    | 'PR_ELSE' IF
    {
        $$ = $1;
    }
    | /* EPSILON */
    {
        $$ = null;
    }
;

WHILE 
    : 'PR_WHILE' '(' EXPRESION ')' SENTENCIA
    {
        $$ = $1;
    }
;

DOWHILE 
    : 'PR_DO' SENTENCIA 'PR_WHILE' '(' EXPRESION ')' ';'
    {
        $$ = $1;
    }
;

SWITCH
    : 'PR_SWITCH' '(' EXPRESION ')' '{' CASES DEFAULT '}'
    {
        $$ = $1;
    }
;

CASES 
    : CASES CASE
    {
        $$ = $1;
    }
    | CASE
    {
        $$ = $1;
    }
;

CASE
    : 'PR_CASE'  EXPRESION ':' INSTRUCCIONES
    {
        $$ = $1;
    }
;

DEFAULT 
    : 'PR_DEFAULT' ':' INSTRUCCIONES
    {
        $$ = $1;
    }
    | /* EPSILON */
    {
        $$ = null;
    }
;

FOR 
    : 'PR_FOR' '(' FOREXP ')' SENTENCIA
    {
        $$ = $1;
    }
;

FOREXP
    : 'PR_LET' ID TIPOFOR ID
    {
        $$ = $1;
    }
    | 'PR_VAR' ID TIPOFOR ID
    {
        $$ = $1;
    }
    | 'PR_CONST' ID TIPOFOR ID
    {
        $$ = $1;
    }
    | DECLARACION_FOR ';' EXPRESION ';' EXPRESION
    {
        $$ = $1;
    }
;

TIPOFOR
    : 'PR_OF'
    {
        $$ = $1;
    }
    | 'PR_IN'
    { 
        $$ = $1;
    }
;

DECLARACION_FOR
    : 'PR_VAR' ID ':' TIPO '=' EXPRESION
    {
        $$ = $1;
    }
    |
    'PR_VAR' ID '=' EXPRESION
    {
        $$ = $1;
    }
    | 'PR_LET' ID ':' TIPO '=' EXPRESION
    {
        $$ = $1;
    }
    |
    'PR_LET' ID '=' EXPRESION
    {
        $$ = $1;
    }
;

CONSOLE: 
    'PR_CONSOLE' '.' 'PR_LOG' '(' EXPRESION ')' ';'
    {
        $$ = $1;
    }
;
