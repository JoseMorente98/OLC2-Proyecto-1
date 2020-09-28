import { ErrorControlador } from '../controlador/error.controlador';

export class ErrorAnalisis {

    
    constructor(
        public id: string, 
        public fila: number, 
        public columna: number
    ){
        console.error("INGRESA A ERROR ")
        this.id = id;
        this.fila = fila;
        this.columna = columna;

        ErrorControlador.getInstancia().agregarError("Error sintactico no se esperaba" + this.id, "Sintactico", this.fila, this.columna)
    }

}