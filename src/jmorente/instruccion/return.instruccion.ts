import { Expression } from '../abstract/expresion.abstract';
import { Instruction } from '../abstract/instruccion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Return extends Instruction {
    
    /**
     * CONSTRUCTOR
     * @param fila 
     * @param columna 
     */
    constructor(
        private value: Expression,
        public fila: number,
        public columna: number){
        super(fila, columna);
    }

    public execute(environment : Environment) {
        //console.log("RETURN")
        //console.log(this.value)
        const val = this.value.execute(environment);

        return {value: val, fila : this.fila, columna: this.columna, type : 'Return'};
    }
}