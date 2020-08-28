

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
":"                     return ':'
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
    : DECLARACION {
        $$ = $1;
    }
;

DECLARACION 
    : 'VAR' ID ':' TIPO '=' STRING ';'{
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
