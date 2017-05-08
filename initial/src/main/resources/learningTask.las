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
#modeb(1, happensAt(remove_col(var(col)), var(time))).
#modeb(1, happensAt(remove_col(var(col)), var(time))).
#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
happensAt(remove_col(brown), 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b10,cyan),1).
happensAt(remove_col(brown), 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b10,cyan)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b03,b02),1).
holdsAt(on(b10,s1),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b03,brown),1).
holdsAt(block_col(b10,cyan),1).
happensAt(remove_col(brown), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b02,cyan)).
goalState(block_col(b03,brown)).
goalState(block_col(b10,cyan)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,red),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b20,red),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,red)).
goalState(block_col(b10,cyan)).
goalState(block_col(b20,red)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,red),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b20,red),1).
holdsAt(block_col(b21,cyan),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,red)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b20,red)).
goalState(block_col(b21,cyan)).
}).

#neg({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,red),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,red),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,red)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,red)).
}).

