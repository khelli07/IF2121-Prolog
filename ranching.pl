/*
:-include('items.pl').
:-include('map.pl').
:-include('inventory.pl').
:-include('house.pl').
:-include('player.pl').
:-include('main.pl').
*/

:-dynamic(animals/1).
:-dynamic(chickenAffection/1).
:-dynamic(cowAffection/1).
:-dynamic(sheepAffection/1).
:-dynamic(layTime/1).
:-dynamic(milkTime/1).
:-dynamic(woolTime/1).
:-dynamic(eggProd/1).
:-dynamic(milkProd/1).
:-dynamic(woolProd/1).
:-dynamic(nextLay/1).
:-dynamic(nextMilk/1).
:-dynamic(nextWool/1).

animals([['chicken', 1],['cow', 1],['sheep', 1]]). % modal awal

chickenAffection(0).
cowAffection(0).
sheepAffection(0).

eggProd(3). 
milkProd(2).
woolProd(1).

layTime(5). % artinya 5 hari
milkTime(4). 
woolTime(7). 

nextLay(0).
nextMilk(0).
nextWool(0).

 /*
changeLayTime:-
    season(CurrSeason),
    seasons(SeasonList),
    layTime(CurrNext,CurrSeason),
    day(Day),
    NewNext is Day + 1,
    (
      NewNext > 28, \+season(winter)
      -> NewNext1 is NewNext mod 28,
         nth(Idx,SeasonList,CurrSeason),
         Idx1 is Idx + 1,
         nth(Idx1,SeasonList,NextSeason),
         retract(layTime(CurrNext,CurrSeason)),
         asserta(layTime(NewNext1,NextSeason));
      NewNext =< 28
      -> retract(layTime(CurrNext,CurrSeason)),
         asserta(layTime(NewNext,CurrSeason)),!
    ).

changeMilkTime:-
    season(CurrSeason),
    seasons(SeasonList),
    milkTime(CurrNext,CurrSeason),
    day(Day),
    NewNext is Day + 1,
    (
      NewNext > 28, \+season(winter)
      -> NewNext1 is NewNext mod 28,
         nth(Idx,SeasonList,CurrSeason),
         Idx1 is Idx + 1,
         nth(Idx1,SeasonList,NextSeason),
         retract(milkTime(CurrNext,CurrSeason)),
         asserta(milkTime(NewNext1,NextSeason));
      NewNext =< 28
      -> retract(milkTime(CurrNext,CurrSeason)),
         asserta(milkTime(NewNext,CurrSeason)),!
    ).

changeWoolTime:-
    season(CurrSeason),
    seasons(SeasonList),
    nextWool(CurrNext,CurrSeason),
    day(Day),
    NewNext is Day + 1,
    (
      NewNext > 28, \+season(winter)
      -> NewNext1 is NewNext mod 28,
         nth(Idx,SeasonList,CurrSeason),
         Idx1 is Idx + 1,
         nth(Idx1,SeasonList,NextSeason),
         retract(nextWool(CurrNext,CurrSeason)),
         asserta(nextWool(NewNext1,NextSeason));
      NewNext =< 28
      -> retract(nextWool(CurrNext,CurrSeason)),
         asserta(nextWool(NewNext,CurrSeason)),!
    ).
 */

updateNextLay:-
    nextLay(Current),
    New is Current + 1,
    retract(nextLay(Current)),
    asserta(nextLay(New)).

updateNextMilk:-
    nextMilk(Current),
    New is Current + 1,
    retract(nextMilk(Current)),
    asserta(nextMilk(New)).

updateNextWool:-
    nextWool(Current),
    New is Current + 1,
    retract(nextWool(Current)),
    asserta(nextWool(New)).

/* Get Animal Count */
chickenCount(Count):-
    animals(Animals),
    nth(1,Animals,Chickens),
    nth(2,Chickens,Count).

cowCount(Count):-
    animals(Animals),
    nth(2,Animals,Cows),
    nth(2,Cows,Count).

sheepCount(Count):-
    animals(Animals),
    nth(3,Animals,Sheep),
    nth(2,Sheep,Count).

/* Add Animal */
addAnimal(Animal):-
    animals(OldAnimals),
    insertItem(OldAnimals, Animal, UpdatedAnimals),
    retract(animals(OldAnimals)),
    asserta(animals(UpdatedAnimals)).

/* Animals Production */

/* Increase Animal Production */
increaseEggProd:-
    eggProd(Old),
    New is Old + 2,
    retract(eggProd(Old)),
    asserta(eggProd(New)).

increaseMilkProd:-
    milkProd(Old),
    New is Old + 2,
    retract(milkProd(Old)),
    asserta(milkProd(New)).

increaseWoolProd:-
    woolProd(Old),
    New is Old + 2,
    retract(woolProd(Old)),
    asserta(woolProd(New)).

/* Decrease Animals Production Time */

decreaseLayTime:- % minimal 2 hari
    layTime(Old),
    ( Old > 2
        -> NewLayTime is Old - 1,
           retract(layTime(Old)),
           asserta(layTime(NewLayTime))
    ).

decreaseMilkTime:- % minimal 1 hari
    milkTime(Old),
    ( Old > 1
        -> NewMilkTime is Old - 1,
           retract(layTime(Old)),
           asserta(layTime(NewMilkTime))
    ).

decreaseWoolTime:- % minimal 4 hari
    woolTime(Old),
    ( Old > 4
        -> NewWoolTime is Old - 1,
           retract(layTime(Old)),
           asserta(layTime(NewWoolTime))
    ).

/* Increase Animals Affection Level */

/* Setiap animal dikunjungi, stats bertambah 2 */
increaseChickenAffection:-
    specialty(rancher),
    chickenAffection(Old),
    New is Old + 2,
    retract(chickenAffection(Old)),
    asserta(chickenAffection(New)).

increaseCowAffection:-
    specialty(rancher),
    cowAffection(Old),
    New is Old + 2,
    retract(cowAffection(Old)),
    asserta(cowAffection(New)).

increaseSheepAffection:-
    specialty(rancher),
    sheepAffection(Old),
    New is Old + 2,
    retract(sheepAffection(Old)),
    asserta(sheepAffection(New)).

sheep:-
    wool.

cow:-
    milk.

chicken:-
    lay.

writeAnimals([], _).
writeAnimals([H|T], Number):-
    itemName(H, Name),
    itemCount(H, Value),
    format('~w ~w', [Value, Name]), nl,
    Number1 is Number + 1,
    writeAnimals(T, Number1).

ranch:- 
    \+menu_status(outside),
    write('Anda sedang tidak berada di luar'),!.

ranch:- 
    locPlayer(X,Y),
    isRanch(X1,Y1),
    X =\= Y,
    X1 =\= Y1,
    write('Anda sedang tidak berada di ranch!'),!.

ranch:-
    animals(Animals),
    write('Welcome to the ranch! You have'),nl,
    writeAnimals(Animals, 1),nl,
    write('What do you want to do?'),nl. 

lay:-
    chickenAffection(AffectionLevel),
    AffectionLevel =\= 0,
    Y is AffectionLevel mod 20,
    Y =:= 0,
    levelranching(LevelRanching),
    GoldenExp is LevelRanching * 15,
    saveToBag(['golden egg',1]),
    write('Your chicken lays a golden egg!'),nl,
    write('You got special item: Golden Egg!'),nl,
    changeExpRanching(GoldenExp),
    format('You gained ~w ranching exp!',[GoldenExp]),nl,
    increaseChickenAffection,
    write('You gained affection from your chicken!'),nl,!.

lay:-
    layTime(LayTime),
    day(Day),
    LayTime =:= Day,
    eggProd(Prod),
    chickenCount(Chickens),
    Eggs is Prod * Chickens,
    Exp is Eggs * 3,
    saveToBag(['chicken',Eggs]),
    format('Your chicken lays ~w eggs.',[Eggs]),nl,
    format('You got ~w eggs!',[Eggs]),nl,
    changeExpRanching(Exp),
    format('You gained ~w ranching exp!',[Exp]),nl,
    increaseChickenAffection,
    write('You gained affection from your chickens!'),nl,!.

lay:-
    write('Your chickens hasn\'t laid any eggs'),nl,
    write('Please check again later.'),nl,!.

milk:-
    cowAffection(AffectionLevel),
    AffectionLevel =\= 0,
    Y is AffectionLevel mod 20,
    Y =:= 0,
    levelranching(LevelRanching),
    GoldenExp is LevelRanching * 20,
    saveToBag(['golden milk',1]),
    write('Your cow produces some golden milk!'),nl,
    write('You got special item: Golden Milk!'),nl,
    changeExpRanching(GoldenExp),
    format('You gained ~w ranching exp!',[GoldenExp]),nl,
    increaseCowAffection,
    write('You gained affection from your cows!'),nl,!.

milk:-
    milkTime(MilkTime),
    day(Day),
    MilkTime =:= Day,
    milkProd(Prod),
    cowCount(Cows),
    Milk is Prod * Cows,
    Exp is Cows * 4,
    saveToBag(['milk',Milk]),
    format('Your cow produces ~w bootle of milk.',[Milk]),nl,
    format('You got ~w bottle of milk!',[Milk]),nl,
    changeExpRanching(Exp),
    format('You gained ~w ranching exp!',[Exp]),nl,
    increaseCowAffection,
    write('You gained affection from your cows!'),nl,!.

milk:-
    write('Your cows hasn\'t produced any milk'),nl,
    write('Please check again later.'),nl,!.

wool:-
    sheepAffection(AffectionLevel),
    AffectionLevel =\= 0,
    Y is AffectionLevel mod 20,
    Y =:= 0,
    levelranching(LevelRanching),
    GoldenExp is LevelRanching * 25,
    saveToBag(['golden wool',1]),
    write('Your sheep grows golden fleece!'),nl,
    write('You got special item: Golden Wool!'),nl,
    changeExpRanching(GoldenExp),
    format('You gained ~w ranching exp!',[GoldenExp]),nl,
    increaseSheepAffection,
    write('You gained affection from your sheep!'),nl,!.

wool:-
    woolTime(WoolTime),
    day(Day),
    WoolTime =:= Day,
    woolProd(Prod),
    sheepCount(Sheep),
    Wool is Prod * Sheep,
    Exp is Sheep * 5,
    saveToBag(['wool',Wool]),
    format('Your sheep produces ~w bag of wool.',[Wool]),nl,
    format('You got ~w bag of wool!',[Wool]),nl,
    changeExpRanching(Exp),
    format('You gained ~w ranching exp!',[Exp]),nl,
    increaseSheepAffection,
    write('You gained affection from your sheep!'),nl,!.

wool:-
    write('Your sheep hasn\'t produced any wool'),nl,
    write('Please check again later.'),nl,!.