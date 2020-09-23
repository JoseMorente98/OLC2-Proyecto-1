 
%{
    const { Aritmetica, OpcionAritmetica } = require('../expresion/aritmetica.expresion');
    const { Relacional, OpcionRelacional } = require('../expresion/relacional.expresion');
    const { Logica, OpcionLogica } = require('../expresion/logica.expresion');
    const { Acceso } = require('../expresion/acceso.expresion');
    const { AccesoType } = require('../expresion/acceso-type.expresion');
    const { Literal } = require('../expresion/literal.expresion');
    const { LiteralObjeto } = require('../expresion/literal-objeto.expresion');
    const { Declaracion } = require('../instruccion/declaracion.instruccion');
    const { SinTipo } = require('../instruccion/sintipo.instruccion');
    const { SinTipoType } = require('../instruccion/sin-tipo-type.instruccion');
    const { Imprimir } = require('../instruccion/console.instruccion');
    const { While } = require('../instruccion/while.instruccion');
    const { For } = require('../instruccion/for.instruccion');
    const { If } = require('../instruccion/if.instruccion');
    const { DoWhile } = require('../instruccion/do-while.instruccion');
    const { Sentencia } = require('../instruccion/sentencia.instruccion');
    const { Switch } = require('../instruccion/switch.instruccion');
    const { Case } = require('../instruccion/case.instruccion');
    const { Default } = require('../instruccion/default.instruccion');
    const { Return } = require('../instruccion/return.instruccion');
    const { Break } = require('../instruccion/break.instruccion');
    const { Continue } = require('../instruccion/continue.instruccion');
    const { Types } = require('../instruccion/type.instruccion');
    const { TypePrimitivo } = require('../instruccion/type-primitivo.instruccion');
    const { Value } = require('../instruccion/value.instruccion');
    const { Funcion } = require('../instruccion/funcion.instruccion');
    const { LlamarFuncion } = require('../instruccion/llamar.instruccion');
%}

%lex
%options case-insensitive
BSL                 "\\".
BSL2                 "\"".
number              ([0-9]+)
decimal             ([0-9]+("."[0-9]+))
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
"type"                  return 'PR_TYPE'


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
    :
    DECLARACION_LET
    {
        $$ = $1
    }
    |
    DECLARACION_CONST
    {
        $$ = {node: newNode(yy, yystate, $1.node)};
    }
    |
    DECLARACION_TYPE
    {
        $$ = $1
    }
    |
    DECLARACION_SIN_TIPO
    {
        $$ = $1
    }
    |
    BREAK
    {
        $$ = $1
    }
    |
    CONTINUE
    {
        $$ = $1
    }
    |
    RETURN
    {
        $$ = $1
    }
    |
    IF
    {
        $$ = $1
    }
    |
    SWITCH
    {
        $$ = $1
    }
    |
    WHILE
    {
        $$ = $1
    }
    |
    DOWHILE
    {
        $$ = $1
    }
    |
    FOR
    {
        $$ = $1
    }
    |
    CONSOLE
    {
        $$ = $1
    }
    |
    LLAMADA_FUNCION
    {
        $$ = $1
    }
    |
    FUNCIONES
    {
        $$ = $1;
    }
;

DECLARACION_LET
    : 'PR_LET' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = new Declaracion($2, $4.type, $6, @1.first_line, @1.first_column, $4.tipo);
    }
    |
    'PR_LET' ID ':' TIPO ';'
    {
        $$ = new Declaracion($2, $4.type, null, @1.first_line, @1.first_column, $4.tipo);
    }
    |
    'PR_LET' ID '=' EXPRESION ';'
    {
        $$ = new Declaracion($2, null, $4, @1.first_line, @1.first_column);
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
        $$ = new SinTipo($1, $3, @1.first_line, @1.first_column);
    }
    |
    ID '.' ID '=' EXPRESION ';'
    {
        $$ = new SinTipoType($1, $3, $5, @1.first_line, @1.first_column);
    }
    |
    EXPRESION ';'
    {
        $$ = $1
    }
;

DECLARACION_TYPE
    : 'PR_TYPE' ID '=' '{' DATOS_PRIMITIVOS '}' ';' 
    {
        $$ = new Types($2, 3, $5, @1.first_line, @1.first_column);
    }
;

DATOS_PRIMITIVOS
    : DATOS_PRIMITIVOS ',' DATO_PRIMITIVO
    {
        $1.push($3)
        $$ = $1;
    }
    | DATO_PRIMITIVO
    {
        $$ = [$1];
    }
;

DATO_PRIMITIVO
    : ID ':' TIPO_TYPE
    {
        $$ = new TypePrimitivo($1, $3, @1.first_line, @1.first_column)
    }
;

TIPO_TYPE
    : 'PR_NUMBER'
    { 
        $$ = $1;
    }
    | 'PR_STRING'
    {
        $$ = $1;
    }
    | 'PR_BOOLEAN'
    { 
        $$ = $1;
    }
    | ID
    { 
        $$ = $1;
    }
;

TIPO
    : 'PR_NUMBER'
    { 
        $$ = {type: 0, tipo: $1};
    }
    | 'PR_STRING'
    {
        $$ = {type: 1, tipo: $1};
    }
    | 'PR_BOOLEAN'
    { 
        $$ = {type: 2, tipo: $1};
    }
    | ID
    { 
        $$ = {type: 3, tipo: $1};
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
    EXPRESION '*' '*' EXPRESION
    {
        $$ = new Aritmetica($1, $4, OpcionAritmetica.EXPONENTE, @1.first_line,@1.first_column);
    } 
    |
    '-' EXPRESION
    {
        $$ = new Aritmetica($2, $2, OpcionAritmetica.NEGATIVO, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '<' EXPRESION
    {
        $$ = new Relacional($1, $3, OpcionRelacional.MENOR, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '>' EXPRESION
    {
        $$ = new Relacional($1, $3, OpcionRelacional.MAYOR, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '<' '=' EXPRESION
    {
        $$ = new Relacional($1, $4, OpcionRelacional.MENOR_IGUAL, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '>' '=' EXPRESION
    {
        $$ = new Relacional($1, $4, OpcionRelacional.MAYOR_IGUAL, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '==' EXPRESION
    {
        $$ = new Relacional($1, $3, OpcionRelacional.IGUAL, @1.first_line,@1.first_column);
    } 
    |
    EXPRESION '!=' EXPRESION
    {
        $$ = new Relacional($1, $3, OpcionRelacional.DIFERENTE, @1.first_line,@1.first_column);
    }
    |
    EXPRESION '&&' EXPRESION
    {
        $$ = new Logica($1, $3, OpcionLogica.AND, @1.first_line,@1.first_column);
    }
    |
    EXPRESION '||' EXPRESION
    {
        $$ = new Logica($1, $3, OpcionLogica.OR, @1.first_line,@1.first_column);
    }
    |
    '!' EXPRESION
    {
        $$ = new Logica($2, $2, OpcionLogica.NOT, @1.first_line,@1.first_column);
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
    |
    EXPRESION_JSON
    {
        $$ = $1
    }
;

IDENTIFICADOR
    : '(' EXPRESION ')'
    {
        $$ = $2;
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
    |
    ID '.' ID 
    {
        $$ = new AccesoType($1, $3, @1.first_line, @1.first_column)
    }
;

EXPRESION_JSON
    : '{' OBJETOS '}'
    {
        $$ = new LiteralObjeto($2, @1.first_line, @1.first_column);
    }
;

OBJETOS
    : 
    OBJETOS ',' OBJECT
    {
        $1.push($3)
        $$ = $1
    }
    | OBJECT
    {
        $$ = [$1]
    }
;

OBJECT
    : ID ':' EXPRESION
    {
        $$ = new Value($1, $3, @1.first_line, @1.first_column);
    }
;

BREAK 
    : 'PR_BREAK'  ';'
    {
        $$ = new Break(@1.first_line, @1.first_column);
    }
;

CONTINUE 
    : 'PR_CONTINUE'  ';'
    {
        $$ = new Continue(@1.first_line, @1.first_column);
    }
;

RETURN 
    : 'PR_RETURN'  ';'
    {
        $$ = new Return(@1.first_line, @1.first_column);
    }
    | 'PR_RETURN' EXPRESION ';'
    {
        $$ = new Return($2, @1.first_line, @1.first_column);
    }
;

IF 
    : 'PR_IF' '(' EXPRESION ')' SENTENCIA ELSEIF
    {
        $$ = new If($3, $5, $6, @1.first_line, @1.first_column);
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
        $$ = $2;
    }
    | 'PR_ELSE' IF
    {
        $$ = $2;
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
        $$ = new DoWhile($5, $2, @1.first_line, @1.first_column);
    }
;

SWITCH
    : 'PR_SWITCH' '(' EXPRESION ')' '{' CASES DEFAULT '}'
    {
        $$ = new Switch($3, $6, $7, @1.first_line, @1.first_column);
    }
;

CASES 
    : CASES CASE
    {
        $$ = $1.push($2)
        $$ = $1
    }
    | CASE
    {
        $$ = [$1]
    }
;

CASE
    : 'PR_CASE'  EXPRESION ':' INSTRUCCIONES
    {
        $$ = new Case($2, new Sentencia($4, @1.first_line, @1.first_column), @1.first_line, @1.first_column);
    }
;

DEFAULT 
    : 'PR_DEFAULT' ':' INSTRUCCIONES
    {
        $$ = new Default(new Sentencia($3, @1.first_line, @1.first_column), @1.first_line, @1.first_column)
    }
    | /* EPSILON */
    {
        $$ = null;
    }
;

FOR 
    : 'PR_FOR' '(' DECLARACION_FOR ';' EXPRESION ';' EXPRESION ')' SENTENCIA
    {
        $$ = new For($3, $5, $7, $9, @1.first_line, @1.first_column);
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
    : 'PR_LET' ID ':' TIPO '=' EXPRESION
    {
        $$ = new Declaracion($2, $4.type, $6, @1.first_line, @1.first_column);
    }
    |
    'PR_LET' ID '=' EXPRESION
    {
        $$ = new Declaracion($2, null, $4, @1.first_line, @1.first_column);
    }
;

CONSOLE: 
    'PR_CONSOLE' '.' 'PR_LOG' '(' EXPRESION ')' ';'
    {
        $$ =  new Imprimir($5, @1.first_line, @1.first_column)
    }
;

FUNCIONES: 
    'PR_FUNCTION' ID '(' ')' SENTENCIA
    {
        $$ = new Funcion($2, $5, [], @1.first_line, @1.first_column);
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' SENTENCIA
    {
        $$ = new Funcion($2, $6, $4, @1.first_line, @1.first_column);
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
        $1.push($3);
        $$ = $1;
    }
    |
    PARAMETRO
    {
        $$ = [$1];
    }
;

PARAMETRO: 
    ID ':' TIPO
    {
        $$ = $1;
    }
;

LLAMADA_FUNCION
    :
    ID '(' ')' ';'
    {
        $$ = new LlamarFuncion($1, [], @1.first_line, @1.first_column);
    }
    |
    ID '(' PARAMETROS_LLAMADA ')' ';'
    {
        $$ = new LlamarFuncion($1, $3, @1.first_line, @1.first_column);
    }
;

PARAMETROS_LLAMADA: 
    PARAMETROS_LLAMADA ',' EXPRESION
    {
        $1.push($3);
        $$ = $1;
    }
    |
    EXPRESION
    {
        $$ = [$1]
    }
;
