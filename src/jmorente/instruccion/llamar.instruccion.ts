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
        const func = environment.getFuncion(this.id);
        if(func != undefined){
            const newEnv = new Environment(environment.getGlobal());
            for(let i = 0; i < this.expresiones.length; i++){
                const value = this.expresiones[i].execute(environment);
                newEnv.guardar(func.parametros[i], value.value, value.type);
            }
            func.statment.execute(newEnv);
        }
    }
}