% needs map.pl
% functions: isNearAir/0, isOnMarket/0, isOnHouse/0, isOnSoil/0, isOnDigged/0, isOnQuest/0, isOnAlchemist/0, isOnRanch/0
isNearAir:-
	locPlayer(P,Q),!,
	checkAir(P,Q),!.

checkAir(P,Q):-
	A is P-1,
	isAir(A,Q),!.
	
checkAir(P,Q):-
	B is Q-1,
	isAir(P,B),!.
	
checkAir(P,Q):-
	C is P+1,
	isAir(C,Q),!.

checkAir(P,Q):-
	D is Q+1,
	isAir(P,D),!.
	
isOnMarket:-
	locPlayer(P,Q),!,
	isMarket(P,Q),!.
	
isOnHouse:-
	locPlayer(P,Q),!,
	isHouse(P,Q),!.
	
isOnSoil:-
	locPlayer(P,Q),!,
	isSoil(P,Q),!.

isOnDigged:-
	locPlayer(P,Q),!,
	isDiggedTile(P,Q),!.

isOnQuest:-
	locPlayer(P,Q),!,
	isQuest(P,Q),!.

isOnAlchemist:-
	locPlayer(P,Q),!,
	isAlchemist(P,Q),!.

isOnRanch:-
	locPlayer(P,Q),!,
	isRanch(P,Q),!.