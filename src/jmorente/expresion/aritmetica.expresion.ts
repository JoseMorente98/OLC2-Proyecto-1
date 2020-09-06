
import { env } from "process";
//import { Error_ } from "../Error";
import { Expression } from '../abstract/expresion.abstract';
import { Retorno, Type } from '../abstract/retorno.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export enum OpcionAritmetica{
    PLUS,
    MINUS,
    TIMES,
    DIV
}

export class Arithmetic extends Expression {

    constructor(private left: Expression, private right: Expression, private type : OpcionAritmetica, line: number, column: number){
        super(line,column);
    }

    public execute(environment : Environment) : Retorno {
        let result : Retorno;
        /*const leftValue = this.left.execute(environment);
        const rightValue = this.right.execute(environment);
        let result : Retorno;
        const tipoDominante = this.tipoDominante(leftValue.type, rightValue.type);
        
        if(this.type == OpcionAritmetica.PLUS){
            if(tipoDominante == Type.STRING)
                result = {value : (leftValue.value.toString() + rightValue.value.toString()), type : Type.NUMBER};
            else if(tipoDominante == Type.NUMBER)
                result = {value : (leftValue.value + rightValue.value), type : Type.NUMBER};
            else
                throw new Error_(this.line, this.column, 'Semantico', 'No se puede operar: ' + leftValue.type + ' _ ' + rightValue.type);            
        }
        else if(this.type == OpcionAritmetica.MINUS){
            if(tipoDominante == Type.STRING)
                throw new Error_(this.line, this.column, 'Semantico', 'No se puede operar: ' + leftValue.type + ' _ ' + rightValue.type);
            result = {value : (leftValue.value - rightValue.value), type : Type.NUMBER};
        }
        else if(this.type == OpcionAritmetica.TIMES){
            result = {value : (leftValue.value * rightValue.value), type : Type.NUMBER};
        }
        else{
            if(rightValue.value == 0){
                throw new Error_(this.line, this.column, "Semantico", "No se puede dividir entre 0");
            }
            result = {value : (leftValue.value / rightValue.value), type : Type.NUMBER};
        }*/
        return result;
    }
}