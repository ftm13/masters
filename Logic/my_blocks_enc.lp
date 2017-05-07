location(X) :- block(X).
location(X) :- stack(X).

% Generate
% Only one blocked can be changed at time T
%{changed(X,T): block(X)} = 1 :- time(T).

% In order for the move to be valid, X must be a block and Y a location
{move(X,Y,T) : block(X), location(Y), X!=Y; remove(X,T) : block(X)} = 1 :- time(T).

1 {max_moves(1..10)} 1.
:~max_moves(M).[M@1]
time(1..T) :- max_moves(T).

%Define

changed(X,T) :- move(X,Y,T).
changed(X,T) :- remove(X,T).

%remove(X,T) :- remove(X,Y,T).
%remove(X,Y,T) :- on(X,Y,T-1), block(X), location(Y), time(T).

% Do I need the time(T) constrain here?
%move(X,Y,T) :- block(X), location(Y), X!=Y, time(T).
on(X,Y,0) :- init_on(X,Y).

move(X,T) :- move(X,_,T), time(T).
on(X,Y,T) :- move(X,Y,T), time(T).
on(X,Y,T) :- not changed(X,T), on(X,Y,T-1), time(T).

%Test

:- on(A,X,T-1), move(X,Y,T).
:- on(A,X,T-1), remove(X,T).

% Enforce the goal
:- goal_on(X,Y), not on(X,Y,M), max_moves(M).
:- not goal_on(X,Y), on(X,Y,M), max_moves(M).

final_state(X,Y) :- on(X,Y,M), max_moves(M).

%remove(b3,1).
%remove(b5,2).

%time(1..2).
#show remove/2.
#show move/3.
