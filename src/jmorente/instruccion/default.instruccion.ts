import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { SalidaControlador } from '../controlador/salida.controlador';

export class Default extends Instruction {

    /**
     * CONSTRUCTOR
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(private code: Instruction,
        fila: number,
        columna: number){
        super(fila, columna);
    }

    public execute(environment : Environment) {
        console.error("DEFAULT")
        console.error(this.code)
        const code = this.code.execute(environment);
        console.error(code)
    }
}