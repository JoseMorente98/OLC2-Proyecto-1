export class TablaControlador {
    private arregloSimbolos: any[] = [];

    //SINGLETON
    private static instancia: TablaControlador;

    private constructor() { }

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
        var simbolo = {id: id, 
            tipo: tipo, 
            descripcion:descripcion, 
            content:content, 
            fila: fila, 
            columna: columna};
        this.arregloSimbolos.push(simbolo);
    }

    imprimirToken(){
        this.arregloSimbolos.forEach(e => {
            console.log(e.toString());
        });
    }

}