import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';

export class If extends Instruction {

    /**
     * CONSTRUCTOR
     * @param condition 
     * @param code 
     * @param elseDeclaracion 
     * @param fila 
     * @param columna 
     */
    constructor(private condition: Expression,
        private code: Instruction,
        private elseDeclaracion: Instruction | null,
        fila: number,
        columna: number){
        super(fila, columna);
    }

    public execute(env : Environment) {
        //console.error('SENTENCIA IF')
        //console.error(this.code)
        //console.error(this.elseDeclaracion)
        const condition = this.condition.execute(env);
        if(condition.type != Type.BOOLEAN){
            throw {error: "La condicion no es booleana", linea: this.fila, columna: this.columna};
        }

        if(condition.value == true){
            return this.code.execute(env);
        }
        else{
            return this.elseDeclaracion?.execute(env);
        }
    }
}