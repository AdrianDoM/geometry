import topology.metric_space.basic
import topology.algebra.uniform_group
import topology.algebra.uniform_mul_action
import topology.algebra.ring.basic
import topology.algebra.star
import topology.algebra.order.field
import ring_theory.subring.basic
import group_theory.archimedean
import algebra.order.group.bounds
import algebra.periodic
import topology.instances.int

import tactic

noncomputable theory
open classical filter int metric set topological_space
open_locale classical topology filter uniformity interval
open_locale big_operators
open finset

--universes u v w
--variables {α : Type u} {β : Type v} {γ : Type w}
--instance : noncompact_space ℝ := int.closed_embedding_coe_real.noncompact_space

variable n : ℕ 

-- define ℝ^n as a topological space
def R (n : ℕ) : Type := { f : ℕ → ℝ // ∀ i : ℕ, i > n → f i = 0 }

instance : topological_space (R n) := subtype.topological_space

def simplex (n : ℕ) : Type := 
{f : ℕ → ℝ // ∑ j in finset.range (n+1), f j = 1 ∧ ∀ i : ℕ, (i > n → f i = 0) ∧ f i ≥ 0}

instance : topological_space (simplex n) := subtype.topological_space

instance : has_coe (simplex n) (R n) :=
⟨λ x, ⟨x.val, 
begin
  intros i hi,
  exact (x.property.right i).left hi,
end⟩⟩

def shift (n : ℕ) (f : ℕ → ℝ) : ℕ → ℝ := 
λ i, if i < n then f i else if n = i then 0 else f (i-1)



variables (f : (simplex n) → ℝ) (h : continuous f)

#check Pi.topological_space
#check subtype.topological_space