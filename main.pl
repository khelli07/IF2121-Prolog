/* Game/Menu states */
:- dynamic(menu_status/1). 
menu_status(game_not_started).
% Available commands by menu status:
% game_not_started: start.
% title_screen: newgame. loadgame.
% outside: {pretty much everything}
% marketplace: buy. sell.
% etc. (can't think of more rn)

/* Commands */
start:-
	\+menu_status(game_not_started),!,
	write('Game sudah dimulai!'),
	nl,nl,!.

start:-
	%file load
	nl,
	['map.pl'],
	['move.pl'],
	['near.pl'],
	%initializaitons
	setpagar,
	retract(menu_status(_)),
	asserta(menu_status(title_screen)),
	%welcome message
	nl,nl,nl,
	write('Selamat Datang di Harpest Moon'),nl,
	write('Ketik \'new.\' untuk memulai game baru'),nl,nl,!.
	

%pseudo new game for testing purposes

new:-
	\+menu_status(title_screen),!,
	write('Tidak dapat memulai game baru!'),
	nl,nl,!.

new:-
	retract(menu_status(title_screen)),
	asserta(menu_status(outside)),
	write('Game baru sukses dibuat'),
	nl,nl,!.
	