/* market.pl */

/* Market helper functions */
isMarket:-
    menu_status(market).

marketListLength([], 0).
marketListLength([_|T], Count):-
    marketListLength(T, C1),
    Count is 1 + C1.

getMarketList(LF):-
    season(Season),
    findall(Seed, seasonSeed(Seed, Season), L),
    findall(Animal, animal(Animal), L1),
    append(L, L1, LF1),
    
    expfarming(LH),
    (LH < 5
        ->  LH1 is LH + 48,
            append("Level ", [LH1], TMP1),
            append(TMP1, " hoe", TMP2),
            atom_codes(STR, TMP2),
            LF2 = [STR], !;
    LH >= 5
        ->  LH1 is 4 + 48,
            append("Level ", [LH1], TMP1),
            append(TMP1, " hoe", TMP2),
            atom_codes(STR, TMP2),
            LF2 = [STR]),

    append(LF1, LF2, LF).

writeItem([], _).
writeItem([H|T], Number):-
    price(H, ItemPrice),    
    format('~w. ~w (~w gold)', [Number, H, ItemPrice]), nl,
    N1 is Number + 1,
    writeItem(T, N1).

writeBalance:-
    money(Money),
    format('Your balance is ~w.', [Money]), nl.

/* Main market functions */
market:-
    isOnMarket,
    retractall(menu_status(_)),
    asserta(menu_status(market)), nl,
    write('Welcome to the marketplace!'), nl,
    writeBalance,
    write('1. Buy'), nl,
    write('2. Sell'), nl.

buy:- 
    isMarket,
    expfishing(LR),
    (LR < 5
        ->  LR1 is LR + 48,
            append("Level ", [LR1], TMP1),
            append(TMP1, " fishing rod", TMP2),
            atom_codes(STR1, TMP2),
            LF3 = [STR1], !;
    LR >= 5
        ->  LR1 is 4 + 48,
            append("Level ", [LR1], TMP1),
            append(TMP1, " fishing rod", TMP2),
            atom_codes(STR1, TMP2),
            LF3 = [STR1]),

    getMarketList(MList), 
    append(MList, LF3, LF),

    nl, write('Here\'s Market List for Today.'), nl,
    writeItem(LF, 1), nl,
    
    write('What item do you want to buy?'), nl,
    writeBalance,
    write('>> '), read_integer(X),
    write('How many?'), nl,
    write('>> '), read_integer(Y),
    
    getItemByIndex(LF, X, Name), !,
    price(Name, ItemPrice), !,
    NewBalance is -Y * ItemPrice,
    PosBalance is Y * ItemPrice,
    money(Money),
    (
        Money < PosBalance
            ->  write('You don\'t have that much money! Aborting..'), !;
    
        Money >= PosBalance
            ->  changeMoney(NewBalance), 
                saveToBag([Name, Y]),
                format('You have bought ~w ~w.', [Y, Name]), nl,
                writeBalance).

sell:-
    isMarket,
    baglist(L),
    itemSum(L, Sum),
    (
        Sum > 0
            ->  inventory, nl,
                write('What do you want to sell?'), nl,
                writeBalance,
                write('>> '), read_integer(X),
                getItemByIndex(L, X, Item),
                itemName(Item, Name),
                
                write('How many?'), nl,
                write('>> '), read_integer(Y),
                deleteFromBag([Name, Y]), !,
                
                price(Name, ItemPrice),
                NewBalance is Y * ItemPrice,

                changeMoney(NewBalance), 
                format('You sold ~w ~w.', [Y, Name]), nl,
                writeBalance, !;
        Sum == 0
            ->  write('You don\'t even have any item!')).

exitMarket:-
    retractall(menu_status(_)),
    asserta(menu_status(outside)).