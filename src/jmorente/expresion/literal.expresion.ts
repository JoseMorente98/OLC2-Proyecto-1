import { Expression } from '../abstract/expresion.abstract';
import { Retorno, Type } from '../abstract/retorno.abstract';

export class Literal extends Expression {

    /**
     * CONSTRUCTOR
     * @param value 
     * @param fila 
     * @param columna 
     * @param type 
     */
    constructor(private value : any, fila : number, columna: number, private type : number){
        super(fila, columna);
    }

    public execute() : Retorno {
        //console.error("LITERAL")
        //console.log(this.value)
        //console.log(this.type)
        switch (this.type) {
            case 0:
                return {value : Number(this.value), type : Type.NUMBER};
            case 1:
                return {value : this.value, type : Type.STRING};
        }
    }
}