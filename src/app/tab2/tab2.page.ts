import { Component } from '@angular/core';
import { ErrorControlador } from 'src/jmorente/controlador/error.controlador';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss']
})
export class Tab2Page {
  itemSelect:any = 'Error'
  data:any = [];
  constructor() {
    this.obtenerErrores();
  }

  segmentChanged(ev: any) {
    console.log('Segment changed', ev);
    this.itemSelect = ev.detail.value;
    switch (this.itemSelect) {
      case "Error":
        this.obtenerErrores();
        break;
      case "Tabla":
        
        break;
    }
  }

  obtenerErrores() {
    this.data = [];
    this.data = ErrorControlador.getInstancia().getArregloError;
  }

}
