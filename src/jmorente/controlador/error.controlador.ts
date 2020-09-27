import { ModeloError } from '../modelo/error.modelo';

export class ErrorControlador {
    private arregloError: ModeloError[] = [];
    private idError:number = 1;

    //SINGLETON
    private static instancia: ErrorControlador;

    private constructor() { }

    public static getInstancia(): ErrorControlador {
        if (this.instancia == null) {
            this.instancia = new ErrorControlador();
        }
        return this.instancia;
    }

    public get getArregloError() : ModeloError[] {
        return this.arregloError; 
    }

    agregarError(descripcion:string, tipo:string, fila: number, columna:number){
        var token = new ModeloError(this.idError, descripcion, tipo, fila, columna);
        this.arregloError.push(token);
        this.idError++;
    }

    imprimirError(){
        //console.log("MOSTRAR REPORTE DE ERRORES")
        this.arregloError.forEach(e => {
            //console.error(e.toString());
        });
    }

    clear(){
        this.arregloError = [];
        this.idError = 1;
    }

}