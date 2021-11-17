/* inventory.pl */
:- dynamic(baglist/1).

/* Initialize bag */
baglist([]).

/* Item selector */
itemName([Name|_], Name).
itemCount([_|T], Value):-
    T = [Value|_].

/* Bag functions */
itemSum([], 0).
itemSum([H|T], Sum):-
    itemCount(H, Count),
    itemSum(T, SumTail),
    Sum is Count + SumTail.

writeInventoryItem([]).
writeInventoryItem([H|T]):-
    itemName(H, Name),
    itemCount(H, Value),
    format('~w ~w', [Value, Name]), nl,
    writeInventoryItem(T).

isItemIn([], _, 0).
isItemIn([H|T], Item, Bool):-
    itemName(Item, Name),
    itemName(H, HeadName),
    (HeadName == Name 
        ->  Bool1 is 1, !;
    HeadName \== Name
        ->  isItemIn(T, Item, Bool1)),
    Bool is Bool1.

insertItem([], Item, [Item]).
insertItem([H|T], Item, NL):-
    itemName(Item, Name),
    itemName(H, HeadName),

    (HeadName == Name 
        ->  itemCount(H, Count),
            itemCount(Item, Increment),
            NewValue is Count + Increment,
            H1 = [HeadName, NewValue], 
            NL = [H1|T], !;

    HeadName \== Name
        ->  insertItem(T, Item, NL1),
            NL = [H|NL1]).

deleteItem([Item], Item, []).
deleteItem([H|T], Item, []):-
    write('Hi, this is under construction').

/* Bag manipulation */
saveToBag(Item):-
    baglist(OldBag),
    itemSum(OldBag, Sum),
    itemCount(Item, Count),
    
    (Sum + Count =< 100 
        ->  insertItem(OldBag, Item, UpdatedBag),
            asserta(baglist(UpdatedBag)),
            retract((baglist(OldBag))) ;
    Sum + Count > 100 
        ->  write('Your inventory is full!')).

throwItem:-
    baglist(OldBag).

/* Bag output */
inventory:-
    baglist(List),
    itemSum(List, Sum), nl,
    format('Your inventory capacity (~w/100)', [Sum]), nl,
    writeInventoryItem(List).