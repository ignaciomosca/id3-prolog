# ID3-Prolog
Prolog Implementation of the ID3 Algorithm

http://en.wikipedia.org/wiki/ID3_algorithm

# 1 Context

The objective of this codebase is to show a simplified implementation of the ID3 algorithm proposed in 1986 by J. R. Quinlan to build a decision tree based on a training set.
A decision tree is also known as a classifier, this is, a piece of code that allows us to determine, based on pre-existing labeled data, to which class does a determined element belong.

This was the first machine learning problem I ever solved. And I didn't even knew what Machine Learning was back then.

ID3 is a recursive algorithm that starts with a set of examples.

On each iteration, ID3 calculates the entropy for each attribute.

Entropy is a measure of the uncertainty of the data. The smaller the entropy, the smaller is the uncertainty.
That's why ID3 chooses the attribute with the smallest entropy and partitions the set of data according to the possible values for that attribtue. ID3 does this recursively on the rest of the attributes. 

Recursion ends when:

* All the elements in the set belong to the same class: ID3 creates a leaf with the corresponding class.

* The set of attributes is empty, but the data set is not: ID3 builds a leaf with the most representative class, that is, the one that has more elements in the data set.

* The data set is empty: a leaf is created with the class of the parent.

# Basic Primitives:

* name/1 - defines the name for an individual

* names/1- lists all the individuals

* attribute/1 - defines the name for an attribute

* attributes/1- lists all the attributes

* class/1 defines the classes. classes/1 defines the list of all the classes.

To each constant atr that satisfies attribute(atr), a predicate atr/1 exists that defines which individuals have said attribute.

* The examples are defined by the predicate classof/2.

* The predicate examples(?Ns) makes Ns the list of all the names N that have a class C that verifies classof(N,C).

And so we have the following predicates in Prolog.

1. sameclass(+Ns, ?C): all the names in N are of class C.
2. partition(+Ns, +A, ?NT, ?NF): partitions the list Ns into two lists: NT and NF. NT has the names that have attribute A, and NF contains the names that don't.
3. proportion(+Ns, +C, +A, ?P): P is the proportion of elements of class C in the Ns list, for which  an element A is true.
4. entropy(+Ns, +As, +A, ?E): E is the entropy of list Ns for an attribute A if it belongs to the list of attributes As, or 1.0 if it doesn't. The entropy for an attribute is calculated as: (−1) * Σ<sub>c∈clases</sub> p(c) * log p(c). Where p(c) is the proportion mentioned previously. If p(c) is 0, then p(c) * log p(c) is replaced by 0.
5. minatr(+Ns, +As, ?M): M is the attribute of the list As which has minimum entropy in Ns. If there are many possible values it returns the first in the list.
6. maxcla(+Ns, ?C): C is the most representative class of Ns.

7. id3(+Ns, +As, +C, ?T), T is the decision tree for a list of names Ns, a list of attributes As and class C. Each leaf of T is a leaf-node, leaf(C), where C is a class. Each non terminal node for an attribute A represents the class label of the final subset of this branch. It has the shape node(A, T1, T2) where A is an attribute and T1 and T2 are trees.

8. tree(?T): T is the tree we get from using id3 for the set of examples. The initial attribute list is the list of all the attributes. The initial class is the most representative of the training set examples.

9. classify(+T, +N, ?C): C is the class of the name according to a classifing tree T.

10. clasification(Ns, ?Xs): Xs is the list of clasifications obtained for the list Ns. Each element of Xs is a tuple (N,C) so that N is an element of Ns and C is a class.

For more information check this link: http://www.cs.princeton.edu/~schapire/talks/picasso-minicourse.pdf
