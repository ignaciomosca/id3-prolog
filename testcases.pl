%% casos de tests

call2(L) :- G=.. L, call(G).

test_1(C) :- call2([sameclass, [batman, alfred], C]).
test_1(C) :- call2([sameclass, [robin, penguin], C]).
test_1(C) :- call2([sameclass, [catwoman], C]).
test_1(C) :- call2([sameclass, [], C]).

test_2(NT, NF) :- call2([partition, [], man, NT, NF]).
test_2(NT, NF) :- call2([partition, [batman, alfred], mask, NT, NF]).
test_2(NT, NF) :- call2([partition, [batman, robin], cape, NT, NF]).
test_2(NT, NF) :- call2([partition, [batman, robin, penguin, riddler], smoker, NT, NF]).
test_2(NT, NF) :- call2([partition, [batman, robin, catwoman, riddler], tie, NT, NF]).
test_2(NT, NF) :- call2([partition, [robin, penguin], woman, NT, NF]).
test_2(NT, NF) :- call2([partition, [dongato], man, NT, NF]).

test_3(P) :- call2([proportion, [batman, robin, penguin, riddler], evil, smoker, P]).
test_3(P) :- call2([proportion, [batman, alfred, catwoman, riddler], good, mask, P]).
test_3(P) :- call2([proportion, [alfred, robin, batman, penguin, catwoman], good, ears, P]).
test_3(P) :- call2([proportion, [catwoman], evil, man, P]).
test_3(P) :- call2([proportion, [], good, man, P]).
test_3(P) :- call2([proportion, [alfred, penguin], good, ultrared, P]).

test_4(E) :- call2([entropy, [batman, robin, penguin, riddler], [mask, smoker], smoker, E]).
test_4(E) :- call2([entropy, [batman, penguin, catwoman], [mask, ears], mask, E]).
test_4(E) :- call2([entropy, [alfred, robin, batman, catwoman], [ears, cape], tie, E]).
test_4(E) :- call2([entropy, [alfred, robin, batman, riddler, penguin], [mask, tie], mask, E]).
test_4(E) :- call2([entropy, [alfred], [mask, tie], ears, E]).
test_4(E) :- call2([entropy, [], [mask, tie], mask, E]).
test_4(E) :- call2([entropy, [], [], mask, E]).

test_5(M) :- call2([minatr, [batman, robin, penguin, riddler], [mask, smoker], M]).
test_5(M) :- call2([minatr, [batman, penguin, catwoman], [mask, ears], M]).
test_5(M) :- call2([minatr, [alfred, robin, batman, catwoman], [ears, cape], M]).
test_5(M) :- call2([minatr, [alfred, robin, batman, riddler, penguin], [mask, tie], M]).
test_5(M) :- call2([minatr, [alfred], [ears, man, cape], M]).
test_5(M) :- call2([minatr, [alfred], [cape, ears, man], M]).
test_5(M) :- call2([minatr, [], [man, tie], M]).
test_5(M) :- call2([minatr, [penguin], [], M]).

test_6(C) :- call2([maxcla, [batman, penguin, alfred], C]).
test_6(C) :- call2([maxcla, [robin, penguin], C]).
test_6(C) :- call2([maxcla, [catwoman], C]).
test_6(C) :- call2([maxcla, [], C]).

test_7(A) :- call2([id3, [penguin, catwoman], [cape], good, A]).
test_7(A) :- call2([id3, [penguin, robin, batman], [], evil, A]).
test_7(A) :- call2([id3, [penguin, catwoman], [], good, A]).
test_7(A) :- call2([id3, [], [mask], good, A]).
test_7(A) :- call2([id3, [], [], good, A]).
test_7(A) :- call2([id3, [batman, robin, penguin, riddler], [mask, smoker, cape], good, A]).
test_7(A) :- call2([id3, [batman, robin, penguin, riddler], [ears, tie], evil, A]).

test_9(C) :- tree(A), call2([classify, A, batman, C]).
test_9(C) :- tree(A), call2([classify, A, penguin, C]).
test_9(C) :- tree(A), call2([classify, A, batgirl, C]).
test_9(C) :- tree(A), call2([classify, A, riddler, C]).
test_9(C) :- tree(A), call2([classify, A, dongato, C]).

test(1, R) :- findall(C, test_1(C), R).
test(2, R) :- findall((NT, NF), test_2(NT, NF), R).
test(3, R) :- findall(P, test_3(P), R).
test(4, R) :- findall(E, test_4(E), R).
test(5, R) :- findall(M, test_5(M), R).
test(6, R) :- findall(C, test_6(C), R).
test(7, R) :- findall(A, test_7(A), R).
test(8, A) :- tree(A).
test(9, R) :- findall(C, test_9(C), R).
test(10, Xs) :- findall(N,name(N),Ns),clasification(Ns,Xs).

testall(Ts) :- findall(T, (member(N, [1,2,3,4,5,6,7,8,9,10]), test(N, T)), Ts).
