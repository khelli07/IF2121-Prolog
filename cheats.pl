% temporary (maybe?), for testing purposes
giveSeed:-
	saveToBag(['potato seed',5]),
	saveToBag(['cabbage seed',3]),
	saveToBag(['corn seed',5]).

setSeason(S):-
	retract(season(_)),
	asserta(season(S)),!.

gotoFarm:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(5,13)),!.
	
gotoAlchemist:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(1,2)),!.