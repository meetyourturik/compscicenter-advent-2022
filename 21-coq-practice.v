Inductive nat : Type :=
  | O : nat
  | S : nat -> nat.
  
Fixpoint add (m n : nat) : nat :=
  match m with
  | O => n
  | S m' => S(add m' n)
  end.

Notation "m + n" := (add m n).

Fixpoint mul (m n : nat) : nat :=
  match m with
  | O => O
  | S m' => n + mul m' n
  end.

Notation "m * n" := (mul m n).


Lemma addA : forall m n p : nat, (m + n) + p = m + (n + p).
Proof.
  intros m n p.
  induction m as [ | m' IHm ].
  - reflexivity.
  - simpl. rewrite IHm. reflexivity.
Qed.

Lemma addn0 : forall n: nat, n + O = n.
Proof.
  intros n.
  induction n.
  - reflexivity.
  - simpl. rewrite IHn. reflexivity.
Qed.

Lemma addnS : forall m n : nat, m + S n = S (m + n).
Proof.
  intros m n.
  induction m.
  - reflexivity.
  - simpl. rewrite IHm. reflexivity.  
Qed.

Lemma addC : forall m n : nat, m + n = n + m.
Proof.
  intros m n.
  induction m.
  - simpl. rewrite addn0. reflexivity.
  - simpl. rewrite addnS. rewrite <- IHm. reflexivity.
Qed.

Lemma addAC : forall m n p : nat, m + (n + p) = n + (m + p).
Proof.
  intros m n p.
  rewrite <- addA.
  rewrite (addC m n).
  rewrite addA.
  reflexivity.
Qed.

(* вспомогательные леммы для умножения *)
Lemma muln0 : forall n : nat, n * O = O.
Proof.
  intros n.
  induction n.
  - reflexivity.
  - simpl. rewrite IHn. reflexivity.
Qed.

Lemma mulD1: forall m n : nat, m * (S n) = m * n + m.
Proof.
  intros m n.
  induction m.
  - reflexivity.
  - simpl. rewrite IHm. rewrite <- addA. rewrite addnS. reflexivity.
Qed.

Lemma mulD: forall m n p: nat, m * (n + p) = m * n + m * p.
Proof.
  intros m n p.
  induction m.
  - reflexivity. 
  - simpl. rewrite <- addA. rewrite addC. rewrite (addC n (m * n)). 
  rewrite (addA (m * n) n). rewrite (addC (m * n) (n + p)). rewrite IHm.
  rewrite (addC (m * n + m * p) (n + p)). rewrite (addA (n + p)). reflexivity.
Qed.

(* что требовалось доказать*)
Lemma mulC : forall m n : nat,
  m * n = n * m.
Proof.
  intros m n.
  induction m.
  - simpl. rewrite muln0. reflexivity.
  - simpl. rewrite IHm. rewrite mulD1. rewrite addC. reflexivity.
Qed.

Lemma mulA : forall m n p : nat,
  (m * n) * p = m * (n * p).
Proof.
  intros m n p.
  induction m.
  - reflexivity.
  - simpl. rewrite mulC. rewrite mulD. 
  rewrite  mulC. rewrite (mulC p (m * n)). 
  rewrite IHm. reflexivity.
Qed.