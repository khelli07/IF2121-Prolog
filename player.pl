:- dynamic(player/1).
:- dynamic(money/1).

:- dynamic(expplayer/1).
:- dynamic(expfarming/1).
:- dynamic(expfishing/1).
:- dynamic(expranching/1).
:- dynamic(levelplayer/1).
:- dynamic(levelfarming/1).
:- dynamic(levelfishing/1).
:- dynamic(levelranching/1).

:- dynamic(nextlevelexp/1).
:- dynamic(nextlevelexpfarming/1).
:- dynamic(nextlevelexpfishing/1).
:- dynamic(nextlevelexpranching/1).

:- dynamic(hoelevel/1).
:- dynamic(fishingrodlevel/1).

createPlayer(Name) :-
    assertz(player(Name)),
    assertz(money(0)),
    assertz(expplayer(0)),
    assertz(expfarming(0)),
    assertz(expfishing(0)),
    assertz(expranching(0)),
    assertz(levelplayer(1)),
    assertz(levelfarming(1)),
    assertz(levelfishing(1)),
    assertz(levelranching(1)),
    assertz(nextlevelexp(100)),
    assertz(nextlevelexpfarming(100)),
    assertz(nextlevelexpfishing(100)),
    assertz(nextlevelexpranching(100)).

createFarmer(Name) :-
    createPlayer(Name),
    assertz(specialty(farmer)).

createFisherman(Name) :-
    createPlayer(Name),
    assertz(specialty(fisherman)).

createRancher(Name) :-
    createPlayer(Name),
    assertz(specialty(rancher)).

status :-   write('Your status:'), nl,
            write('Job: '), specialty(A), write(A), nl,
            write('Level: '), levelplayer(B), write(B), nl,
            expplayer(C), nextlevelexp(NC), format('Exp: ~w/~w',[C,NC]), nl,
            write('Money: '), money(Money), write(Money), write(' gold'), nl, nl,
            write('Level farming: '), levelfarming(D), write(D), nl,
            expfarming(E), nextlevelexpfarming(NE), format('Exp farming: ~w/~w',[E,NE]), nl,
            write('Level fishing: '), levelfishing(F), write(F), nl,
            expfishing(G), nextlevelexpfishing(NG), format('Exp fishing: ~w/~w',[G,NG]), nl,
            write('Level ranching: '), levelranching(H), write(H), nl,
            expranching(I), nextlevelexpranching(NI), format('Exp ranching: ~w/~w',[I,NI]), nl,!.

/* Untuk semua peredikat change berlaku penambahan, jadi Change adalah perubahan, bukan nilai baru yang menggantikan nilai lama */
/* Mengubah banyak uang, gunakan negatif untuk mengurangi */
changeMoney(Change) :-
    money(Old),
    New is Old + Change,
    retract(money(Old)),
    assertz(money(New)).

/* Mengubah experience dan level keseluruhan player */
changeExpPlayer(Change) :-
    expplayer(Old),
    NewExp is Old + Change,
    retract(expplayer(Old)),
    assertz(expplayer(NewExp)),
    nextlevelexp(NextLevelExp),
    ( NewExp >= NextLevelExp -> changeLevelPlayer(1),
                                NewNextLevelExp is NextLevelExp + 50,
								retract(expplayer(NewExp)),
								MinusExp is NewExp - NextLevelExp,
								assertz(expplayer(MinusExp)),
                                retract(nextlevelexp(NextLevelExp)),
                                assertz(nextlevelexp(NewNextLevelExp));
	  NewExp < NextLevelExp	 -> ! %biar yes
	).

changeLevelPlayer(Change) :-
    levelplayer(Old),
    New is Old + Change,
    retract(levelplayer(Old)),
    assertz(levelplayer(New)).

/* Mengubah experience dan level tiap skill */
changeExpFarming(Change) :-
    expfarming(Old),
    NewExp is Old + Change,
    retract(expfarming(Old)),
    assertz(expfarming(NewExp)),
    nextlevelexpfarming(NextLevelExp),
    ( NewExp >= NextLevelExp -> changeLevelFarming(1),
                                NewNextLevelExp is NextLevelExp + 50,
								retract(expfarming(NewExp)),
								MinusExp is NewExp - NextLevelExp,
								assertz(expfarming(MinusExp)),
                                retract(nextlevelexpfarming(NextLevelExp)),
                                assertz(nextlevelexpfarming(NewNextLevelExp));
	  NewExp < NextLevelExp	 -> ! %biar yes
	).

changeLevelFarming(Change) :-
    levelfarming(Old),
    New is Old + Change,
    retract(levelfarming(Old)),
    assertz(levelfarming(New)).

changeExpFishing(Change) :-
    expfishing(Old),
    NewExp is Old + Change,
    retract(expfishing(Old)),
    assertz(expfishing(NewExp)),
    nextlevelexpfishing(NextLevelExp),
    ( NewExp >= NextLevelExp -> changeLevelFishing(1),
                                NewNextLevelExp is NextLevelExp + 50,
								retract(expfishing(NewExp)),
								MinusExp is NewExp - NextLevelExp,
								assertz(expfishing(MinusExp)),
                                retract(nextlevelexpfishing(NextLevelExp)),
                                assertz(nextlevelexpfishing(NewNextLevelExp));
	  NewExp < NextLevelExp	 -> !
	).

changeLevelFishing(Change) :-
    levelfishing(Old),
    New is Old + Change,
    retract(levelfishing(Old)),
    assertz(levelfishing(New)).

changeExpRanching(Change) :-
    expranching(Old),
    NewExp is Old + Change,
    retract(expranching(Old)),
    assertz(expranching(NewExp)),
    nextlevelexpranching(NextLevelExp),
    ( NewExp >= NextLevelExp -> changeLevelRanching(1),
                                NewNextLevelExp is NextLevelExp + 50,
								retract(expranching(NewExp)),
								MinusExp is NewExp - NextLevelExp,
								assertz(expranching(MinusExp)),
                                retract(nextlevelexpranching(NextLevelExp)),
                                assertz(nextlevelexpranching(NewNextLevelExp)); 
	  NewExp < NextLevelExp	 -> !
	).

changeLevelRanching(Change) :-
    levelranching(Old),
    New is Old + Change,
    retract(levelranching(Old)),
    assertz(levelranching(New)).

hoelevel(1).
fishingrodlevel(1).

changeHoeLevel :- 
    levelplayer(CurrentPlayerLevel),
    hoelevel(Old),
    ( 0 =:= CurrentPlayerLevel mod 2
        ->  NewHoeLevel is Old + 1,
            retract(hoelevel(Old)),
            asserta(hoelevel(NewHoeLevel))
    ).

changeFishingRodLevel :-
    levelplayer(CurrentPlayerLevel),
    fishingrodlevel(Old),
    ( 0 =:= CurrentPlayerLevel mod 2
        ->  NewFishRodLevel is Old + 1,
            retract(fishingrodlevel(Old)),
            asserta(fishingrodlevel(NewFishRodLevel))
    ).
