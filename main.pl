/* Game states */
:- dynamic(menu_status/1). 
menu_status(game_not_started).

/* 
    Available commands by menu status:
    game_not_started: start.
    title_screen: newgame. loadgame.
    outside: { pretty much everything }
    marketplace: buy. sell.
	house: sleep. writeDiary. readDiary. exit.
    etc. (can't think of more rn)
*/

:- initialization(start).

start:-
	\+menu_status(game_not_started),!,
	write('Permainan sudah dimulai! Silahkan exit terlebih dahulu.'),
	nl,nl,fail.

/* Commands */
start:-
	/* file load */
	nl,
	set_prolog_flag(unknown, warning),
	['utilities.pl'],
	resetAllDynamicFacts,	% mencegah double fakta kalau command start dijalankan lagi, resetAllDynamicFacts tidak mengubah menu_status
	['map.pl'],
	['move.pl'],
	['near.pl'],
	['items.pl'],
	['player.pl'],
	['inventory.pl'],
	['quest.pl'],
	['house.pl'],
	['market.pl'],
	['farming.pl'],
	['fishing.pl'],
	['ranching.pl'],
	['alchemist.pl'],
	['fairy.pl'],
	['help.pl'],
	/* initializaitons */
	setpagar,
	retractall(menu_status(_)),
	asserta(menu_status(title_screen)),

	/* welcome message */
	nl,nl,nl,
	write('Selamat Datang di Harpest Moon'),nl,
	write('Ketik\n\'new.\' untuk memulai game baru\n\'load.\' untuk load game sebelumnya'),nl,nl,!.
	

/* character creation */ 
farmer:-
	menu_status(character_creation),
	createFarmer(player),
	retract(menu_status(character_creation)),
	assertz(menu_status(outside)),
	write('Anda memilih menjadi Farmer!'),nl,nl,
	help,!.

fisherman:-
	menu_status(character_creation),
	createFisherman(player),
	retract(menu_status(character_creation)),
	assertz(menu_status(outside)),
	write('Anda memilih menjadi Fisherman!'),nl,nl,
	help,!.
	
rancher:-
	menu_status(character_creation),
	createRancher(player),
	retract(menu_status(character_creation)),
	assertz(menu_status(outside)),
	write('Anda memilih menjadi Rancher!'),nl,nl,
	help,!.
	
new:-
	\+menu_status(title_screen),!,
	write('Tidak dapat memulai game baru!'),
	nl,nl,fail.

new:-
	retract(menu_status(title_screen)),
	asserta(menu_status(character_creation)),
	write('Silahkan pilih role!'),nl,nl,
	help,
	nl,nl,!.

load:-
	\+menu_status(title_screen),!,
	write('Tidak dapat load game!'),
	nl,nl,fail.

load :-
	retract(menu_status(title_screen)),
	retractall(menu_status(_)),
	asserta(menu_status(house)),
	(readDiary -> !;
	 retractall(menu_status(_)), asserta(menu_status(title_screen)), write('Load gagal/dibatalkan!'), nl
	).

exit:-
	menu_status(game_not_started),!,
	write('Permainan belum dimulai!'),
	nl,nl,fail.

exit :- 
    menu_status(house),
    write('You go to outside'), nl, nl,
    retract(menu_status(house)),
    assertz(menu_status(outside)), !.

exit:-
	menu_status(outside),
	retractall(menu_status(_)),
	asserta(menu_status(game_not_started)),
	write('Thanks for Playing!'),
	nl,nl,!.
	
hesoyam:- %cheat code easter egg
	['cheats.pl'],nl,nl,
	write('Go home CJ, you\'re drunk'),nl.
