import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Retorno } from '../abstract/retorno.abstract';

export class AccesoType3 extends Expression {

    /**
     * CONSTRUCTOR
     * @param id 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public id2: string, 
        public id3: string, 
        public fila : number, 
        public columna: number){
        super(fila, columna);
    }

    public execute(environment: Environment): Retorno {
        //console.error("ACCESO TYPE 3")
        //console.log(this.id)
        //console.log(this.id2)
        //console.log(this.id3)
        const value = environment.getVar(this.id);
        //console.error("___________")

        //console.log(value)
        //console.error("___________")

        if(value == null) {
            throw new Error("La variable no existe D:");
        }

        //console.log()
        for (const iterator of value.valor.value) {

            if(iterator.id == this.id2) {
                //return {value : iterator.value.value, type : iterator.value.type};
                //console.log("BUSCAR ID 3")
                //console.log(iterator)
                const value2 = environment.getVar(iterator.value.id);


                if(value2 != undefined || value != null) {
                    for (const iterator2 of value2.valor.value) {

                        if(iterator2.id == this.id3) {
                            return {value : iterator2.value.value, type : iterator2.value.type};
                        }
                        
                    }
                }
            }
        }
        return {value : value.valor, type : value.type};
    }
}