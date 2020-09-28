import { Instruction } from '../abstract/instruccion.abstract';
import { Expression } from '../abstract/expresion.abstract';
import { Environment } from '../simbolos/enviroment.simbolos';
import { Type } from '../abstract/retorno.abstract';
import { ErrorControlador } from '../controlador/error.controlador';

export class Declaracion extends Instruction{

    /**
     * CONSTRUCTOR
     * @param id 
     * @param type 
     * @param value 
     * @param fila 
     * @param columna 
     */
    constructor(
        public id: string, 
        public type:any, 
        public value: Expression, 
        public fila: number, 
        public columna: number,
        public typeType?:any){
        super(fila, columna);
        this.id = id;
        this.value = value;
        this.type = type;
        this.typeType = typeType;
    }

    public execute(environment: Environment) {
        try {
            //console.error("DECLARACION" + this.id)
            //console.error(environment)
            //console.error(this.type)
            //console.error(this.value)
            //console.error(this.typeType)
            const val = this.value.execute(environment);
            //console.error(val)
            if(this.type == undefined) {
                environment.guardar(this.id, val.value, val.type, "LET", this.fila, this.columna);
            } else {
                if(this.type != val.type) {
                    throw {error: "El tipo " + val.value + " no es asignable con " + this.obtenerTipo(this.type), fila: this.fila, columna : this.columna};
                } else {
                    /**
                     * AGREGAR VALIDACIONES DE TIPO TYPE
                     */
                    /*if(val.type == 3) {
                        //console.log("================TYPE======================")
                        let typeType = environment.getTypes(this.typeType); 
                        typeType.valor
                        //console.log(typeType)
                        //console.log("================ITEMS======================")
                        //console.log(val.value)
                        for (const item of val.value) {
                            //console.log("================ITEMS VALIDAR======================")

                            let ejecutar = item.execute(environment);
                            //console.log("================EJECUTAR======================")
                            //console.error(ejecutar)
                            for (const item2 of typeType.valor) {
                                //console.log(item2)
                                if(ejecutar.id == item2.id) {
                                    //console.error(ejecutar)
                                    //console.error(item2)
                                    //console.error(ejecutar.type)
                                    //console.error(item2.type)

                                    
                                    switch (item2) {
                                        case 'number':
                                            if(ejecutar.type!=0) {
                                                throw {error: "El tipo " + ejecutar.value + " no es asignable con " + item2.type.toUpperCase(), fila: ejecutar.fila, columna : ejecutar.columna};
                                            }
                                            break;
                                        case 'string':
                                            if(ejecutar.type!=1) {
                                                throw {error: "El tipo " + ejecutar.value + " no es asignable con " + item2.type.toUpperCase(), fila: ejecutar.fila, columna : ejecutar.columna};
                                            }
                                            break;
                                        case 'boolean':
                                            if(ejecutar.type!=2) {
                                                throw {error: "El tipo " + ejecutar.value + " no es asignable con " + item2.type.toUpperCase(), fila: ejecutar.fila, columna : ejecutar.columna};
                                            }
                                            break;
                                        default:
                                            //TODO: BUSCAR AMBITO Y VALIDAR QUE EXISTA
                                            //console.error("==========AMBITO==========")
                                            //console.error(item2.typeType)
                                            let ambito = environment.getTypes(item2.type); 
                                            if(ambito != undefined) {
                                                if(ambito.type!=3) {
                                                    throw {error: "El tipo " + ejecutar.value + " no es asignable con " + item2.type.toUpperCase(), fila: ejecutar.fila, columna : ejecutar.columna};
                                                }
                                            }
                                            break;
                                    }
                                }
                                
                            }
                            continue;
                            //console.log(item)
                            
                        }
                        //console.log("================ITEMS======================")
                    } else {*/
                        /**
                         * ALMACENAR STRING, NUMBER, BOOLEAN
                         */
                        environment.guardar(this.id, val.value, val.type, "LET", this.fila, this.columna);
                    //}
                }
            }
        } catch (error) {
            /**
             * INGRESAR ERRORES SEMANTICOS
             */
            ErrorControlador.getInstancia().agregarError(error.error, "Semántico", error.fila, error.columna);
        }
        
    }

    public obtenerTipo(type: Type):string {
        switch (type) {
            case 0:
                return "NUMBER"
            case 1:
                return "STRING"
            case 2:
                return "BOOLEAN"
            case 3:
                return "TYPE"
        }
        return ""
    }

}