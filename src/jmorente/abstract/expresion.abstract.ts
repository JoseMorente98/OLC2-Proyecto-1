//import { tipos } from "../Util/TablaTipos";

import { Retorno } from './retorno.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';

export abstract class Expression {

    /**
     * CONSTRUCTOR
     * @param fila 
     * @param columna 
     */
    constructor(
        public fila: number,
        public columna: number) {
        this.fila = fila;
        this.columna = columna;
    }

    public abstract execute(environment: Environment) : Retorno;

}