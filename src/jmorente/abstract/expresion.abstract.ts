//import { tipos } from "../Util/TablaTipos";

import { Retorno } from './retorno.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export abstract class Expression {
    public fila: number;
    public columna: number;

    /**
     * CONSTRUCTOR
     * @param fila 
     * @param columna 
     */
    constructor(fila: number, columna: number) {
        this.fila = fila;
        this.columna = columna;
    }

    public abstract execute(environment: Environment) : Retorno;

    /*public tipoDominante(tipo1 : Type, tipo2 : Type) : Type{
        const type = tipos[tipo1][tipo2];
        return type;
    }*/

}