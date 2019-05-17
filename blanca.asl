// Agent blanca in project P1Recuperacion.mas2j


introduccion("Menudo sol hace hoy").
introduccion(jose,"Hace un dia estupendo","Bueno y a donde os apetece ir hoy").
introduccion(clara,"Yo quiero un helado","Quizas luego clara").
introduccion(clara,"A algun sitio divertido","Hoy el parque tematico esta abierto").
introduccion(jose,"Hola don Pepito","Hola Pepe").

/*Frases del escenario regaño a clara*/
escenario1(clara,"Clara espera un poco mas","Tengo hambre").
escenario1(clara,"Mmmmmm","No molestes clara").
escenario1(clara,"Es que estoy aburrida","Aguanta un poco mas y te compro un helado").

/* Initial beliefs and rules */


/* Initial goals */



!inicio.



/* Plans */


/*Planes para la introduccion*/
+!inicio[source(self)]: introduccion(Respuesta)<-
			.print("-------------------------------- Introduccion -----------------------------------");
			.print("Blanca: ",Respuesta);
			.send(clara,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).		

+!digoQue("Hola don Pepito")[source(jose)]: introduccion(jose,"Hola don Pepito",Respuesta)<-
			.print("Blanca: ",Respuesta);
			.send(clara,achieve,digoQue(Respuesta));
			.send(pepe,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).
	
+!digoQue(Frase)[source(jose)]: introduccion(jose,Frase,Respuesta)<-
			.print("Blanca: ",Respuesta);
			.send(clara,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).
+!digoQue(Frase)[source(clara)]: introduccion(clara,Frase,Respuesta)<-
			.print("Blanca: ",Respuesta);
			.send(clara,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).

/*Planes para el escenario1*/
+!burla(Frase)[source(clara)]: escenario1(blanca,Frase,Respuesta)<-
			.print("Blanca: ",Respuesta);
			.send(clara,achieve,digoQue(Respuesta));
			.send(pepe,achieve,digoQue(Respuesta));
			.send(jose,achieve,digoQue(Respuesta)).
			
			
/*Plan por defecto escuchar y guardar la informacion*/
+!digoQue(Frase)[source(Sender)]<-+escuchado(Sender,Frase).
