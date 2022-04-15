man(john).
man(ted).

woman(mary).

loves(john, wine).
loves(mary, wine).
loves(john, X) :- loves(X, wine).
% loves(john, X) :- loves(john, X).
% ∀X(loves(X, wine) → loves(john, X)).

% loves(+X, +Y)
% loves(+X, -Y)
% loves(-X, +Y)
% loves(-X, -Y)

nat(o).
nat(s(X)) :- nat(X).

% add(X,Y,Z) <-> X + Y = Z
add(o,X,X).
add(s(X),Y,s(Z)) :- add(X,Y,Z).

% mem(X,Y) <-> X ∈ Y

mem(X, [X|_]).
mem(X, [_|T]) :- mem(X, T).

:- op(100, xfx, ∈).

X ∈ [X|_].
X ∈ [_|T] :- X ∈ T.
