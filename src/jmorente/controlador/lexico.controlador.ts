import { TokenControlador } from './token.controlador';
//import { ASTControlador } from './ast/chart.ast.ts';
//declare var parser: any;
//var analizadorLexico = require('../analizador/lexico.analizador');
//const parser = require('../gramatica/gramatica.js');
import * as parser from '../gramatica/gramatica';
import * as analisis from '../gramatica/analisis';
import * as graficar from '../ast/chart';
import { Imprimir } from '../instruccion/console.instruccion';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Declaracion } from '../instruccion/declaracion.instruccion';

//var fs = require('fs');
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
        console.clear()
        const env = new Environment(null);
        //var symbols = fs.readFileSync('./jison/lexico.jison', 'utf8');
        //var parser = new JisonLex(symbols);
        let ast = parser.parse(strEntrada);
        let ast2 = analisis.parse(strEntrada);
        console.log("==========AST===========")
        console.log(ast)

        setTimeout(() => {
            graficar.generateTree([ast.node]);
            //console.log(grafica)
        }, 1000);

        console.log("=========PRIMERA ITERACION=========")
        for (const iterator of ast2) {
            if (iterator instanceof Declaracion) {
                console.log(iterator)
                iterator.execute(env);
            }
            if (iterator instanceof Imprimir) {
                iterator.execute(env);
            }
        }
        console.log("=========SEGUNDA ITERACION=========")

        for(const instr of ast2){
            if (instr instanceof Declaracion) {
                console.log(instr)
                instr.execute(env);

            }
            if (instr instanceof Imprimir) {
                instr.execute(env);
            }
            try {
                const actual = instr.execute(env);
                console.log(actual)
                if(actual != null || actual != undefined){
                    //errores.push(new Error_(actual.line, actual.column, 'Semantico', actual.type + ' fuera de un ciclo'));
                    console.error("ERROR SEMANTICO")
                }
            } catch (error) {
               // errores.push(error);  
               console.error(error)
            }
        }
        /*for(const instr of ast){
            try {
                //if(instr instanceof Function)
                    //instr.execute(env);
            } catch (error) {
                //errores.push(error);  
            }
        }*/
        /*while (!parser.done) {
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
        }*/

        //TokenControlador.getInstancia().imprimirError();
        //TokenControlador.getInstancia().imprimirToken();
    }

}