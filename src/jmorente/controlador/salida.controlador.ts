
export class SalidaControlador {
    private strSalida:string = "";

    //SINGLETON
    private static instancia: SalidaControlador;

    /**
     * CONSTRUCTOR
     */
    private constructor() { }

    public static getInstancia(): SalidaControlador {
        if (this.instancia == null) {
            this.instancia = new SalidaControlador();
        }
        return this.instancia;
    }

    /**
     * ASIGNAR VALOR
     */
    public asignarValor(strSalida: string) {
        this.strSalida += strSalida;
    }

    /**
     * OBTENER SALIDA
     */
    public get getSalida() : string {
        return this.strSalida
    }

    /**
     * LIMPIAR VARIABLE
     */
    public clear() {
        this.strSalida = "";
    }
    
}