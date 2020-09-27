import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { ErrorControlador } from '../controlador/error.controlador';

export class Value extends Instruction{

    /**
     * CONSTRUCTOR
     * @param id 
     * @param type 
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string,
        public value: Expression, 
        public fila: number, 
        public columna: number
    ){
        super(fila, columna);
        this.id = id;
        this.value = value;
    }

    public execute(environment: Environment) {
        try {
            //console.error("VALUE TYPE")
            //console.log(this.id)
            //console.log(this.value)
            const val = this.value.execute(environment);

            return {id: this.id, value: val.value, type: val.type};
            
        } catch (error) {
            /**
             * INGRESAR ERRORES SEMANTICOS
             */
            ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
        }
        
    }

}