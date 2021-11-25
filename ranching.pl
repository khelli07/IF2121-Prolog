/* :-include('items.pl').
:-include('map.pl').
:-include('player.pl').
:-include('inventory.pl'). */

:-dynamic(chickenAffectionLevel/1).
:-dynamic(cowAffectionLevel/1).
:-dynamic(sheepAffectionLevel/1).
:-dynamic(animals/1).
:-dynamic(layTime/1).
:-dynamic(milkTime/1).
:-dynamic(woolTime/1).

chickenAffectionStats(1).
cowAffectionStats(1).
sheepAffectionStats(1).
layTime(4). % minimal 2 hari
milkTime(3). % minimal 1 hari
woolTime(6). % minimal 4 hari

animals([]).

addAnimal(Animal):-
    animals(OldAnimals),
    insertItem(OldAnimals, Animal, UpdatedAnimals),
    asserta(animals(UpdatedAnimals)),
    retract((animals(OldAnimals))).

/* Decrease Animal's Production Time */

decreaseLayTime:-
    layTime(Old),
    ( Old > 1
        -> NewLayTime is Old - 1,
           retract(layTime(Old)),
           asserta(layTime(NewLayTime))
    ).

decreaseMilkTime:-
    milkTime(Old),
    ( Old > 2
        -> NewMilkTime is Old - 1,
           retract(layTime(Old)),
           asserta(layTime(NewMilkTime))
    ).

decreaseWoolTime:-
    woolTime(Old),
    ( Old > 4
        -> NewWoolTime is Old - 1,
           retract(layTime(Old)),
           asserta(layTime(NewWoolTime))
    ).

/* Increase Animals Affection Level */

/* Setiap animal dikunjungi, stats bertambah 2 */
increaseChickenAffectionStats:-
    chickenAffectionLevel(Old),
    New is Old + 2,
    retract(chickenAffectionLevel(Old)),
    asserta(chickenAffectionLevel(New)).

increaseCowAffectionStats:-
    cowAffectionLevel(Old),
    New is Old + 2,
    retract(cowAffectionLevel(Old)),
    asserta(cowAffectionLevel(New)).

increaseSheepAffectionStats:-
    sheepAffectionLevel(Old),
    New is Old + 2,
    retract(sheepAffectionLevel(Old)),
    asserta(sheepAffectionLevel(New)).

visitSheep:-
    increaseSheepAffectionStats,
    write('You gained affection from your sheep!'),nl.

visitCows:-
    increaseCowAffectionStats,
    write('You gained affection from your cows!'),nl.

visitChickens:-
    increaseChickenAffectionStats,
    write('You gained affection from your chickens!'),nl.