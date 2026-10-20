# Consequential design choices

Use this reference for the design-choice subsection of Section 07. Select choices
whose alternatives could change the result, interpretation, cost, or ability to
reproduce the paper. Do not enumerate every implementation setting or fill a quota.

## Reconstruct the choice, not an invented history

For each selected choice, record:

- **Problem and choice:** the constraint or uncertainty being addressed, and what
  the paper actually selected: an assumption, representation, objective, data or
  sample selection, measurement, control, comparison, or validation setting.
- **Rationale and origin:** cite an explicit author explanation as `[Paper]`. If
  no rationale is given, say so; any plausible explanation is `[Analysis]` with
  its reasoning and source basis. Do not infer that the authors tried, rejected,
  or even considered an alternative unless the source says they did.
- **Feasible alternative:** address the same problem under stated information and
  resource constraints. Cite a sourced alternative; label an analyst-proposed one
  `[Analysis]` or `[Hypothesis]`. If feasibility is unknown, name the missing
  prerequisite instead of presenting it as ready.
- **Consequence and evidence:** distinguish a reported ablation or comparison from
  an expected trade-off. State which evidence discriminates between choices, or
  what comparison is missing. A successful full system does not isolate the
  contribution of one choice; an untested alternative is not an improvement.
- **Source pointer:** use the active locator mode. A design ID is an internal
  cross-reference, not a replacement for a page, section, figure, or block pointer.

Use compact IDs such as `D01` when cross-referencing the choices. Keep supplied
IDs stable. The schema in [card-schema.md](card-schema.md) provides a suggested
table; use concise prose if a table would obscure the reasoning.

## Connect to the existing card

- Section 07 explains the choice and its rationale.
- Section 08 describes what the components do and refers back to the relevant
  choice instead of repeating its justification.
- Section 10 supplies the comparison and observed evidence.
- Section 16 can turn a consequential unresolved comparison into a validation
  action under [research-idea-gates.md](research-idea-gates.md).

Select choices appropriate to the paper type. A theory paper may turn on an
assumption or proof strategy; a review may turn on eligibility criteria or the
synthesis method. Do not invent modules, ablations, or experimental data for them.

For partial sources, distinguish a visible choice with an unstated rationale from
a choice that cannot be assessed at all. Mark unseen decisions `Not assessable`
and prioritize the specific missing material. Respect requests to omit research
extensions while retaining the paper's actual design analysis.
