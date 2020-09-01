import { Component } from '@angular/core';
import { LexicoControlador } from 'src/jmorente/controlador/lexico.controlador';

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
  strEntrada:string;

  constructor() {}


  analizar() {
    if (document.getElementById("grafo")) {
      document.getElementById("grafo").remove();
    }
    LexicoControlador.getInstancia().ejecutarAnalisis(this.strEntrada);
  }

}
