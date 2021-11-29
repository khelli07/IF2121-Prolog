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
	write('Selamat Datang di Hopeless Moon'),nl,
	write('Ketik\n\'new.\' untuk memulai game baru\n\'load.\' untuk load game sebelumnya'),nl,nl,!.
	

/* character creation */ 
farmer:-
	menu_status(character_creation),
	createFarmer(player),
	retract(menu_status(character_creation)),
	assertz(menu_status(outside)),
	write('You choose to be a Farmer!'),nl,nl,
	help,!.

fisherman:-
	menu_status(character_creation),
	createFisherman(player),
	retract(menu_status(character_creation)),
	assertz(menu_status(outside)),
	write('You choose to be a Fisherman!'),nl,nl,
	help,!.
	
rancher:-
	menu_status(character_creation),
	createRancher(player),
	retract(menu_status(character_creation)),
	assertz(menu_status(outside)),
	write('You choose to be a Rancher!'),nl,nl,
	help,!.
	
new:-
	\+menu_status(title_screen),!,
	write('Can not start a new game right now!'),
	nl,nl,fail.

new:-
    X1 = 'Welcome to the game!', 
    writeDelay(X1, 0.05), nl, nl,
    X2 = 'Grandpa: Hello, Claire! Thank God you are back. My village has been neglected these days. I have been very busy with my health :(', 
    writeDelay(X2, 0.05), nl, nl,
    write('Type any number to continue'), nl, read_integer(X11), nl,

    X3 = 'Claire: What happend to your health grandpa?',
    writeDelay(X3, 0.05), nl, nl,
    write('Type any number to continue'), nl, read_integer(X22), nl,

    X4 = 'Grandpa: Nah, don\'t worry about it. Just some old sickness. Anyway, could you take over my village?', 
    writeDelay(X4, 0.05), nl, nl,
    write('Type any number to continue'), nl, read_integer(X33), nl,

    X5 = 'Claire: Yes, grandpa. I also happen to have a 20 000 debt and I need to pay them in less than a year.', 
    writeDelay(X5, 0.05), nl, nl, 
    write('Type any number to continue'), nl, read_integer(X44), nl,

    X6 = 'Grandpa: Aww, my sweetheart. Thank you very much. From now on, this is your village. I don\'t even know if I can survive another year, lol. Good luck! Love you <3',
    writeDelay(X6, 0.05), nl, nl,
    write('Type any number to continue'), nl, read_integer(X55), nl,
    nl, nl,
	retract(menu_status(title_screen)),
	asserta(menu_status(character_creation)),
	write('Please choose a role!'),nl,nl,
	help,
	nl,nl,!.

load:-
	\+menu_status(title_screen),!,
	write('Can not load the game!'),
	nl,nl,fail.

load :-
	retractall(menu_status(_)),
	asserta(menu_status(house)),
	(readDiary -> !; retractall(menu_status(_)), asserta(menu_status(title_screen))).
	% catch(readDiary, E, (write('Cannot acces saved files! Try restarting Prolog!\n'),
	% 					 retractall(menu_status(_)),
	% 					 asserta(menu_status(title_screen)))),
	% (player(X) -> !; retractall(menu_status(_)), asserta(menu_status(title_screen))). % Mengecek gagal atau tidak

exit:-
	menu_status(game_not_started),!,
	write('GAME! IS! NOT! STARTED!!!'),
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
