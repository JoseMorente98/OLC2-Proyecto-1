import { Component } from '@angular/core';
import { LexicoControlador } from 'src/jmorente/controlador/lexico.controlador';
import * as parser from '../../jmorente/gramatica/gramatica';
import * as analisis from '../../jmorente/gramatica/analisis';
import * as graficar from '../../jmorente/ast/chart';
import { Environment } from 'src/jmorente/simbolos/enviroment.simbolos';
import { Imprimir } from 'src/jmorente/instruccion/console.instruccion';
import { Declaracion } from 'src/jmorente/instruccion/declaracion.instruccion';


@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss']
})
export class Tab1Page {
  codeMirrorOptions: any = {
    theme: 'idea',
    mode: 'application/ld+json',
    lineNumbers: true,
    lineWrapping: true,
    foldGutter: true,
    gutters: ['CodeMirror-linenumbers', 'CodeMirror-foldgutter', 'CodeMirror-lint-markers'],
    autoCloseBrackets: true,
    matchBrackets: true,
    lint: true
  };
  codeMirrorOptions3: any = {
    theme: 'idea',
    mode: 'application/ld+json',
    lineNumbers: true,
    lineWrapping: true,
    foldGutter: true,
    gutters: ['CodeMirror-linenumbers', 'CodeMirror-foldgutter', 'CodeMirror-lint-markers'],
    autoCloseBrackets: true,
    matchBrackets: true,
    lint: true
  };
  strEntrada:string;
  strSalida:string;

  constructor() {}


  analizar() {
    if (document.getElementById("grafo")) {
      document.getElementById("grafo").remove();
    }
    
    console.clear()
    const env = new Environment(null);
    //var symbols = fs.readFileSync('./jison/lexico.jison', 'utf8');
    //var parser = new JisonLex(symbols);
    let ast = parser.parse(this.strEntrada);
    let ast2 = analisis.parse(this.strEntrada);
    // console.log("==========AST===========")
    // console.log(ast)

    setTimeout(() => {
        graficar.generateTree([ast.node]);
        //console.log(grafica)
    }, 1000);

    // console.log("=========PRIMERA ITERACION=========")
    for (const iterator of ast2) {
        if (iterator instanceof Declaracion) {
            console.log(iterator)
            iterator.execute(env);
        }
    }
    console.log("=========SEGUNDA ITERACION=========")

    for(const instr of ast2){
        if (instr instanceof Imprimir) {
          let str = instr.execute(env);
            console.log(str);
            this.strSalida += str.value;
        }
        try {
            const actual = instr.execute(env);
            // console.log("========ACTUAL=======")
            // console.log(actual)
            if(actual != null || actual != undefined){
                //errores.push(new Error_(actual.line, actual.column, 'Semantico', actual.type + ' fuera de un ciclo'));
                console.error("ERROR SEMANTICO")
            }
        } catch (error) {
            // errores.push(error);  
            console.error(error)
        }
    }
  }

}
