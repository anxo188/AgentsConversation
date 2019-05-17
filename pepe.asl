// Agent pepe in project P1Recuperacion.mas2j

/* Initial beliefs and rules */


/*Conjunto de frases para el escenario1*/
escenario1(jose,"Hola don Pepito", "Hola don Jose").
escenario1(jose, "Paso usted por mi casa?", "Por su casa yo pase").
escenario1(jose, "Vio usted a mi abuela?", "A su abuela yo la vi").
escenario1(jose, "Adios don Pepito", "Adios don Jose").

/*Conjunto de frases para el escenario2*/
escenario2(clara,"Clara piensa un número entre 20 y 40. Ahora multiplícalo por 100.").
escenario2(clara,"Ya lo pense","Muy bien Clara, lo estás haciendo muy bien. A continuación piensa un número entre 50 y 60 y sumaselo al resultado anterior.").
escenario2(clara,"Hecho","Lo tienes; muy bien ahora resta 101 y dime el resultado.").
escenario2(clara,"El resultado es ",X,"Pues verás Clara el primer numero que pensaste es "," y el segundo ").


/*Averigua el número mágico*/
averiguarNumero(X,A,B):- (Z=X+101) & (Z/100=Aux) & (math.floor(Aux)=A) & (Z-(A*100)=B).

/* Initial goals */
/* Plans */


//Conversacion normal con jose en el escenario1, al acabar empieza el escenario2
+!digoQue(Frase)[source(jose)]: escenario1(jose,Frase,"Adios don Jose")<-
		.print("Pepe: Adios don Jose");
		.send(clara,achieve,digoQue("Adios don Jose"));
		!digoQue[source(clara)].

+!digoQue(Frase)[source(jose)] : escenario1(jose,Frase,Answer) <-
		.print("Pepe: ",Answer);
		.send(jose,achieve,digoQue(Answer));
		.send(clara,achieve,digoQue(Answer)).
		
+!digoQue(Frase)[source(clara)]: escenario2(clara,Frase,Respuesta) <- 
		.print("Pepe: ",Respuesta);
		.send(clara,achieve,digoQue(Answer)).
		
+!digoQue(F1,X)[source(clara)]: escenario2(clara,F1,X,F2,F3) & averiguarNumero(X,Y,Z)<-
			.print("Pepe: ",F2,Y,F3,Z);
			.send(clara,achieve,digoQue(F2,Y,F3,Z)).
			
+!digoQue[source(clara)]: escenario2(clara,Respuesta) <- 
		.print("Pepe: ",Respuesta);
		.send(clara,achieve,digoQue(Answer)).
		
		


