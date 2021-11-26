% temporary (maybe?), for testing purposes
giveSeed:-
	saveToBag(['potato seed',5]),
	saveToBag(['cabbage seed',3]),
	saveToBag(['corn seed',5]).

givePotion:-
	saveToPotion(['red pill',2]),
	saveToPotion(['white pill',1]).

addBag:-
    saveToBag(['corn', 10]),
    saveToBag(['carp', 8]),
    saveToBag(['egg', 12]), 
    saveToBag(['tomato seed', 5]),
    saveToBag(['Level 1 hoe', 1]).
	
giveMoney:-
	changeMoney('1000').

setSeason(S):-
	retract(season(_)),
	asserta(season(S)),!.

gotoFarm:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(5,13)),!.
	
gotoAlchemist:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(3,2)),!.