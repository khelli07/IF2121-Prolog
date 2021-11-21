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
isItemIn([H|T], Name, Bool):-
    itemName(H, HeadName),
    toUpper(HeadName, HeadUpper),
    toUpper(Name, NameUpper),

    (HeadUpper == NameUpper
        ->  Bool1 is 1, !;
    HeadUpper \== NameUpper
        ->  isItemIn(T, Name, Bool1)),
    Bool is Bool1.

getItem([H|T], ItemName, Item):-
    itemName(H, HeadName),
    toUpper(HeadName, HeadUpper),
    toUpper(ItemName, NameUpper),

    (HeadUpper == NameUpper
        ->  Item1 = H, !;
    HeadUpper \== NameUpper
        ->  getItem(T, ItemName, Item1)),
    Item = Item1.

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

deleteItem([Item], Item1, NL):-
    itemName(Item, Name),
    
    itemCount(Item, Count),
    itemCount(Item1, Decrement),
    NewValue is Count - Decrement,

    (NewValue == 0 
        -> NL = [], !;
    NewValue > 0 
        -> H1 = [Name, NewValue],
           NL = [H1], !;
    NewValue < 0
        -> format('You don\'t have that many ~w. Cancelling..', [Name])).

deleteItem([H|T], Item, NL):-
    itemName(Item, Name),
    itemName(H, HeadName),
    (HeadName == Name 
        -> itemCount(H, Count),
           itemCount(Item, Decrement),
           NewValue is Count - Decrement,
           (
               NewValue > 0 
                    -> H1 = [HeadName, NewValue],
                       NL = [H1|T], !;
               NewValue == 0 
                    -> NL = T, !;
               NewValue < 0 
                    -> format('You don\'t have that many ~w. Cancelling..', [HeadName])
           ), !;

    HeadName \== Name
        -> deleteItem(T, Item, NL1),
           NL = [H|NL1]).

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

throwFromBag(Item):-
    baglist(OldBag),
    deleteItem(OldBag, Item, UpdatedBag),
    asserta(baglist(UpdatedBag)),
    retract((baglist(OldBag))).

/* Bag command */
inventory:-
    baglist(List),
    itemSum(List, Sum), nl,
    format('Your inventory capacity (~w/100)', [Sum]), nl,
    writeInventoryItem(List).

throwItem:-
    baglist(List),
    write('What do you want to throw? (Use \'\', e.g. \'fishing rod\')'), nl,
    read(_ItemName), nl,
    isItemIn(List, _ItemName, Bool),
    (
        Bool == 1
            -> write('How many? '), read_integer(X),
               Item = [_ItemName, X],
               throwFromBag(Item), !;
        Bool == 0
            -> write('You don\'t even have that item :(')
    ).
    

/* utils */
charUpper(String, Index, CU):-
    sub_atom(String, Index, 1, _, Char),
    lower_upper(Char, CU).

stringUpper(String, Index, UpperStr):-
    atom_length(String, Length),
    Index == Length,
    UpperStr = '', !.

stringUpper(String, Index, UpperStr):-
    atom_length(String, Length),
    Index < Length,
    charUpper(String, Index, CU),
    Index1 is Index + 1,
    stringUpper(String, Index1, UpperStr1),
    atom_concat(CU, UpperStr1, UpperStr).

toUpper(String, Output):-
    stringUpper(String, 0, Output).