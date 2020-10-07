import { Instruction } from '../abstract/instruccion.abstract';
import { TablaControlador } from '../controlador/tabla.controlador';
import { Environment } from '../simbolos/enviroment.simbolos';


export class Sentencia extends Instruction {

    /**
     * CONSTRUCTOR
     * @param code 
     * @param fila 
     * @param columna 
     */
    constructor(
        public code: Array<Instruction>, 
        public fila: number, 
        public columna: number) {
        super(fila, columna);
    }

    public execute(env: Environment) {
        //console.error("SENTENCIA")
        const nuevoEntorno = new Environment(env);
        for (const instr of this.code) {
            console.log(instr)
            
            try {
                const element = instr.execute(nuevoEntorno);
                //console.error(nuevoEntorno)
                

                if (element != undefined || element != null) {
                    if(element.type == 'Break') {
                        return;
                    } else
                    if(element.type == 'Return') {
                        if(element.value == null || element.value == undefined) {
                            return element;
                        } else {
                            console.log(element.value)
                            return element.value;
                        }
                    }
                    return element;
                }
            } catch (error) {
                ///errores.push(error);
                //console.error(error)
            }
        }

        /**
         * VARIABLES NUEVO ENTORNO
         */
        for (const iterator of nuevoEntorno.variables) {
            console.log(iterator[1])
            TablaControlador.getInstancia()
                .addToken(iterator[1].id, this.obtenerTipo(iterator[1].type), iterator[1].descripcion, iterator[1].valor, iterator[1].fila, iterator[1].columna);
        }
        TablaControlador.getInstancia().imprimir();

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
}
