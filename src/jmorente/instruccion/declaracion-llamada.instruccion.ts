import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';
import { TablaControlador } from '../controlador/tabla.controlador';

export class DeclaracionLlamada extends Instruction{

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
        public type:any, 
        public code:Instruction, 
        public fila: number, 
        public columna: number,
        public typeType?:any){
        super(fila, columna);
        this.id = id;
        this.code = code;
        this.typeType = typeType;
        this.fila = fila;
        this.columna = fila;
    }

    public execute(environment: Environment) {
        try {
            console.error("DECLARACION" + this.id)
            console.error(this.fila)
            console.error(this.columna)
            //console.error(environment)
            //console.error(this.code)
            //console.error(this.typeType)
            const val = this.code.execute(environment);
            //console.error(val)
            if(this.type == undefined) {
                environment.guardar(this.id, val.value, val.type, "LET", this.fila, this.columna);
                //TablaControlador.getInstancia().agregarToken(this.id, val.type, 'LET', val.value, this.fila, this.columna);
            } else {
                if(this.type != val.type) {
                    throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(this.type), fila: this.fila, columna : this.columna};
                } else {
                    environment.guardar(this.id, val.value, val.type, "LET", this.fila, this.columna);
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
            case 3:
                return "TYPE"
        }
        return ""
    }

}