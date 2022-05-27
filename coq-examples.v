Section Test.
  Check 0.
  Check nat.
  Check Set.
  Check Type.
  Variable n : nat.
  Check n.
  Check n > 0.
  Check Prop.
  Check bool.
  Variable A : Prop.
  Check A.
  Check gt.
  Check gt n 0.
End Test.

Section Calculations.
  Definition one := S 0.
  Check one.
  Definition three := S (S one).
  Definition double (n:nat) := plus n n.
  Check plus.
  Check plus 0 0.
  Check double.
  Print one.
  Print three.
  Print double.
  Print gt.
  Check forall m:nat, m > 0.
  Check exists m:nat, m > 0.
  Compute three.
  Compute double three.
  Compute double (double 15).
End Calculations.

Section PropLog.
  Variable A B C : Prop.
  Goal A -> A.
  intro u.
  apply u.
  Save Identity.
  Print Identity.
  
  Lemma K : (A -> B -> A).
    intros u v.
    apply u.
  Qed.
  Check K.
  
  Lemma S : (A -> B -> C) -> (A -> B) -> A -> C.
    intros.
    apply H; [ assumption | apply H0; assumption ].
  Qed.
  
  Lemma Conjunction_is_commutative : A /\ B -> B /\ A.
    intros.
    split; [ apply H | apply H ].
  Qed.
  
  Lemma A_implies_not_not_A : A -> ~~A.
    tauto.
  Qed.
  
  Lemma Disjunction_elimination : (A -> C) -> (B -> C) -> A \/ B -> C.
    intros.
    elim H1; [ assumption | assumption ].
  Qed.
  
  Lemma Conjunction_implies_Disjunction : A /\ B -> A \/ B.
    intro.
    left.
    apply H.
  Qed.
  
  Hypothesis Stab : forall (A : Prop), ~~A -> A.
  
  Lemma Excluded_middle : A \/ ~A.
    apply Stab.
    intro u.
    apply u.
    left.
    apply Stab.
    intro v.
    apply u.
    right.
    assumption.
  Qed.
End PropLog.

Section PredLog.
  Variables x y : nat.
  Variable p : nat -> Prop.
  
  Lemma All_implies_exists : (forall x, p x) -> exists x, p x.
    intro.
    exists y.
    apply H.
  Qed.
  
  Variable B : Prop.
  
  Lemma Ex_elim_axiom : (forall x, p x -> B) -> (exists x, p x) -> B.
    intros.
    elim H0.
    apply H.
  Qed.
  
  Hypothesis Stab : forall A : Prop, ~~A -> A.
  
  (* Lemma Drinker_formula : exists x, p x -> forall x, p x. *)
End PredLog.
