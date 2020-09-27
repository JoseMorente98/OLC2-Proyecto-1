import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';

export class SinTipoTypeLlamada extends Instruction{

    /**
     * CONSTRUCTOR
     * @param id 
     * @param id2 
     * @param code 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public id2: string, 
        public code: Instruction,
        public fila: number, 
        public columna: number){
        super(fila, columna);
        this.id = id;
        this.code = code;
    }

    public execute(environment: Environment) {
        try {
            //console.error("SIN TIPO TYPE LLAMADA")
            //console.log(environment)
            const val = this.code.execute(environment);
            //console.log(val)
            // TODO: SIN TIPO
            /**
             * VALIDAR VALOR
             */
            

            const code = environment.getVar(this.id);
            //console.log(code);
            if(code == null) {
                throw new Error("La variable no existe D:");
            }
    
            for (const iterator of code.valor.code) {
                if(iterator.id == this.id2) {
                        //console.log(iterator.code.code)
                    iterator.code.value = val.value;
                    return {code : iterator.code.value, type : iterator.code.type};
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