% Facts
time(1..2).
col(brown).
col(red).
col(cyan).
col(yellow).
col(orange).
col(black).
stack(s1). stack(s2).
height(1..6).

covered(B,T) :- holdsAt(on(B2,B),T), time(T).
max_height(S, S, 0, T) :- holdsAt(stack(S), T).
max_height(S, B1, H+1, T) :- max_height(S, B2, H, T), H < 6, holdsAt(on(B1, B2), T).
max_height2(S,H,T) :- max_height(S,_,H,T).
height(S,H,T) :- max_height2(S,H,T), not max_height2(S, H+1, T).

top_of_stack(B, S, T) :- max_height(S,B,H,T), height(S, H, T).

% Event calculus rules
holdsAt(F,T+1) :- initAt(F,T), time(T).
holdsAt(F,T+1) :- holdsAt(F,T), not terminateAt(F,T), time(T).
holdsAt(F,1) :- initState(F).

% Constraints required for the learning
:- holdsAt(F, 2), not goalState(F).
:- not holdsAt(F,2), goalState(F).

%holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).

#modeh(initAt(block_col(var(block), var(col)), var(time))).
#modeh(initAt(on(var(block),var(block)), var(time))).
%#modeh(terminateAt(block_col(var(block), var(col)), var(time))).
#modeh(terminateAt(on(var(block), var(block)), var(time))).
#modeb(1, height(var(stack), var(height), var(time))).
#modeb(1, happensAt(remove_col(var(col)), var(time))).
#modeb(1, holdsAt(on(var(block), var(block)), var(time))).
#modeb(1, covered(var(block), var(time))).
#modeb(1, holdsAt(block_col(var(block), var(col)), var(time))).
#maxv(4).

#pos({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(on(b2, b1), 1).
    holdsAt(on(b3, s2), 1).
    holdsAt(on(b4, b3), 1).

    holdsAt(block_col(b1, red), 1).
    holdsAt(block_col(b2, black), 1).
    holdsAt(block_col(b3, red), 1).
    holdsAt(block_col(b4, black), 1).

    happensAt(remove_col(black), 1).

    goalState(on(b1, s1)).
    goalState(on(b3, s2)).

    goalState(block_col(b1, red)).
    goalState(block_col(b2, black)).
    goalState(block_col(b3, red)).
    goalState(block_col(b4, black)).

}).

#pos({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(on(b2, b1), 1).
    holdsAt(on(b3, s2), 1).
    holdsAt(on(b4, b3), 1).

    holdsAt(block_col(b1, red), 1).
    holdsAt(block_col(b2, red), 1).
    holdsAt(block_col(b3, red), 1).
    holdsAt(block_col(b4, black), 1).

    happensAt(remove_col(black), 1).

    goalState(on(b1, s1)).
    goalState(on(b2, b1)).
    goalState(on(b3, s2)).

    goalState(block_col(b1, red)).
    goalState(block_col(b2, red)).
    goalState(block_col(b3, red)).
    goalState(block_col(b4, black)).
}).

#pos({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(on(b2, b1), 1).
    holdsAt(on(b3, b2), 1).
    holdsAt(on(b4, s2), 1).

    holdsAt(block_col(b1, red), 1).
    holdsAt(block_col(b2, red), 1).
    holdsAt(block_col(b3, red), 1).
    holdsAt(block_col(b4, black), 1).

    happensAt(remove_col(red), 1).

    goalState(on(b1, s1)).
    goalState(on(b2, b1)).
    goalState(on(b4, s2)).

    goalState(block_col(b1, red)).
    goalState(block_col(b2, red)).
    goalState(block_col(b3, red)).
    goalState(block_col(b4, black)).
}).

#pos({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(on(b2, b1), 1).

    holdsAt(block_col(b1, red), 1).
    holdsAt(block_col(b2, black), 1).

    happensAt(remove_col(red), 1).

    goalState(on(b1, s1)).
    goalState(on(b2, b1)).

    goalState(block_col(b1, red)).
    goalState(block_col(b2, black)).
}).

#pos({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(on(b2, s2), 1).
    holdsAt(on(b3, s3), 1).
    holdsAt(on(b4, s4), 1).

    holdsAt(block_col(b1, red), 1).
    holdsAt(block_col(b2, red), 1).
    holdsAt(block_col(b3, red), 1).
    holdsAt(block_col(b4, black), 1).

    happensAt(remove_col(red), 1).

    goalState(on(b4, s4)).

    goalState(block_col(b1, red)).
    goalState(block_col(b2, red)).
    goalState(block_col(b3, red)).
    goalState(block_col(b4, black)).
}).

#neg({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(on(b2, b1), 1).

    holdsAt(block_col(b1, red), 1).
    holdsAt(block_col(b2, black), 1).

    happensAt(remove_col(red), 1).

    goalState(on(b2, s1)).

    goalState(block_col(b1, red)).
    goalState(block_col(b2, black)).
}).

#neg({}, {}, {
    holdsAt(on(b1, s1), 1).
    holdsAt(block_col(b1, red), 1).

    happensAt(remove_col(black), 1).

    goalState(block_col(b1, red)).
}).
