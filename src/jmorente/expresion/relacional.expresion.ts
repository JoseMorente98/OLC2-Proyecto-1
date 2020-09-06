import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Retorno, Type } from '../abstract/retorno.abstract';

export enum RelationalOption{
    IGUAL,
    DIFERENTE,
    MENOR,
    MENOR_IGUAL,
    MAYOR,
    MAYOR_IGUAL
}

export class Relational extends Expression {

    constructor(private left: Expression, private right: Expression, private type : RelationalOption, line: number, column: number){
        super(line,column);
    }

    public execute(environment : Environment) : Retorno{
        const leftValue = this.left.execute(environment);
        const rightValue = this.right.execute(environment);
        if(this.type == RelationalOption.IGUAL){
            const result = leftValue.value == rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        else if(this.type == RelationalOption.DIFERENTE){
            const result = leftValue.value != rightValue.value;
            return {value : result, type : Type.BOOLEAN};
        }
        return {value:0, type : Type.NUMBER}
    }
}