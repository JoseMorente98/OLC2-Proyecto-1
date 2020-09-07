import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Retorno, Type } from '../abstract/retorno.abstract';

export enum OpcionLogica{
    AND,
    OR,
    NOT
}

export class Logica extends Expression {

    constructor(private left: Expression,
        private right: Expression,
        private type : OpcionLogica,
        fila: number,
        columna: number){
        super(fila,columna);
    }

    public execute(environment : Environment) : Retorno{
        console.error("LOGICA")
        console.error(this.left)
        console.error(this.right)
        const leftValue = this.left.execute(environment);
        const rightValue = this.right.execute(environment);
        if(this.type == OpcionLogica.AND){
            const result = leftValue.value && rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        else if(this.type == OpcionLogica.OR){
            const result = leftValue.value || rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        } 
        else if(this.type == OpcionLogica.NOT){
            const result = !leftValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        return {value:false, type : Type.BOOLEAN}
    }
}