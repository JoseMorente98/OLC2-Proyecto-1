import { Environment } from '../simbolos/enviroment.simbolos';

export abstract class Instruction {

    /**
     * CONSTRUCTOR
     * @param fila 
     * @param columna 
     */
    constructor(
        public fila: number,
        public columna: number) {
        this.fila = fila;
        this.columna = columna;
    }

    public abstract execute(environment : Environment) : any;

}