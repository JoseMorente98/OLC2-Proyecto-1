import { Instruction } from '../abstract/instruccion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Types extends Instruction {

    constructor(
        public id: string,
        public type:any,
        public value: any, 
        public fila: number, 
        public columna: number
    ) {
        super(fila, columna);
        this.id = id;
        this.value = value;
        this.type = type;
    }

    public execute(environment: Environment) {
        try {
            //console.error("DECLARACION TYPE")
            //console.log(environment)
            //console.log(this.value)

            environment.guardarTypes(this.id, this.value, this.type);

            //const val = this.value.execute(environment);
            ////console.log(val)
            /*if(this.type == undefined) {
                environment.guardar(this.id, val.value, val.type);
            } else {
                if(this.type != val.type) {
                    throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(this.type), fila: this.fila, columna : this.columna};
                } else {
                    environment.guardar(this.id, val.value, val.type);
                }
            }8*/
        } catch (error) {
            //console.log(error)
            /**
             * INGRESAR ERRORES SEMANTICOS
             */
            //ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
        }
        
    }

}