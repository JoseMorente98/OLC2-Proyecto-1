import { Expression } from '../abstract/expresion.abstract';
import { Retorno, Type } from '../abstract/retorno.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class LiteralObjeto extends Expression {

    /**
     * CONSTRUCTOR
     * @param value 
     * @param fila 
     * @param columna 
     * @param type 
     */
    constructor(
        public value: any,
        public fila : number, 
        public columna: number, 
    ){
        super(fila, columna);
    }

    public execute(enviroment: Environment) : Retorno {
        //console.error("____________________________")
        //console.error("LITERAL OBJETO")
        //console.error("____________________________")
        //console.error(this.value)

        var strJSON = "{"
        for (const iterator of this.value) {
            let val = iterator.value.execute(enviroment);
            strJSON += iterator.id + ": " + (val.value.valorSTR || val.value);
        }
        strJSON += "}";

        var data = {
            value: this.value,
            valorSTR: strJSON
        }

        return {value: data, type : Type.TYPE};
    }
}