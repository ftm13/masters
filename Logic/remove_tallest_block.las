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

%n_tallest_stack(S1,T) :- height(S1, H1, T), height(S2, H2, T), lt(H1, H2).

%#modeh(initAt(on(var(block), var(block)), var(time))).
#modeb(1, holdsAt(on(var(block), var(block)), var(time))).
#modeb(1, n_tallest_stack(var(stack), var(time))).
#modeh(n_tallest_stack(var(stack), var(time))).
#modeh(terminateAt(on(var(block), var(block)), var(time))).
#modeb(1, holdsAt2(covered(var(block)), var(time))).
#modeb(1, holdsAt(block_col(var(block), var(col)), var(time))).
#modeb(1, happensAt(rm_tallest_block, var(time)), (positive)).
#modeb(1, top_of_stack(var(block), var(stack), var(time))).
#modeb(height(var(stack), var(height), var(time)), (positive)).
#modeb(1, lt(var(height),var(height)), (positive, anti_reflexive, symmetric)).
#maxv(5).


#bias("var_of_type(V, time) :- body(holdsAt2(_, V)).").
#bias("var_of_type(V, time) :- body(top_of_stack(_,_,V)).").
#bias("var_of_type(V, time) :- body(holdsAt(_,V)).").
#bias("var_of_type(V, time) :- body(height(_,_,V)).").
#bias("var_of_type(V, time) :- body(happensAt(_,V)).").
#bias("var_of_type(V, time) :- body(n_tallest_stack(_,V)).").
%#bias(":- var_of_type(V1, time), var_of_type(V2, time), V1 < V2.").

lt(H1, H2) :- h(H1), h(H2), H1 < H2.
h(0..6).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b20,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b20,s2)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b20,cyan)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b03,b02),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b03,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b20,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b10,s1)).
goalState(on(b20,s2)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,cyan)).
goalState(block_col(b03,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b20,cyan)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,cyan),1).
holdsAt(block_col(b20,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(block_col(b00,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,cyan)).
goalState(block_col(b20,cyan)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b10,brown),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,brown),1).
holdsAt(block_col(b20,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(block_col(b00,cyan)).
goalState(block_col(b10,brown)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,brown)).
goalState(block_col(b20,cyan)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,red),1).
holdsAt(block_col(b01,red),1).
holdsAt(block_col(b02,brown),1).
holdsAt(block_col(b10,red),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b20,brown),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(block_col(b00,red)).
goalState(block_col(b01,red)).
goalState(block_col(b02,brown)).
goalState(block_col(b10,red)).
goalState(block_col(b11,brown)).
goalState(block_col(b20,brown)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b03,b02),1).
holdsAt(on(b04,b03),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,red),1).
holdsAt(block_col(b01,red),1).
holdsAt(block_col(b02,brown),1).
holdsAt(block_col(b03,orange),1).
holdsAt(block_col(b04,orange),1).
holdsAt(block_col(b10,red),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b20,brown),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b03,b02)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(block_col(b00,red)).
goalState(block_col(b01,red)).
goalState(block_col(b02,brown)).
goalState(block_col(b03,orange)).
goalState(block_col(b04,orange)).
goalState(block_col(b10,red)).
goalState(block_col(b11,brown)).
goalState(block_col(b20,brown)).
}).

#neg({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b12,brown),1).
holdsAt(block_col(b20,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(block_col(b00,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
goalState(block_col(b12,brown)).
goalState(block_col(b20,cyan)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b22,b21),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b20,cyan),1).
holdsAt(block_col(b21,brown),1).
holdsAt(block_col(b22,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b02,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
goalState(block_col(b20,cyan)).
goalState(block_col(b21,brown)).
goalState(block_col(b22,cyan)).
}).

#pos({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b13,b12),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(on(b22,b21),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,brown),1).
holdsAt(block_col(b02,cyan),1).
holdsAt(block_col(b10,cyan),1).
holdsAt(block_col(b11,brown),1).
holdsAt(block_col(b12,red),1).
holdsAt(block_col(b13,red),1).
holdsAt(block_col(b20,cyan),1).
holdsAt(block_col(b21,brown),1).
holdsAt(block_col(b22,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b02,b01)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(on(b22,b21)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,brown)).
goalState(block_col(b02,cyan)).
goalState(block_col(b10,cyan)).
goalState(block_col(b11,brown)).
goalState(block_col(b12,red)).
goalState(block_col(b13,red)).
goalState(block_col(b20,cyan)).
goalState(block_col(b21,brown)).
goalState(block_col(b22,cyan)).
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
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b10,brown),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,cyan),1).
holdsAt(block_col(b20,cyan),1).
holdsAt(block_col(b21,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b10,brown)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,cyan)).
goalState(block_col(b20,cyan)).
goalState(block_col(b21,cyan)).
}).

#neg({}, {}, {
initState(stack(s0)).
initState(stack(s1)).
initState(stack(s2)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b02,b01),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(on(b12,b11),1).
holdsAt(on(b20,s2),1).
holdsAt(on(b21,b20),1).
holdsAt(block_col(b00,cyan),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b02,red),1).
holdsAt(block_col(b10,brown),1).
holdsAt(block_col(b11,cyan),1).
holdsAt(block_col(b12,cyan),1).
holdsAt(block_col(b20,cyan),1).
holdsAt(block_col(b21,cyan),1).
happensAt(rm_tallest_block, 1).
goalState(stack(s0)).
goalState(stack(s1)).
goalState(stack(s2)).
goalState(on(b00,s0)).
goalState(on(b01,b00)).
goalState(on(b10,s1)).
goalState(on(b11,b10)).
goalState(on(b12,b11)).
goalState(on(b20,s2)).
goalState(on(b21,b20)).
goalState(block_col(b00,cyan)).
goalState(block_col(b01,cyan)).
goalState(block_col(b02,red)).
goalState(block_col(b10,brown)).
goalState(block_col(b11,cyan)).
goalState(block_col(b12,cyan)).
goalState(block_col(b20,cyan)).
goalState(block_col(b21,cyan)).
}).

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
