% fungsi fungsi umum
max(A,B,A):- 
	A>B,!.

max(A,B,B):- 
	A=<B,!.