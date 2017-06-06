time(1..2).
col(black).
col(brown).
col(red).
col(cyan).
col(yellow).
col(orange).
holdsAt(F, T+1) :- initAt(F,T), time(T).
holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T).
holdsAt(F,1) :- initState(F).
:- holdsAt(F, 2), not goalState(F).
:- not holdsAt(F,2), goalState(F).
holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).

#modeh(initAt(on(var(block), var(block)), var(time))).
#modeh(terminateAt(on(var(block), var(block)), var(time))).
#modeb(1, holdsAt(on(var(block), var(block)), var(time))).
#modeb(1, holdsAt2(covered(var(block)), var(time))).
#modeb(1, holdsAt(block_col(var(block), var(col)), var(time))).
#maxv(4).
#modeb(1, happensAt(rm_tallest_block, var(time))).
#neg({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b13,b12),1).
holdsAt(block_col(b00,brown),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,cyan),1).
holdsAt(block_col(b13,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b13,b12)).
goalState(block_col(b00,brown)).
goalState(block_col(b01,brown)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,cyan)).
goalState(block_col(b13,cyan)).
}).

#neg({}, {}, {
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
}).