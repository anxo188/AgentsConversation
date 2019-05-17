// Agent blanca in project P1Recuperacion.mas2j


frase("Bueno y a donde os apetece ir hoy"):- estado(conversacion).
frase("Hace un día estupendo"):- estado(conversacion).
frase("Hoy el parque temático está abierto"):- estado(conversacion).

frase("Hola Pepe"):- estado(llegada).

/*Frases del escenario regaño a clara*/
frase("Clara espera un poco más",clara,0):- estado(bronca).
frase("No molestes clara",clara,1):- estado(bronca).
frase("Aguanta un poco más y te compro un helado",clara,2):- estado(bronca).

autorizados([clara,jose,pepe,self]).

presentes(Agentes):- .member(clara,Agentes) & .member(pepe,Agentes) & .member(jose,Agentes).


//apropiado(Agentes):- .member(clara) & .member(pepe) & .member(jose).
/* Initial beliefs and rules */


/* Initial goals */



!start.



/* Plans */


+!start[source(Fuente)] : .all_names(Agentes) & presentes(Agentes) & autorizados(Lista) & .member(Fuente,Lista) <- .print("hola");
+autorizados([clara,jose,pepe,self]).

+!responderAMensaje[source(Fuente)]: autorizados(Lista) & .member(Fuente,Lista) & not (Fuente = clara) & estado(conversacion) & frase(X)<-.send(Fuente,X).
+!responderAMensaje[source(clara)]: estado(bronca) & frase(X,clara)<-.send(Fuente,X).