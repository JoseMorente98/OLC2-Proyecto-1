import { Expression } from '../abstract/expresion.abstract';
import { Retorno, Type } from '../abstract/retorno.abstract';

export class Nullable extends Expression {

    /**
     * CONSTRUCTOR
     * @param value 
     * @param fila 
     * @param columna 
     * @param type 
     */
    constructor(
        public fila : number,
        public columna: number, 
        public type : number
    ){
        super(fila, columna);
    }

    public execute() : Retorno {
        return {value : null, type : Type.NULL};
    }
}