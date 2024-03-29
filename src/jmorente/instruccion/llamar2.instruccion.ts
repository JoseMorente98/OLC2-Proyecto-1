import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';

export class LlamarFuncion2 extends Instruction{

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
        public expresiones : Array<Expression>,
        public fila: number, 
        public columna: number){
        super(fila, columna);
        this.id = id;
    }

    public execute(environment: Environment) {
        try {
            //console.error("LLAMADA REGRESA EXPRESION" + this.id)
            //console.error(environment)
            //console.error(this.code)
            //console.error(this.typeType)
            const func = environment.getFuncion(this.id);
            //console.error(func)

            if(func != undefined){
            //console.error("ENTRA FUNC" + this.id)
                //console.log(func)
                const nuevoEntorno = new Environment(environment.getGlobal());
                //console.log(nuevoEntorno)
                for(let i = 0; i < this.expresiones.length; i++){
                    const value = this.expresiones[i].execute(environment);
                    //console.log(value)
                    nuevoEntorno.guardar(func.parametros[i], value.value, value.type);
                }
    
                const funcion_Elementos = func.code.execute(nuevoEntorno);
                //console.log("LO QUE TRAE LA LLAMADA")
                //console.log(funcion_Elementos)
                
                if(funcion_Elementos != null || funcion_Elementos != undefined){
                    //console.log(funcion_Elementos);
                    if(funcion_Elementos.type == 'Return') {
                        console.log("RETORNAR DATOS")
                    console.log(funcion_Elementos.value)
                        if(funcion_Elementos.value == null || funcion_Elementos.value == undefined) {
                            return undefined;
                        } else {
                            console.log(funcion_Elementos)
                            return funcion_Elementos.value;
                        }
                    }
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