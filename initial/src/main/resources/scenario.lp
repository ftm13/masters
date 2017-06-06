initState(stack(s0)).
initState(stack(s1)).
holdsAt(on(b00,s0),1).
holdsAt(on(b01,b00),1).
holdsAt(on(b10,s1),1).
holdsAt(on(b11,b10),1).
holdsAt(block_col(b00,red),1).
holdsAt(block_col(b01,cyan),1).
holdsAt(block_col(b10,red),1).
holdsAt(block_col(b11,cyan),1).
happensAt(rm_tallest_block, 1).

