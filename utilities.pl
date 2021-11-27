% fungsi fungsi umum
max(A,B,A):- 
	A>B,!.

max(A,B,B):- 
	A=<B,!.

% Get I th element of list, index from 0
get_list_element([], _, _) :- fail, !.
get_list_element(L, 0, E) :-
	[H|_] = L,
	E = H, !.
get_list_element(L, I, E) :-
	[_|T] = L,
	I1 is I - 1,
	get_list_element(T, I1, E).

% Get random from list
chooseRandomFromList(L, X) :-
	length(L, N),
	random(0, N, R),
	get_list_element(L, R, X).

% Add X to L for N times, to the end, X is element, new List LNew created
addNTimesToList(_, L, 0, LNew) :- LNew = L, !.
addNTimesToList(X, L, N, LNew) :-
    N > 0,
    N1 is N - 1,
    addNTimesToList(X, L, N1, L1),
    append(L1, [X], LNew).

% Read string, output List of character code
read_str(String) :-
	get0(Char), read_str_aux(Char, String).
read_str_aux(-1, []) :- !.	% EOF
read_str_aux(10, []) :- !.	% EOL (Linux)
read_str_aux(13, []) :- !.	% EOL (baris baru)
read_str_aux(Char, [Char|Rest]) :- read_str(Rest).
% Read atom, able to accept space separated atom
read_atom_string(Atom) :-
	read_str(String),
	atom_codes(Atom, String).

% Read Number
read_num(Number) :-
	read_str(String),
	number_codes(Number, String).

/* Convert string to uppercase */
charUpper(String, Index, CU):-
    sub_atom(String, Index, 1, _, Char),
    lower_upper(Char, CU).

stringUpper(String, Index, UpperStr):-
    atom_length(String, Length),
    Index == Length,
    UpperStr = '', !.

stringUpper(String, Index, UpperStr):-
    atom_length(String, Length),
    Index < Length,
    charUpper(String, Index, CU),
    Index1 is Index + 1,
    stringUpper(String, Index1, UpperStr1),
    atom_concat(CU, UpperStr1, UpperStr).

toUpper(String, Output):-
    stringUpper(String, 0, Output).

% resetAllDynamicFacts tidak mereset menu_status
resetAllDynamicFacts :-
    % alchemist.pl
    retractall(gandalf(_)),
    retractall(potionBag(_)),
    retractall(kaburTimer(_)),
    % farming.pl
    retractall(crop(_)),
    % fishing.pl
    retractall(today_fishing_count(_)),
    % house.pl
    retractall(day(_)),
    retractall(season(_)),
    % inventory.pl
    retractall(baglist(_)),
    % map.pl
    retractall(draw_done(_)),
    retractall(locPlayer(_,_)),
    retractall(isAir(_,_)),
    retractall(isPagar(_,_)),
    retractall(isSoil(_,_)),
    retractall(isDiggedTile(_,_)),
    retractall(isCrop(_,_)),
    retractall(isHarvest(_,_)),
    retractall(isAlchemist(_,_)),
    retractall(isCrater(_,_)),
    % player.pl
    retractall(player(_)),
    retractall(money(_)),
    retractall(specialty(_)),
    retractall(money(_,_)),
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
    retractall(hoelevel(_)),
    retractall(fishingrodlevel(_)),
    % quest.pl
    retractall(harvest_item(_,_)),
    retractall(fish_item(_,_)),
    retractall(ranch_item(_,_)),
    retractall(isQuestActive(_)),
    retractall(isSpecialQuest(_)),
    retractall(questAdd(_)),
    % ranching.pl
    retractall(animals(_)),
    retractall(chickenAffection(_)),
    retractall(cowAffection(_)),
    retractall(sheepAffection(_)),
    retractall(layTime(_)),
    retractall(milkTime(_)),
    retractall(woolTime(_)),
    retractall(eggProd(_)),
    retractall(milkProd(_)),
    retractall(woolProd(_)),
    retractall(nextLay(_)),
    retractall(nextMilk(_)),
    retractall(nextWool(_)).
