terminateAt(on(V3, V2), V1) :- n_tallest_stack(V0, V1), holdsAt2(covered(V2), V1), top_of_stack(V3, V0, V1).
n_tallest_stack(V0, V3) :- height(V0, V1, V2), not height(V0, V1, V3), happensAt(rm_tallest_block, V3).

time(1..2).
col(brown).
col(red).
col(cyan).
col(yellow).
col(orange).

max_height(S, S, 0, T) :- holdsAt(stack(S), T).
max_height(S, B1, H+1, T) :- max_height(S, B2, H, T), H < 6, holdsAt(on(B1, B2), T).
max_height2(S,H,T) :- max_height(S,_,H,T).
height(S,H,T) :- max_height2(S,H,T), not max_height2(S, H+1, T).

top_of_stack(B, S, T) :- max_height(S,B,H,T), height(S, H, T).

holdsAt(F, T+1) :- initAt(F,T), time(T+1).
holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T+1).
holdsAt(F,1) :- initState(F).
:- holdsAt(F, 2), not goalState(F).
:- not holdsAt(F,2), goalState(F).
holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).

initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b13,b12),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,cyan),1).
holdsAt(block_col(b13,cyan),1).
holdsAt(block_col(b20,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b13,b12)).
goalState(on(b20,s2)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,cyan)).
goalState(block_col(b13,cyan)).
goalState(block_col(b20,cyan)).
