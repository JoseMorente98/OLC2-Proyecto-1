
//var punteo = 0;

/*
        SALIDA ESPERADA:
            ========= Metodo Declaracion =========
            Voy a ganar Compiladores 2 :D
            ======================================
    
    */
   //console.log("========= Metodo Declaracion =========");
   var n1 = 2;
   var n2 = 2;
   var n3 = 2;
   var n4 = 2;
   var str1 = "Voy a ganar Compiladore";
   var str2 = "Voy a ganar Compiladore";
   var str3 = "Voy a ganar Compiladore";
   var str4 = "Voy a ganar Compiladore";
   var db1 = 0.0;
   var db2 = 0.0;
   var db3 = 0.0;
   var db4 = 0.0;
   var chr1 = 's';
   var chr2 = 's';
   var chr3 = 's';
   var chr4 = "s";
   //if n modificar la asignación
   if (db1 == db4){
       //console.log(str4 + chr4 +" " +n4+" :D");
   }else {
       //console.log("Problemas en el metodo declaracion :(");
   }
   //console.log("======================================");
   punteo = punteo + 5;

   //suma de lets con caracteres
/*
    SALIDA ESPERADA
==============Aritmeticas=============
Hola COMPI
El valor de  n1 = 52.1
El valor de n3 = 70.0
-Operaciones Basicas: valor esperado:   a)62   b)0   c)-19   d)256   resultados>
a) 62
b) 0
c) -19
d) 256
======================================
*/
//console.log("==============Aritmeticas=============");
var art1 = "Hola "+"C"+""+"O"+""+"M"+""+"P"+""+"I";
//console.log(art1);
if (art1=="Hola COMPI"){
    punteo = punteo + 3;
}else {
    //console.log("Perdiste 3 puntos en suma de var y var :c");
}

var n1 = 0.0 + 1 + 1 + 1 + 0.1 + 49;
//console.log("El valor de  n1 = "+n1);
if (n1 == 52.1){
    punteo = punteo + 5;
}else {
    //console.log("Perdiste 5 puntos en suma de enteros booleanos y caracteres :c");
}

var n4 = (5750 * 2) - 11800 + 1.0;
var n3 = (((3 * 3) + 4) - 80 + 40.00 * 2 + 358.50 - (29 / 14.50)) - (0.50) + n4;
//console.log("El valor de n3 = "+n3);
if (n3 == 70)
{
    punteo = punteo + 3;
}
else 
{
    //console.log("Perdiste 3 puntos :c ");
}

//console.log("Operaciones Aritmeticas 1: valor esperado:  \na)62   \nb)0   \nc)-19   \nd)256   \nresultados>");
    var a = (20-10+8/2*3+10-10-10+50);
    var b = (50/50*50+50-100+100-100);
    var c = (100/20*9-78+6-7+8-7+7*1*2*3/3);
    var d = (2 **(20/5*2));
    //console.log("a) " +a);
    //console.log("b) " +b);
    //console.log("c) " +c);
    //console.log("d) " +d);
    if (a==62 && b==0 && c == -19 && d ==256){
        //console.log("Operaciones aritmeticas 1 bien :D");
        punteo = punteo + 5;
    }else {
        //console.log("Error en las operaciones basicas :(");
    }

    var hola = -1;
    var hola = -"hola";
    var hola = -true;
    var hola = -false;

    var aritmetica1 = 2;
    var aritmetica2 = -10;
    //console.log("Operaciones Aritmeticas 2: valor esperado> -20  41, resultado>");
    var aritmetica3 = aritmetica2*aritmetica1;
    //console.log(aritmetica3+"");
    aritmetica1 = aritmetica3/aritmetica1+50 **2/50+50*2-100+100/100-0;
    //console.log(aritmetica1+"");
    if (aritmetica3 == -20 && aritmetica1 == 41){
        //console.log("Operaciones aritmeticas 2 bien :D");
        punteo = punteo + 5;
    }else {
        //console.log("Error Operaciones Aritmeticas :c alv :c");
    }
    //var punteo = 0;

    //console.log("==============logicas1=============");
    if (!!!!!!!!!!!!!!!!!!!!!!true){
        punteo = punteo + 1;
        //console.log("Bien primera condicion :)");
    }else {
        //console.log("Perdiste 1 punto :c");
    }

    if (true && true || false && false && false || !true){
        punteo = punteo + 1;
        //console.log("Bien segunda condicion:)");
    }else {
        //console.log("Perdiste 1 punto :c");
    }
    //console.log("======================================");

    var n0 = 16;
         //console.log("==============logicas2=============");

    if (!(!(n0 == 16 && false == true) && !(true))){
            //console.log("Not y Ands Correctos");
                        punteo = punteo +3;

    }else {
                //console.log("No funcionan nots y ands :(");
        }
    var n1 = n0 /16;
    n1 = n1 + 1;
        var condicion1 = n1 !=2; //esto es false
        var aritmetica1 = n0/16 + 0; // aritmetica1 = 0
        var condicion2 = aritmetica1 == n1; //false
        var condicion3 = !true; //false
        
    if (!(!(!(condicion1||condicion2) || condicion3 ))){
        //console.log("Nots y Ors correectos");
                punteo = punteo + 3;
    }else {
            //console.log("No Funciona nots y ands :(");
        }
            //console.log("======================================");

            var salida = 10;

//console.log("==============relacionales1=============");
        var n0 = salida + 0.0;
        if (n0 < 34.44)
            {
                salida = salida+15;
                if (salida > 44)
                    {
                        salida++;
                    }
            }
            else {
                salida = 1;
            }
        
        if (salida != 1)
            {
                if (salida == 50)
                    {
                        //console.log("salida Correcta Relacionales 1!");
                        punteo = punteo + 5;
                    }
                    else {
                        //console.log("salida incorrecta!!");
                    }
            }
            else {
                //console.log("salida incorrecta!!");
            }
        //console.log("======================================");


for (let index = 0; index < 12; index++) {
    //console.log("Hola Mundo");
    
}