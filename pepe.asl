// Agent pepe in project P1Recuperacion.mas2j


/* Initial beliefs and rules */


/*Conjunto de frases para el escenario1*/
escenario1(jose,"Hola don Pepito","Hola don Jose").
escenario1(jose, "Paso usted por mi casa?", "Por su casa yo pase").
escenario1(jose, "Vio usted a mi abuela?", "A su abuela yo la vi").
escenario1(jose, "Adios don Pepito", "Adios don Jose").
escenario1(clara,"Hola don Pepito", "Hola clara, voy a hablar con jose y te ense�o ahora un truco de magia").
escenario1(blanca,"Hola Pepe","Blanca").

/*Conjunto de frases para el escenario2*/
escenario2(clara,"Clara piensa un n�mero entre 20 y 40. Ahora multipl�calo por 100.").
escenario2(clara,"Ya lo pense","Muy bien Clara, lo est�s haciendo muy bien. A continuacion piensa un numero entre 50 y 60 y sumaselo al resultado anterior.").
escenario2(clara,"Hecho","Lo tienes; muy bien ahora resta 101 y dime el resultado.").
escenario2(clara,"El resultado es",X,"Pues ver�s Clara el primer numero que pensaste es "," y el segundo ").


/*Averigua el n�mero m�gico*/
averiguarNumero(X,A,B):- (Z=X+101) & (Z/100=Aux) & (math.floor(Aux)=A) & (Z-(A*100)=B).

/* Initial goals */
/* Plans */


/*Planes escenario1*/

		
+!digoQue(Frase)[source(jose)]: escenario1(jose,Frase,"Adios don Jose") & (Respuesta = "Adios don Jose")<-
		.print("Pepito: ",Respuesta);
		.send(clara,achieve,digoQue(Respuesta));
		.send(jose,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		!escenario2.
		
+!digoQue(Frase)[source(jose)] : escenario1(jose,Frase,Respuesta) <-
		.print("Pepito: ",Respuesta);
		.send(jose,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(clara,achieve,digoQue(Respuesta)).
		
+!digoQue(Frase)[source(clara)] : escenario1(clara,Frase,Respuesta) <-
		.print("Pepito: ",Respuesta);
		.send(jose,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(clara,achieve,digoQue(Respuesta)).
+!digoQue(Frase)[source(blanca)] : escenario1(blanca,Frase,Respuesta) <-
		.print("Pepito: ",Respuesta);
		.send(jose,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(clara,achieve,digoQue(Respuesta)).
		
/*Planes para el escenario2*/		

+!escenario2: escenario2(clara,Respuesta) <- 
		.print("-------------------------------- Escenario2 -----------------------------------");
		.print("Pepito: ",Respuesta);
		.send(jose,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(clara,achieve,digoQue(Respuesta)).
		
+!digoQue(Frase)[source(clara)]: escenario2(clara,Frase,Respuesta) <- 
		.print("Pepito: ",Respuesta);
		.send(jose,achieve,digoQue(Respuesta));
		.send(blanca,achieve,digoQue(Respuesta));
		.send(clara,achieve,digoQue(Respuesta)).
		
+!digoQue(F1,X)[source(clara)]: escenario2(clara,F1,X,F2,F3) & averiguarNumero(X,Y,Z)<-
			.print("Pepito: ",F2," ",Y," ",F3," ",Z);
			.send(jose,achieve,digoQue(Respuesta));
			.send(blanca,achieve,digoQue(Respuesta));
			.send(clara,achieve,digoQue(F2,Y,F3,Z)).
			
		
/*Plan por defecto escuchar y guardar la informacion*/
+!digoQue(Frase)[source(Sender)]<-+escuchado(Sender,Frase).

/*Plan por defecto escuchar y guardar la informacion*/
+!burla(Frase)[source(Sender)]<-+escuchadaBurla(Sender,Frase).
