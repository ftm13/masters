time(1..2).

% Event calculus
holdsAt(F, T+1) :- initAt(F,T), time(T).
holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T).
holdsAt(F,1) :- initState(F).

:- holdsAt(F, 2), not goalState(F).
:- not holdsAt(F,2), goalState(F).

% Covered
holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).

% Definition of remove specific block
terminateAt(on(V0, V1), V2) :- holdsAt(on(V0,V1), V2), happensAt(remove(V0), V2).
terminateAt(on(V0, V1), V2) :- holdsAt(on(V0,V1), V2), happensAt(remove(V1), V2).
initAt(on(V0,V3), V2) :- holdsAt(on(V0,V1), V2), holdsAt(on(V1,V3), V2), happensAt(remove(V1), V2).

#modeh(happensAt(remove(var(block)),var(time))).

% Completely irrelevant stuff
#modeh(initAt(block_col(var(block), var(col)), var(time))).
#modeh(initAt(on(var(block),var(block)), var(time))).
#modeh(terminateAt(block_col(var(block), var(col)), var(time))).
#modeh(terminateAt(on(var(block), var(block)), var(time))).

#modeb(1, holdsAt2(covered(var(block)), var(time))).
#modeb(1, holdsAt(block_col(var(block), var(col)), var(time))).
#modeb(1, happensAt(remove_col(var(col)), var(time))).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
initState(stack(s3)).
initState(stack(s4)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b03,b02),1).
holdsAt(on(b04,b03),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b13,b12),1).
holdsAt(on(b14,b13),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b22,b21),1).
holdsAt(on(b23,b22),1).
holdsAt(on(b24,b23),1).
holdsAt(on(b30,s3),1).
holdsAt(on(b31,b30),1).
holdsAt(on(b32,b31),1).
holdsAt(on(b33,b32),1).
holdsAt(on(b34,b33),1).
holdsAt(on(b40,s4),1).
holdsAt(on(b41,b40),1).
holdsAt(on(b42,b41),1).
holdsAt(on(b43,b42),1).
holdsAt(on(b44,b43),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b03,red),1).
holdsAt(block_col(b04,red),1).
holdsAt(block_col(b10,red),1).
holdsAt(block_col(b11,red),1).
holdsAt(block_col(b12,cyan),1).
holdsAt(block_col(b13,cyan),1).
holdsAt(block_col(b14,red),1).
holdsAt(block_col(b20,red),1).
holdsAt(block_col(b21,brown),1).
holdsAt(block_col(b22,cyan),1).
holdsAt(block_col(b23,cyan),1).
holdsAt(block_col(b24,cyan),1).
holdsAt(block_col(b30,red),1).
holdsAt(block_col(b31,red),1).
holdsAt(block_col(b32,cyan),1).
holdsAt(block_col(b33,cyan),1).
holdsAt(block_col(b34,red),1).
holdsAt(block_col(b40,cyan),1).
holdsAt(block_col(b41,orange),1).
holdsAt(block_col(b42,orange),1).
holdsAt(block_col(b43,brown),1).
holdsAt(block_col(b44,red),1).
happensAt(remove_col(red), 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(stack(s3)).
goalState(stack(s4)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b03,b02)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b13,b12)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(on(b22,b21)).
goalState(on(b23,b22)).
goalState(on(b24,b23)).
goalState(on(b30,s3)).
goalState(on(b31,b30)).
goalState(on(b32,b31)).
goalState(on(b33,b32)).
goalState(on(b40,s4)).
goalState(on(b41,b40)).
goalState(on(b42,b41)).
goalState(on(b43,b42)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,cyan)).
goalState(block_col(b03,red)).
goalState(block_col(b04,red)).
goalState(block_col(b10,red)).
goalState(block_col(b11,red)).
goalState(block_col(b12,cyan)).
goalState(block_col(b13,cyan)).
goalState(block_col(b14,red)).
goalState(block_col(b20,red)).
goalState(block_col(b21,brown)).
goalState(block_col(b22,cyan)).
goalState(block_col(b23,cyan)).
goalState(block_col(b24,cyan)).
goalState(block_col(b30,red)).
goalState(block_col(b31,red)).
goalState(block_col(b32,cyan)).
goalState(block_col(b33,cyan)).
goalState(block_col(b34,red)).
goalState(block_col(b40,cyan)).
goalState(block_col(b41,orange)).
goalState(block_col(b42,orange)).
goalState(block_col(b43,brown)).
goalState(block_col(b44,red)).
}).
