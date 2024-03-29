import { Type } from '../abstract/retorno.abstract';
import { Funcion } from '../instruccion/funcion.instruccion';
import { Symbol } from './symbol.simbolos';

export class Environment{
    public variables: Map<string, Symbol>;
    public types: Map<string, Symbol>;
    public funciones: Map<string, Funcion>;

    /**
     * CONSTRUCTOR
     * @param anterior 
     * @param nombre 
     */
    constructor(
        public anterior : Environment | null,
        public nombre?: string
    ){
        //INICIALIAZAR MAPS
        this.variables = new Map();
        this.funciones = new Map();
        this.types = new Map();
        this.nombre = nombre;
    }

    /*public guardar(id: string, valor: any, type: Type){
        let env : Environment | null = this;
        while(env != null){
            if(env.variables.has(id)){
                env.variables.set(id, new Symbol(valor, id, type));
                return;
            }
            env = env.anterior;
        }
        this.variables.set(id, new Symbol(valor, id, type));
    }

    public guardarFuncion(id: string, funcion : Function){
        //TODO ver si la funcion ya existe, reportar error
        this.funciones.set(id, funcion);
    }

    public getVar(id: string) : Symbol | undefined | null{
        let env : Environment | null = this;
        while(env != null){
            if(env.variables.has(id)){
                return env.variables.get(id);
            }
            env = env.anterior;
        }
        return null;
    }   

    public getFuncion(id: string) : Function | undefined{
        let env : Environment | null = this;
        while(env != null){
            if(env.funciones.has(id)){
                return env.funciones.get(id);
            }
            env = env.anterior;
        }
        return undefined;
    }

    public getGlobal() : Environment{
        let env : Environment | null = this;
        while(env?.anterior != null){
            env = env.anterior;
        }
        return env;
    }*/

    public getFuncion(id: string) : Funcion | undefined{
        let env : Environment | null = this;
        while(env != null){
            if(env.funciones.has(id)){
                return env.funciones.get(id);
            }
            env = env.anterior;
        }
        return undefined;
    }

    public getGlobal() : Environment{
        let env : Environment | null = this;
        while(env?.anterior != null){
            env = env.anterior;
        }
        return env;
    }

    public guardarFuncion(id: string, funcion : Funcion){
        this.funciones.set(id, funcion);
    }

    public getVar(id: string) : Symbol | undefined | null{
        let env : Environment | null = this;
        while(env != null){
            if(env.variables.has(id)){
                return env.variables.get(id);
            }
            env = env.anterior;
        }
        return null;
    }

    public setVar(id: string, valor: any, type: Type){
        let env : Environment | null = this;
        while(env != null){
            if(env.variables.has(id)){
                env.variables.set(id, new Symbol(valor, id, type))
                return;
            }
            env = env.anterior;
        }
    }

    public guardar(id: string, valor: any, type: Type, descripcion?: any, fila?: any, columna?: any){
        let env : Environment | null = this;
        while(env != null){
            if(env.variables.has(id)){
                env.variables.set(id, new Symbol(valor, id, type, descripcion, fila, columna));
                return;
            }
            env = env.anterior;
        }
        this.variables.set(id, new Symbol(valor, id, type, descripcion, fila, columna));
    }

    public guardarTypes(id: string, valor: any, type: Type){
        let env : Environment | null = this;
        while(env != null){
            if(env.types.has(id)){
                env.types.set(id, new Symbol(valor, id, type));
                return;
            }
            env = env.anterior;
        }
        this.types.set(id, new Symbol(valor, id, type));
    }

    public getTypes(id: string) : Symbol | undefined | null{
        let env : Environment | null = this;
        while(env != null){
            if(env.types.has(id)){
                return env.types.get(id);
            }
            env = env.anterior;
        }
        return null;
    }
    
}