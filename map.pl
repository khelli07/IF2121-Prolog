% additional legends:
% . -> path tile (not soil)
% * -> crop tile (still growing)
% + -> harvest tile (ready to harvest)

:-dynamic(draw_done/1).
:-dynamic(isAir/2).
:-dynamic(isPagar/2).
:-dynamic(isDiggedTile/2).
:-dynamic(locPlayer/2).
:-dynamic(isSoil/2).
:-dynamic(isCrop/2).
:-dynamic(isHarvest/2).
:-dynamic(isAlchemist/2).
:-dynamic(isCrater/2).
draw_done(false).

isMarket(15,3).
isQuest(18,18).
isHouse(8,12).
isRanch(9,19).
isAlchemist(3,2).

locPlayer(8,13).%starts near house

isAir(7,3).
isAir(5,4).
isAir(5,5).
isAir(6,3).
isAir(6,4).
isAir(6,5).
isAir(6,6).
isAir(7,4).
isAir(7,5).
isAir(7,6).
isAir(7,7).
isAir(8,4).
isAir(8,5).
isAir(8,6).
isAir(8,3).
isAir(8,7).
isAir(9,6).
isAir(9,7).
isAir(9,5).
isAir(10,5).

isAir(15,15).
isAir(15,16).
isAir(15,17).
isAir(16,14).
isAir(16,15).
isAir(16,16).
isAir(16,17).
isAir(17,13).
isAir(17,14).
isAir(17,15).
isAir(17,16).
isAir(14,13).
isAir(14,14).
isAir(14,15).
isAir(13,14).

/* why did i paste this */
isSoil(1,19).
isSoil(1,18).
isSoil(1,17).
isSoil(1,16).
isSoil(1,15).
isSoil(1,14).
isSoil(1,13).
isSoil(2,19).
isSoil(2,18).
isSoil(2,17).
isSoil(2,16).
isSoil(2,15).
isSoil(2,14).
isSoil(2,13).
isSoil(3,19).
isSoil(3,18).
isSoil(3,17).
isSoil(3,16).
isSoil(3,15).
isSoil(3,14).
isSoil(3,13).
isSoil(4,19).
isSoil(4,18).
isSoil(4,17).
isSoil(4,16).
isSoil(4,15).
isSoil(4,14).
isSoil(4,13).
isSoil(5,19).
isSoil(5,18).
isSoil(5,17).
isSoil(5,16).
isSoil(5,15).
isSoil(5,14).
isSoil(5,13).
isSoil(6,19).
isSoil(6,18).
isSoil(6,17).
isSoil(6,16).
isSoil(6,15).
isSoil(6,14).
isSoil(6,13).
isSoil(7,19).
isSoil(7,18).
isSoil(7,17).
isSoil(7,16).
isSoil(7,15).
isSoil(7,14).
isSoil(7,13).

/* Initialization (im too lazy to print then paste this here) */
setpagar:- 
	forall(between(0,20,X), assertz(isPagar(X,0))),
	forall(between(0,20,X), assertz(isPagar(X,20))),
	forall(between(0,20,Y), assertz(isPagar(0,Y))),
	forall(between(0,20,Y), assertz(isPagar(20,Y))).
	
/* Printing Map */

/* draw in place */
draw_point(X,Y):-
	isPagar(X,Y),!,
	write('#'),!.
draw_point(X,Y):-
	locPlayer(X,Y),!,
	write('P'),!.
draw_point(X,Y):-
	isAir(X,Y),!,
	write('o'),!.
draw_point(X,Y):-
	isMarket(X,Y),!,
	write('M'),!.
draw_point(X,Y):-
	isRanch(X,Y),!,
	write('R'),!.
draw_point(X,Y):-
	isHouse(X,Y),!,
	write('H'),!.
draw_point(X,Y):-
	isQuest(X,Y),!,
	write('Q'),!.
draw_point(X,Y):-
	isDiggedTile(X,Y),!,
	write('='),!.
draw_point(X,Y):-
	isSoil(X,Y),!,
	write('-'),!.
draw_point(X,Y):-
	isCrop(X,Y),!,
	write('*'),!.
draw_point(X,Y):-
	isHarvest(X,Y),!,
	write('+'),!.
draw_point(X,Y):-
	isAlchemist(X,Y),!,
	write('?'),!.
draw_point(X,Y):-
	isCrater(X,Y),!,
	write('%'),!.
draw_point(_,_):-
	write('.').

/* traversal */

/* done */
draw_map(_,Y):-
	Y =:= 21,
	retract(draw_done(_)),
	assertz(draw_done(true)),!.
	
/* move down */
draw_map(X,Y):-
	draw_done(false),
	X =:= 21,
	Y<21,
	nl,
	Z is Y+1,
	draw_map(0,Z).
	
/* move right */
draw_map(X,Y):-
	draw_done(false),
	X<21,
	Y<21,
	draw_point(X,Y),
	Z is X+1,
	draw_map(Z,Y).

/* Commands */
map:-
	\+menu_status(outside),!,
	write('Command tidak dapat diakses!'),
	nl,nl,fail.

map:-
	write('-----Leaf Valley-----'),nl,nl,
	retract(draw_done(_)),
	assertz(draw_done(false)),
	draw_map(0,0),!,nl,nl,
	write('---------------------'),nl,nl.
