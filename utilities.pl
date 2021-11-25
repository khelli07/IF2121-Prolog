% fungsi fungsi umum
max(A,B,A):- 
	A>B,!.

max(A,B,B):- 
	A=<B,!.

% Get I th element of list, index from 0
get_list_element([], I, E) :- fail, !.
get_list_element(L, 0, E) :-
	[H|_] = L,
	E = H, !.
get_list_element(L, I, E) :-
	[_|T] = L,
	I1 is I - 1,
	get_list_element(T, I1, E).


% Read string, output List of character code
read_str(String) :-
	get0(Char), read_str_aux(Char, String).
read_str_aux(-1, []) :- !.	% EOF
read_str_aux(10, []) :- !.	% EOL (Linux)
read_str_aux(13, []) :- !.	% EOL (baris baru)
read_str_aux(Char, [Char|Rest]) :- read_str(Rest).

% Read atom, output atom misal 'Ini string _ !@#'
read_atom(Atom) :-
	read_str(String),
	atom_codes(Atom, String).
% Read Number
read_num(Number) :-
	read_str(String),
	number_codes(Number, String).
