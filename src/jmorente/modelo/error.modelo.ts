export class ModeloError {
    id: number;
    descripcion: string;
    tipo: string;
    fila: number;
    columna: number;

    constructor(id:number, descripcion:string, tipo:string, fila:number, columna:number) {
        this.id = id;
        this.descripcion = descripcion;
        this.tipo = tipo;
        this.fila = fila;
        this.columna = columna;
    }
    
    public get getId() : number {
        return this.id;
    }

    public set setId(v : number) {
        this.id = v;
    }
    
    public get getDescripcion() : string {
        return this.descripcion;
    }
    
    public set setDescripcion(v : string) {
        this.descripcion = v;
    }
    
    public get getFila() : number {
        return this.fila;
    }
    
    public set setFila(v : number) {
        this.fila = v;
    }
    
    public get getColumna() : number {
        return this.columna;
    }

    public set setColumna(v : number) {
        this.columna = v;
    }

    public get getTipo() : string {
        return this.tipo;
    }

    public set setTipo(v : string) {
        this.tipo = v;
    }

    toString() {
        return {
            "id" : this.id,
            "descripcion" : this.descripcion,
            "tipo" : this.tipo,
            "fila" : this.fila,
            "columna" : this.columna
        };
    }

}