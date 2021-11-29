% temporary (maybe?), for testing purposes
giveSeed:-
	saveToBag(['potato seed',5]),
	saveToBag(['cabbage seed',3]),
	saveToBag(['corn seed',5]).

givePotion:-
	saveToPotion(['red pill',2]),
	saveToPotion(['white pill',1]).

giveBestTools:-
    saveToBag(['Level 4 hoe', 1]),
    saveToBag(['Level 4 fishing rod', 1]).

giveBaseTools:-
	saveToBag(['Level 1 hoe', 1]),
    saveToBag(['Level 1 fishing rod', 1]).

addBag:-
    saveToBag(['corn', 10]),
    saveToBag(['carp', 8]),
    saveToBag(['egg', 12]), 
    saveToBag(['tomato seed', 5]),
    saveToBag(['Level 1 hoe', 1]).

addOneBag:-
	saveToBag(['corn',1]).
	
clearBag:-
	retract(baglist(_)),
	assertz(baglist([])),!.
	
makeMeRich:-
	changeMoney('30000').
	
makeMePoor:-
	retract(money(_)),
	assertz(money(0)),!.
	
giveMoney:-
	changeMoney('1000').

setSeason(S):-
	retract(season(_)),
	asserta(season(S)),!.

teleport(X,Y):-
	retract(locPlayer(_,_)),
	assertz(locPlayer(X,Y)),!.

gotoFarm:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(5,13)),!.
	
gotoAlchemist:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(3,2)),!.

gotoMarket:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(15,3)),!.

gotoQuest:-
	retract(locPlayer(_,_)),
	asserta(locPlayer(18,18)),!.

fullAffection:-
	specialty(rancher),
	chickenAffection(OldChickAff),
	cowAffection(OldCowAff),
	sheepAffection(OldSheepAff),
	New is 20,
	retract(chickenAffection(OldChickAff)),
	asserta(chickenAffection(New)),
	retract(cowAffection(OldCowAff)),
	asserta(cowAffection(New)),
	retract(sheepAffection(OldSheepAff)),
	asserta(sheepAffection(New)).