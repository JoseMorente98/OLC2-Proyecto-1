import { ErrorControlador } from '../controlador/error.controlador';

export class ErrorLexico {

    /**
     * CONSTRUCTOR
     * @param id 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public fila: number, 
        public columna: number
    ){
        console.error("INGRESA LEXICO ")
        this.id = id;
        this.fila = fila;
        this.columna = columna;
        console.error("Error lexico no se esperaba " + this.id + " en la linea " + this.fila + " en la columna " + this.columna);

        ErrorControlador.getInstancia().agregarError("Error lexico no se esperaba " + this.id + " en la linea " + this.fila + " en la columna " + this.columna, " Léxico ", this.fila, this.columna)
    }

}