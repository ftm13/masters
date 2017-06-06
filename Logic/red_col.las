col(red).
col(blue).
%block(b1).
%block_col(b1, red).


%block_col(b1, red).
%red_block(B) :- block_col(B, red).

#modeh(red_block(var(block))).
#modeb(block_col(var(block), const(col))).

#pos(a, {
block_col(0, red),
red_block(0)
},
{}).

#pos(b, {
block_col(1, red),
red_block(1)
},
{}).

#neg(c, {
block_col(1,blue),
red_block(1)
}, {}).


#constant(col, red).
#constant(col, blue).
