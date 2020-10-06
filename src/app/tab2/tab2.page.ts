import { Component } from '@angular/core';
import { ErrorControlador } from 'src/jmorente/controlador/error.controlador';
import { TablaControlador } from 'src/jmorente/controlador/tabla.controlador';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss']
})
export class Tab2Page {
  itemSelect:any = 'Error'
  data:any = [];
  dataSimbol:any = [];

  constructor() {
    this.obtenerErrores();
  }

  segmentChanged(ev: any) {
    //console.log('Segment changed', ev);
    this.itemSelect = ev.detail.value;
    switch (this.itemSelect) {
      case "Error":
        this.obtenerErrores();
        break;
      case "Tabla":
        this.obtenerTablaSimbol();
        break;
      default: 
        this.obtenerErrores();
    }
  }

  obtenerErrores() {
    this.data = [];
    this.data = ErrorControlador.getInstancia().getArregloError;
  }

  obtenerTablaSimbol() {
    this.dataSimbol = [];
    this.dataSimbol = TablaControlador.getInstancia().getArregloToken;
  }

}
