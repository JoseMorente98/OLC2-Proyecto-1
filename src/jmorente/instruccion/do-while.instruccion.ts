import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';

export class DoWhile extends Instruction{

    /**
     * CONSTRUCTOR
     * @param condicion 
     * @param code 
     * @param fila 
     * @param columna 
     */
    constructor(
        private condicion: Expression,
        private code: Instruction, 
        fila: number, 
        columna: number){
        super(fila, columna);
    }

    public execute(env : Environment) {
        //console.error('WHILE')
        //console.log(env)
        //console.log(this.condicion)
        let condicion = this.condicion.execute(env);
        //console.log(condicion)
        //console.log(this.code)

        if(condicion.type != Type.BOOLEAN){
            throw {error: "La condicion no es booleana", linea: this.fila, columna : this.columna};
        }
        //console.log(condicion.value == true)
        do {
            const element = this.code.execute(env);
            //console.log(element)
            if(element != null || element != undefined){
                //console.log(element);
                if(element.type == 'Break')
                    break;
                else if(element.type == 'Continue')
                    continue;
            }
            condicion = this.condicion.execute(env);
            if(condicion.type != Type.BOOLEAN){
                throw {error: "La condicion no es booleana", linea: this.fila, columna : this.columna};
            }
        } while(condicion.value == true);
    }
}