import { Component } from '@angular/core';
import { ErrorControlador } from 'src/jmorente/controlador/error.controlador';
import * as parser from '../../jmorente/gramatica/ast';
import * as analisis from '../../jmorente/gramatica/sintactico';
import * as graficar from '../../jmorente/ast/chart';
import { Environment } from 'src/jmorente/simbolos/enviroment.simbolos';
import { SalidaControlador } from 'src/jmorente/controlador/salida.controlador';
import { Funcion } from 'src/jmorente/instruccion/funcion.instruccion';
import { TablaControlador } from 'src/jmorente/controlador/tabla.controlador';
import { AlertController } from '@ionic/angular';


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
  obj:string;

  constructor(
    private alertController: AlertController
  ) {}


  analizar = () => {
    if (document.getElementById("grafo")) {
      document.getElementById("grafo").remove();
    }
    try {
      /**
       * INICIO DE ANALISIS SINTACTICO
       */
      SalidaControlador.getInstancia().clear();
      ErrorControlador.getInstancia().clear();
      TablaControlador.getInstancia().clear();
      console.clear()
      this.strSalida = "";
      const entorno = new Environment(null, "Global");
      
      let analisisAST = analisis.parse(this.strEntrada);

      /**
       * EJECUTAR FUNCIONES
       */
      for(const instr of analisisAST){
          try {
              if(instr instanceof Funcion) {
                instr.execute(entorno);
              }
          } catch (error) {
            //console.log(error) 
          }
      }

      /**
       * EJECUTAR EJECUCION
       */
      for(const instr of analisisAST){
        try {
            const actual = instr.execute(entorno);
            if(actual != null || actual != undefined){
                //errores.push(new Error_(actual.line, actual.column, 'Semantico', actual.type + ' fuera de un ciclo'));
                //console.error("ERROR SEMANTICO")
            }
        } catch (error) {
            //console.error(error)
        }
      }
      for (const iterator of entorno.variables) {
        console.log(iterator[1])
        TablaControlador.getInstancia()
        .addToken(iterator[1].id, this.obtenerTipo(iterator[1].type), iterator[1].descripcion, iterator[1].valor, iterator[1].fila, iterator[1].columna);
      }
      TablaControlador.getInstancia().imprimir();
    } catch (error) {
      /**
       * ERRORES
       */
      ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
    }
    this.strSalida = SalidaControlador.getInstancia().getSalida;
  }

  generarAST = () => {
    SalidaControlador.getInstancia().clear();
    console.clear()
    this.strSalida = "";
    let graficaAST = parser.parse(this.strEntrada);

    setTimeout(async () => {
        await graficar.generateTree([graficaAST.node]);
        console.log("ARBOL GENERADO")
        this.presentAlert();
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

  async presentAlert() {
    const alert = await this.alertController.create({
      cssClass: 'my-custom-class',
      header: 'AST Generado',
      message: 'El arbol se ha generado exitosamente.',
      buttons: ['OK']
    });

    await alert.present();
  }


}
