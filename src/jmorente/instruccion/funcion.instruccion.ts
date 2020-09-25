import { Instruction } from '../abstract/instruccion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Funcion extends Instruction {

    /**
     * CONSTRUCTOR
     * @param id 
     * @param statment 
     * @param parametros 
     * @param line 
     * @param column 
     */
    constructor(
        public id: string,
        public code: Instruction,
        public parametros : Array<string>, 
        public line : number,
        public column : number
    ){
        super(line, column);
    }

    public execute(environment : Environment) {
        environment.guardarFuncion(this.id, this);
    }
}