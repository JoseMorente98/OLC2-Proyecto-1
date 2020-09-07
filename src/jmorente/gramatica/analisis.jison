 
%{
    const {Aritmetica, OpcionAritmetica} = require('../expresion/aritmetica.expresion');
    const { Acceso } = require('../expresion/acceso.expresion');
    const { Literal } = require('../expresion/literal.expresion');
    const { Declaracion } = require('../instruccion/declaracion.instruccion');
    const { Imprimir } = require('../instruccion/console.instruccion');
    const { While } = require('../instruccion/while.instruccion');
    const { Sentencia } = require('../instruccion/sentencia.instruccion');
%}

%lex
%options case-insensitive
BSL                 "\\".
BSL2                 "\"".
number              ([+-]?[0-9]+)
decimal             ([+-]?[0-9]+("."[0-9]+))
string              (\"([^"]|{BSL})*\")
string2             (\'([^']|{BSL}|{BSL2})*\')
string3             (\`([^`]|{BSL}|{BSL2})*\`)
%%

\s+                   /* skip whitespace */
"//".*                /* skip comments */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */

{decimal}               return 'DECIMAL'
{number}                return 'NUMERO'
{string}                return 'CADENA'
{string2}               return 'CADENA'
{string3}               return 'CADENA'
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
        return $$;
    } 
;

INSTRUCCIONES
    : INSTRUCCIONES INSTRUCCION{
        $1.push($2);
        $$ = $1
    }
    | INSTRUCCION{
        $$ = [$1]
    }
;

INSTRUCCION
    : DECLARACION_VAR
    {
        $$ = $1
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
        $$ = $1
    }
    |
    DOWHILE
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    FOR
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    CONSOLE
    {
        $$ = $1
    }
    |
    LLAMADA_FUNCION
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
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
        $$ = new Declaracion($2, $4, $6, @1.first_line, @1.first_column);
    }
    |
    'PR_VAR' ID ':' TIPO ';'
    {
        $$ = new Declaracion($2, $4, null, @1.first_line, @1.first_column);
    }
    |
    'PR_VAR' ID '=' EXPRESION ';'
    {
        $$ = new Declaracion($2, null, $4, @1.first_line, @1.first_column);
    }
    |
    'PR_VAR' ID ';'
    {
        $$ = new Declaracion($2, null, null, @1.first_line, @1.first_column);
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
        $$ = 1;
    }
    | 'PR_NUMBER'
    { 
        $$ = 0;
    }
    | 'PR_BOOLEAN'
    { 
        $$ = 2;
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
        $$ = new Aritmetica($1, $3, OpcionAritmetica.SUMA, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '-' EXPRESION
    {
        $$ = new Aritmetica($1, $3, OpcionAritmetica.RESTA, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '*' EXPRESION
    {
        $$ = new Aritmetica($1, $3, OpcionAritmetica.MULTIPLICACION, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '/' EXPRESION
    {
        $$ = new Aritmetica($1, $3, OpcionAritmetica.DIVISION, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '%' EXPRESION
    {
        $$ = new Aritmetica($1, $3, OpcionAritmetica.MODULO, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '^' EXPRESION
    {
        $$ = new Aritmetica($1, $3, OpcionAritmetica.EXPONENTE, @1.first_line,@1.first_column);
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
        $$ = new Aritmetica($1, $1, OpcionAritmetica.INCREMENTO, @1.first_line,@1.first_column);
    }
    |
    EXPRESION '-' '-'
    {
        $$ = new Aritmetica($1, $1, OpcionAritmetica.DECREMENTO, @1.first_line,@1.first_column);
    }
    |
    IDENTIFICADOR
    {
        $$ = $1
    }
;

IDENTIFICADOR
    : '(' EXPRESION ')'
    {
        $$ = {node: newNode(yy, yystate, $1, $2.node, $3)};
    }
    | CADENA
    { 
        $$ = new Literal($1, @1.first_line, @1.first_column, 1);
    }
    | NUMERO
    { 
        $$ = new Literal($1, @1.first_line, @1.first_column, 0)
    }
    | DECIMAL
    { 
        $$ = new Literal($1, @1.first_line, @1.first_column, 0)
    }
    | 'PR_TRUE'
    { 
        $$ = new Literal($1, @1.first_line, @1.first_column, 2)
    }
    | 'PR_FALSE'
    { 
        $$ = new Literal($1, @1.first_line, @1.first_column, 2)
    }
    | ID
    { 
        $$ = new Acceso($1, @1.first_line, @1.first_column)
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
        $$ = new Sentencia($2, @1.first_line, @1.first_column)
    }
    | '{' '}'
    {
        $$ = $1;
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
        $$ = new While($3, $5, @1.first_line, @1.first_column);
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
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5.node)};
    }
;

FOREXP
    : 'PR_LET' ID TIPOFOR ID
    {
       $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4)};
    }
    | 'PR_VAR' ID TIPOFOR ID
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4)};
    }
    | 'PR_CONST' ID TIPOFOR ID
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4)};
    }
    | DECLARACION_FOR ';' EXPRESION ';' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node, $4, $5.node)};
    }
;

TIPOFOR
    : 'PR_OF'
    {
        $$ = {node: newNode(yy, yystate, $1)};
    }
    | 'PR_IN'
    { 
        $$ = {node: newNode(yy, yystate, $1)};
    }
;

DECLARACION_FOR
    : 'PR_VAR' ID ':' TIPO '=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5, $6.node)};
    }
    |
    'PR_VAR' ID '=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node)};
    }
    | 'PR_LET' ID ':' TIPO '=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node, $5, $6.node)};
    }
    |
    'PR_LET' ID '=' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4.node)};
    }
;

CONSOLE: 
    'PR_CONSOLE' '.' 'PR_LOG' '(' EXPRESION ')' ';'
    {
        $$ =  new Imprimir($5, @1.first_line, @1.first_column)
    }
;

FUNCIONES: 
    'PR_FUNCTION' ID '(' ')' SENTENCIA_FUNCION
    {
        $$ = $1;
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' SENTENCIA_FUNCION
    {
        $$ = $1;
    }
;

SENTENCIA_FUNCION: 
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
    FUNCION_HIJA OTRA_INSTRUCCION
    {
        $$ = $1;
    }
;

FUNCION_HIJA: 
    'PR_FUNCTION' ID '(' ')' SENTENCIA_FUNCION
    {
        $$ = $1;
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' SENTENCIA_FUNCION
    {
        $$ = $1;
    }
;

OTRA_INSTRUCCION: 
    FUNCION_HIJA OTRA_INSTRUCCION
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

LLAMADA_FUNCION:
    ID '(' ')' ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3, $4)};
    }
    |
    ID '(' PARAMETROS_LLAMADA ')' ';'
    {
        $$ = {node: newNode(yy, yystate, $1, $2, $3.node, $4, $5)};
    }
;

PARAMETROS_LLAMADA: 
    PARAMETROS_LLAMADA ',' EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    EXPRESION
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
;
