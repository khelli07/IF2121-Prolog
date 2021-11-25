/* :- include('main.pl'). */
:- discontiguous(exit/0).

seasons([spring, summer, fall, winter]).

house :- 
    menu_status(outside),
    retract(menu_status(outside)),
    assertz(menu_status(house)),
    write('- sleep'), nl,
    write('- writeDiary'), nl,
    write('- readDiary'), nl,
    write('- exit'), nl.

sleep :-
    menu_status(house),
    toNextDay,
    write('You went to sleep'), nl, nl,
    day(D), season(S),
    write('Day '), write(D),
    write(' Season '), write(S), nl, nl, !.

sleep :- 
    write('You don''t have access to this function!').

exit :- 
    menu_status(house),
    write('You go to outside'), nl, nl,
    retract(menu_status(house)),
    assertz(menu_status(outside)).

toNextDay :- 
    addDay(1).

/* negatif Add to substract day */
addDay(Add):-
    day(Old),
    New is Old + Add,
    retract(day(Old)),
    (New / 28 > 1 -> NewAdjusted is (New mod 28), assertz(day(NewAdjusted)), toNextSeason
   ; assertz(day(New))).

toNextSeason :-
    season(Current),
    seasons(SeasonsList),
    getNextSeason(Current, SeasonsList, SeasonsList, Next),
    changeSeason(Next).

getNextSeason(_, [], _, _) :- /* Jika tidak ada season yang cocok, gagal */
    !. 
getNextSeason(Current, SeasonsList, SeasonsListOriginal, Next) :-
    [H|T] = SeasonsList,
    (H = Current, T \= [] -> [HT|_] = T, Next = HT
     ; H = Current, T = [] -> [HT|_] = SeasonsListOriginal, Next = HT
     ; getNextSeason(Current, T, SeasonsListOriginal, Next)).

changeSeason(New) :-
    season(Current),
    retract(season(Current)),
    assertz(season(New)).
