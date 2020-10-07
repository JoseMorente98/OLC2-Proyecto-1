import { ThrowStmt } from '@angular/compiler';

export class TablaControlador {
    private arregloSimbolos: any[] = [];
    private arregloSimbolo: Map<string, DataSymbol>;

    //SINGLETON
    private static instancia: TablaControlador;

    private constructor() { 
        this.arregloSimbolo = new Map();
    }

    public static getInstancia(): TablaControlador {
        if (this.instancia == null) {
            this.instancia = new TablaControlador();
        }
        return this.instancia;
    }

    public get getArregloToken() : any[] {
        return this.arregloSimbolos; 
    }
    
    agregarToken(id: string, tipo:any, descripcion:string, content:any, fila: number, columna:number){
        //console.error("AGREGAR TOKEN")
        var simbolo = {id: id, 
            tipo: tipo, 
            descripcion:descripcion, 
            content:content, 
            fila: fila, 
            columna: columna};
        this.arregloSimbolos.push(simbolo);
    }

    addToken(id: string, tipo:any, descripcion:string, content:any, fila: number, columna:number){
        //console.error("AGREGAR TOKEN" + id)  
        if(this.arregloSimbolo.has(id)) {
          //   console.error("SI EXISTE TOKEN" + id)  

            this.arregloSimbolo.set(id, new DataSymbol(id, tipo, descripcion, content, fila, columna));
            return;
        } 
        //console.error("NO EXISTE TOKEN" + id)  

        this.arregloSimbolo.set(id, new DataSymbol(id, tipo, descripcion, content, fila, columna));
        //TablaControlador.getInstancia().imprimir()
        
    }

    imprimirToken(){
        this.arregloSimbolos.forEach(e => {
            //console.log(e)
        });
    }

    imprimir() {
        this.arregloSimbolos = []
        for (const iterator of this.arregloSimbolo) {
            //console.log(iterator[1])
            TablaControlador.getInstancia()
                .agregarToken(iterator[1].id, iterator[1].tipo, iterator[1].descripcion, iterator[1].content, iterator[1].fila, iterator[1].columna);
        }
        this.imprimirToken()
    }

    public obtenerTipo(type: any): string {
        switch (type) {
            case 0:
                return "NUMBER"
            case 1:
                return "STRING"
            case 2:
                return "BOOLEAN"
        }
        return "OTHER"
    }
    
    clear() {
        this.arregloSimbolos = []
    }

}

class DataSymbol {

    /**
     * CONSTRUCTOR
     * @param valor 
     * @param id 
     * @param type 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: any, 
        public tipo: string, 
        public descripcion?:any, 
        public content?:any, 
        public fila?:number, 
        public columna?:number
    ){
        this.id = id;
        this.content = content;
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.fila = fila;
        this.columna = columna;
    }
}