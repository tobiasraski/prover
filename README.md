Sequent calculus prover for propositional logic
======

[wikipedia](http://en.wikipedia.org/wiki/Sequent_calculus)

Give the program (Prover.rb) a sequent of the form 

proposition, proposition, ... : proposition

and it will try to prove that the proposition to the right of ":"
follows from the left hand propositions using the inference rules
of sequent calculus.

The propositions should be put in using reverse polish notation, e.g
a b ->
for "a implies b"

Propositions can be built from atoms (e.g a, b, p, q, ...), implication ( -> )
and Falsity (F).
The other binary operators can be built using these. e.g

"a F -> F -> b ->"  is the same as "a or b"
