location(X) :- block(X).
location(X) :- stack(X).

% Generate
% Only one blocked can be changed at time T
%{changed(X,T): block(X)} = 1 :- time(T).

% In order for the move to be valid, X must be a block and Y a location
1 {move(X,Y,T) : block(X), location(Y), X!=Y; remove(X,T) : block(X)} 1 :- time(T).

1 {max_moves(1..10)} 1.
:~max_moves(M).[M@1]
time(1..T) :- max_moves(T).

%Define

changed(X,T) :- move(X,Y,T).
changed(X,T) :- remove(X,T).

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

#mode

#modeo( (var(day), var(time)), (positive)).
#modeo(1, type(var(day), var(time), const(course)), (positive)).
#modeo(1, var(day) != var(day)).

#constant(course, c2).
#weight(1).


% For each example, we show the corresponding partial timetable.  "Yes" means
% that the person was definitely assigned the slot; "No" means that the person
% definitely was not assigned the slot; "?" meas that whether this slot was
% assigned to this person is unknown.

#pos(pos1, {         %           ---------------------
  assigned(mon,1)    %          |   | Mon | Tue | Wed |
}, { }).             %           =====================
                     %          | 1 | Yes |  ?  |  ?  |
                     %          |---+-----+-----+-----|
                     %          | 2 |  ?  |  ?  |  ?  |
                     %          |---+-----+-----+-----|
                     %          | 3 |  ?  |  ?  |  ?  |
                     %           ---------------------

#pos(pos2, {         %           ---------------------
  assigned(mon,3),   %          |   | Mon | Tue | Wed |
  assigned(wed,1),   %           =====================
  assigned(wed,3)    %          | 1 | No  |  ?  | Yes |
}, {                 %          |---+-----+-----+-----|
  assigned(mon,1),   %          | 2 |  ?  |  ?  | No  |
  assigned(tue,3),   %          |---+-----+-----+-----|
  assigned(wed,2)    %          | 3 | Yes | No  | Yes |
}).                  %           ---------------------

#pos(pos3, {         %           ---------------------
  assigned(mon,1),   %          |   | Mon | Tue | Wed |
  assigned(wed,3)    %           =====================
}, {}).              %          | 1 | Yes |  ?  |  ?  |
                     %          |---+-----+-----+-----|
                     %          | 2 |  ?  |  ?  |  ?  |
                     %          |---+-----+-----+-----|
                     %          | 3 |  ?  |  ?  | Yes |
                     %           ---------------------


#pos(pos4, {         %           ---------------------
  assigned(mon,1),   %          |   | Mon | Tue | Wed |
  assigned(mon,2),   %           =====================
  assigned(mon,3)    %          | 1 | Yes | Yes | Yes |
}, {                 %          |---+-----+-----+-----|
  assigned(tue,1),   %          | 2 | No  | No  | No  |
  assigned(tue,2),   %          |---+-----+-----+-----|
  assigned(tue,3),   %          | 3 | No  | No  | No  |
  assigned(wed,1),   %           ---------------------
  assigned(wed,2),
  assigned(wed,3)
}).

#pos(pos5, {         %           ---------------------
  assigned(mon,2),   %          |   | Mon | Tue | Wed |
  assigned(mon,3)    %           =====================
},{                  %          | 1 | No  | Yes | Yes |
  assigned(mon,1),   %          |---+-----+-----+-----|
  assigned(tue,1),   %          | 2 | No  | No  | No  |
  assigned(tue,2),   %          |---+-----+-----+-----|
  assigned(tue,3),   %          | 3 | No  | No  | No  |
  assigned(wed,1),   %           ---------------------
  assigned(wed,2),
  assigned(wed,3)
}).

#pos(pos6, {         %           ---------------------
  assigned(mon,2),   %          |   | Mon | Tue | Wed |
  assigned(tue,1)    %           =====================
},{                  %          | 1 | No  | Yes | No  |
  assigned(mon,1),   %          |---+-----+-----+-----|
  assigned(mon,3),   %          | 2 | Yes | No  | No  |
  assigned(tue,2),   %          |---+-----+-----+-----|
  assigned(tue,3),   %          | 3 | No  | No  | No  |
  assigned(wed,1),   %           ---------------------
  assigned(wed,2),
  assigned(wed,3)
}).

#cautious_ordering(pos4, pos3).
#cautious_ordering(pos2, pos1).
#cautious_ordering(pos2, pos3).
#brave_ordering(pos5, pos6).
#maxv(4).
#maxp(2).
