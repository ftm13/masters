block(b1;b2;b3;b4;b5).

col(red;blue).
stack(s1;s2;s3).

has_col(b1,red).
has_col(b2,blue).
has_col(b3, red).
has_col(b4, blue).
has_col(b5, red).


%b3r b4b
%b1r b2b b5r
init_on(b1, s1).
init_on(b3, b1).
init_on(b2, s2).
init_on(b4, b2).
init_on(b5, s3).

%Consequence of remove red

%    b4b
%b1r b2b
goal_on(b1, s3).
goal_on(b2, s2).
goal_on(b4, b2).
