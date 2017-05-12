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
#modeb(1, happensAt(remove_col(var(col)), var(time))).
#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b30,s3),1).
holdsAt(on(b31,b30),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b10,brown),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b20,brown),1).
holdsAt(block_col(b21,red),1).
holdsAt(block_col(b30,brown),1).
holdsAt(block_col(b31,red),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(on(b30,s3)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b10,brown)).
goalState(block_col(b11,cyan)).
goalState(block_col(b20,brown)).
goalState(block_col(b21,red)).
goalState(block_col(b30,brown)).
goalState(block_col(b31,red)).
}).

#neg({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b30,s3),1).
holdsAt(on(b31,b30),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b10,brown),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b20,brown),1).
holdsAt(block_col(b21,red),1).
holdsAt(block_col(b30,brown),1).
holdsAt(block_col(b31,red),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(on(b30,s3)).
goalState(on(b31,b30)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b10,brown)).
goalState(block_col(b11,cyan)).
goalState(block_col(b20,brown)).
goalState(block_col(b21,red)).
goalState(block_col(b30,brown)).
goalState(block_col(b31,red)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,brown),1).
holdsAt(block_col(b20,brown),1).
holdsAt(block_col(b21,brown),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,brown)).
goalState(block_col(b20,brown)).
goalState(block_col(b21,brown)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b30,s3),1).
holdsAt(on(b31,b30),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,brown),1).
holdsAt(block_col(b20,brown),1).
holdsAt(block_col(b21,brown),1).
holdsAt(block_col(b30,red),1).
holdsAt(block_col(b31,orange),1).
happensAt(remove_col(red), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(on(b30,s3)).
goalState(on(b31,b30)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,brown)).
goalState(block_col(b20,brown)).
goalState(block_col(b21,brown)).
goalState(block_col(b30,red)).
goalState(block_col(b31,orange)).
}).

#pos({}, {}, {
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b30,s3),1).
holdsAt(on(b31,b30),1).
holdsAt(on(b32,b31),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,brown),1).
holdsAt(block_col(b20,brown),1).
holdsAt(block_col(b21,brown),1).
holdsAt(block_col(b30,red),1).
holdsAt(block_col(b31,orange),1).
holdsAt(block_col(b32,cyan),1).
happensAt(remove_col(cyan), 1).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(on(b30,s3)).
goalState(on(b31,b30)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,brown)).
goalState(block_col(b20,brown)).
goalState(block_col(b21,brown)).
goalState(block_col(b30,red)).
goalState(block_col(b31,orange)).
goalState(block_col(b32,cyan)).
}).

