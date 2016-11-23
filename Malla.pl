% Primer año
prerrequisitos(progra).
prerrequisitos(mate1).
prerrequisitos(fis100).
% Otros prerrequisitos
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
% Semestre tentativo para cada ramo
nsemestre(progra, 1).
nsemestre(mate1, 1).
nsemestre(fis100, 1).
nsemestre(edd, 2).
nsemestre(ed, 2).
nsemestre(lp, 3).
nsemestre(talf, 3).
nsemestre(feria, 4).

% Comprueba si el ramo es requisito directo
req(X, Z):- prerrequisitos(X, Z).

% Comprueba si el ramo es requisito indirecto
req(X, Z):- prerrequisitos(X, Y), req(Y, Z).

% Busca todos los resultados entregados por req
listareq(Cursar, L):- findall(X, req(X, Cursar), L).

% Trabaja la lista como conjunto, eliminando elementos repetidos
% Caso base
set([], []).

% Paso recursivo.
set([H|T], [H|T1]) :-
    remove(H, T, T2),
    set(T2, T1), !.

% Remueve el elemento correspondiente de una lista
% Caso base, con lista vacia
remove(_, [], []).

% Remueve de la lista que comienza con el elemento deseado
remove(X, [X|T], T1) :- remove(X, T, T1).

% Remueve recursivamente en caso contrario
remove(X, [H|T], [H|T1]) :-
    X \= H,
    remove(X, T, T1).

% Hace un sort sobre la lista
sortear(List,Sorted):-i_sort(List,[],Sorted).

% Sortea siguiendo insert sort
% Caso base, con lista vacia
i_sort([],Acc,Acc):- !.

% Paso recursivo, segun insert
i_sort([H|T],Acc,Sorted):- insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted), !.

% Inserta segun el semestre correspondiente al ramo
% Caso primer elemento tiene semestre mayor al segundo
insert(X,[Y|T],[Y|NT]):- nsemestre(X, A), nsemestre(Y, B), A>B,insert(X,T,NT).

% Caso primer elemento tiene semestre menor o igual al segundo
insert(X,[Y|T],[X,Y|T]):- nsemestre(X, A), nsemestre(Y, B), A=<B.

% Caso insertar sobre lista vacia
insert(X,[],[X]).

% Dada una lista de Aprobados y un ramo que se desea Cursar, obtiene una
% lista L con todos los ramos que se deben tomar, de forma ordenada
% eg: Aprobados = [mate1, fis100, ...]
%     Cursar = feria
rama(Aprobados, Cursar, L):- listareq(Cursar, Lista), set(Lista, L1), sortear(L1, L2), subtract(L2, Aprobados, L).
