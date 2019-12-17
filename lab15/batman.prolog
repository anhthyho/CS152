
villain(joker).
villain(penguin).
villain(catwoman).
villain(scarecrow).
villain(bane).

kills_people(joker).
kills_people(penguin).
kills_people(bane).

power(scarecrow, fear).
power(bane,venom).

% Rules
scary(V) :- villain(V), kills_people(V).
scary(V) :- villain(V), power(V,_).

bad_breakup(batman, talia).
bad_breakup(batman, poison_ivy).
enemy(batman, X) :-romantic_interest(X),\+bad_breakup(batman, X).
enemy(batman, X) :- villain(X).

% ?- findall(V, scary(V), R).
% R = [joker, penguin, bane, scarecrow, bane].
%
% ?- setof(V, scary(V), R).
% R = [bane, joker, penguin, scarecrow].

% What if we did not have setof?
find_scary(ScarySet) :-
  findall(V, scary(V), ListOfScaries),
  get_unique(ListOfScaries,ScarySet)
,  !. % Green cut

get_unique([],[]).
get_unique([H|Tail], Set) :-
  get_unique(Tail, TailSet),
  \+ member(H, TailSet),
  Set = [H|TailSet].
get_unique([H|Tail], Set) :-
  get_unique(Tail, TailSet),
  member(H, TailSet),
  Set = TailSet.

% Base case
myappend([], L2, L2).
% Recursive case
myappend([H|T1],L2,[H|T2]) :-
myappend(T1, L2, T2).

myreverse([], []).
myreverse([H|T], L) :-myreverse(T, RT),append(RT, [H], L).

%in class graph examples
edge(a, b, 2).
edge(b, a, 2).
edge(a, c, 3).
edge(c, a, 3).
edge(a, f, 4).
edge(f, a, 4).
edge(b, c, 2).
edge(c, b, 2).
edge(c, d, 3).
edge(d, c, 3).
edge(c, e, 1).
edge(e, c, 1).
edge(d, f, 5).
edge(f, d, 5).

%graph rules
find_path(Start, End, Cost, Path) :-edge(Start, End, Cost),Path = [Start, End].
find_path(Start,End,TotalCost,Path) :-edge(Start, X, InitCost), find_path(X,End,RestCost,TailPath),TotalCost is InitCost + RestCost, Path = [Start|TailPath].

