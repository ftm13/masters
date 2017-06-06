time(1..2).
col(black).
col(brown).
col(red).
col(cyan).
col(yellow).
col(orange).
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
initState(stack(s3)).
initState(stack(s4)).
initState(stack(s5)).

max_height(S, S, 0, T) :- holdsAt(stack(S), T).
max_height(S, B1, H+1, T) :- max_height(S, B2, H, T), holdsAt(on(B1, B2), T), H < 5.
max_height2(S,H,T) :- max_height(S,_,H,T).
height(S,H,T) :- max_height2(S,H,T), not max_height2(S, H+1, T).

top_of_stack(B, S, T) :- max_height(S,B,H,T), height(S, H, T).

n_tallest_stack(S1,T) :- height(S1, H1, T), height(S2, H2, T), H1 < H2.

holdsAt(F, T+1) :- initAt(F,T), time(T).
holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T).
holdsAt(F,1) :- initState(F).
:- holdsAt(F, 2), not goalState(F).
:- not holdsAt(F,2), goalState(F).
holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).

% #modeh(initAt(on(var(block), var(block)), var(time))).
#modeh(terminateAt(on(var(block), var(block)), var(time))).
#modeb(1, holdsAt(on(var(block), var(block)), var(time))).
#modeb(1, holdsAt2(covered(var(block)), var(time))).
#modeb(1, holdsAt(block_col(var(block), var(col)), var(time))).
#modeb(1, happensAt(rm_tallest_block, var(time))).
#modeb(1, top_of_stack(var(block), var(stack), var(time))).
#modeb(height(var(stack), var(height), var(time))).
% #modeb(var(height) < var(height)).
#modeb(n_tallest_stack(var(stack), var(time))).
#maxv(4).


#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
happensAt(rm_tallest_block, 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b12,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(block_col(b00,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
goalState(block_col(b12,cyan)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b03,b02),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,brown),1).
holdsAt(block_col(b03,red),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b12,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,brown)).
goalState(block_col(b03,red)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
goalState(block_col(b12,cyan)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b10,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,cyan)).
goalState(block_col(b10,cyan)).
}).

#neg({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b10,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,cyan)).
goalState(block_col(b10,cyan)).
}).

#neg({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b10,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,cyan)).
goalState(block_col(b10,cyan)).
}).
