time(1).
col(blue).
col(red).

% red_block(B) :- block_col(B, red).

#modeh(holdsAt(red_block(var(block)), var(time))).
#modeb(1, holdsAt(block_col(var(block), const(col)), var(time))).

#pos(p1, {
	holdsAt(red_block(b1), 1)
},{
	holdsAt(red_block(b2), 1)
},{ 
	holdsAt(block_col(b1, red), 1).
	holdsAt(block_col(b2, blue), 1).
}).


#constant(col,red).
#constant(col,blue).
