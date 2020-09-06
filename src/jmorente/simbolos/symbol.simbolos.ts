import { Type } from '../abstract/retorno.abstract';

export class Symbol {
    public valor: any;
    public id: string;
    public type: Type;
    public fila: number;
    public columna : number;

    /**
     * CONSTRUCTOR
     * @param valor 
     * @param id 
     * @param type 
     * @param fila 
     * @param columna 
     */
    constructor(valor: any, id: string, type: Type, fila?:number, columna?:number){
        this.valor = valor;
        this.id = id;
        this.type = type;
        this.fila = fila;
        this.columna = columna;
    }
}