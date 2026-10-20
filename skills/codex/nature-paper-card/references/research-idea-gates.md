# Research idea gates

Apply all gates before including an idea in Section 16.

## 1. Traceability gate

Tie the idea to a specific limitation, failure case, assumption, contradiction, or unexplained result. Include its source pointer.

## 2. Hypothesis gate

State a proposition that could be false. Reject vague ideas such as "improve efficiency" or "use a larger model".

## 3. Delta gate

State exactly what changes relative to the paper:

- representation;
- mechanism;
- data;
- objective;
- feedback;
- evaluation;
- deployment constraint.

## 4. Validation gate

Specify:

- comparison;
- controlled variables;
- metric;
- dataset or population;
- expected observation;
- falsifying result;
- compute or experimental budget when relevant.

## 5. Failure gate

Give at least two plausible reasons the idea may fail. Include attribution error, confounding, instability, cost, data scarcity, or invalid assumptions when applicable.

## 6. Novelty-language gate

Use:

- `candidate idea`;
- `hypothesis`;
- `possible extension`;
- `prior-art search required`.

Do not use `novel`, `first`, `unexplored`, or a numeric innovation score unless a dedicated prior-art search has been performed and cited.

## From candidates to next-step validation

For a full Paper Card, follow the candidates with a compact validation plan inside
Section 16, unless the user excludes extensions or planning. Plan only grounded,
useful actions; there is no required number of candidates or stages. If none pass
the gates, name the missing evidence and make obtaining or checking it the first
action. Do not invent a research direction to complete the template.

### Choose the first useful check

Rank actions by which consequential uncertainty they resolve, the prerequisites,
and the resource cost. Prefer the smallest informative comparison or analysis
before a broad experiment matrix. Explain why it comes first. Reuse known user
goals, data, budget, and stop conditions; when these are unknown, state the few
adaptation assumptions that affect feasibility rather than inventing a project.

An action can be an evidence check, reanalysis, theoretical counterexample,
baseline reproduction, or controlled experiment. Choose the type that addresses
the paper's actual claim. A plan is not evidence that its work has been completed.

### Make each substantive action reviewable

Use action IDs such as `A01` when dependencies need cross-references. Include:

- **Grounding:** the originating observation, design choice, or evidence gap,
  with a source pointer and any existing candidate or `D` ID. Distinguish an
  author-proposed extension from an Agent proposal.
- **Question:** the hypothesis or explicitly exploratory uncertainty being tested.
- **Procedure and comparison:** the required data, measurements, analysis, or
  implementation; baseline or control; controlled variables; and evaluation
  setting. Keep information access, task tolerance, and resource accounting
  comparable where relevant. Explain material differences rather than assuming
  an alternative has the same inputs or budget.
- **Decision evidence:** the metric or observation, an outcome that would support
  the direction, and an outcome that would weaken or falsify it. Include an
  unresolved outcome when the available measurement or uncertainty could be
  inconclusive. Do not treat a nonsignificant difference as proof of equivalence.
- **Feasibility and output:** available and missing resources, dependencies,
  expected cost when estimable, and a concrete deliverable such as a checked
  evidence table, comparison plot, counterexample, or experiment protocol.
- **Next decision:** what permits continuation, what stops or narrows the claim,
  and what additional evidence is needed when the result is inconclusive.

Unknown thresholds, sample sizes, budgets, and durations remain unknown until
estimated from stated evidence or a pilot. Specify how to estimate consequential
unknowns; do not invent improvement percentages, compute allocations, or dates.

### Stage around evidence

Make later actions conditional on earlier deliverables and decisions. A premise
check may justify a controlled test, and a successful controlled test may justify
broader validation; use only the stages the candidate needs. If the premise fails,
stop or narrow that candidate instead of automatically trying more variants.
Reading one paper does not establish novelty: identify any necessary prior-art
check before claiming a contribution, without forcing external search into a
user-requested source-only card.

Preserve evidence levels in transfer plans. For example, a simulation result may
motivate a physical test but cannot establish physical validity. A teaching demo,
proposed implementation, or prepared configuration is not completed reproduction.
Proposing actions does not itself authorize running experiments or scheduling work.

### Manual plan review

Check that the first action resolves the stated gap, its comparison can distinguish
the hypothesis from a plausible alternative, and its deliverable can support the
next decision under the stated resources. Use the card's existing provenance and
locator rules. The bundled auditor remains required, but it does not establish
the scientific merit, feasibility, or novelty of these plans.
