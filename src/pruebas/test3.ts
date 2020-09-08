/**
 * SALUDANDO
 * HOLA MUNDO
 */

var saludar:string = "Hola Mundo";

console.log(saludar);


/**
 * WHILE
 */
while (true) {

    console.log(saludar);
    break;
}

/**
 * DECLARACION DE VARIABLES
 */
var apellido:string = "";
var spanish1:string = "Hola \n Mundo";
var spanish3:string = "Hola \\ Mundo";
var spanish4:string = "Hola \r Mundo";
var spanish5:string = "Hola \t Mundo";
var english:string = 'Hello World';
var english2:string = 'Hello \n World';
var english3:string = 'Hello \\ World';
var english4:string = 'Hello \r World';
var english5:string = 'Hello \t World';
var english6:string = 'Hello \" World';
var cadena:string = `cadena de texto ${apellido} \n texto`;
var cadena2:string = `cadena de texto ${apellido} \\ texto`;
var cadena3:string = `cadena de texto ${apellido} \r texto`;
var cadena4:string = `cadena de texto ${apellido} \t texto`;
var cadena5:string = `cadena de texto ${apellido} \" texto`;
var cadena6:string = `cadena de texto ${apellido} texto`;
var edad:number = 1234;
var edad2:number = +1234;
var edad3:number = -1234;
var edad4:number = 12.34;
var edad5:number = +12.34;
var edad6:number = -12.34;
var sexo:boolean = true;

/**
 * STRING
 *
var variable1:string = "Hola \n Mundo";
var variable5:string = 1;
var variable5:string = true;

/**
 * NUMBER
 *
var variable10:number = 1;
var variable12:number = "1";
var variable11:number = true;

/**
 * BOOLEAN
 *
var variable20:boolean = 1;
var variable22:boolean = "Hola";
var variable21:boolean = true;

/**
 * VARIABLES SIN TIPO
 */
var varA = "hola";
var varB = 1;
var varC = true;

/**
 * VARIABLES SIN TIPO
 *
var varA:string = "Hola \n Mundo" + 5;
var varB:number =  5 + "Hola numer";
var varBC:number =  5 - "Hola numer";
var varBD:number =  5 * "Hola numer";
var varBE:number =  5 / "Hola numer";
var varCF:number =  5 % true;
var varD:number =  5 ^ false;
var varE:number =  5 + 6;
var varG:string =  5 + "Hola mundos";
console.log(varE);


/**
 * SUMA DE VARIABLE
 *
var varA:string = "Hola \n Mundo" + 5;
var varB:string = 6 + 5;
var varC:string = true + true;
var varD:string = true + false;
var varE:string = true + 5;
var varF:string = true + "hola mundo";

var varAA:string = "Hola \n Mundo" + 5 + "Hola";
var varAA:string = "Hola \n Mundo" + "hola";
var varAA:string = "Hola \n Mundo" + true;
var varAA:string = "Hola \n Mundo" + -5.12;
var varBB:number = 6 + 5;
var varCC:number = true + true;
var varDD:number = true + false;
var varEE:number = true + 5;
var varFF:number = true + "hola mundo";


var varAA:string = "Hola \n Mundo" + 5 + "Hola";
var varAAA:number = 10 + 12;
var varAAB:number = varAA - 12;
var varAAC:number = varAA * 2;
var varAAD:number = varAA / 2;
var varAAE:number = varAA ^ 2;
var varAAF:number = varAA % 3;
var varAAF:number = varAA++;
var varAAF:number = varAA--;


var constante:boolean = true==true;
var constanteA:boolean = true==false;
var constanteA:boolean = "hola"=="hola";
var constanteB:boolean = true!=true;
var constanteC:boolean = 5 < 7;
var constanteE:boolean = 5 > 7;
var constanteF:boolean = 5 >= 7;
var constanteD:boolean = 5 <= 7;

var varAAA:number = 10 + 12;//22
var varAAB:number = varAAA - 12;//12
var constanteD:boolean = 5 <= varAAA;//true
var constanteD:boolean = varAAA <= 5;//false
var constanteD:boolean = varAAB <= varAAA;//true
var constanteD:boolean = varAAB >= varAAA;//false
var constanteD:boolean = varAAB >= varAAA;//false
var constanteF:boolean = varAAB && varAAA;//false
var constanteG:boolean = varAAB || varAAA;//false
var constanteH:boolean = !varAAB;//false

var constanteF:boolean = true && true;//false
var constanteG:boolean = false || varAAA;//false
var constanteH:boolean = !varAAB;//false


var constanteAND:boolean = false && false;//false
var constanteAND:boolean = false && true;//false
var constanteAND:boolean = true && false;//false
var constanteAND:boolean = true && true;//true


var constanteOR:boolean = false || false;//false
var constanteOR:boolean = false || true;//true
var constanteOR:boolean = true || false;//true
var constanteOR:boolean = true || true;//true

var constanteNOT:boolean = !true;//false
var constanteNOT:boolean = !false;//true


var varAAA:number = 10 + 12;//22
var constanteAND1:boolean = varAAA && true;//true
var constanteNOT2:boolean = varAAA || true;//true
console.log(constanteAND1)
console.log(constanteNOT2)

var varAAA:number = 10 + 12;//22
var varAAAs:string = "hola" + 12;//22
var constanteNOT:boolean = !varAAA;//false
var constanteNOT2:boolean = !varAAAs;//false

console.log(varAAA);
console.log(varAAAs);
console.log(constanteNOT);
console.log(constanteNOT2);
console.log(varAAA);
console.log(varAAAs);
console.log(constanteNOT);
console.log(constanteNOT2);
console.log(varAAA);
console.log(varAAAs);
console.log(constanteNOT);
console.log(constanteNOT2);

/**
 * DECLARACION DE VARIABLES
 */
var apellido:string = "";
var spanish1:string = "Hola \n Mundo";
var spanish3:string = "Hola \\ Mundo";
var spanish4:string = "Hola \r Mundo";
var spanish5:string = "Hola \t Mundo";
var english:string = 'Hello World';
var english2:string = 'Hello \n World';
var english3:string = 'Hello \\ World';
var english4:string = 'Hello \r World';
var english5:string = 'Hello \t World';
var english6:string = 'Hello \" World';
var cadena:string = `cadena de texto ${apellido} \n texto`;
var cadena2:string = `cadena de texto ${apellido} \\ texto`;
var cadena3:string = `cadena de texto ${apellido} \r texto`;
var cadena4:string = `cadena de texto ${apellido} \t texto`;
var cadena5:string = `cadena de texto ${apellido} \" texto`;
var cadena6:string = `cadena de texto ${apellido} texto`;
var edad:number = 1234;
var edad2:number = +1234;
var edad3:number = -1234;
var edad4:number = 12.34;
var edad5:number = +12.34;
var edad6:number = -12.34;
var sexo:boolean = true;

var apellido:string = "Morente";
var cadena:string = `cadena de texto ${apellido} \n texto`;
var cadena2:string = `cadena de texto ${apellido} \\ texto`;
var cadena3:string = `cadena de texto ${apellido} \r texto`;
var cadena4:string = `cadena de texto ${apellido} \t texto`;
var cadena5:string = `cadena de texto ${apellido} \" texto`;
var cadena6:string = `cadena de texto ${apellido} texto`;
console.log(cadena);

/**
 * MANEJO DE SIN TIPOS
 */
var apellido:string = "Morente";
apellido = "González" + true;
console.log(apellido);
var nombre:string = "Morente";
nombre = 1;
console.log(nombre);
var sexo:boolean = true;
sexo = false;
sexo = "true";
console.log(sexo);

var edad:number = "aba";
while (edad < 5) {
    edad = edad + 1;
    console.log('HOLA MUNDO');
}

var edad:number = 0;
do {
    edad = edad + 1;
    console.log('HOLA MUNDO');
} while (edad < 5);

var edad:number = 7^2/14;
console.log(edad);
