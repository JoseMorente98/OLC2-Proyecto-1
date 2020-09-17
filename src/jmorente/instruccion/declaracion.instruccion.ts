import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';

export class Declaracion extends Instruction{
    public id: string;
    public value: Expression;
    public type: any;

    constructor(id: string, type:any, value: Expression, fila: number, columna: number){
        super(fila, columna);
        this.id = id;
        this.value = value;
        this.type = type;
    }

    public execute(environment: Environment) {
        try {
            console.error("DECLARACION")
            console.log(environment)
            const val = this.value.execute(environment);
            console.log(val)
            if(this.type == undefined) {
                environment.guardar(this.id, val.value, val.type);
            } else {
                if(this.type != val.type) {
                    throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(this.type), fila: this.fila, columna : this.columna};
                } else {
                    environment.guardar(this.id, val.value, val.type);
                }
            }
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