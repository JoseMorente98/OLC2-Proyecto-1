import { Type } from '../abstract/retorno.abstract';

export class Symbol {

    /**
     * CONSTRUCTOR
     * @param valor 
     * @param id 
     * @param type 
     * @param fila 
     * @param columna 
     */
    constructor(
        public valor: any, 
        public id: string, 
        public type: Type, 
        public descripcion?:any, 
        public fila?:number, 
        public columna?:number
    ){
        this.valor = valor;
        this.id = id;
        this.type = type;
        this.descripcion = descripcion;
        this.fila = fila;
        this.columna = columna;
    }
}