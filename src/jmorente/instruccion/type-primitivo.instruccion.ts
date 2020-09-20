import { Instruction } from '../abstract/instruccion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class TypePrimitivo extends Instruction{

    /**
     * CONSTRUCTOR
     * @param id 
     * @param type 
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public type:any, 
        public fila: number, 
        public columna: number
    ){
        super(fila, columna);
        this.id = id;
        this.type = type;
    }

    public execute(environment: Environment) {
        console.error("TYPO")
        console.log(environment)
        return {id: this.id, type: this.type};
    }

}