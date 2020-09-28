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
        
        const func = environment.getFuncion(this.id);
        //console.log(func)



        if(func != undefined){
            //console.log(func)
            const newEnv = new Environment(environment.getGlobal());
            //console.log(newEnv)
            for(let i = 0; i < this.expresiones.length; i++){
                const value = this.expresiones[i].execute(environment);
                //console.log(value)
                newEnv.guardar(func.parametros[i], value.value, value.type);
                
            }
            
            const funcionElement = func.code.execute(newEnv);
            


            if(funcionElement != null || funcionElement != undefined){
                console.log(funcionElement);
                if(funcionElement.type == 'Return') {
                    if(funcionElement.value == null || funcionElement.value == undefined) {
                        return undefined;
                    } else {
                        return funcionElement.value;
                    }
                }
            } else {
                console.log("AMBIENTE")
            console.log(newEnv)
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
