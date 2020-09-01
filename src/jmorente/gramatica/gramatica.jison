

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
        $$ = {node: newNode(yy, yystate, $1.node)};
        return $$;
    } 
;

INSTRUCCIONES
    : INSTRUCCIONES INSTRUCCION{
        $$ = {node: newNode(yy, yystate, $1.node, $2.node)};
    }
    | INSTRUCCION{
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
;

INSTRUCCION
    : DECLARACION_VAR
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
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
    : 'PR_VAR' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5, $6.node, $7)};
    }
    |
    'PR_VAR' ID ':' TIPO ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
    |
    'PR_VAR' ID '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
    |
    'PR_VAR' ID ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3)};
    }
    | 'PR_VAR' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5.node, $6, $7.node, $8)};
    }
    |
    'PR_VAR' ID ':' TIPO ARREGLO ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5.node, $6)};
    }
    |
    'PR_VAR' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node, $6)};
    }
    |
    'PR_VAR' ID ARREGLO ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4)};
    }
;

DECLARACION_LET
    : 'PR_LET' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5, $6.node, $7)};
    }
    |
    'PR_LET' ID ':' TIPO ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
    |
    'PR_LET' ID '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
    |
    'PR_LET' ID ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3)};
    }
    | 'PR_LET' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5.node, $6, $7.node, $8)};
    }
    |
    'PR_LET' ID ':' TIPO ARREGLO ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5.node, $6)};
    }
    |
    'PR_LET' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node, $6)};
    }
    |
    'PR_LET' ID ARREGLO ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4)};
    }
;

DECLARACION_CONST
    : 'PR_CONST' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5, $6.node, $7)};
    }
    |
    'PR_CONST' ID '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5)};
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
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | 'PR_NUMBER'
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | 'PR_BOOLEAN'
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
;

ARREGLO
    : '[' ']'
    {
        $$ = {node: newNode(yy, yystate, $1, $2)};
    }
    | '[' ']' '[' ']'
    { 
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4)};
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
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
;

IDENTIFICADOR
    : '(' EXPRESION ')'
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node, $3)};
    }
    | CADENA
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | NUMERO
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | DECIMAL
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | 'PR_TRUE'
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | 'PR_FALSE'
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | ID
    { 
        $$ = {node: newNode(yy, yystate, $1)};
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
