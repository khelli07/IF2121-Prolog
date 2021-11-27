/* inventory.pl */
:- dynamic(baglist/1).
/* Initialize bag */
baglist([]).

fillBagInitial :-
    saveToBag(['Level 1 fishing rod', 1]),
    saveToBag(['Level 1 hoe', 1]).

/* Item getter */
itemName([Name|_], Name).
itemCount([_|T], Value):-
    T = [Value|_].

getItemByIndex([H|_], 1, H).
getItemByIndex([_|T], Number, Item):-
    Number1 is Number - 1,
    getItemByIndex(T, Number1, Item).

getItemByName([H|T], ItemName, Item):-
    itemName(H, HeadName),
    toUpper(HeadName, HeadUpper),
    toUpper(ItemName, NameUpper),

    (HeadUpper == NameUpper
        ->  Item1 = H, !;
    HeadUpper \== NameUpper
        ->  getItemByName(T, ItemName, Item1)),
    Item = Item1.

/* Bag helper functions */
itemSum([], 0).
itemSum([H|T], Sum):-
    itemCount(H, Count),
    itemSum(T, SumTail),
    Sum is Count + SumTail.

itemTotal([], 0).
itemTotal([_|T], Total):-
    itemTotal(T, Total1),
    Total is 1 + Total1.

totalByType([], _, 0).
totalByType([H|T], TypeName, Total):-
    itemName(H, HName),
    itemType(HName, Type),
    itemCount(H, Count),
    totalByType(T, TypeName, Total1),

    (Type == TypeName
        -> Total is Count + Total1, !;
    Type \== TypeName
        -> Total is 0 + Total1
    ).

writeInventoryItem([], _).
writeInventoryItem([H|T], Number):-
    itemName(H, Name),
    itemCount(H, Value),
    format('~w. ~w: ~w units', [Number, Name, Value]), nl,
    Number1 is Number + 1,
    writeInventoryItem(T, Number1).

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
        ->  NL = [], !;
    NewValue > 0 
        ->  H1 = [Name, NewValue],
            NL = [H1], !;
    NewValue < 0
        ->  format('You don\'t have that many ~w. Cancelling..', [Name])).

deleteItem([H|T], Item, NL):-
    itemName(Item, Name),
    itemName(H, HeadName),
    (HeadName == Name 
        ->  itemCount(H, Count),
            itemCount(Item, Decrement),
            NewValue is Count - Decrement,
            (
               NewValue > 0 
                    ->  H1 = [HeadName, NewValue],
                        NL = [H1|T], !;
               NewValue == 0 
                    ->  NL = T, !;
               NewValue < 0 
                    ->  format('You don\'t have that many ~w. Cancelling..', [HeadName]), !
            ), !;

    HeadName \== Name
        ->  deleteItem(T, Item, NL1),
            NL = [H|NL1]).

/* Bag main functions */
/* How to use: 
    saveToBag(['corn', 10]) 
    saveToBag(['Level 2 fishing rod', 1])
    deleteFromBag(['Level 2 fishing rod', 1])
    
    Generalisasinya -> namaCommand([NamaItem, JumlahItem])
*/

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

deleteFromBag(Item):-
    baglist(OldBag),
    deleteItem(OldBag, Item, UpdatedBag),
    asserta(baglist(UpdatedBag)),
    retract((baglist(OldBag))).

/* Bag command */
isInventory:-
    \+menu_status(title_screen),
    \+menu_status(game_not_started).

inventory:-
    isInventory,
    baglist(List),
    itemSum(List, Sum), nl,
    format('Your inventory capacity (~w/100)', [Sum]), nl,
    (Sum == 0
        ->  write('You currently don\'t have anything.'), !;
    Sum \== 0
        ->  writeInventoryItem(List, 1)).

throwItem:-
    isInventory,
    baglist(Bag),
    inventory, nl,
    write('What do you want to throw?'), nl,
    write('Input number: '), nl,
    write('>> '), read_integer(Number),
    itemTotal(Bag, Total),
    (
        Number < 0
            ->  write('Please input a valid number!'), !;
        Number > Total
            ->  write('Please input a valid number!'), !;
        Number =< Total
            ->  getItemByIndex(Bag, Number, Item1),
                itemName(Item1, ItemName),
                write('How many? '), nl,
                write('>> '), read_integer(X),
                Item = [ItemName, X],
                deleteFromBag(Item), !
    ).
    

