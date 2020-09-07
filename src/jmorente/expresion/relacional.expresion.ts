import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Retorno, Type } from '../abstract/retorno.abstract';

export enum OpcionRelacional{
    IGUAL,
    DIFERENTE,
    MENOR,
    MENOR_IGUAL,
    MAYOR,
    MAYOR_IGUAL
}

export class Relacional extends Expression {

    constructor(private left: Expression,
        private right: Expression,
        private type : OpcionRelacional,
        fila: number,
        columna: number){
        super(fila,columna);
    }

    public execute(environment : Environment) : Retorno{
        console.error("RELACIONAL")
        console.error(this.left)
        console.error(this.right)
        const leftValue = this.left.execute(environment);
        const rightValue = this.right.execute(environment);
        if(this.type == OpcionRelacional.IGUAL){
            console.error(leftValue.value)
            console.error(rightValue.value)
            console.error(leftValue.value == rightValue.value)
            const result = leftValue.value == rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        else if(this.type == OpcionRelacional.DIFERENTE){
            const result = leftValue.value != rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        } 
        else if(this.type == OpcionRelacional.MENOR){
            const result = leftValue.value < rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        else if(this.type == OpcionRelacional.MENOR_IGUAL){
            const result = leftValue.value <= rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        } 
        else if(this.type == OpcionRelacional.MAYOR){
            const result = leftValue.value > rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        else if(this.type == OpcionRelacional.MAYOR_IGUAL){
            const result = leftValue.value >= rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        return {value:0, type : Type.NUMBER}
    }
}