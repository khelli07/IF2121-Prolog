% :- include('main.pl').
% :- include('utilities.pl').
% :- include('player.pl').
% :- include('map.pl').
% :- include('farming.pl'). %for updateCrop in toNextDay
% :- include('fairy.pl'). %for rollFairy in toNextDay
:- dynamic(day/1).
:- dynamic(season/1).
day(1).
season(spring).
seasons([spring, summer, fall, winter]).

house :- 
    menu_status(outside),
    isOnHouse,
    retract(menu_status(outside)),
    assertz(menu_status(house)),
    write('Welcome to house'), nl,
    write('- sleep.'), nl,
    write('- writeDiary.'), nl,
    write('- readDiary.'), nl,
    write('- exit.'), nl.

sleep :-
    menu_status(house),
	write('You went to sleep'), nl, nl,
    toNextDay,
    day(D), season(S),
	( menu_status(house)
		->	write('Day '), write(D),
			write(' Season '), write(S), nl, nl,
			write('house'), nl,
			write('- sleep.'), nl,
			write('- writeDiary.'), nl,
			write('- readDiary.'), nl,
			write('- exit.'), nl; 
	   menu_status(X)
		->  !
	),!.

sleep :- 
	\+menu_status(game_not_started),!,
    write('You don''t have access to this function! Go to house').

toNextDay :- 
    money(CurrMoney),
    day(CurrDay),
    NextDay is CurrDay + 1,
    ( CurrMoney >= 20000
      -> write('Congratulations! You have finally collected 20000 golds!'),nl,nl,
         retractall(menu_status(_)),
         asserta(menu_status(game_not_started)),!;
      CurrMoney < 20000, NextDay > 28, season(winter)
      -> write('You have worked hard, but in the end result is all that matters.'),nl,
         write('May God bless you in the future with kind people!'),nl,nl,
         retractall(menu_status(_)),
         asserta(menu_status(game_not_started)),!   
    ),!,fail.

toNextDay :-
	updateCrop, % updates crop timer, farming.pl
	rollFairy, % peri tidur, fairy.pl
    updateNextLay, % hasil animal, ranching.pl
    updateNextMilk,
    updateNextWool,
    retractall(today_fishing_count(_)), % reset fishing count
    asserta(today_fishing_count(0)),
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
    changeSeason(Next),
    retractall(fish_season_list(_)),
    createNewSeasonFishList(Next, LFish),
    asserta(fish_season_list(LFish)).

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


writeDiary :-
    menu_status(house),
    retract(menu_status(house)),
    assertz(menu_status(saving)),
    write('Enter save name (ex: Firstday, no file extension and EOL dot (.) needed)'),nl,
    read_atom_string(Name),
    atom_concat(Name, '.pl', FileName),
    atom_concat('./saved_files/', FileName, DirFileName),
    open(DirFileName, write, Stream), !,

    % TO DO: Menambahkan lebih banyak state
    % Jangan lupa menggunakan nl(Stream) bukan nl biasa, supaya newlinenya tersimpan ke file bukan ke layar

    % alchemist.pl
    gandalf(Gandalf), saveSingleFact(Stream, gandalf, Gandalf),
    potionBag(PotionBag), saveSingleFact(Stream, potionBag, PotionBag),
    kaburTimer(KaburTimer), saveSingleFact(Stream, kaburTimer, KaburTimer),
    % farming.pl
    crop(Crop), saveSingleFact(Stream, crop, Crop),
    % fishing.pl
    today_fishing_count(TodayFishingCount), saveSingleFact(Stream, today_fishing_count, TodayFishingCount),
    % house.pl
    day(Day), saveSingleFact(Stream, day, Day),
    season(Season), saveSingleFact(Stream, season, Season),
    % inventory.pl
    baglist(BagList), saveSingleFact(Stream, baglist, BagList),
    % map.pl
    format(Stream, ':- dynamic(~q/2).\n', [locPlayer]),
    locPlayer(XCur,YCur), saveCoupledFact(Stream, locPlayer, XCur, YCur),
    draw_done(DrawDone), saveSingleFact(Stream, draw_done, DrawDone),
    format(Stream, ':- dynamic(~q/2).\n', [isAir]),
    forall(isAir(X,Y), saveCoupledFact(Stream, isAir, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isPagar]),
    forall(isPagar(X,Y), saveCoupledFact(Stream, isPagar, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isDiggedTile]),
    forall(isDiggedTile(X,Y), saveCoupledFact(Stream, isDiggedTile, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isSoil]),
    forall(isSoil(X,Y), saveCoupledFact(Stream, isSoil, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isCrop]),
    forall(isCrop(X,Y), saveCoupledFact(Stream, isCrop, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isHarvest]),
    forall(isHarvest(X,Y), saveCoupledFact(Stream, isHarvest, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isAlchemist]),
    forall(isAlchemist(X,Y), saveCoupledFact(Stream, isAlchemist, X, Y)),
    format(Stream, ':- dynamic(~q/2).\n', [isCrater]),
    forall(isCrater(X,Y), saveCoupledFact(Stream, isCrater, X, Y)),
    % player.pl
    player(Player), saveSingleFact(Stream, player, Player),
    specialty(Specialty), saveSingleFact(Stream, specialty, Specialty),
    money(Money) , saveSingleFact(Stream, money, Money),
    expplayer(ExpPlayer), saveSingleFact(Stream, expplayer, ExpPlayer),
    expfarming(ExpFarming), saveSingleFact(Stream, expfarming, ExpFarming),
    expfishing(ExpFishing), saveSingleFact(Stream, expfishing, ExpFishing),
    expranching(ExpRanching), saveSingleFact(Stream, expranching, ExpRanching),
    levelplayer(LevelPlayer), saveSingleFact(Stream, levelplayer, LevelPlayer),
    levelfarming(LevelFarming), saveSingleFact(Stream, levelfarming, LevelFarming),
    levelfishing(LevelFishing), saveSingleFact(Stream, levelfishing, LevelFishing),
    levelranching(LevelRanching), saveSingleFact(Stream, levelranching, LevelRanching),
    nextlevelexp(NextLevelExp), saveSingleFact(Stream, nextlevelexp, NextLevelExp),
    nextlevelexpfarming(NextLevelExpFarming), saveSingleFact(Stream, nextlevelexpfarming, NextLevelExpFarming),
    nextlevelexpfishing(NextLevelExpFishing), saveSingleFact(Stream, nextlevelexpfishing, NextLevelExpFishing),
    nextlevelexpranching(NextLevelExpRanching), saveSingleFact(Stream, nextlevelexpranching, NextLevelExpRanching),
    hoelevel(HL), saveSingleFact(Stream, hoelevel, HL),
    fishingrodlevel(FRL), saveSingleFact(Stream, fishingrodlevel, FRL),
    % quest.pl
    (harvest_item(HarvestItemA, HarvestItemB) -> saveCoupledFact(Stream, harvest_item, HarvestItemA, HarvestItemB); !),
    (fish_item(FishItemA, FishItemB) -> saveCoupledFact(Stream, fish_item, FishItemA, FishItemB); !),
    (ranch_item(RanchItemA, RanchItemB) -> saveCoupledFact(Stream, ranch_item, RanchItemA, RanchItemB); !),
    isQuestActive(IsQuestActive), saveSingleFact(Stream, isQuestActive, IsQuestActive),
    isSpecialQuest(IsSpecialQuest), saveSingleFact(Stream, isSpecialQuest, IsSpecialQuest),
    questAdd(QuestAdd), saveSingleFact(Stream, questAdd, QuestAdd),
    % ranching.pl
    animals(Animals), saveSingleFact(Stream, animals, Animals),
    chickenAffection(ChickenAffection), saveSingleFact(Stream, chickenAffection, ChickenAffection),
    cowAffection(CowAffection), saveSingleFact(Stream, cowAffection, CowAffection),
    sheepAffection(SheepAffection), saveSingleFact(Stream, sheepAffection, SheepAffection),
    layTime(LayTime), saveSingleFact(Stream, layTime, LayTime),
    milkTime(MilkTime), saveSingleFact(Stream, milkTime, MilkTime),
    woolTime(WoolTime), saveSingleFact(Stream, woolTime, WoolTime),
    eggProd(EggProd), saveSingleFact(Stream, eggProd, EggProd),
    milkProd(MilkProd), saveSingleFact(Stream, milkProd, MilkProd),
    woolProd(WoolProd), saveSingleFact(Stream, woolProd, WoolProd),
    nextLay(NextLay), saveSingleFact(Stream, nextLay, NextLay),
    nextMilk(NextMilk), saveSingleFact(Stream, nextMilk, NextMilk),
    nextWool(NextWool), saveSingleFact(Stream, nextWool, NextWool),

    close(Stream),
    retract(menu_status(saving)),
    assertz(menu_status(house)), 

    write('Diary succesfully saved'), nl,
    !.

writeDiary :-
    \+ (menu_status(house)),
    write('Can only write diary on house'), nl.

saveSingleFact(Stream, Predicate, Val) :-
    menu_status(saving),
    format(Stream, ':- dynamic(~q/1).\n', [Predicate]),
    format(Stream, '~q(~q).\n', [Predicate, Val]).  % formatnya q agar ketika di save quotes nya ('') tidak hilang (misal atom lebih dari satu kata)

saveCoupledFact(Stream, Predicate, A, B) :-
    menu_status(saving),
    format(Stream, '~q(~q,~q).\n', [Predicate, A, B]). % formatnya q agar ketika di save quotes nya ('') tidak hilang (misal atom lebih dari satu kata)


readDiary :-
    menu_status(house),
    write('Choose your saved diary (Enter number (0 to cancel), ex: 1, without dot (.) EOL)'), nl,

    catch(directory_files('./saved_files', L), E, (write('Cannot acces saved files! Try close VS Code/any code editor and then restart Prolog and the command line!\n'), fail)),
    [_|[_|FL]] = L,
    displayFilesNameList(FL, 1),
    read_num(Num),
    Num1 is Num - 1,
    get_list_element(FL,Num1,Res),  % fail jika pilihan di luar (< 0 atau >= N elemen), berguna untuk load dari main menu nanti
    
    resetAllDynamicFacts,

    atom_concat('./saved_files/', Res, DirFileName),
    consult(DirFileName),

    season(CurrentSeason),
    createNewSeasonFishList(CurrentSeason, LFish),
    retractall(fish_season_list(_)),
    asserta(fish_season_list(LFish)),

    nl,write('Reading diary succesful'), nl,
    status, nl,
    write('house'), nl,
    write('- sleep.'), nl,
    write('- writeDiary.'), nl,
    write('- readDiary.'), nl,
    write('- exit.'), nl, !. 

displayFilesNameList([], _) :- !.
displayFilesNameList(L, IDX) :-
    [H|T] = L,
    write(IDX), write('. '),
    write(H), nl,
    IDX1 is IDX + 1,
    displayFilesNameList(T, IDX1).

