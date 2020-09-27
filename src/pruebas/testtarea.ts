//console.log("HOla");

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
    edad: string
};

let comoestas:hola = { 
    nombre:"nombre",
    apellido: "apellido",
    edad: "hola"
};

comoestas.nombre = "JOSE RAFAEL";

//console.log(comoestas);
//console.log(comoestas.nombre);
//console.log(comoestas.apellido);
//console.log(comoestas.edad);
comoestas.nombre = "JOSE CHIQUIN";

//console.log(comoestas);
//console.log(comoestas.nombre);
//console.log(comoestas.apellido);
//console.log(comoestas.edad);
//console.log(comoestas);
comoestas.nombre = "DAVID MORENTE";

//console.log(comoestas.nombre);
//console.log(comoestas.apellido);
//console.log(comoestas.edad);
let persona1:hola;