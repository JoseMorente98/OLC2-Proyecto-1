import { Instruction } from '../abstract/instruccion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Continue extends Instruction {

    /**
     * CONSTRUCTOR
     * @param fila 
     * @param columna 
     */
    constructor(
        public fila : number,
        public columna : number
    ){
        super(fila, columna);
    }

    public execute(environment : Environment) {
        return {fila : this.fila, columna: this.columna, type : 'Continue'};
    }
}