heists(joker, 97).
heists(penguin, 18).
heists(catwoman, 31).
heists(scarecrow, 42).
combined_heists(X, Y, Total) :-
heists(X,XN), heists(Y,YN),
Total is XN + YN.
%if true, no need to keep searching
max(X,Y,Y):- X =< Y, !.
%last rule, no cut needed
max(X,Y,X):- X > Y. 
