import tactic

open set

def evens : set ℕ := { x : ℕ | x % 2 = 0}
def odds : set ℕ := { x : ℕ | x % 2 = 1}

def inter_evens_odds : evens ∩ odds = ∅ :=
begin
  simp only [inter_def],
  ext,
  split,
  intros h,
  simp [evens, odds] at h,
  cases h with he ho,
  exfalso,
  have e : 0 = 1,
  exact calc 0 = x % 2 : eq.symm he
           ... = 1 : ho,
  /-
  rw ←he,
  nth_rewrite 1 ←ho,
  -/
  contradiction,
  simp,
end

def union_evens_odds : evens ∪ odds = univ :=
begin
  simp only [union_def, evens, odds],
  ext,
  split,
  intros, trivial,
  intros h,
  simp,
  library_search,
end

#print even
#check nat.even_iff
#print odd
#check nat.odd_iff

variable {A : Type}
variables (R S T : set A)

#check @and_or_distrib_left

def inter_union_distrib : S ∩ (T ∪ R) = (S ∩ T) ∪ (S ∩ R) :=
begin
  ext,
  simp,
  apply and_or_distrib_left,
end

def inter_func (h : S ⊆ T) : S ∩ R ⊆ T ∩ R :=
begin
  simp only [subset_def, inter_def],
  simp only [subset_def] at h,
  rintros x ⟨ xs, xr ⟩,
  exact ⟨h _ xs, xr⟩,
end

#print \

def cmpl_inter : S ∩ (T \ S) = ∅ :=
begin
  simp only [inter_def],
  dsimp,
  ext,
  dsimp,
  split,
  simp,
  intros h1 h2 h3,
  contradiction,
  intros,
  contradiction
end

variable {B : Type}
variable f : A → B
open function

def preim_im : S ⊆ f ⁻¹' (f '' S) :=
begin
  intros x xs,
  simp,
  use x,
  split,
  assumption,
  refl
end

def preim_im' (finj : injective f) : f ⁻¹' (f '' S) ⊆ S :=
begin
  intros x,
  /-
  dsimp,
  intros h,
  cases h with y h,
  cases h with h1 h2,
  -/
  simp,
  intros y h1 h2,
  --
  have e := finj h2,
  rw ←e,
  assumption
end

example : f '' (f⁻¹' u) ⊆ u :=
sorry

example (h : surjective f) : u ⊆ f '' (f⁻¹' u) :=
sorry
