/* Game states */
:- dynamic(menu_status/1). 
menu_status(game_not_started).
/* TEMPORARY!!! */
:- dynamic(season/1). %should be in house.pl
season(spring). %spring, summer, fall, winter

/* 
    Available commands by menu status:
    game_not_started: start.
    title_screen: newgame. loadgame.
    outside: { pretty much everything }
    marketplace: buy. sell.
    etc. (can't think of more rn)
*/

start:-
	\+menu_status(game_not_started),!,
	write('Permainan sudah dimulai! Silahkan exit terlebih dahulu.'),
	nl,nl,fail.

/* Commands */
start:-
	/* file load */
	nl,
	['map.pl'],
	['move.pl'],
	['near.pl'],
	['items.pl'],
	['inventory.pl'],
	['quest.pl'],
	['market.pl'],
	['farming.pl'],
	['alchemist.pl'],
	['utilities.pl'],
	/* initializaitons */
	setpagar,
	retractall(menu_status(_)),
	asserta(menu_status(title_screen)),

	/* welcome message */
	nl,nl,nl,
	write('Selamat Datang di Harpest Moon'),nl,
	write('Ketik \'new.\' untuk memulai game baru'),nl,nl,!.
	

/* pseudo new game for testing purposes */ 
new:-
	\+menu_status(title_screen),!,
	write('Tidak dapat memulai game baru!'),
	nl,nl,fail.

new:-
	retract(menu_status(title_screen)),
	asserta(menu_status(outside)),
	write('Game baru sukses dibuat'),
	nl,nl,!.

exit:-
	menu_status(game_not_started),!,
	write('Permainan belum dimulai!'),
	nl,nl,fail.

exit:-
	retractall(menu_status(_)),
	asserta(menu_status(game_not_started)),
	write('Thanks for Playing!'),
	nl,nl,!.
	
hesoyam:- %cheat code easter egg
	['cheats.pl'],nl,nl,
	write('Go home CJ, you\'re drunk'),nl.