/* quest.pl */
:- include('items.pl').
:- include('inventory.pl').
:- dynamic(harvest_item/2).
:- dynamic(fish_item/2).
:- dynamic(ranch_item/2).
:- dynamic(isQuestActive/1).
:- dynamic(isSpecialQuest/1).

/* Initialize status */
isQuestActive(0).
isSpecialQuest(0).

/* Quest functions */
writeQuest:-
    write('You need to collect: '), nl,
    harvest_item(HName, HCount),
    fish_item(FName, FCount),
    ranch_item(RName, RCount),

    format('- ~w ~w',[HCount, HName]), nl,
    format('- ~w ~w',[FCount, FName]), nl,
    format('- ~w ~w',[RCount, RName]), nl.

retractQuest:-
    retractall(harvest_item(_, _)),
    retractall(fish_item(_, _)),
    retractall(ranch_item(_, _)),
    retractall(isQuestActive(_)),
    retractall(isSpecialQuest(_)).

acceptQuestHandler:-
    writeQuest,
    write('Accept quest (yes/no)? '), read(X), nl,
    toUpper(X, Answer),
    (
        Answer == 'YES'
            -> write('Quest accepted, good luck!'),
               asserta(isQuestActive(1)), !;
        Answer == 'NO'
            -> write('Quest discarded, aborting...'),
               retractQuest,
               asserta(isQuestActive(0)), 
               asserta(isSpecialQuest(0)), !;
        (Answer \== 'YES'; Answer \== 'NO')
            -> write('Please input a valid command!'),
               retractQuest,
               asserta(isQuestActive(0)), 
               asserta(isSpecialQuest(0))
    ), !.

/* Quest generator */
generateNormalQuest:-
    retractQuest,

    random(1, 10, HCount),
    random(1, 10, FCount),
    random(1, 10, RCount),

    asserta(harvest_item('harvest item', HCount)),
    asserta(fish_item('fish', FCount)),
    asserta(ranch_item('ranch item', RCount)),
    
    acceptQuestHandler.

generateSpecialQuest:-
    retractQuest,

    random(3, 10, HCount),
    random(3, 10, FCount),
    random(3, 10, RCount),

    random(1, 23, HarvestNumber),
    random(1, 12, FishNumber),
    random(1, 3, RanchNumber),

    harvestTag(HarvestName, HarvestNumber), !,
    fishTag(FishName, FishNumber), !,
    ranchTag(RanchName, RanchNumber), !,

    asserta(harvest_item(HarvestName, HCount)),
    asserta(fish_item(FishName, FCount)),
    asserta(ranch_item(RanchName, RCount)),

    acceptQuestHandler,
    asserta(isSpecialQuest(1)).

/* Quest handler */
submitQuest:-
    baglist(OldBag),
    writeInventoryItem(OldBag, 1).    

showQuest:-
    isQuestActive(Status), nl,
    (
        Status == 0
            -> write('You don\'t have any quest right now.'), !;
        Status == 1
            -> writeQuest, !
    ).