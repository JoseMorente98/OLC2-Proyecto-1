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
"^"                     return '^'
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
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    DECLARACION_CONST
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    DECLARACION_SIN_TIPO
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    BREAK
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    CONTINUE
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    RETURN
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    IF
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    SWITCH
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    WHILE
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    DOWHILE
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
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
    |
    FUNCIONES
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
    : ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node, $6)};
    }
    |
    ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5, $6.node, $7)};
    }
    |
    ID '=' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4)};
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
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '-' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '*' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '/' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '%' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '^' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '<' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '<=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '>' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '>=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '==' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '!=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    EXPRESION '&&' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    EXPRESION '||' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    '!' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node)};
    }
    |
    EXPRESION '+' '+'
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3)};
    }
    |
    EXPRESION '-' '-'
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3)};
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
        $$ = {node: newNode(yy, yystate, $1, $2)};
    }
;

CONTINUE 
    : 'PR_CONTINUE'  ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2)};
    }
;

RETURN 
    : 'PR_RETURN'  ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2)};
    }
    | 'PR_RETURN' EXPRESION ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node, $3)};
    }
;

IF 
    : 'PR_IF' '(' EXPRESION ')' SENTENCIA ELSEIF
    {
        if($6 == undefined) {
            $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node)};
        } else {
            $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node, $6.node)};
        }
    }
;

SENTENCIA 
    : '{' INSTRUCCIONES '}'
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node, $3)};
    }
    | '{' '}'
    {
        $$ = {node: newNode(yy, yystate, $1, $2)};
    }
;

ELSEIF 
    : 'PR_ELSE' SENTENCIA
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node)};
    }
    | 'PR_ELSE' IF
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node)};
    }
    | /* EPSILON */
    {
        $$ = null;
    }
;

WHILE 
    : 'PR_WHILE' '(' EXPRESION ')' SENTENCIA
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node)};
    }
;

DOWHILE 
    : 'PR_DO' SENTENCIA 'PR_WHILE' '(' EXPRESION ')' ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node, $3, $4, $5.node, $6, $7)};
    }
;

SWITCH
    : 'PR_SWITCH' '(' EXPRESION ')' '{' CASES DEFAULT '}'
    {
        if($7 == undefined) {
            $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5, $6.node, $8)};
        } else {
            $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5, $6.node, $7.node, $8)};
        }
    }
;

CASES 
    : CASES CASE
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2.node)};
    }
    | CASE
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
;

CASE
    : 'PR_CASE'  EXPRESION ':' INSTRUCCIONES
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node, $3, $4.node)};
    }
;

DEFAULT 
    : 'PR_DEFAULT' ':' INSTRUCCIONES
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node)};
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

FUNCIONES: 
    'PR_FUNCTION' ID '(' ')' SENTENCIAFUNCION
    {
        $$ = $1;
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' SENTENCIAFUNCION
    {
        $$ = $1;
    }
;

SENTENCIAFUNCION: 
    '{' FUNCIONHIJA '}'
    {
        $$ = $1;
    }
    |
    '{' '}'
    {
        $$ = $1;
    }
;

FUNCIONHIJA: 
    FUNCIONH OTRAFUNCIONH
    {
        $$ = $1;
    }
;

FUNCIONH: 
    'PR_FUNCTION' ID '(' ')' SENTENCIAFUNCION
    {
        $$ = $1;
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' SENTENCIAFUNCION
    {
        $$ = $1;
    }
;

OTRAFUNCIONH: 
    FUNCIONH OTRAFUNCIONH
    {
        $$ = $1;
    }
    | /*EPSILON*/
    {
        $$ = $1;
    }
;

PARAMETROS: 
    PARAMETROS ',' PARAMETRO
    {
        $$ = $1;
    }
    |
    PARAMETRO
    {
        $$ = $1;
    }
;

PARAMETRO: 
    ID ':' TIPO
    {
        $$ = $1;
    }
;