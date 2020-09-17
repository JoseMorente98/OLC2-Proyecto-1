import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { Declaracion } from './declaracion.instruccion';
import { Aritmetica } from '../expresion/aritmetica.expresion';

export class For extends Instruction {

    /**
     * CONSTRUCTOR
     * @param inicializacion 
     * @param condicion 
     * @param actualizacion 
     * @param code 
     * @param fila 
     * @param columna 
     */
    constructor(
        private inicializacion: Declaracion,
        private condicion: Expression,
        private actualizacion: Expression,
        private code: Instruction, 
        fila: number, 
        columna: number){
        super(fila, columna);
    }

    public execute(environment : Environment) {
        console.error('FOR')
        console.log(environment)
        console.log(this.condicion)
        let inicializacion = this.inicializacion.execute(environment);
        let condicion = this.condicion.execute(environment);
        //let actualizacion = this.actualizacion.execute(environment);
        console.error('INICIALIZACION')
        console.log(inicializacion)

        //console.log(actualizacion)
        console.log(condicion)
        console.log(this.code)

        if(condicion.type != Type.BOOLEAN){
            throw {error: "La condicion no es booleana", linea: this.fila, columna : this.columna};
        }
        
        console.log(condicion.value == true)

        while(condicion.value == true){
            const element = this.code.execute(environment);
            console.log(element)
            if(element != null || element != undefined){
                console.log(element);
                if(element.type == 'Break')
                    break;
                else if(element.type == 'Continue')
                    continue;
            }
            
            let actualizacion = this.actualizacion.execute(environment);
            environment.setVar(this.inicializacion.id, actualizacion.value, actualizacion.type);

            condicion = this.condicion.execute(environment);

            if(condicion.type != Type.BOOLEAN){
                throw {error: "La condicion no es booleana", linea: this.fila, columna : this.columna};
            }
        }
        
    }
}