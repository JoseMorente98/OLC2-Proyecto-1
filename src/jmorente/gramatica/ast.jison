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

";"                     return ';'
":"                     return ':'
","                     return ','
"||"                    return '||'
"*"                     return '*'
"/"                     return '/'
"-"                     return '-'
"&&"                    return '&&'
"!"                     return '!'
"."                     return '.'
"("                     return '('
")"                     return ')' 
"+"                     return '+'
"%"                     return '%'
"^"                     return '^'
"{"                     return '{'
"}"                     return '}'
"<="                    return '<='
">="                    return '>='
"=="                    return '=='
"["                     return '['
"]"                     return ']'
"}"                     return '}'
"}"                     return '}'
"<"                     return '<'
">"                     return '>'
"!="                    return '!='
"="                     return '='

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
"null"                  return 'PR_NULL'
"undefined"             return 'PR_UNDEFINED'

([a-zA-Z_])[a-zA-Z0-9_ñÑ]*	return 'ID';
<<EOF>>               return 'EOF';
.                     return 'ERRORS'
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
        $$ = { node: nodoAST(yy, yystate, $1.node) };
        return $$;
    } 
;

INSTRUCCIONES
    : INSTRUCCIONES INSTRUCCION{
        $$ = { node: nodoAST(yy, yystate, $1.node, $2.node) };
    }
    | INSTRUCCION{
        $$ = { node: nodoAST(yy, yystate, $1.node)};
    }
;

INSTRUCCION
    : 
    DECLARACION_LET
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    DECLARACION_CONST
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    DECLARACION_TYPE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    DECLARACION_SIN_TIPO
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_BREAK
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_CONTINUE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_RETURN
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_IF
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_SWITCH
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_WHILE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_DO_WHILE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_FOR
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    CONSOLE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    LLAMADA_FUNCION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    SENTENCIA_FUNCIONES
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    | error { 
        $$ = $1
    }
;

DECLARACION_LET
    : 'PR_LET' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5, $6.node, $7)};
    }
    |
    'PR_LET' ID ':' TIPO ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
    |
    'PR_LET' ID '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
    |
    'PR_LET' ID ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3)};
    }
    | 'PR_LET' ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5.node, $6, $7.node, $8)};
    }
    |
    'PR_LET' ID ':' TIPO ARREGLO ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5.node, $6)};
    }
    |
    'PR_LET' ID ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5.node, $6)};
    }
    |
    'PR_LET' ID ARREGLO ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4)};
    }
;

DECLARACION_CONST
    : 'PR_CONST' ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5, $6.node, $7)};
    }
    |
    'PR_CONST' ID '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5)};
    }
;

DECLARACION_SIN_TIPO
    : ID ':' TIPO '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5.node, $6)};
    }
    |
    ID ':' TIPO ARREGLO '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5, $6.node, $7)};
    }
    |
    ID '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4)};
    }
    |
    ID '.' ID '=' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4, $5.node, $6)};
    }
    |
    EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
;

DECLARACION_TYPE
    : 'PR_TYPE' ID '=' '{' DATOS_PRIMITIVOS '}' ';' 
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4, $5.node, $6, $7)};
    }
;

DATOS_PRIMITIVOS
    : DATOS_PRIMITIVOS ',' DATO_PRIMITIVO
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    }
    | DATO_PRIMITIVO
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
;

DATO_PRIMITIVO
    : ID ':' TIPO
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node)};
    }
;

TIPO
    : 'PR_STRING'
    {
        $$ = {node: nodoAST(yy, yystate, $1)};
    }
    | 'PR_NUMBER'
    { 
        $$ = {node: nodoAST(yy, yystate, $1)};
    }
    | 'PR_BOOLEAN'
    { 
        $$ = {node: nodoAST(yy, yystate, $1)};
    }
    | ID
    { 
        $$ = {node: nodoAST(yy, yystate, $1)};
    }
;

ARREGLO
    : '[' ']'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2)};
    }
    | '[' ']' '[' ']'
    { 
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4)};
    }
;

EXPRESION     
    : EXPRESION '+' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '-' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '*' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '/' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '%' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '^' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '*' '*' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, "**", $4.node)};
    } 
    |
    '-' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, "-", $2.node)};
    } 
    |
    EXPRESION '<' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '>' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '<' '=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, "<=", $4.node)};
    }
    |
    EXPRESION '>' '=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, "<=", $4.node)};
    } 
    |
    EXPRESION '==' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    } 
    |
    EXPRESION '!=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    EXPRESION '&&' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    EXPRESION '||' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    '!' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node)};
    }
    |
    EXPRESION '+' '+'
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3)};
    }
    |
    EXPRESION '-' '-'
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3)};
    }
    |
    LLAMADA_FUNCION2
    {
        $$ = $1
    }
    |
    IDENTIFICADOR
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
    |
    EXPRESION_JSON
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
;

IDENTIFICADOR
    : '(' EXPRESION ')'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node, $3)};
    }
    | CADENA
    { 
        $$ = {
            node: nodoAST(yy, yystate, $1)
        };
    }
    | NUMERO
    { 
        $$ = {
            node: nodoAST(yy, yystate, $1)
        };
    }
    | DECIMAL
    { 
        $$ = {
            node: nodoAST(yy, yystate, $1)
        };
    }
    | 'PR_TRUE'
    { 
        $$ = {
            node: nodoAST(yy, yystate, $1)
        };
    }
    | 'PR_FALSE'
    { 
        $$ = {
            node: nodoAST(yy, yystate, $1)
        };
    }
    | 'PR_NULL'
    { 
        $$ = { node: nodoAST(yy, yystate, $1)};
    }
    | ID
    { 
        $$ = {
            node: nodoAST(yy, yystate, $1)
        };
    }
    |
    ID '.' ID 
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3)
        };
    }
    |
    ID '.' ID '.' ID 
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3,$4, $5)
        };
    }
;

EXPRESION_JSON
    : '{' OBJETOS '}'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node, $3)};
    }
;

OBJETOS
    : 
    OBJETOS ',' OBJECT
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    }
    | OBJECT
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
;

OBJECT
    : ID ':' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node)};
    }
;

SENTENCIA_BREAK 
    : 'PR_BREAK'  ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2)};
    }
;

SENTENCIA_CONTINUE 
    : 'PR_CONTINUE'  ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2)};
    }
;

SENTENCIA_RETURN 
    : 'PR_RETURN'  ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2)};
    }
    | 'PR_RETURN' EXPRESION ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node, $3)};
    }
;

SENTENCIA_IF 
    : 'PR_IF' '(' EXPRESION ')' SENTENCIA ELSEIF
    {
        if($6 == undefined) {
            $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5.node)};
        } else {
            $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5.node, $6.node)};
        }
    }
;

SENTENCIA 
    : '{' INSTRUCCIONES '}'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node, $3)};
    }
    | '{' '}'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2)};
    }
;

ELSEIF 
    : 'PR_ELSE' SENTENCIA
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node)};
    }
    | 'PR_ELSE' SENTENCIA_IF
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node)};
    }
    | /* EPSILON */
    {
        $$ = null;
    }
;

SENTENCIA_WHILE 
    : 'PR_WHILE' '(' EXPRESION ')' SENTENCIA
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5.node)};
    }
;

SENTENCIA_DO_WHILE 
    : 'PR_DO' SENTENCIA 'PR_WHILE' '(' EXPRESION ')' ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node, $3, $4, $5.node, $6, $7)};
    }
;

SENTENCIA_SWITCH
    : 'PR_SWITCH' '(' EXPRESION ')' '{' CASES DEFAULT '}'
    {
        if($7 == undefined) {
            $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5, $6.node, $8)};
        } else {
            $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5, $6.node, $7.node, $8)};
        }
    }
;

CASES 
    : CASES CASE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2.node)};
    }
    | CASE
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
;

CASE
    : 'PR_CASE'  EXPRESION ':' INSTRUCCIONES
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2.node, $3, $4.node)};
    }
;

DEFAULT 
    : 'PR_DEFAULT' ':' INSTRUCCIONES
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node)};
    }
    | /* EPSILON */
    {
        $$ = null;
    }
;

SENTENCIA_FOR 
    : 'PR_FOR' '(' FOREXP ')' SENTENCIA
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5.node)};
    }
;

FOREXP
    : 'PR_LET' ID TIPOFOR ID
    {
       $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4)};
    }
    | 'PR_VAR' ID TIPOFOR ID
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4)};
    }
    | 'PR_CONST' ID TIPOFOR ID
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4)};
    }
    | DECLARACION_FOR ';' EXPRESION ';' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node, $4, $5.node)};
    }
;

TIPOFOR
    : 'PR_OF'
    {
        $$ = {node: nodoAST(yy, yystate, $1)};
    }
    | 'PR_IN'
    { 
        $$ = {node: nodoAST(yy, yystate, $1)};
    }
;

DECLARACION_FOR
    : 'PR_VAR' ID ':' TIPO '=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5, $6.node)};
    }
    |
    'PR_VAR' ID '=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node)};
    }
    | 'PR_LET' ID ':' TIPO '=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5, $6.node)};
    }
    |
    'PR_LET' ID '=' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4.node)};
    }
;

CONSOLE: 
    'PR_CONSOLE' '.' 'PR_LOG' '(' EXPRESION ')' ';'
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3, $4, $5.node, $6, $7)
        };
    }
;

SENTENCIA_FUNCIONES: 
    'PR_FUNCTION' ID '(' ')' ':' TIPO SENTENCIA
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3, $4, $5, $6.node, $7.node)
        };
    }
    |
    'PR_FUNCTION' ID '(' ')' SENTENCIA
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3, $4, $5.node)
        };
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' ':' TIPO SENTENCIA
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5, $6, $7.node, $8.node)
        };
    }
    |
    'PR_FUNCTION' ID '(' PARAMETROS ')' SENTENCIA
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3, $4.node, $5, $6.node)
        };
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
        $$ = {
            node: nodoAST(yy, yystate, $1.node, $2, $3.node)
        };
    }
    |
    PARAMETRO
    {
        $$ = {
            node: nodoAST(yy, yystate, $1.node)
        };
    }
;

PARAMETRO: 
    ID ':' TIPO
    {
        $$ = {
            node: nodoAST(yy, yystate, $1, $2, $3.node)
        };
    }
;

LLAMADA_FUNCION:
    ID '(' ')' ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3, $4)};
    }
    |
    ID '(' PARAMETROS_LLAMADA ')' ';'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4, $5)};
    }
;

LLAMADA_FUNCION2
    :
    ID '(' ')'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3)};
    }
    |
    ID '(' PARAMETROS_LLAMADA ')'
    {
        $$ = {node: nodoAST(yy, yystate, $1, $2, $3.node, $4)};
    }
;

PARAMETROS_LLAMADA: 
    PARAMETROS_LLAMADA ',' EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node, $2, $3.node)};
    }
    |
    EXPRESION
    {
        $$ = {node: nodoAST(yy, yystate, $1.node)};
    }
;
