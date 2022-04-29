:- set_prolog_flag(occurs_check, true).

% type checking
% Γ ⊢ λ(x,x) : α ⇒ α.

% type inference
% Γ ⊢ λ(x,x) : Τ.

% type inhabitance
% Γ ⊢ M : α ⇒ α.

% Γ ⊢ ((λ(x,λ(y,λ(z,((x@z)@(y@z)))))) : (α ⇒ (β ⇒ β))).

:- op(170, fx, ⊢).
:- op(160, xfx, ⊢).
:- op(160, xfx, ⊩).
:- op(150, xfx, #).
:- op(150, xfx, :).
:- op(140, xfy, ⇒).
:- op(130, yfx, @).

% [x:α, y:β]

% Γ ⊢ λ(x,x) : α ⇒ α.
% +Γ ⊢ -M : +Τ. 

functional(_ ⇒ _).

deconstruct([], Α, Α) :- atom(Α).
deconstruct([Ρ | Ρs], Α, Ρ ⇒ Σ) :-
    deconstruct(Ρs, Α, Σ).

_ ⊩ [] : [].
Γ ⊩ [N | Ns] : [Ρ | Ρs] :- Γ ⊢ N : Ρ, Γ ⊩ Ns : Ρs.

whenAppliedEquals(X, [], X).
whenAppliedEquals(X, [N | Ns], M) :-
    whenAppliedEquals(X @ N, Ns, M).

extendContext(Γ, [], [], Γ).
extendContext(Γ, [X | Xs] , [Ρ | Ρs], [X : Ρ | Γ1]) :-
    extendContext(Γ, Xs, Ρs, Γ1).

whenAbstractedEquals([], M, M).
whenAbstractedEquals([X | Xs], N, λ(X, M)) :-
    whenAbstractedEquals(Xs, N, M).

% оптимизация: T е в контекста
Γ ⊢ X : Τ   :- member(X : Τ, Γ), !.

% Τ е базов тип
Γ#TV ⊢ M : Α    :- atom(Α), not(member(Α, TV)),
                   member(X : Τ, Γ),
                   % deconstruct(-Ρs, -Α, +Τ)
                   deconstruct(Ρs, Α, Τ),
                   Γ#[Α | TV] ⊩ Ns : Ρs,
                   % whenAppliedEquals(+X, +Ns, -M)
                   whenAppliedEquals(X, Ns, M).
                

% Τ е функционален тип
Γ#TV ⊢ M : Τ    :- functional(Τ),
                   % deconstruct(-Ρs, -Σ, +Τ)
                   deconstruct(Ρs, Σ, Τ),
                   % extendContext(+Γ, -Xs, +Ρs, -Γ1)
                   extendContext(Γ, Xs, Ρs, Γ1),
                   Γ1#TV ⊢ N : Σ,
                   % whenAbstractedEquals(+Xs, +N, -M)
                   whenAbstractedEquals(Xs, N, M).


⊢ M : Τ             :- []#[] ⊢ M : Τ.

i(λ(x,x)).
ti(α ⇒ α).

k(λ(x,λ(y,x))).
tk(α ⇒ β ⇒ α).

s(λ(x,λ(y,λ(z,x@z@(y@z))))).
ts((α ⇒ β ⇒ γ) ⇒ (α ⇒ β) ⇒ α ⇒ γ).

c0(λ(f,λ(x,x))).
c1(λ(f,λ(x,f@x))).
c2(λ(f,λ(x,f@(f@x)))).
tc((α ⇒ α) ⇒ α ⇒ α).

w(λ(x,x@x)).
omega(W@W) :- w(W).

