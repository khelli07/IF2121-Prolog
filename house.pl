% :- include('main.pl').
% :- include('utilities.pl').
% :- include('player.pl').
% :- include('map.pl').
% :- include('farming.pl'). %for updateCrop in toNextDay
% :- include('fairy.pl'). %for rollFairy in toNextDay

seasons([spring, summer, fall, winter]).

house :- 
    menu_status(outside),
    retract(menu_status(outside)),
    assertz(menu_status(house)),
    write('Welcome to house'), nl,
    write('- sleep.'), nl,
    write('- writeDiary.'), nl,
    write('- readDiary.'), nl,
    write('- exit.'), nl.

sleep :-
    menu_status(house),
    toNextDay,
    write('You went to sleep'), nl, nl,
    day(D), season(S),
    write('Day '), write(D),
    write(' Season '), write(S), nl, nl,
    write('house'), nl,
    write('- sleep.'), nl,
    write('- writeDiary.'), nl,
    write('- readDiary.'), nl,
    write('- exit.'), nl, !.

sleep :- 
    write('You don''t have access to this function! Go to house').


writeDiary :-
    menu_status(house),
    retract(menu_status(house)),
    assertz(menu_status(saving)),
    write('Enter save name (ex: Firstday, no file extension and EOL dot (.) needed)'),nl,
    read_atom(Name),
    concat(Name, '.pl', FileName),
    concat('./saved_files/', FileName, DirFileName),
    open(DirFileName, write, Stream),

    % TO DO: Menambahkan lebih banyak state
    player(A), write(Stream, 'player('),write(Stream, A), write(Stream, ').'), nl(Stream),
    expplayer(B), write(Stream, 'expplayer('),write(Stream, B), write(Stream, ').'), nl(Stream),
    expfarming(C), write(Stream, 'expfarming('),write(Stream, C), write(Stream, ').'), nl(Stream),
    expfishing(D), write(Stream, 'expfishing('),write(Stream, D), write(Stream, ').'), nl(Stream),
    expranching(E), write(Stream, 'expranching('),write(Stream, E), write(Stream, ').'), nl(Stream),
    levelplayer(F), write(Stream, 'levelplayer('),write(Stream, F), write(Stream, ').'), nl(Stream),
    levelfarming(G), write(Stream, 'levelfarming('),write(Stream, G), write(Stream, ').'), nl(Stream),
    levelfishing(H), write(Stream, 'levelfishing('),write(Stream, H), write(Stream, ').'), nl(Stream),
    levelranching(I), write(Stream, 'levelranching('),write(Stream, I), write(Stream, ').'), nl(Stream),
    nextlevelexp(J), write(Stream, 'nextlevelexp('),write(Stream, J), write(Stream, ').'), nl(Stream),
    nextlevelexpfarming(K), write(Stream, 'nextlevelexpfarming('),write(Stream, K), write(Stream, ').'), nl(Stream),
    nextlevelexpfishing(L), write(Stream, 'nextlevelexpfishing('),write(Stream, L), write(Stream, ').'), nl(Stream),
    nextlevelexpranching(M), write(Stream, 'nextlevelexpranching('),write(Stream, M), write(Stream, ').'), nl(Stream),

    locPlayer(N,O), write(Stream, 'locPlayer('),write(Stream, N), write(Stream, ','), write(Stream, O), write(Stream, ').'), nl(Stream),
    forall(isDiggedTile(X,Y), saveDiggedTile(Stream, X, Y)),
    forall(isCrop(X,Y), saveCrop(Stream, X, Y)),
    forall(isHarvest(X,Y), saveHarvest(Stream, X, Y)),
    close(Stream),
    retract(menu_status(saving)),
    assertz(menu_status(house)), 
    write('Diary succesfully saved'), nl,
    !.

writeDiary :-
    \+ (menu_status(house)),
    write('Can only write diary on house'), nl.

saveDiggedTile(Stream, X, Y) :-
    menu_status(saving),
    write(Stream, 'isDiggedTile('),write(Stream, X), write(Stream, ','), write(Stream, Y), write(Stream, ').'), nl(Stream).

saveCrop(Stream, X, Y) :-
    menu_status(saving),
    write(Stream, 'isCrop('),write(Stream, X), write(Stream, ','), write(Stream, Y), write(Stream, ').'), nl(Stream).

saveHarvest(Stream, X, Y) :-
    menu_status(saving),
    write(Stream, 'isHarvest('),write(Stream, X), write(Stream, ','), write(Stream, Y), write(Stream, ').'), nl(Stream).


readDiary :-
    % not yet tested
    menu_status(house),
    write('Choose your saved diary (Enter number, ex: 1, without dot (.) EOL)'), nl,

    directory_files('./saved_files', L),
    [_|[_|FL]] = L,
    displayFilesNameList(FL, 1),
    read_num(Num),
    Num1 is Num - 1,
    get_list_element(FL,Num1,Res),
    retractall(player(_)),
    retractall(expplayer(_)),
    retractall(expfarming(_)),
    retractall(expfishing(_)),
    retractall(expranching(_)),
    retractall(levelplayer(_)),
    retractall(levelfarming(_)),
    retractall(levelfishing(_)),
    retractall(levelranching(_)),
    retractall(nextlevelexp(_)),
    retractall(nextlevelexpfarming(_)),
    retractall(nextlevelexpfishing(_)),
    retractall(nextlevelexpranching(_)),

    retractall(locPlayer(_,_)),
    retractall(isDiggedTile(_,_)),
    retractall(isCrop(_,_)),
    retractall(isHarvest(_,_)),
    concat('./saved_files/', Res, DirFileName),
    consult(DirFileName),
    write('Reading diary succesful'), nl,
    status, nl,
    write('house'), nl,
    write('- sleep.'), nl,
    write('- writeDiary.'), nl,
    write('- readDiary.'), nl,
    write('- exit.'), nl. 

displayFilesNameList([], _) :- !.
displayFilesNameList(L, IDX) :-
    [H|T] = L,
    write(IDX), write('. '),
    write(H), nl,
    IDX1 is IDX + 1,
    displayFilesNameList(T, IDX1).

toNextDay :- 
	updateCrop, % updates crop timer, farming.pl
	rollFairy, % peri tidur, fairy.pl
    addDay(1).

/* negatif Add to substract day */
addDay(Add):-
    day(Old),
    New is Old + Add,
    retract(day(Old)),
    (
        New / 28 > 1 -> NewAdjusted is (New mod 28), assertz(day(NewAdjusted)), toNextSeason;
        assertz(day(New))
    ).

toNextSeason :-
    season(Current),
    seasons(SeasonsList),
    getNextSeason(Current, SeasonsList, SeasonsList, Next),
    changeSeason(Next).

getNextSeason(_, [], _, _) :- /* Jika tidak ada season yang cocok, gagal */
    !. 
getNextSeason(Current, SeasonsList, SeasonsListOriginal, Next) :-
    [H|T] = SeasonsList,
    (
        H = Current, T \= []    -> [HT|_] = T, Next = HT;
        H = Current, T = []     -> [HT|_] = SeasonsListOriginal, Next = HT;
        getNextSeason(Current, T, SeasonsListOriginal, Next)
    ).

changeSeason(New) :-
    season(Current),
    retract(season(Current)),
    assertz(season(New)).

