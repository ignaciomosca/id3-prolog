# id3-prolog
Prolog Implementation of the ID3 Algorithm

http://en.wikipedia.org/wiki/ID3_algorithm

# 1 Contexto

El objetivo del obligatorio es implementar en Prolog una versi ́on simplifi-
cada del algoritmo ID3 1 propuesto en 1986 por J. R. Quinlan para construir
un  ́arbol de decisi ́on a partir de un conjunto de datos llamados ejemplos o
tambi ́en conjunto de entrenamiento. Un  ́arbol de decisi ́on es lo que se conoce
tambi ́en como un clasificador, es decir, permite determinar, de acuerdo a
los datos disponibles, a qu ́e clase pertenece un elemento determinado. Este
problema se enmarca dentro del contexto general de la inteligencia artificial,
m ́as precisamente en aprendizaje autom ́atico.

ID3 es un algoritmo recursivo que comienza con el conjunto de ejemplos.
En cada iteraci ́on, ID3 calcula la entrop ́ıa para cada atributo no consider-
ado previamente, sobre el conjunto de datos restantes. La entrop ́ıa es una
medida de la incertidumbre en los datos: cuanto menor la entrop ́ıa, menor
la incertidumbre. Por eso, ID3 elige el atributo que tiene menor entrop ́ıa
y particiona el conjunto de datos de acuerdo a los valores posibles para ese
atributo. ID3 continua recursivamente analizando cada uno de los subcon-
juntos as ́ı obtenidos, eliminando el atributo elegido del conjunto de atributos
a considerar. La recursi ́on termina si se da alguno de los siguientes casos:

1. Todos los elementos en el conjunto de datos pertenecen a la misma
clase. En este caso, ID3 construye una hoja con la clase correspondi-
ente.
2. El conjunto de atributos es vac ́ıo, pero en el conjunto de datos hay ele-
mentos pertenecientes a m ́as de una clase. En este caso, ID3 construye
una hoja con la clase m ́as representativa, es decir, de la que hay m ́as
elementos en el conjunto de datos.
3. El conjunto de datos es vac ́ıo. Esto puede pasar cuando no se en-
contraron en el conjunto padre elementos correspondientes a un cierto
valor del atributo. En este caso, se construye una hoja con la clase m ́as
representativa en el padre.
1
12
Construcci ́
on del  ́
arbol
Para este obligatorio se tomaron los datos del seminario Machine Learning
Algorithms for Classification, Rob Schapire, Princeton University 2 , en el cual
se puede encontrar tambi ́en informaci ́on adicional sobre el tema.
El programa Prolog se deber ́a construir a partir de los siguientes predi-
cados de base dados:
1. nombre/1 define los nombres de los individuos. nombres/1 define la
lista de todos los nombres.
2. atributo/1 define los atributos. atributos/1 define la lista de todos
los atributos.
3. clase/1 define las clases. clases/1 define la lista de todos las clases.
4. Para cada constante atr que satisface atributo(atr), existe un pre-
dicado atr/1 que define qu ́e individuos tienen ese atributo.
5. Los ejemplos est ́an definidos por el predicado clasede/2.
6. El predicado ejemplos(?Ns) es tal que Ns es la lista de todos los nom-
bres N para los que existe una clases C que verifica clasede(N, C).
Se pide definir los siguientes predicados Prolog:
1. mismaclase(+Ns, ?C): todos los nombres en Ns son de clase C.
2. particion(+Ns, +A, ?NT, ?NF): particiona la lista Ns en dos listas
NT y NF tal que cada una contiene, respectivamente, los nombres que
tienen y no tienen el atributo A.
3. proporcion(+Ns, +C, +A, ?P): P es la proporci ́on de elementos de
clase C en la lista Ns para los cuales el atributo A es verdadero.
4. entropia(+Ns, +As, +A, ?E): E es la entropia de la lista Ns para
el atributo A si pertenece a la lista de atributos As, o 1.0 si no. La
entrop ́ıa para un atributo se calcula como: (−1) · c∈clases p(c) · log p(c),
donde p(c) es la proporci ́on del punto anterior. Si p(c) es 0, el sumando
p(c) · log p(c) se reemplaza por 0.
5. minatr(+Ns, +As, ?M): M es el atributo de la lista As que tiene menor
entrop ́ıa en Ns. Si hay varios posibles, se devuelve el que aparece
primero en la lista.
2
http://www.cs.princeton.edu/~schapire/talks/picasso-minicourse.pdf
26. maxcla(+Ns, ?C): C es la clase m ́as representativa de Ns.
7. id3(+Ns, +As, +C, ?T), T es el a  ́ rbol de decisi ́on para la lista de nom-
bre Ns dada la lista de atributos As y la clase C. Cada hoja de T es un
t ́ermino de la forma hoja(C), d ́onde C es una clase. Cada nodo es un
t ́ermino de la forma nodo(A, T1, T2) d ́onde A es un atributo y T1 y
T2 son  ́arboles.
8. arbol(?T): T es el  ́arbol construido usando id3 para el conjunto de
ejemplos. La lista de atributos inicial es la lista de todos los atributos.
La clase inicial es la m ́as representativa en los ejemplos.
9. clasificar(+T, +N, ?C): C es la clase del nombre N seg ́
un el  ́arbol T.
10. clasificacion(Ns, ?Xs): Xs es la lista de clasificaciones obtenida
para la lista Ns. Cada elemento de Xs es un par (N, C) tal que N es un
elemento de Ns y C es una clase.
