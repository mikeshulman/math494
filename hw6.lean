/- I hope that in Math 260/262 (or elsewhere) you have encountered the notion of "equivalence relation".  In dependent type theory, a "relation" is a two-variable predicate, i.e. a function X → X → Prop.  -/

-- Here is a structure that represents an "isomorphism" or "bijection" between two types.
structure iso (X Y : Type) :=
  (to : X → Y)
  (fro : Y → X)
  (to_fro : ∀(y : Y), to (fro y) = y)
  (fro_to : ∀(x : X), fro (to x) = x)

-- This allows us to use the infix notation ≅ for isomorphisms (type it as \~=).
notation X ` ≅ ` Y := iso X Y

-- Define a function that reverses the direction of an isomorphism.
def inverse_iso {X Y : Type} (f : X ≅ Y) : Y ≅ X := sorry

-- Define a function that composes two isomorphisms.  Here's a hint: you can use "begin...end" *anywhere* that Lean expects to see an expression, to drop into tactic mode to construct the necesary term.
def compose_iso {X Y Z : Type} (f : X ≅ Y) (g : Y ≅ Z) : X ≅ Z :=
  { to := sorry,
    fro := sorry,
    to_fro := begin
      sorry
    end,
    fro_to := begin
      sorry
    end,
  }

-- Boolean negation is called "bnot":
#check bnot
-- Show that this function is an isomorphism.
def bnot_iso : bool ≅ bool := sorry

-- Define a typeclass parametrized by a type X, consisting of an equivalence relation on X.
class eqr (X : Type) :=
  (equiv : X → X → Prop)
  -- Add the types of the following fields.
  (refl : sorry)
  (symm : sorry)
  (trans : sorry)

open eqr

-- With your definition, the following proof should compile, showing that the relation of "equality" on any type is an equivalence relation.
def eq_is_eqr (X : Type) : eqr X :=
  { equiv := λ (x y : X), x = y,
    refl := eq.refl,
    symm := @eq.symm X,
    trans := @eq.trans X,
  }

-- This lets us use the infix notation ~ for any equivalence relation.
notation x ` ~ ` y := equiv x y

-- Two propositions are logically equivalent, P ↔ Q (type it as \iff), if each implies the other.  This could be just defined as
--   def iff (P Q : Prop) : Prop := (P → Q) ∧ (Q → P)
-- but Lean prefers to make it a structure, as follows:
/-
structure iff (P Q : Prop) : Prop :=
  (mp : P → Q)
  (mpr : Q → P)
notation P ` ↔ ` Q := iff P Q
-/
-- The name "mp" stands for "modus ponens", and "mpr" for "modus ponens reversed".

-- Prove that logical equivalence is an equivalence relation on Prop.
instance eqr_iff : eqr Prop := sorry

-- The equivalence class of an element.  This notation "{ ... // ... }" is a version of the Σ-type that acts on a family of Props rather than a family of Types; it is an analogue in type theory of the "set-builder" notation for subsets in set theory.
def equiv_class {X : Type} [eqr X] (x : X) : Type :=
  { y : X // x ~ y }

-- Prove that if x ~ y, then their equivalence classes are isomorphic.
def iso_eqc {X : Type} [eqr X] (x y : X) (xy : x ~ y) :
  equiv_class x ≅ equiv_class y :=
begin
  -- Here is a useful trick.  We can construct an isomorphism starting with the tactic "constructor", but for some reason that reorders the goals in a funny way so that to_fro and fro_to come first.  Now the tactic "constructor" is equivalent to "apply iso.mk", where "iso.mk" is the constructor of the structure "iso" (if we don't explicitly name the constructor of a structure, it is automatically called "mk").  And there is a variant of "apply" called "fapply" that keeps the goals in the right order, so we can say:
  fapply iso.mk,
  -- (The Lean standard library also includes a tactic called "fconstructor" that does this directly, but you may not have that library installed.)
  -- In what follows, you may also want to "fapply subtype.mk", where "subtype" is the Σ-like type denoted by the notation { ... // ... }.
  sorry, sorry, sorry, sorry
end
