import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';

export class SinTipoType extends Instruction{

    /**
     * CONSTRUCTOR
     * @param id 
     * @param id2 
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public id2: string, 
        public value: Expression,
        public fila: number, 
        public columna: number){
        super(fila, columna);
        this.id = id;
        this.value = value;
    }

    public execute(environment: Environment) {
        try {
            console.error("SIN TIPO TYPE")
            console.log(environment)
            const val = this.value.execute(environment);
            console.log(val)
            // TODO: SIN TIPO
            /**
             * VALIDAR VALOR
             */

            const value = environment.getVar(this.id);
            console.log(value);
            if(value == null) {
                throw new Error("La variable no existe D:");
            }
    
            for (const iterator of value.valor.value) {
                if(iterator.id == this.id2) {
                        console.log(iterator.value.value)
                    iterator.value.value = val.value;
                    return {value : iterator.value.value, type : iterator.value.type};
                }
            }
            /*switch (val.type) {
                /**
                 * VALIDAR NUMBER
                 *
                case 0:
                    if(valor.type == 0) {
                        environment.setVar(this.id, val.value, val.type);
                    } else {
                        throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(valor.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                /**
                 * VALIDAR STRING
                 *
                case 1:
                    if(valor.type == 1) {
                        environment.setVar(this.id, val.value, val.type);
                    } else {
                        throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(valor.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                /**
                 * VALIDAR BOOLEAN
                 *
                case 2:
                    if(valor.type == 2) {
                        environment.setVar(this.id, val.value, val.type);
                    } else {
                        throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(valor.type), fila: this.fila, columna : this.columna};
                    }
                    break;
                default:
                    throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(valor.type), fila: this.fila, columna : this.columna};
            }*/
        } catch (error) {
            /**
             * INGRESAR ERRORES SEMANTICOS
             */
            ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
        }
        
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

}