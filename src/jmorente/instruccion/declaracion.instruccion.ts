import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export class Declaracion extends Instruction{
    private id: string;
    private value: Expression;
    private tipo: any;

    constructor(id: string, tipo:any, value: Expression, fila: number, columna: number){
        super(fila, columna);
        this.id = id;
        this.value = value;
        this.tipo = tipo;
    }

    public execute(environment: Environment) {
        //console.error("DECLARACION")
        //console.log(environment)
        const val = this.value.execute(environment);
        //console.log(val)
        environment.guardar(this.id, val.value, val.type);
    }

}