%%%%%%%%%%%%%%%%%%%%%%
%% Predicados dados %%
%%%%%%%%%%%%%%%%%%%%%%


call1(F, X) :- G=.. [F,X], call(G).

%% Nombres

nombre(batman).
nombre(robin).
nombre(alfred).
nombre(pinguino).
nombre(gatubela).
nombre(guason).
nombre(batichica).
nombre(acertijo).

%% Atributos

atributo(hombre).
atributo(mascara).
atributo(capa).
atributo(corbata).
atributo(orejas).
atributo(fumador).

%% Clases

clase(bueno).
clase(malo).

%% Registros

hombre(batman).
hombre(robin). 
hombre(alfred).
hombre(pinguino).
hombre(guason).
hombre(acertijo).

mascara(batman).
mascara(robin).
mascara(gatubela).
mascara(batichica).
mascara(acertijo).

capa(batman).
capa(robin).
capa(batichica).

corbata(alfred).
corbata(pinguino).

orejas(batman).
orejas(gatubela).
orejas(batichica).

fumador(pinguino).

%% Ejemplos

clasede(batman, bueno).
clasede(robin, bueno).
clasede(alfred, bueno).
clasede(pinguino, malo).
clasede(gatubela, malo).
clasede(guason, malo).

ejemplos(Ns) :- findall(N, (nombre(N),clase(C), clasede(N, C)), Ns).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Predicados a definir %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

call1(F, X) :- G=.. [F,X], call(G).

mismaclase([N1|[]],C):- nombre(N1),clasede(N1,C),!.
mismaclase([N1,N2|Ns],C):- nombre(N1),clasede(N1,C),nombre(N2),clasede(N2,C),mismaclase([N2|Ns],C),!.

particion(Xs, A, NT, NF) :- findall(X, (atributo(A),member(X, Xs), call1(A, X)), NT), findall(Y, (atributo(A),member(Y, Xs),nombre(Y), not(call1(A, Y))), NF).

%%obtiene todos los nombres de una clase C
filtrarPorClase(Ns,C,Rs):- findall(N, (member(N,Ns),clase(C),nombre(N),clasede(N,C)), Rs).

atributos(As):-findall(A,atributo(A),As),!.

proporcion([],_,_,0),!.
proporcion(Ns, C, A, 0):- atributo(A),clase(C), particion(Ns,A,NT,NF), filtrarPorClase(NT,C,Rs), length(Rs,TLista),length(NT,T),T=0.
proporcion(Ns, C, A, P):- atributo(A),clase(C), particion(Ns,A,NT,NF), filtrarPorClase(NT,C,Rs), length(Rs,TLista),length(NT,T),T>0,P is (TLista/T).

sumatoria([C|Cs],Ns,A,Acc,E):-  proporcion(Ns,C,A,P), P=0, A1 is (Acc+0),sumatoria(Cs,Ns,A,A1,E).
sumatoria([C|Cs],Ns,A,Acc,E):-  proporcion(Ns,C,A,P), P>0, log(P,R), A1 is (Acc+P*R),sumatoria(Cs,Ns,A,A1,E).
sumatoria([C|[]],Ns,A,Acc,E):- proporcion(Ns,C,A,P), P>0, log(P,R), E is (Acc+P*R).
sumatoria([C|[]],Ns,A,Acc,Acc):- proporcion(Ns,C,A,P), P=0.

%%obtiene las clases de una lista de nombres
obtenerClases(Ns,Cs):-findall(C,(member(N,Ns),nombre(N),clasede(N,C)),R),sort(R,Cs).

entropia([], As, A,0):-atributo(A),member(A,As).
entropia(_, As, A, 1.0):- atributo(A),not(member(A,As)).
entropia(Ns, As, A, E):- atributo(A),member(A,As), obtenerClases(Ns,Clases), sumatoria(Clases,Ns,A,0,S), E is (-1*S).

minatr(Ns,[A1|[]],A1).
minatr(Ns,[A1,A2|[]],A1):-atributo(A1),atributo(A2), entropia(Ns,[A1,A2|[]],A1,E1),entropia(Ns,[A1,A2|[]],A2,E2),E1=<E2,!.
minatr(Ns, [A1,A2|[]], A2):- atributo(A1),atributo(A2),entropia(Ns,[A1,A2|[]],A1,E1),entropia(Ns,[A1,A2|[]],A2,E2),E1>E2,!.
minatr(Ns, [A1,A2|As], M):- atributo(A1),atributo(A2), entropia(Ns,[A1,A2|As],A1,E1),entropia(Ns,[A1,A2|As],A2,E2),E1=<E2,minatr(Ns,[A1|As],M),!.
minatr(Ns, [A1,A2|As], M):- atributo(A1),atributo(A2),entropia(Ns,[A1,A2|As],A1,E1),entropia(Ns,[A1,A2|As],A2,E2),E1>E2,minatr(Ns,[A2|As],M),!.

%%particiona clases entre buenos y malos, la sublista que tenga más elementos es la de la clase más representativa
particionClases(Cs,Bs,Ms) :- findall(C, (member(C, Cs), clase(C) == clase(bueno)), Bs), findall(C, (member(C, Cs), clase(C) == clase(malo)), Ms),!.

maxcla(Ns,C):-length(Ns,L),L>0,clase(C),obtenerClases(Ns,Cs),particionClases(Cs,Bs,Ms), length(Bs,B), length(Ms,M), B>=M,C=bueno,!.
maxcla(Ns,C):-length(Ns,L),L>0,clase(C),obtenerClases(Ns,Cs),particionClases(Cs,Bs,Ms), length(Bs,B), length(Ms,M), M>B,C=malo,!.

id3(Ns, [], C, hoja(C1)):- maxcla(Ns,C1),!.
id3([], As, C, T):- T=hoja(C),!.
id3(Ns, As, C, T):- mismaclase(Ns,C1),T=hoja(C1),!.
id3(Ns,As,C,T):- minatr(Ns,As,A), delete(As,A,R), particion(Ns,A,NT,NF), id3(NT,R,C,T1), id3(NF,R,C,T2), (T=nodo(A,T1, T2)),!.

arbol(T):- ejemplos(Ns),atributos(As), maxcla(Ns,C), id3(Ns,As,C,T).

clasificar(T, N,C):-nombre(N),clasede(N,C),!.
clasificar(hoja(C), N,C):-nombre(N).
clasificar(nodo(A,T1,T2), N,C):- nombre(N),call1(A,N), clasificar(T1,N,C),!.
clasificar(nodo(A,T1,T2), N,C):- clasificar(T2,N,C),!.

clasificacion(Ns, Xs):-arbol(T),clasificaraux(T,Ns,[],Xs).

%%función auxiliar que almacena en Aux los nombres de los elementos que no tienen una clase.
clasificaraux(T,[],Aux,Xs):-Xs=Aux.
clasificaraux(T,[N|Ns],Aux,Xs):-clasificar(T,N,C),clasede(N,C), clasificaraux(T,Ns,Aux,Xs),!.
clasificaraux(T,[N|Ns],Aux,Xs):-clasificar(T,N,C), clasificaraux(T,Ns,[(N,C)|Aux],Xs),!.
