// Agent jose in project P1Recuperacion.mas2j

/* Initial beliefs and rules */


/*Conjunto de frases para el escenario2*/

/*Frases para la introduccion*/
introduccion(blanca,"Menudo sol hace hoy","Hace un dia estupendo").
introduccion(clara,"Siii yo quiero ir","Hola don Pepito").

/*Frases para el escenario1*/
escenario1(pepe, "Hola don Jose", "Paso usted por mi casa?").
escenario1(pepe, "Por su casa yo pase", "Vio usted a mi abuela?").
escenario1(pepe, "A su abuela yo la vi", "Adios don Pepito").

/* Initial goals */


/* Plans */


/*Planes para la introduccion*/
+!digoQue(Frase)[source(blanca)]: introduccion(blanca,Frase,Respuesta)<-
			.print("Jose: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(clara,achieve,digoQue(Respuesta)).
			
+!digoQue("Siii yo quiero ir")[source(clara)]: introduccion(clara,"Siii yo quiero ir",Respuesta)<-
			.print("Jose: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(pepe,achieve,digoQue(Respuesta));
			.send(clara,achieve,digoQue(Respuesta)).
			
+!digoQue(Frase)[source(clara)]: introduccion(jose,Frase,Respuesta)<-
			.print("Jose: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(clara,achieve,digoQue(Respuesta)).
+!digoQue(Frase)[source(blanca)]: introduccion(jose,Frase,Respuesta)<-
			.print("Jose: ",Respuesta);
			.send(blanca,achieve,digoQue(Respuesta));
			.send(clara,achieve,digoQue(Respuesta)).

/*Planes para el escenario1*/		
+!digoQue(Frase)[source(pepe)]: escenario1(jose,Frase,Respuesta)<-
			.print("Jose: ",Respuesta);
			.send(pepe,achieve,digoQue(Respuesta));
			.send(blanca,achieve,digoQue(Respuesta));
			.send(clara,achieve,digoQue(Respuesta)).
			
			
/*Planes por defecto escuchar y guardar la informacion*/
+!digoQue(Frase)[source(Sender)]<-+escuchado(Sender,Frase).

+!burla(Frase)[source(Sender)]<-+escuchadaBurla(Sender,Frase).
