import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Retorno } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';

export class Acceso extends Expression {

    /**
     * CONSTRUCTOR
     * @param id 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string,
        public fila : number,
        public columna: number
    ){
        super(fila, columna);
    }

    public execute(environment: Environment): Retorno {
        // //console.error("ACCESO")
        // //console.log(environment)
        const value = environment.getVar(this.id);
        // //console.log(value)

        

        if(value == null) {
            ErrorControlador.getInstancia().agregarError(this.id + " NO esta definido", "Sintactico", this.fila, this.columna)
            return {value : undefined, type : 5};
        }
        return {value : value.valor, type : value.type};
    }
}