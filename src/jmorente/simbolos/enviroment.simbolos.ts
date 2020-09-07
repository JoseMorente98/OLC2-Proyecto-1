import { Type } from '../abstract/retorno.abstract';
import { Symbol } from './symbol.simbolos';

export class Environment{
    private variables: Map<string, Symbol>;
    public funciones: Map<string, Function>;

    /**
     * CONSTRUCTOR
     * @param anterior 
     */
    constructor(public anterior : Environment | null){
        this.variables = new Map();
        this.funciones = new Map();
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

    public guardar(id: string, valor: any, type: Type){
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
}