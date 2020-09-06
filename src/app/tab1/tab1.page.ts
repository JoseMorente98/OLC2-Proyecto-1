import { Component } from '@angular/core';
import { ErrorControlador } from 'src/jmorente/controlador/error.controlador';
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

    try {
      console.clear()
      const env = new Environment(null);
      let graficaAST = parser.parse(this.strEntrada);
      let analisisAST = analisis.parse(this.strEntrada);

      setTimeout(() => {
          graficar.generateTree([graficaAST.node]);
      }, 1000);

      /**
       * EJECUTAR EJECUCION
       */
      for(const instr of analisisAST){
        /*if (instr instanceof Imprimir) {
          let str = instr.execute(env);
            console.log(str);
            this.strSalida += str.value;
        }*/
        try {
            const actual = instr.execute(env);
            // console.log("========ACTUAL=======")
            // console.log(actual)
            if(actual != null || actual != undefined){
                //errores.push(new Error_(actual.line, actual.column, 'Semantico', actual.type + ' fuera de un ciclo'));
                console.error("ERROR SEMANTICO")
            }
        } catch (error) {
            console.error(error)
        }
      }
    } catch (error) {
      /**
       * INGRESAR ERRORES PARA REPORTE
       */
      console.error(error)
      //ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
    }
    
    // IMPRIMIR ERRORES
    ErrorControlador.getInstancia().imprimirError();
  }

}
