import { Environment } from '../simbolos/enviroment.simbolos';

export abstract class Instruction {
    public fila: number;
    public columna: number;

    /**
     * CONSTRUCTOR
     * @param fila 
     * @param columna 
     */
    constructor(fila: number, columna: number) {
        this.fila = fila;
        this.columna = columna;
    }

    public abstract execute(environment : Environment) : any;

}