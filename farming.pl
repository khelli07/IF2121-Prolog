% needs items.pl, inventory.pl, player.pl, house.pl and main.pl
% player commands: dig, plant
% internal commands: updateCrop/0

:-dynamic(crop/1). % [X,Y,duration,name]
crop([]).

/* Crop Insert/Delete */
insertCrop([],Item,[Item]).

insertCrop([H|T],Item,Newbag):-
	insertCrop(T,Item,L),!,
	Newbag = [H|L],!.

addCrop(Item):-
	crop(Bag),
	insertCrop(Bag,Item,Newbag),!,
	retract(crop(Bag)),
	asserta(crop(Newbag)),!.

deleteCrop([H|T],H,T).

deleteCrop([H|T],Item,Newbag):-
	deleteCrop(T,Item,L),!,
	Newbag = [H|L],!.

doneCrop(Item):-
	crop(Bag),
	deleteCrop(Bag,Item,Newbag),!,
	retract(crop(Bag)),
	asserta(crop(Newbag)),!.

/* DIGGING */
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
/* Crop Acessing */
getH([H|_],H).
getT([_|T],T).

coordsCrop([H|T],H,Y):-
	getH(T,X),!,
	Y is X,!.

durCrop([_|T],D):-
	getT(T,T1),
	getH(T1,X),!,
	D is X, !.
	
nameCrop([_|T],Name):-
	getT(T,T1),
	getT(T1,T2),
	getH(T2,N),!,
	Name = N, !.

findCrop([H|_],P,Q,H):-
	coordsCrop(H,X,Y),
	P is X,
	Q is Y,!.

findCrop([_|T],P,Q,C1):-
	findCrop(T,P,Q,C2),!,
	C1 = C2,!.

/* PLANTING */
totalInSeason([],_,0).

totalInSeason([H|T], S, Total):-
	itemName(H, HName),
    \+itemType(HName, seed),!,
	totalInSeason(T, S, Total).


totalInSeason([H|T], S, Total):-
	itemName(H, HName),
	\+seasonSeed(HName,S),!,
	totalInSeason(T, S, Total).


totalInSeason([H|T], S, Total):-
    itemCount(H, Count),!,
    totalInSeason(T, S, Total1),!,
	Total is Count + Total1,!.

displaySeed([],_,[],_,0):-!.

displaySeed([H|T], S, L, I, Total):-
	itemName(H, HName),
    \+itemType(HName, seed),!,
	displaySeed(T, S, L, I, Total).

displaySeed([H|T], S, L, I, Total):-
	itemName(H, HName),
	\+seasonSeed(HName,S),!,
	displaySeed(T, S, L, I, Total).

displaySeed([H|T],S,L,I,Total):-
	itemName(H, HName),
    itemCount(H, Count),
	format('~w. ~w (x ~w)', [I, HName, Count]),nl,
	IN is I + 1,
	displaySeed(T,S,LN,IN,TotalN),!,
	Total is TotalN + 1,
	L = [HName|LN].

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
	addCrop([P,Q,D,Name]),
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

/* PLANT UPDATES */
cropToHarvest(0,_,_,_).
cropToHarvest(_,0,X,Y):-
	retract(isCrop(X,Y)),
	assertz(isHarvest(X,Y)),!.
cropToHarvest(_,_,_,_).

updateInstance(L,New):- %X,Y,dur,Name
	coordsCrop(L,X,Y),
	durCrop(L,D),
	nameCrop(L,N),
	D1 is D-1,
	max(D1,0,D2),
	cropToHarvest(D,D2,X,Y),
	New = [X,Y,D2,N],!.

updateCrop([],[]).
updateCrop([H|T],L):-
	updateInstance(H,New),
	updateCrop(T,L1),
	L = [New|L1],!.
	
updateCrop:-
	crop(L),
	updateCrop(L,NewL),!,
	asserta(crop(NewL)),
	retract(crop(L)),!.

/* HARVEST TIME */

harvest(_,_,_):-
	\+menu_status(outside),
	write('Anda tidak sedang berada di luar!'),
	nl,nl,fail,!.

harvest(P,Q,C):-
	isCrop(P,Q),
	write('Tanaman belum siap panen'),nl,
	findCrop(C,P,Q,C1),
	nameCrop(C1,N),
	growTo(N,N1),
	durCrop(C1,D),
	format('~w akan tumbuh dalam ~w hari',[N1,D]),
	nl,nl,!.

harvest(P,Q,C):- % TODO: ADD XP AND ADD YIELDS
	isHarvest(P,Q),
	findCrop(C,P,Q,C1),
	doneCrop(C1),
	retract(isHarvest(P,Q)),
	asserta(isSoil(P,Q)),
	nameCrop(C1,N),
	growTo(N,N1),
	format('~w berhasil dipanen',[N1]),nl,nl,
	saveToBag([N1,1]),!.

harvest:-
	crop(C),
	locPlayer(P,Q),
	harvest(P,Q,C),!.
	