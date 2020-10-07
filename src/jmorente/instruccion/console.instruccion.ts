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
        //console.error(this.value)
        const value = this.value.execute(environment);
        //console.error("CONSOLE")
        //console.error(value)
        if(value.type == 3) {
            SalidaControlador.getInstancia().asignarValor(value.value.valorSTR + "\n");
        }if(value.type == 5) {
            SalidaControlador.getInstancia().asignarValor(undefined + "\n");
        } else {
            SalidaControlador.getInstancia().asignarValor(value.value.toString() + "\n");
        }
    }
}