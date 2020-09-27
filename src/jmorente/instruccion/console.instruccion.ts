import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { SalidaControlador } from '../controlador/salida.controlador';

export class Imprimir extends Instruction {

    /**
     * CONSTRUCTOR
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(
        private value: Expression,
        fila: number,
        columna: number){
        super(fila, columna);
    }

    public execute(environment : Environment) {
        const value = this.value.execute(environment);
        //console.log(value)
        if(value.type == 3) {
            SalidaControlador.getInstancia().asignarValor(value.value.valorSTR + "\n");
        } else {
            SalidaControlador.getInstancia().asignarValor(value.value.toString() + "\n");
        }
    }
}