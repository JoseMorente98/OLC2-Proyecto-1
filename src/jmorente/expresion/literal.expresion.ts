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
    constructor(
        public value: any, 
        public fila : number, 
        public columna: number, 
        public type : number
    ){
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
                return {value : this.value.replace(/"/g,'').replace(/'/g,'').replace(/`/g,''), type : Type.STRING};
            case 2:
                return {value : (this.value=="false")?false:true, type : Type.BOOLEAN};
        }
    }
}