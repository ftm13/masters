time(1).
time(2).
col(black).
col(red).

holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T), time(T+1).

holdsAt(F,1) :- initState(F).

holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T).

terminateAt(on(V2, V3), V1) :- happensAt(remove_col(V0), V1), holdsAt(on(V2, V3), V1), not holdsAt2(covered(V2), V1), holdsAt(block_col(V2, V0), V1).

holdsAt(on(b1, s1), 1).
holdsAt(on(b2, s2), 1).
holdsAt(on(b3, s3), 1).
holdsAt(on(b4, s4), 1).

holdsAt(block_col(b1, red), 1).
holdsAt(block_col(b2, red), 1).
holdsAt(block_col(b3, red), 1).
holdsAt(block_col(b4, black), 1).

happensAt(remove_col(red), 1).
