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
:- op(150, xfx, :).
:- op(140, xfy, ⇒).
:- op(130, yfx, @).

% [x:α, y:β]

% Γ ⊢ λ(x,x) : α ⇒ α.
% +Γ ⊢ +M : ?Τ.

Γ ⊢      X : Τ      :- member(X : Τ, Γ).

Γ ⊢ M1@M2  : Σ      :- Γ ⊢ M1 : Ρ ⇒ Σ,
                       Γ ⊢ M2 : Ρ.

Γ ⊢ λ(X,N) : Ρ ⇒ Σ  :- not(member(X:_, Γ)),
                       [X:Ρ|Γ] ⊢ N : Σ.

⊢ M : Τ             :- [] ⊢ M : Τ.

i(λ(x,x)).
ti(α ⇒ α).

k(λ(x,λ(y,x))).
tk(α ⇒ β ⇒ α).

s(λ(x,λ(y,λ(z,x@z@(y@z))))).

c0(λ(f,λ(x,x))).
c1(λ(f,λ(x,f@x))).
c2(λ(f,λ(x,f@(f@x)))).

w(λ(x,x@x)).
omega(W@W) :- w(W).
