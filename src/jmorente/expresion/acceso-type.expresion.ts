import { type } from "os";
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Retorno } from '../abstract/retorno.abstract';

export class AccesoType extends Expression {

    /**
     * CONSTRUCTOR
     * @param id 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public id2: string, 
        public fila : number, 
        public columna: number){
        super(fila, columna);
    }

    public execute(environment: Environment): Retorno {
        console.error("ACCESO TYPE")
        console.log(this.id)
        console.log(this.id2)
        const value = environment.getVar(this.id);
        console.log(value)

        if(value == null) {
            throw new Error("La variable no existe D:");
        }

        for (const iterator of value.valor.value) {
            if(iterator.id == this.id2) {
                return {value : iterator.value.value, type : iterator.value.type};
            }
        }

        return {value : value.valor, type : value.type};
    }
}