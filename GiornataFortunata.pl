vocale("a").
vocale("e").
vocale("i").
vocale("o").
vocale("u").

lung([],0).

lung([_|T],A):-
	lung(T,B),
	A is B+1.

nV([],0).

nV([E|T],M):-
	vocale(E),!,
	nV(T,N),
	M is N+1.

nV([_|T],M):-
	nV(T,M).

nC([],0).

nC([E|T],M):-
	\+vocale(E),!,
	nC(T,N),
	M is N+1.

nC([_|T],M):-
	nC(T,M).

calcolo(A,B):-
	A=B,!,
	write("Giornata Fortunata").
calcolo(A,B):-
	\+A=B,
	write("Giornata Sfortunata").

giornata(Segno):-
	nV(Segno,A),
	nC(Segno,B),
	%V is A/5,%questo serve per la frequenza media
	%C is B/16,%anche questo
	%calcolo(V,C).
	calcolo(A,B).

% giornata(["a","a","b","b"]). esempio di query




