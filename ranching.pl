/*
:-include('items.pl').
:-include('map.pl').
:-include('player.pl').
:-include('inventory.pl'). */

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

animals([['chicken', 1],['cow', 1],['sheep', 1]]). % modal awal

chickenAffection(0).
cowAffection(0).
sheepAffection(0).

eggProd(3). 
milkProd(2).
woolProd(1).

layTime(5). 
milkTime(4). 
woolTime(7). 

/* Get Animal Count */
chickenCount(Count):-
    animals(Animals),
    nth(0,Animals,Chickens),
    nth(1,Chickens,Count).

cowCount(Count):-
    animals(Animals),
    nth(1,Animals,Cows),
    nth(1,Cows,Count).

sheepCount(Count):-
    animals(Animals),
    nth(2,Animals,Sheep),
    nth(1,Sheep,Count).

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
    cowAffectionLevel(Old),
    New is Old + 2,
    retract(cowAffection(Old)),
    asserta(cowAffection(New)).

increaseSheepAffection:-
    specialty(rancher),
    sheepAffectionLevel(Old),
    New is Old + 2,
    retract(sheepAffection(Old)),
    asserta(sheepAffection(New)).

sheep:-
    increaseSheepAffection,
    write('You gained affection from your sheep!'),nl.

cow:-
    increaseCowAffection,
    write('You gained affection from your cows!'),nl.

chicken:-
    increaseChickenAffection,
    lay,
    write('You gained affection from your chickens!'),nl.

writeAnimals([], _).
writeAnimals([H|T], Number):-
    itemName(H, Name),
    itemCount(H, Value),
    format('~w ~w', [Value, Name]), nl,
    Number1 is Number + 1,
    writeAnimals(T, Number1).

ranch:-
    animals(Animals),
    write('Welcome to the ranch! You have'),nl,
    writeAnimals(Animals, 1),nl,
    write('What do you want to do?'),nl. 

lay:-
    AffectionLevel =\= 0,
    Y is AffectionLevel mod 20,
    Y =:= 0,
    levelranching(LevelRanching),
    GoldenExp is LevelRanching * 15,
    saveToBag(['golden egg',1]),
    write('Your chicken lays a golden egg!'),nl,
    write('You got special item: Golden Egg!'),nl,
    changeExpRanching(GoldenExp),
    format('You gained ~w ranching exp!',[GoldenExp]),nl,!.

lay:-
    isLayTime,
    eggProd(Prod),
    chickenCount(Chickens),
    Eggs is Prod * Chickens,
    Exp is Eggs * 3,
    saveToBag(['chicken',Eggs]),
    format('Your chicken lays ~w eggs.',[Eggs]),nl,
    format('You got ~w eggs!',[Eggs]),nl,
    changeExpRanching(Exp),
    format('You gained ~w ranching exp!',[Exp]),nl,!.

lay:-
    write('Your chickens hasn\'t laid any eggs'),nl,
    write('Please check again later.'),nl,!.