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
        if(this.type == OpcionLogica.AND){
            const leftValue = this.left.execute(environment);
            const rightValue = this.right.execute(environment);
            const result = leftValue.value && rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        else if(this.type == OpcionLogica.OR){
            const leftValue = this.left.execute(environment);
            const rightValue = this.right.execute(environment);
            const result = leftValue.value || rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        } 
        else if(this.type == OpcionLogica.NOT){
            //console.error("EVALUCION")
            
            const leftValue = this.left.execute(environment);
            //console.error(leftValue.value)
            //console.error(!leftValue.value)
            const result = !leftValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        return {value:false, type : Type.BOOLEAN}
    }
}