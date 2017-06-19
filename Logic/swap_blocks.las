time(1..2).

% Trying to learn what it means to remove a block, assumming that
% removing a block that is covered results in the blocks on the top of it
% are now resting on the block/stack below it
	
% Event calculus axioms
holdsAt(F, T+1) :- initAt(F,T), time(T+1).
holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T+1).

% Define remove specific block
terminateAt(on(V0, V1), V2) :- holdsAt(on(V0,V1), V2), happensAt(remove(V0), V2).
terminateAt(on(V0, V1), V2) :- holdsAt(on(V0,V1), V2), happensAt(remove(V1), V2).
initAt(on(V0,V3), V2) :- holdsAt(on(V0,V1), V2), holdsAt(on(V1,V3), V2), happensAt(remove(V1), V2).

% Define add specific block
terminateAt(on(V0, V1), V2) :- holdsAt(on(V0,V1), V2), happensAt(add(V3, V1), V2).
initAt(on(V0,V1), V2) :- happensAt(add(V0, V1), V2).
initAt(on(V0,V3), V2) :- holdsAt(on(V0,V1), V2), happensAt(add(V3, V1), V2).

% Head mode declarations
%#modeh(initAt(on(var(block),var(block)), const(time))).
%#modeh(terminateAt(on(var(block), var(block)), const(time))).
#modeh(happensAt(remove(var(block)), const(time))).
#modeh(happensAt(add(var(block), var(block)), const(time))).

% Body mode declarations
#modeb(1,holdsAt(on(var(block),var(block)), const(time))).
#modeb(1,happensAt(add(var(block), var(block)), const(time))).
#modeb(1,happensAt(swap(var(block),var(block)), const(time))).

#maxv(2).

% b3	 b3 b5
% b2 b5	 b2 bnew
% b1 b4	 b1 b4
% s1 s2	 s1 s2
#pos(p3, {
	holdsAt(on(b1,s1),2),
	holdsAt(on(b2,b1),2),
	holdsAt(on(b3,b2),2),
	holdsAt(on(b4,s2),2),
	holdsAt(on(bnew,b4),2),
	holdsAt(on(b5,bnew),2)
},{
	holdsAt(on(b5,b4),2)
},{ 
	holdsAt(on(b1,s1),1).
	holdsAt(on(b2,b1),1).
	holdsAt(on(b3,b2),1).
	holdsAt(on(b4,s2),1).
	holdsAt(on(b5,b4),1).
	happensAt(swap(bnew,b4),1).
}).

#constant(time,1).
#constant(time,2).
#constant(time,3).
#constant(time,4).
