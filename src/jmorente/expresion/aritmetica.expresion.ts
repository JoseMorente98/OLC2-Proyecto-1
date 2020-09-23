import { Expression } from '../abstract/expresion.abstract';
import { Retorno, Type } from '../abstract/retorno.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { AccesoType } from './acceso-type.expresion';
import { Acceso } from './acceso.expresion';

export enum OpcionAritmetica{
    SUMA,
    RESTA,
    MULTIPLICACION,
    DIVISION,
    EXPONENTE,
    MODULO,
    INCREMENTO,
    DECREMENTO,
    NEGATIVO
}

export class Aritmetica extends Expression {
    /**
     * CONSTRUCTOR
     * @param left 
     * @param right 
     * @param type 
     * @param fila 
     * @param columna 
     */
    constructor(
        private left: Expression, 
        private right: Expression, 
        private type: OpcionAritmetica, 
        fila: number, 
        columna: number){
        super(fila,columna);
    }

    public execute(environment : Environment) : Retorno {
        let result : Retorno;
        const leftValue = this.left.execute(environment);
        const rightValue = this.right.execute(environment);

        if(this.type == OpcionAritmetica.SUMA) {
            switch (leftValue.type) {
                /**
                 * SI EL IZQUIERDO ES NUMBER
                 * NUMBER + NUMBER : NUMBER
                 * NUMBER + STRING : STRING
                 * NUMBER + OTHER : ERROR
                 */
                case 0:
                    switch (rightValue.type) {
                        case 0:
                            result = {value : (leftValue.value + rightValue.value), type : Type.NUMBER};
                            break;
                        case 1:
                            result = {value : (leftValue.value.toString() + rightValue.value.toString()), type : Type.STRING};
                            break;
                        default:
                            throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                /**
                 * SI EL IZQUIERDO ES STRING
                 * STRING + OTHER : STRING
                 */
                case 1:
                    result = {value : (leftValue.value.toString() + rightValue.value.toString()), type : Type.STRING};
                    break;
                /**
                 * SI EL IZQUIERDO ES BOOLEAN
                 * BOOLEAN + STRING : STRING
                 * BOOLEAN + OTHER : ERROR
                 */
                case 2:
                    switch (rightValue.type) {
                        case 1:
                            result = {value : (leftValue.value.toString() + rightValue.value.toString()), type : Type.STRING};
                            break;
                        default:
                            throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
            }
        } else if(this.type == OpcionAritmetica.RESTA) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER - NUMBER : NUMBER
             * NUMBER - OTHER : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    if(rightValue.type == 0) {
                        result = {value : (leftValue.value - rightValue.value), type : Type.NUMBER};
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
            }
        } else if(this.type == OpcionAritmetica.MULTIPLICACION) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER * NUMBER : NUMBER
             * NUMBER * OTHER : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    if(rightValue.type == 0) {
                        result = {value : (leftValue.value * rightValue.value), type : Type.NUMBER};
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
            }
        } else if(this.type == OpcionAritmetica.DIVISION) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER / NUMBER : NUMBER
             * NUMBER / OTHER : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    if(rightValue.type == 0) {
                        result = {value : (leftValue.value / rightValue.value), type : Type.NUMBER};
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
            }
        } else if(this.type == OpcionAritmetica.EXPONENTE) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER ^ NUMBER : NUMBER
             * NUMBER ^ OTHER : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    if(rightValue.type == 0) {
                        result = {value : Math.pow(leftValue.value, rightValue.value), type : Type.NUMBER};
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
            }
        } else if(this.type == OpcionAritmetica.MODULO) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER % NUMBER : NUMBER
             * NUMBER % OTHER : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    if(rightValue.type == 0) {
                        result = {value : (leftValue.value % rightValue.value), type : Type.NUMBER};
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
            }
        } else if(this.type == OpcionAritmetica.INCREMENTO) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER ++ : NUMBER
             * OTHER ++ : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    console.log(leftValue)
                    console.log(this.left.id)
                    let newVal = leftValue.value + 1;
                    if(rightValue.type == 0) {
                        result = {value : newVal, type : Type.NUMBER};
                        environment.setVar(this.left.id, result.value, result.type);
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type), fila: this.fila, columna : this.columna};
            }
        }else if(this.type == OpcionAritmetica.DECREMENTO) {
            /**
             * SI EL IZQUIERDO ES NUMBER
             * NUMBER -- : NUMBER
             * OTHER -- : ERROR
             */
            switch (leftValue.type) {
                case 0:
                    console.log(leftValue)
                    console.log(this.left.id)
                    if(rightValue.type == 0) {
                        let newVal = leftValue.value - 1;
                        result = {value : newVal, type : Type.NUMBER};
                        environment.setVar(this.left.id, result.value, result.type);
                    } else {
                        throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type), fila: this.fila, columna : this.columna};
            }
        }else if(this.type == OpcionAritmetica.NEGATIVO) {
            /**
             * SI EL IZQUIERDO ES -
             * - NUMBER : NUMBER
             * - BOOLEAN : 0 o -1
             * - STRING: NAN
             */
            switch (leftValue.type) {
                case 0:
                    result = {value : (-leftValue.value), type : Type.NUMBER};
                    break;
                case 1:
                    result = {value : (-leftValue.value), type : Type.NUMBER};
                    break;
                case 2:
                    result = {value : (-leftValue.value), type : Type.NUMBER};
                    break;
                default:
                    throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type), fila: this.fila, columna : this.columna};
            }
        } else {
            throw {error: "Operador " + this.obtenerOperador(this.type) + " NO puede ser aplicado a los tipos " + this.obtenerTipo(leftValue.type) + " con " + this.obtenerTipo(rightValue.type), fila: this.fila, columna : this.columna};
        }

        return result;
    }

    public obtenerTipo(type: Type):string {
        switch (type) {
            case 0:
                return "NUMBER"
            case 1:
                return "STRING"
            case 2:
                return "BOOLEAN"
        }
        return ""
    }

    public obtenerOperador(type: OpcionAritmetica):string {
        switch (type) {
            case 0:
                return "+"
            case 1:
                return "-"
            case 2:
                return "*"
            case 3:
                return "/"
            case 4:
                return "^"
            case 5:
                return "%"
            case 6:
                return "++"
            case 7:
                return "--"
            case 7:
                return "-"
        }
        return ""
    }
}