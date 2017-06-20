time(1).

max_height(S, S, 0, T) :- holdsAt(stack(S), T).
max_height(S, B1, H+1, T) :- max_height(S, B2, H, T), H < 6, holdsAt(on(B1, B2), T).
max_height2(S,H,T) :- max_height(S,_,H,T).
height(S,H,T) :- max_height2(S,H,T), not max_height2(S, H+1, T).

top_of_stack(B, S, T) :- max_height(S,B,H,T), height(S, H, T).

holdsAt(F, T+1) :- initAt(F,T), time(T+1).
holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T+1).
holdsAt(F,1) :- initState(F).

holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).
lt(H1, H2) :- h(H1), h(H2), H1 < H2.
h(0..6).

% Relevant stuff
#modeh(holdsAt2(taller(var(stack), var(stack)), var(time))).
	
#modeb(2, height(var(stack), var(height), var(time)), (positive)).
#modeb(1, lt(var(height),var(height)), (positive, anti_reflexive, symmetric)).

% Completely irrelevant stuff
#modeh(initAt(block_col(var(block), var(col)), var(time))).
#modeh(initAt(on(var(block),var(block)), var(time))).
#modeh(terminateAt(block_col(var(block), var(col)), var(time))).
#modeh(terminateAt(on(var(block), var(block)), var(time))).

#modeh(n_tallest_stack(var(stack), var(time))).

#modeb(holdsAt2(covered(var(block)), var(time))).
#modeb(top_of_stack(var(block), var(stack), var(time))).
#modeb(n_tallest_stack(var(stack), var(time))).

#maxv(5).

#pos({
	holdsAt2(taller(s0,s1),1),
	holdsAt2(taller(s0,s2),1)
}, {
	holdsAt2(taller(s1,s0),1)
}, {
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
}).
