import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Imprimir extends Instruction {

    /**
     * CONSTRUCTOR
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(private value : Expression, fila : number, columna : number){
        super(fila, columna);
    }

    public execute(environment : Environment) {
        //console.error("CONSOLE")

//        console.log(environment)
        const value = this.value.execute(environment);
 //       console.log(value);
        return value;
    }
}