% peri tidur, activates every daychange

fairy:-
	locPlayer(P,Q),
	retract(locPlayer(P,Q)),
	map,
	write('In your dream, you met Paimon'),nl,
	write('Paimon asks you what place do you like most in Leaf Valley!'),nl,nl,
	write('Enter X Coordinate (1-19)'), nl,
    write('Input number: '), nl,
    write('>> '), read_integer(X),
	write('Enter Y Coordinate (1-19)'), nl,
    write('Input number: '), nl,
    write('>> '), read_integer(Y),
    (
        X < 1  
            -> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),!;
		Y < 1
			-> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),!;
		X > 19
			-> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),!;
		Y > 19
			-> write('EHE TE NANDAYO'),nl, assertz(locPlayer(P,Q)),!;
		isAir(P,Q)
			-> write('YOU CANT SWIM PEKO!'),nl, assertz(locPlayer(P,Q)),!;
        X > 0
            -> write('Oghey Peko!'), nl,nl,
			   assertz(locPlayer(X,Y)), !
    ).
	
rollFairy:-
	random(0,100,X),
	(
		X < 10 -> fairy;
		X > 9 -> !
	).