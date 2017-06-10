%% casos de tests

call2(L) :- G=.. L, call(G).

test_1(C) :- call2([mismaclase, [batman, alfred], C]).
test_1(C) :- call2([mismaclase, [robin, pinguino], C]).
test_1(C) :- call2([mismaclase, [gatubela], C]).
test_1(C) :- call2([mismaclase, [], C]).

test_2(NT, NF) :- call2([particion, [], hombre, NT, NF]).
test_2(NT, NF) :- call2([particion, [batman, alfred], mascara, NT, NF]).
test_2(NT, NF) :- call2([particion, [batman, robin], capa, NT, NF]).
test_2(NT, NF) :- call2([particion, [batman, robin, pinguino, acertijo], fumador, NT, NF]).
test_2(NT, NF) :- call2([particion, [batman, robin, gatubela, acertijo], corbata, NT, NF]).
test_2(NT, NF) :- call2([particion, [robin, pinguino], mujer, NT, NF]).
test_2(NT, NF) :- call2([particion, [dongato], hombre, NT, NF]).

test_3(P) :- call2([proporcion, [batman, robin, pinguino, acertijo], malo, fumador, P]).
test_3(P) :- call2([proporcion, [batman, alfred, gatubela, acertijo], bueno, mascara, P]).
test_3(P) :- call2([proporcion, [alfred, robin, batman, pinguino, gatubela], bueno, orejas, P]).
test_3(P) :- call2([proporcion, [gatubela], malo, hombre, P]).
test_3(P) :- call2([proporcion, [], bueno, hombre, P]).
test_3(P) :- call2([proporcion, [alfred, pinguino], bueno, infrarrojo, P]).

test_4(E) :- call2([entropia, [batman, robin, pinguino, acertijo], [mascara, fumador], fumador, E]).
test_4(E) :- call2([entropia, [batman, pinguino, gatubela], [mascara, orejas], mascara, E]).
test_4(E) :- call2([entropia, [alfred, robin, batman, gatubela], [orejas, capa], corbata, E]).
test_4(E) :- call2([entropia, [alfred, robin, batman, acertijo, pinguino], [mascara, corbata], mascara, E]).
test_4(E) :- call2([entropia, [alfred], [mascara, corbata], orejas, E]).
test_4(E) :- call2([entropia, [], [mascara, corbata], mascara, E]).
test_4(E) :- call2([entropia, [], [], mascara, E]).

test_5(M) :- call2([minatr, [batman, robin, pinguino, acertijo], [mascara, fumador], M]).
test_5(M) :- call2([minatr, [batman, pinguino, gatubela], [mascara, orejas], M]).
test_5(M) :- call2([minatr, [alfred, robin, batman, gatubela], [orejas, capa], M]).
test_5(M) :- call2([minatr, [alfred, robin, batman, acertijo, pinguino], [mascara, corbata], M]).
test_5(M) :- call2([minatr, [alfred], [orejas, hombre, capa], M]).
test_5(M) :- call2([minatr, [alfred], [capa, orejas, hombre], M]).
test_5(M) :- call2([minatr, [], [hombre, corbata], M]).
test_5(M) :- call2([minatr, [pinguino], [], M]).

test_6(C) :- call2([maxcla, [batman, pinguino, alfred], C]).
test_6(C) :- call2([maxcla, [robin, pinguino], C]).
test_6(C) :- call2([maxcla, [gatubela], C]).
test_6(C) :- call2([maxcla, [], C]).

test_7(A) :- call2([id3, [pinguino, gatubela], [capa], bueno, A]).
test_7(A) :- call2([id3, [pinguino, robin, batman], [], malo, A]).
test_7(A) :- call2([id3, [pinguino, gatubela], [], bueno, A]).
test_7(A) :- call2([id3, [], [mascara], bueno, A]).
test_7(A) :- call2([id3, [], [], bueno, A]).
test_7(A) :- call2([id3, [batman, robin, pinguino, acertijo], [mascara, fumador, capa], bueno, A]).
test_7(A) :- call2([id3, [batman, robin, pinguino, acertijo], [orejas, corbata], malo, A]).

test_9(C) :- arbol(A), call2([clasificar, A, batman, C]).
test_9(C) :- arbol(A), call2([clasificar, A, pinguino, C]).
test_9(C) :- arbol(A), call2([clasificar, A, batichica, C]).
test_9(C) :- arbol(A), call2([clasificar, A, acertijo, C]).
test_9(C) :- arbol(A), call2([clasificar, A, dongato, C]).

test(1, R) :- findall(C, test_1(C), R).
test(2, R) :- findall((NT, NF), test_2(NT, NF), R).
test(3, R) :- findall(P, test_3(P), R).
test(4, R) :- findall(E, test_4(E), R).
test(5, R) :- findall(M, test_5(M), R).
test(6, R) :- findall(C, test_6(C), R).
test(7, R) :- findall(A, test_7(A), R).
test(8, A) :- arbol(A).
test(9, R) :- findall(C, test_9(C), R).
test(10, Xs) :- findall(N,nombre(N),Ns),clasificacion(Ns,Xs).

testall(Ts) :- findall(T, (member(N, [1,2,3,4,5,6,7,8,9,10]), test(N, T)), Ts).
