// Agent clara in project P1Recuperacion.mas2j



/* Initial beliefs and rules */


/*Conjunto de frases para el escenario2*/

/*Frases para la introduccion*/

introduccion(blanca,"Bueno y a donde os apetece ir hoy","A algun sitio divertido").
introduccion(jose,"Hace un dia estupendo","Yo quiero un helado").
introduccion(blanca,"Hoy el parque tematico esta abierto","Siii yo quiero ir").
introduccion(jose,"Hola don Pepito","Hola don Pepito").

/*Frases para el escenario1*/
escenario1(pepe,"Por su casa yo pase","Tengo hambre").
escenario1(blanca,"Clara espera un poco mas","Mmmmmm").
escenario1(blanca,"No molestes clara","Es que estoy aburrida").
escenario1(blanca,"Aguanta un poco mas y te compro un helado","Valeeee :D").


/*Frases para el escenario2*/
escenario2(pepe,"Clara piensa un número entre 20 y 40. Ahora multiplícalo por 100.","Ya lo pense",Y):- elegirRandom(X,20,40) & (Y=X*100) & .print("Shh no se lo digais, he pensado el ", X).
escenario2(pepe,"Muy bien Clara, lo estás haciendo muy bien. A continuacion piensa un numero entre 50 y 60 y sumaselo al resultado anterior.","Hecho",Y,Z):- elegirRandom(Y,50,60) &
		almacenar(X) & (Z=X+Y) & .print("Shh no se lo digais,ahora he pensado el ", Y).
escenario2(pepe,"Lo tienes; muy bien ahora resta 101 y dime el resultado.","El resultado es ",X):- numero(A) & (A - 101 = X).
escenario2(pepe,"Pues verás Clara el primer numero que pensaste es ",X," y el segundo ", Y, "Bravo, bravo, más, más. Mama, tio Jose habeis visto lo que ha hecho"):- almacenar(X*100) & almacenar(Y).
escenario2(pepe,"Pues verás Clara el primer numero que pensaste es ",X," y el segundo ", Y, "Noooo, te has equivocado, jajaja").

/*Elige un random entre dos numero dados buscando randoms hasta que encuentra uno adecuado*/
elegirRandom(X,A,B):- (math.random *100 =Z  ) & (math.floor(Z) = X) & (X > A) & (X < B).
elegirRandom(X,A,B):- elegirRandom(X,A,B).

/* Initial goals */




/* Plans */


/*Planes para la introduccion*/
+!digoQue(Frase)[source(blanca)]: introduccion(blanca,Frase,Respuesta)<-
			.print("Clara: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).
			
+!digoQue("Hola don Pepito")[source(jose)]: introduccion(jose,"Hola don Pepito",Respuesta)<-
			.print("Clara: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(pepe,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).
			
+!digoQue(Frase)[source(jose)]: introduccion(jose,Frase,Respuesta)<-
			.print("Clara: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).

/*Planes para el escenario1*/
+!digoQue(Frase)[source(blanca)]: escenario1(blanca,Frase,Respuesta)<-
			.print("Clara: ",Respuesta);
			.send(pepe,achieve,burla(Respuesta));
			.send(blanca,achieve,burla(Respuesta));
			.send(jose,achieve,burla(Respuesta)).
			
+!digoQue(Frase)[source(pepe)]: escenario1(jose,Frase,Respuesta)<-
			.print("Clara: ",Respuesta);
			.send(pepe,achieve,burla(Respuesta));
			.send(blanca,achieve,burla(Respuesta));
			.send(jose,achieve,burla(Respuesta)).
			

/*Planes para el escenario2*/
+!digoQue(Frase)[source(pepe)]: escenario2(pepe,Frase,"El resultado es ",X) & (Respuesta ="El resultado es") <- 
		.print("Clara: ",Respuesta," ",X);
		.send(pepe,achieve,digoQue(Respuesta,X));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(jose,achieve,digoQue(Respuesta)).
		
+!digoQue(Frase)[source(pepe)]: escenario2(pepe,Frase,Respuesta,X,Y) <- 
		+almacenar(X);
		+numero(Y);
		.print("Clara: ",Respuesta);
		.send(pepe,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(jose,achieve,digoQue(Respuesta)).	
		
+!digoQue(Frase)[source(pepe)]: escenario2(pepe,Frase,Respuesta,X) <- 
		+almacenar(X);
		.print("Clara: ",Respuesta);
		.send(pepe,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(jose,achieve,digoQue(Respuesta)).
		

+!digoQue(F1,X,F2,Y)[source(pepe)]: escenario2(pepe,F1,X,F2,Y,Respuesta)<-
		.print("Clara: ",Respuesta);
		.print("-------------------------------- Fin -----------------------------------");
		.send(pepe,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(jose,achieve,digoQue(Respuesta)).
			
/*Plan por defecto escuchar y guardar la informacion*/
+!digoQue(Frase)[source(Sender)]<-+escuchado(Sender,Frase).

