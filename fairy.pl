% peri tidur, activates every daychange

fairy:-
	locPlayer(P,Q),
	retract(locPlayer(P,Q)),
	retract(menu_status(house)),
	assertz(menu_status(outside)),
	map,
	retract(menu_status(outside)),
	write('In your dream, you met Paimon'),nl,
	write('Paimon asks you what place you like most in Leaf Valley!'),nl,nl,
	write('Enter X Coordinate (1-19)'), nl,
    write('Input number: '), nl,
    write('>> '), read_integer(X),
	write('Enter Y Coordinate (1-19)'), nl,
    write('Input number: '), nl,
    write('>> '), read_integer(Y),
    (
        X < 1  
            -> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),assertz(menu_status(house)),!;
		Y < 1
			-> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),assertz(menu_status(house)),!;
		X > 19
			-> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),assertz(menu_status(house)),!;
		Y > 19
			-> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),assertz(menu_status(house)),!;
		isAir(P,Q)
			-> write('YOU CANT SWIM PEKO!'),nl, assertz(locPlayer(P,Q)),assertz(menu_status(house)),!;
        X > 0
            -> write('Oghey Peko!'), nl,nl,
			   assertz(locPlayer(X,Y)), assertz(menu_status(outside)), !
    ).
	
rollFairy:-
	random(0,100,X),
	(
		X < 10 -> fairy;
		X > 9 -> !
	).