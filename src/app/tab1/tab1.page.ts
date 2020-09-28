import { Component } from '@angular/core';
import { ErrorControlador } from 'src/jmorente/controlador/error.controlador';
import * as parser from '../../jmorente/gramatica/ast';
import * as analisis from '../../jmorente/gramatica/sintactico';
import * as graficar from '../../jmorente/ast/chart';
import { Environment } from 'src/jmorente/simbolos/enviroment.simbolos';
import { SalidaControlador } from 'src/jmorente/controlador/salida.controlador';
import { Funcion } from 'src/jmorente/instruccion/funcion.instruccion';
import { TablaControlador } from 'src/jmorente/controlador/tabla.controlador';


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


  analizar = () => {
    if (document.getElementById("grafo")) {
      document.getElementById("grafo").remove();
    }
    try {
      /**
       * LIMPIAR VARIABLES
       */
      SalidaControlador.getInstancia().clear();
      console.clear()
      this.strSalida = "";
      const env = new Environment(null);
      
      let analisisAST = analisis.parse(this.strEntrada);

      /**
       * EJECUTAR FUNCIONES
       */
      ErrorControlador.getInstancia().clear();
      for(const instr of analisisAST){
          try {
              if(instr instanceof Funcion)
                  instr.execute(env);
          } catch (error) {
            //console.log(error) 
          }
      }

      /**
       * EJECUTAR EJECUCION
       */
      for(const instr of analisisAST){
        try {
            const actual = instr.execute(env);
            if(actual != null || actual != undefined){
                //errores.push(new Error_(actual.line, actual.column, 'Semantico', actual.type + ' fuera de un ciclo'));
                //console.error("ERROR SEMANTICO")
            }
        } catch (error) {
            //console.error(error)
        }
      }


      console.log("CONSTANTES");
      console.log(env);
      //TablaControlador.getInstancia().agregarToken(this.id, val.type, 'LET', val.value, this.fila, this.columna);
      for (const iterator of env.variables) {
        console.log(iterator[1])
        TablaControlador.getInstancia()
        .agregarToken(iterator[1].id, this.obtenerTipo(iterator[1].type), 'LET', iterator[1].valor, iterator[1].fila, iterator[1].columna);
      }
      TablaControlador.getInstancia().imprimirToken();
    } catch (error) {
      /**
       * INGRESAR ERRORES PARA REPORTE
       */
      //console.log(error)
      //ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
    }
    this.strSalida = SalidaControlador.getInstancia().getSalida;
    // IMPRIMIR ERRORES
    ErrorControlador.getInstancia().imprimirError();
  }

  generarAST = () => {
    SalidaControlador.getInstancia().clear();
    console.clear()
    this.strSalida = "";
    let graficaAST = parser.parse(this.strEntrada);

    setTimeout(() => {
        graficar.generateTree([graficaAST.node]);
    }, 1000);
  }

  public obtenerTipo(type: any):string {
    switch (type) {
        case 0:
            return "NUMBER"
        case 1:
            return "STRING"
        case 2:
            return "BOOLEAN"
    }
    return "OTHER"
  }


}
