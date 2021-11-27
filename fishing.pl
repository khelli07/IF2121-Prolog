% :- include('map.pl').
% :- include('near.pl').
% :- include('utilities.pl').
% :- include('inventory.pl').
% :- include('main.pl').
% :- include('player.pl').
% :- include('utilities.pl').
% :- include('items.pl').

:- dynamic(fish_season_list/1).
:- dynamic(today_fishing_count/1).
:- dynamic(temp_fish_list/1).
today_fishing_count(0).

% Rarity berdasarkan harga
% 1 (20), 2 (50), 3 (120), 4 (200), 5 (350)
fish_rarity('zonk fish', 0).    % paling melimpah zonk
fish_rarity('arowana',5).
fish_rarity('beltfish',4).
fish_rarity('carp',3).
fish_rarity('char',3).
fish_rarity('cherry trout',3).
fish_rarity('honmoroko',2).
fish_rarity('keiji salmon',5).
fish_rarity('killfish',2).
fish_rarity('lake prawn',1).
fish_rarity('large crucian carp',4).
fish_rarity('large sea bass',4).
fish_rarity('large snakehead',4).

fish :- 
    menu_status(outside),
    isNearAir,
    fish_season_list(L),
    fishingrodlevel(LevelRod),
    today_fishing_count(FC),
    RodCapacity is LevelRod * 5,
    FC < RodCapacity,
    levelfishing(LevelFishing),
    Level is LevelRod + LevelFishing,
    chooseRandomFishBasedLevel(L, Level, X),
    ( 
        X = 'zonk fish', specialty(fisherman) ->  write('You didn''t get anything'), nl,
                                                  write('You gained 4 fishing exp'), nl,
                                                  changeExpFishing(4),
                                                  changeExpPlayer(4), !;
        X = 'zonk fish', \+ (specialty(fisherman)) -> write('You didn''t get anything'), nl,
                                                      write('You gained 2 fishing exp'), nl,
                                                      changeExpFishing(2),
                                                      changeExpPlayer(2), !;
        X \= 'zonk fish', specialty(fisherman)  -> format('You got a ~w!', [X]), nl,
                                                   write('You gained 8 fishing exp'), nl,
                                                   saveToBag([X, 1]),
                                                   changeExpFishing(8),
                                                   changeExpPlayer(8), !;
        X \= 'zonk fish', \+ (specialty(fisherman)) -> format('You got a ~w!', [X]), nl,
                                                       write('You gained 4 fishing exp'), nl,
                                                       saveToBag([X, 1]),
                                                       changeExpFishing(4),
                                                       changeExpPlayer(4), !
    ),
    addTodayFishingCount,
    FCNew is FC + 1,   % -1 karena FC data sebelumnya sebelum addTOdaFishingCount
    format('Fishing rod capacity ~w/~w', [FCNew, RodCapacity]), nl, !.

fish :- 
    \+ menu_status(outside), write('Cannot fish here! You must be outside to fish'), nl, !;
    \+ isNearAir, write('Cannot fish here! You must be near water to fish'), nl, !;
    fishingrodlevel(LevelRod), today_fishing_count(FC), FC >= LevelRod * 5, write('Your fishing rod is exhausted! Fish again tomorrow'), nl, !.

chooseRandomFishBasedLevel(L, 1, X) :-
    chooseRandomFromList(L, X), !.
chooseRandomFishBasedLevel(L, Level, X) :-
    Level > 1,
    chooseRandomFromList(L, XA),
    Level1 is Level - 1,
    chooseRandomFishBasedLevel(L, Level1, XB),
    fish_rarity(XA, RA),
    fish_rarity(XB, RB),
    (
        RB > RA -> X = XB, !;
        X = XA, !
    ).

% Create fish list with weighted rarity, called each new season (or each new level possibly with other mechanism)
createNewSeasonFishList(S, L) :-
    asserta(temp_fish_list([])),
    forall(seasonFish(X, S), addFishBasedRarityToList(X)),
    temp_fish_list(LTemp),
    permutation(LTemp, L),
    retractall(temp_fish_list(_)).

addFishBasedRarityToList(X) :-
    fish_rarity(X, R),
    Count is (6-R)*(6-R),
    temp_fish_list(L),
    addNTimesToList(X, L, Count, LNew),
    retract(temp_fish_list(L)),
    asserta(temp_fish_list(LNew)).

addTodayFishingCount :-
    today_fishing_count(X),
    X1 is X + 1,
    retractall(today_fishing_count(_)),
    asserta(today_fishing_count(X1)).

% Initialize fish_season_list, spring season
loadfirstseasonfish :- menu_status(game_not_started), retractall(fish_season_list(_)), createNewSeasonFishList(spring, L), asserta(fish_season_list(L)).
:- initialization(loadfirstseasonfish).
