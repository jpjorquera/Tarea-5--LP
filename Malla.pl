prerrequisitos(progra).
prerrequisitos(mate1).
prerrequisitos(fis100).
prerrequisitos(progra, edd).
prerrequisitos(edd, lp).
prerrequisitos(progra, ed).
prerrequisitos(mate1, ed).
prerrequisitos(edd, talf).
prerrequisitos(ed, talf).
prerrequisitos(talf, feria).
prerrequisitos(ed, feria).
prerrequisitos(lp, feria).
prerrequisitos(fis100, feria).

nsemestre(progra, 1).
nsemestre(mate1, 1).
nsemestre(fis100, 1).
nsemestre(edd, 2).
nsemestre(ed, 2).
nsemestre(lp, 3).
nsemestre(talf, 3).
nsemestre(feria, 4).

req(X, Z):- prerrequisitos(X, Z).
req(X, Z):- prerrequisitos(X, Y), req(Y, Z).
listareq(Cursar, L):- findall(X, req(X, Cursar), L).

set([], []).
set([H|T], [H|T1]) :-
    remove(H, T, T2),
    set(T2, T1), !.
remove(_, [], []).
remove(X, [X|T], T1) :- remove(X, T, T1).
remove(X, [H|T], [H|T1]) :-
    X \= H,
    remove(X, T, T1).

insert_sort(List,Sorted):-i_sort(List,[],Sorted).
i_sort([],Acc,Acc):- !.
i_sort([H|T],Acc,Sorted):- insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted), !.

insert(X,[Y|T],[Y|NT]):- nsemestre(X, A), nsemestre(Y, B), A>B,insert(X,T,NT).
insert(X,[Y|T],[X,Y|T]):- nsemestre(X, A), nsemestre(Y, B), A=<B.
insert(X,[],[X]).

rama(Aprobados, Cursar, L):- listareq(Cursar, Lista), set(Lista, L1), insert_sort(L1, L2), subtract(L2, Aprobados, L).
