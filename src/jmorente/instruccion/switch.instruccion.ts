import { Expression } from '../abstract/expresion.abstract';
import { Instruction } from '../abstract/instruccion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Case } from './case.instruccion';

export class Switch extends Instruction {
        
    /**
     * CONSTRUCTOR
     * @param condicion 
     * @param cases 
     * @param code 
     * @param fila 
     * @param columna 
     */
    constructor(private condicion: Expression,
        private cases: Array<Case>,
        private code: Instruction,
        public fila: number, 
        public columna: number){
        super(fila, columna);
    }

    /**
     * METODO DE EJECUCION
     * @param environment 
     */
    public execute(environment: Environment){
        //console.error('SWITCH')
        var condicion = this.condicion.execute(environment);
        var numeroCaso = -1;

        for (var item in this.cases) {
        console.log(numeroCaso)
            
            let cases = this.cases[item].obtenerCondicion(environment);
            
            if (condicion.value == cases.value) {
                numeroCaso = Number(item);

                var newAmbit = new Environment(environment);
                const element = this.cases[item];
                element.execute(newAmbit);
                break;
            }
        }
        if (numeroCaso == -1) {
            console.log("DEFAULT SWITCH")
            console.log(this.code)
            if (this.code != null) {
                this.code.execute(environment)                
            }  
        }
        
    }

}