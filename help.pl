% displays available command for each menu

helpmsg:-
	write('Command tidak tersdia! Ketik \'help.\' untuk daftar command'),!.

help:-
	menu_status(game_not_started),
	write('---------------- Command List ----------------'),nl,
	write('| start.      :- loads game                  |'),nl,
	write('----------------------------------------------'),nl,!.

help:-
	menu_status(title_screen),
	write('---------------- Command List ----------------'),nl,
	write('| new.        :- starts a new game           |'),nl,
	write('| load.       :- loads a savefile            |'),nl,
	write('----------------------------------------------'),nl,!.

help:-
	menu_status(character_creation),
	write('---------------- Command List ----------------'),nl,
	write('| farmer.      :- starts as farmer           |'),nl,
	write('| fisherman.   :- starts as fisherman        |'),nl,
	write('| rancher.     :- starts as rancher          |'),nl,
	write('----------------------------------------------'),nl,!.

help:-
	menu_status(outside),
	write('---------------- Command List ----------------'),nl,
	write('| w.          :- moves up                    |'),nl,
	write('| a.          :- moves left                  |'),nl,
	write('| s.          :- moves down                  |'),nl,
	write('| d.          :- moves right                 |'),nl,
	write('| map.        :- displays map                |'),nl,
	write('| legends.    :- displays map legends        |'),nl,
	write('| status.     :- displays player stats       |'),nl,
	write('| inventory.  :- displays inventory          |'),nl,
	write('| dig.        :- digs soil                   |'),nl,
	write('| plant.      :- plants seed                 |'),nl,
	write('| harvest.    :- harvests crops              |'),nl,
	write('| ranch.      :- opens ranch                 |'),nl,
	write('| fish.       :- fishing                     |'),nl,
	write('| market.     :- enters market               |'),nl,
	write('| house.      :- enters house                |'),nl,
	write('| quest.      :- gets quest                  |'),nl,
	write('| alchemist.  :- ?                           |'),nl,
	write('| potion.     :- ??                          |'),nl,
	write('----------------------------------------------'),nl,!.
	
help:-
	isOnRanch,
	write('---------------- Command List ----------------'),nl,
	write('| chicken.    :- grooms your chicken         |'),nl,
	write('| cow.        :- grooms your cow             |'),nl,
	write('| sheep.      :- grooms your sheep           |'),nl,
	write('----------------------------------------------'),nl,!.
	
help:-
	menu_status(market),
	write('---------------- Command List ----------------'),nl,
	write('| buy.        :- buy stuff                   |'),nl,
	write('| sell.       :- sell stuff                  |'),nl,
	write('| exitMarket. :- exits market                |'),nl,
	write('----------------------------------------------'),nl,!.
	
help:-
	menu_status(house),
	write('---------------- Command List ----------------'),nl,
	write('| sleep.       :- sleeps till the next day   |'),nl,
	write('| writeDiary.  :- writes log to diary        |'),nl,
	write('| readDiary.   :- reads previous diary logs  |'),nl,
	write('| exit.        :- exits house                |'),nl,
	write('----------------------------------------------'),nl,!.