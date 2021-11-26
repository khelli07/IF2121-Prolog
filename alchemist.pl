%potions, bag is seperate from inventory
%requires map.pl, player.pl, main.pl, utilities.pl
%commands: potion (open potion inventory), alchemist (open alchemist store)

:-dynamic(gandalf/1). %[potion name, amount]
:-dynamic(potionBag/1). %[potion name, amount]
:-dynamic(kaburTimer/1). %alchemist akan tutup setelah 5 kali beli

kaburTimer(0).
potionType('red pill',farming).
potionType('blue pill',fishing).
potionType('white pill',ranching).
% Potion Price 500G, gives 400 XP

gandalf([['red pill',3],['blue pill',3],['white pill',3]]).
potionBag([]).

deleteFromAlchemist(Item):-
    gandalf(OldBag),
    deleteItem(OldBag, Item, UpdatedBag),
    asserta(gandalf(UpdatedBag)),
    retract((gandalf(OldBag))).

deleteFromPotion(Item):-
    potionBag(OldBag),
    deleteItem(OldBag, Item, UpdatedBag),
    asserta(potionBag(UpdatedBag)),
    retract((potionBag(OldBag))).

saveToPotion(Item):-
	potionBag(OldBag),
    insertItem(OldBag, Item, UpdatedBag),
    asserta(potionBag(UpdatedBag)),
    retract((potionBag(OldBag))).

writePotions([], _, 0).

writePotions([H|T], Number, C):-
    itemName(H, Name),
    format('~w. ~w: 500 G', [Number, Name]), nl,
    Number1 is Number + 1,
    writePotions(T, Number1, C1),
	C is C1 + 1.

alchemist:-
	\+menu_status(outside),!,
	write('YAMETE!'),
	nl,nl,fail.


alchemist:-
	locPlayer(P,Q),
	\+isAlchemist(P,Q),!,
	write('Alchemist??'),
	nl,nl,fail,!.


alchemist:-
	money(X),X < 500,
	write('...zZZ.'),nl,nl,!,fail.

alchemist:-
	kaburTimer(5),
	write('また後で oooooo'),nl,nl,
	s,
	write('You got kicked one tile'),nl,
	isAlchemist(P,Q),!,
	retract(isAlchemist(P,Q)),
	assertz(isCrater(P,Q)),fail,!.

alchemist:-
    gandalf(List),
	write('-------ガンダルフの店-------'),nl,
    writePotions(List, 1,C),
	write('-----------------------------------'),nl,nl,
	write('What do you want to buy? (Enter 0 to return)'), nl,
    write('Input number: '), read_integer(Number),
    (
        Number < 0
            ->  write('Please input a valid number .. 馬鹿!'),nl,nl, !;
		Number == 0
			->  write('... めんどくさい'),nl,nl,!;
        Number > C
            ->  write('Please input a valid number .. 馬鹿!'),nl,nl, !;
        Number =< C
            ->  getItemByIndex(List, Number, Item1),
                itemName(Item1, ItemName),
				changeMoney(-500),
				write('ありがとう ございます'),nl,nl,
				kaburTimer(A),
				retract(kaburTimer(A)),
				A1 is A + 1,
				assertz(kaburTimer(A1)),
				deleteFromAlchemist([ItemName,1]),
				saveToPotion([ItemName,1]),!
    ).

writePotionBag([], _, 0).

writePotionBag([H|T], Number, C):-
    itemName(H, Name),
	itemCount(H,Count),
    format('~w. ~w (x ~w)', [Number, Name, Count]), nl,
    Number1 is Number + 1,
    writePotionBag(T, Number1, C1),
	C is C1 + 1.

addToPlayer:-
	changeExpPlayer(50),
	changeExpPlayer(50),
	changeExpPlayer(50),
	changeExpPlayer(50),!.

usePotion(ranching):-
	addToPlayer,
	changeExpRanching(100),
	changeExpRanching(100),
	changeExpRanching(100),
	changeExpRanching(100).

usePotion(fishing):- %one by one
	addToPlayer,
	changeExpFishing(100),
	changeExpFishing(100),
	changeExpFishing(100),
	changeExpFishing(100).

usePotion(farming):-
	addToPlayer,
	changeExpFarming(100),
	changeExpFarming(100),
	changeExpFarming(100),
	changeExpFarming(100).
	
	
potion(_):-
	\+menu_status(outside),!,
	write('DA MEE'),fail.

potion(Bag):-
	itemTotal(Bag,0),!,
	write('da me?'),fail.

potion(Bag):-
	writePotionBag(Bag,1,C),!,
	write('Pakai yang mana? (0 to return)'), nl, nl,
	write('Input number: '), read_integer(Number),
	(
        Number < 0
            ->  write('Please input a valid number!'),nl,nl, !;
		Number == 0
			->  nl,nl,!;
        Number > C
            ->  write('Please input a valid number!'),nl,nl, !;
        Number =< C
            ->  getItemByIndex(Bag, Number, Item1),
                itemName(Item1, ItemName),
				potionType(ItemName,Type),
				write('You feel a bit smarter!'),nl,nl,
				deleteFromPotion([ItemName,1]),
				usePotion(Type),!
    ).

potion:-
	potionBag(Bag),
	potion(Bag).
	