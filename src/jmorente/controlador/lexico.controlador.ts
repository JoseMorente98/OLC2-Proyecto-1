import { TokenControlador } from './token.controlador';
//declare var parser: any;
//var analizadorLexico = require('../analizador/lexico.analizador');
//const parser = require('../gramatica/gramatica.js');
import * as parser from '../gramatica/gramatica';
export class LexicoControlador {
    //SINGLETON
    private static instancia: LexicoControlador;

    private constructor() { }

    public static getInstancia(): LexicoControlador {
        if (this.instancia == null) {
            this.instancia = new LexicoControlador();
        }
        return this.instancia;
    }

    ejecutarAnalisis(strEntrada:string) {
        let columna = 0;
        let fila = 0;
        parser.parse(strEntrada);
        while (!parser.done) {
            let token = parser.lex();
            columna = parser.yylloc.first_column;
            fila = parser.yylloc.first_line;
            //console.log('<' + token + ', ' + parser.yytext + "Fila: " + fila + " Columna: "+ columna + '>')
            if(token=='TK_Desconocido') {
                TokenControlador.getInstancia().agregarError(parser.yytext, token, fila, columna);
            }else if(token=='EOF') {
                //EPSILON
            } else {
                TokenControlador.getInstancia().agregarToken(parser.yytext, token, fila, columna);
            }
        }

        TokenControlador.getInstancia().imprimirError();
        TokenControlador.getInstancia().imprimirToken();
    }

}