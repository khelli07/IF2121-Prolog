/* quest.pl */
:- include('inventory.pl').
:- dynamic(harvest_item/2).
:- dynamic(fish_item/2).
:- dynamic(ranch_item/2).
:- dynamic(isQuestActive/1).
isQuestActive(0).

/* Quest functions */
writeQuest:-
    write('You need to collect: '), nl,
    harvest_item(HName, HCount),
    fish_item(FName, FCount),
    ranch_item(RName, RCount),

    format('- ~w ~w',[HCount, HName]), nl,
    format('- ~w ~w',[FCount, FName]), nl,
    format('- ~w ~w',[RCount, RName]), nl.

retractAllQuest:-
    retractall(harvest_item(_, _)),
    retractall(fish_item(_, _)),
    retractall(ranch_item(_, _)),
    retractall(isQuestActive(_)).

/* Quest generator */
generateNormalQuest:-
    retractAllQuest,

    random(1, 10, HCount),
    random(1, 10, FCount),
    random(1, 10, RCount),

    asserta(harvest_item('harvest item', HCount)),
    asserta(fish_item('fish', FCount)),
    asserta(ranch_item('ranch item', RCount)),
    
    writeQuest,
    write('Accept quest (yes/no)? '), read(X), nl,
    toUpper(X, Answer),
    (
        Answer == 'YES'
            -> write('Quest accepted, good luck!'),
               asserta(isQuestActive(1)), !;
        Answer == 'NO'
            -> write('Quest discarded, aborting...'),
               retractAllQuest,
               asserta(isQuestActive(0)), !
    ).

generateSpecialQuest:-
    retractAllQuest,

    random(3, 10, HCount),
    random(3, 10, FCount),
    random(3, 10, RCount),



    write('Coming soon...').

/* Quest handler */
submitQuest:-
    write('Coming soon...').

showQuest:-
    isQuestActive(Status),
    (
        Status == 0
            -> nl, write('You don\'t have any quest right now.'), !;
        Status == 1
            -> writeQuest, !
    ).