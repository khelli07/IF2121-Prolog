% needs items.pl, inventory.pl, player.pl, house.pl and main.pl
% player commands: dig, plant

:-dynamic(crop/4). % X,Y,duration,name

dig:-
	\+menu_status(outside),!,
	write('Anda tidak sedang berada di luar!'),
	nl,nl,fail.

dig:-
	isOnSoil,!,
	locPlayer(P,Q),!,
	R is Q-1,
	move(P,R),!,
	retract(isSoil(P,Q)),
	assertz(isDiggedTile(P,Q)),
	write('Anda berhasil menggarap tanah'),
	nl,nl,!.

dig:-
	write('Anda tidak berada di tanah kosong!'),
	nl,nl,fail.
	
totalInSeason([],_,0).

totalInSeason([H|T], S, Total):-
    itemName(H, HName),!,
    itemType(HName, seed),!,
	seasonSeed(HName,S),!,
    itemCount(H, Count),!,
    totalInSeason(T, S, Total1),!,
	Total is Count+Total1.

totalInSeason([_|T], S, Total):-
	totalInSeason(T, S, Total),!.

displaySeed([],_,[],_,0):-!.

displaySeed([H|T],S,L,I,Total):-
	itemName(H, HName),!,
    itemType(HName, seed),!,
	seasonSeed(HName,S),!,
    itemCount(H, Count),!,
	format('~w. ~w (x ~w)', [I, HName, Count]),nl,
	IN is I + 1,
	displaySeed(T,S,LN,IN,TotalN),!,
	Total is TotalN + 1,
	L = [HName|LN].

displaySeed([_|T],S,L,I,Total):-
	displaySeed(T,S,L,I,Total),!.

getSeed([H|_],1,H):- !.

getSeed([_|T],Number,Name):-
	NewNumber is Number-1,
	getSeed(T,NewNumber,SeedName),!,
	Name = SeedName,!.
	
getSeedSelection(B,S,Name):-
	displaySeed(B,S,SeedList,1,Total),!,
	write('What do you want to plant?'), nl,
    write('Input number: '), read_integer(Number),
    (
        Number < 0
            ->  write('Please input a valid number!'), fail;
        Number > Total
            ->  write('Please input a valid number!'), fail;
        Number =< Total
            ->  getSeed(SeedList,Number,SeedName),!, Name = SeedName,!
    ).
	

plant(_,_):-
	\+menu_status(outside),!,
	write('Anda tidak sedang berada di luar!'),
	nl,nl,fail,!.

plant(_,_):-
	\+isOnDigged,!,
	write('Anda tidak sedang berada di tanah yang sudah digarap!'),
	nl,nl,fail,!.

plant(S,_):-
	S == 'winter',
	write('Tanaman tidak dapat ditanam di musim dingin!'),
	nl,nl,fail,!.

plant(S,B):-
	totalInSeason(B,S,0),!,
	write('Anda tidak memiliki biji!'),
	nl,nl,fail,!.
	
plant(S,B):-
	getSeedSelection(B,S,Name),!,
	locPlayer(P,Q),!,
	growTime(Name,D),!, % D needs to be recalibrated
	R is Q-1,
	assertz(crop(P,Q,D,Name)),
	move(P,R),!,
	deleteFromBag([Name,1]),!,
	retract(isDiggedTile(P,Q)),
	assertz(isCrop(P,Q)),
	write('Anda berhasil menanam'),
	nl,nl,!.

plant:-
	season(X),!,
	baglist(B),!,
	plant(X,B),!.