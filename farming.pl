% needs items.pl, inventory.pl, player.pl, and main.pl
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

plant:-
	\+menu_status(outside),!,
	write('Anda tidak sedang berada di luar!'),
	nl,nl,fail.

plant:-
	isOnDigged,!, % todo: display seeds and select first
	locPlayer(P,Q),!, 
	R is Q-1,
	move(P,R),!,
	retract(isDiggedTile(P,Q)),
	assertz(isCrop(P,Q)),
	write('Anda berhasil menanam '),
	nl,nl,!.

plant:-
	write('Anda tidak berada di tanah kosong!'),
	nl,nl,fail.
	