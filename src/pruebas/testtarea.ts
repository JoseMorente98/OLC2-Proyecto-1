console.log("HOla")

/**
 * TYPES
 */
type persona = {
    nombre:string,
    apellido: string,
    edad: number,
    trabaja: boolean,
    estudia: boolean
};

type hola = {
    nombre:string,
    apellido: string,
    edad: hola
};

let comoestas:hola = { 
    nombre:"nombre",
    apellido: "apellido",
    edad: { 
        nombre:"nombre",
        apellido: "apellido",
        edad: { 
            nombre:"nombre",
            apellido: "apellido",
            edad: "hola"
        }
    }
};


console.log(comoestas);
let persona1:hola;