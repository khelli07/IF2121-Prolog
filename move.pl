/* Requres map.pl and main.pl */

move(_,_):-
	\+menu_status(outside),!,
	write('Anda tidak sedang berada di luar'),
	nl,!.

move(P,Q):-
	isPagar(P,Q),!,
	write('Anda menabrak tembok!'),
	nl,!.

move(P,Q):-
	isAir(P,Q),!,
	write('Anda terjatuh ke kolam!'),
	nl,!.

move(P,Q):-
	retract(isPlayer(_,_)),
	asserta(isPlayer(P,Q)),!.

w:-
	isPlayer(A,B),!,
	C is B-1,
	move(A,C),!.
	
a:- 
	isPlayer(A,B),!,
	C is A-1,
	move(C,B),!.

s:- 
	isPlayer(A,B),!,
	C is B+1,
	move(A,C),!.

d:-
	isPlayer(A,B),!,
	C is A+1,
	move(C,B),!.
