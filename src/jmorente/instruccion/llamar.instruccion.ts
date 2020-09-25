import { Expression } from '../abstract/expresion.abstract';
import { Instruction } from '../abstract/instruccion.abstract';
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
        console.error("FUNCIONES LLAMAR")
        console.log(this.expresiones)
        
        const func = environment.getFuncion(this.id);
        console.log(func)



        if(func != undefined){
            console.log(func)
            const newEnv = new Environment(environment.getGlobal());
            console.log(newEnv)
            for(let i = 0; i < this.expresiones.length; i++){
                const value = this.expresiones[i].execute(environment);
                console.log(value)
                newEnv.guardar(func.parametros[i], value.value, value.type);
            }
            func.code.execute(newEnv);
            console.log(func)
        }
    }
}