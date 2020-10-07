import { Expression } from '../abstract/expresion.abstract';
import { Instruction } from '../abstract/instruccion.abstract';
import { TablaControlador } from '../controlador/tabla.controlador';
import { Environment } from '../simbolos/enviroment.simbolos';

export class LlamarFuncion extends Instruction {

    /**
     * CONSTRUCTOR
     * @param id 
     * @param expresiones 
     * @param line 
     * @param column 
     */
    constructor(
        public id: string, 
        public expresiones : Array<Expression>, 
        public line : number, 
        public column : number
    ){
        super(line, column);
    }

    public execute(environment : Environment) {
        //console.error("FUNCIONES LLAMAR")
        //console.error("================================")
        //console.log(this.expresiones)
        
        const funcion_llamada = environment.getFuncion(this.id);
        //console.error(funcion_llamada);



        if(funcion_llamada != null || funcion_llamada != undefined){
            const nuevoEntorno = new Environment(environment.getGlobal());
            
            /**
             * EJECUTAR EXPRESIONES RECIBIDAS
             */
            for(let i = 0; i < this.expresiones.length; i++){
                const value = this.expresiones[i].execute(environment);
                //console.log(value)
                nuevoEntorno.guardar(funcion_llamada.parametros[i], value.value, value.type);
                
            }
            
            const funcion_Elementos = funcion_llamada.code.execute(nuevoEntorno);
            //console.error("funcino element")
            //console.error(funcion_Elementos)


            if(funcion_Elementos != null || funcion_Elementos != undefined){
                //console.log(funcion_Elementos);
                if(funcion_Elementos.type == 'Break') {
                    return;
                } else 
                if(funcion_Elementos.type == 'Return') {
                    if(funcion_Elementos.value == null || funcion_Elementos.value == undefined) {
                        return undefined;
                    } else {
                        return funcion_Elementos.value;
                    }
                }
            }
        }
        //console.error("================================")
        

    }

    public obtenerTipo(type: any):string {
        switch (type) {
            case 0:
                return "NUMBER"
            case 1:
                return "STRING"
            case 2:
                return "BOOLEAN"
        }
        return "OTHER"
    }
}
