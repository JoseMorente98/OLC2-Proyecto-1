export enum Type{
    NUMBER = 0,
    STRING = 1,
    BOOLEAN = 2,
    TYPE = 3,
    NULL = 4,
    ARRAY = 5
}

export type Retorno ={
    value : any,
    valor?: any,
    type : Type,
}