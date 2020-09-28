import { Expression } from '../abstract/expresion.abstract';
import { Instruction } from '../abstract/instruccion.abstract';
import { Retorno } from '../abstract/retorno.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Case extends Instruction {
    
    /**
     * CONSTRUCTOR
     * @param condition 
     * @param code 
     * @param fila 
     * @param columna 
     */
    constructor(
        private condition: Expression,
        private code: Instruction,
        public fila: number,
        public columna: number)
    {
        super(fila, columna);
    }

    public execute(environment: Environment) {
        const element = this.code.execute(environment);
        if(element != null || element != undefined){
            if(element != null || element != undefined){
                //console.log(element);
                if(element.type == 'Break')
                    return;
                else if(element.type == 'Return')
                    return element.value;
            }
        }
    }

    obtenerCondicion = (environment: Environment): Retorno =>  {
        return this.condition.execute(environment);
    } 

}