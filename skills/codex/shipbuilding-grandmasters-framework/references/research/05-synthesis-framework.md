# 05-synthesis-framework

Purpose: synthesize the collected theories into a practical judgement system for shipbuilding and naval architecture problems.

## Candidate mental models

### 1. Similarity before extrapolation

Grandmaster lineage: William Froude, David Taylor, ITTC.

Rule:
- Before extrapolating any model, CFD, empirical formula, or trial result, identify the nondimensional similarity and the correction terms.

Checks:
- Froude number, Reynolds number, cavitation number, advance coefficient, Strouhal frequency where relevant.
- Model-ship correlation allowance.
- Domain range of empirical method.
- Uncertainty and procedure used.

Failure mode:
- Treating a small model, a regression, or a CFD result as reality without scale-effect accounting.

### 2. Decompose the resistance and load mechanism

Grandmaster lineage: Froude, Michell, Newman, Larsson/Raven, Faltinsen.

Rule:
- Do not accept "resistance increased" or "load increased" as an explanation. Ask which component changed and by what mechanism.

Checks:
- Frictional, form, wave-making, appendage, air, roughness, added resistance in waves.
- Wake fraction, thrust deduction, hull efficiency, propeller open-water efficiency.
- Sea loads: wave excitation, added mass, damping, slamming, drift, resonance.

Failure mode:
- Using a single total coefficient to hide an unresolved physical cause.

### 3. Method validity is regime validity

Grandmaster lineage: Savitsky, Holtrop/Mennen, Delft Series, PNA.

Rule:
- A method is only strong inside its regime and calibration range.

Checks:
- Displacement/semi-displacement/planing.
- Low/medium/high speed.
- Monohull/multihull/yacht/offshore/special craft.
- Main dimensions and coefficients within series/database.

Failure mode:
- Applying Holtrop to a hull outside statistical range, Savitsky outside planing assumptions, or yacht series outside yacht geometry.

### 4. Stability is a curve and an operating envelope, not a single GM

Grandmaster lineage: IMO IS Code, PNA Stability.

Rule:
- Stability judgement must include loading conditions, GZ curve, free-surface effects, dynamic criteria, weather/wave influence, and operating restrictions.

Checks:
- Lightship data source, KG margin, loading conditions, tank free surfaces, downflooding points, intact/damage criteria.
- Whether the relevant IMO/class rules apply to the vessel type.

Failure mode:
- Declaring a ship stable because GM is positive.

### 5. Structure follows load path and failure mode

Grandmaster lineage: Hughes/Paik, PNA Strength, IACS CSR.

Rule:
- Structural review starts from load path and failure mode: hull girder, local panels, buckling, fatigue, ultimate strength, impact/slamming, vibration, corrosion, production defects.

Checks:
- Global and local loads.
- Boundary conditions and mesh quality for FEA.
- Fatigue hot spots and weld details.
- Rule minimum vs first-principles verification.

Failure mode:
- Treating class scantling compliance as sufficient for novel designs or high-risk loads.

### 6. Ship design is a coupled system, not a sequence of departments

Grandmaster lineage: Rawson/Tupper, Evans design spiral, modern systems engineering criticism.

Rule:
- Every design choice should be checked for second-order consequences across displacement, stability, resistance, propulsion, volume, structure, production, cost, and operation.

Checks:
- Mission profile and requirement traceability.
- Margins and growth allowance.
- Interface risks.
- Design spiral interactions and iteration status.

Failure mode:
- Optimizing hull resistance while breaking stability, structure, machinery arrangement, or cargo/mission function.

### 7. Rules are the floor, not the ceiling

Grandmaster lineage: IMO, IACS, SNAME.

Rule:
- Compliance is a necessary condition, not a sufficient condition for good engineering.

Checks:
- Latest applicable rules, vessel type, flag/class requirements.
- Explicit gap between rule minimum and operational robustness.
- Documentation for assumptions.

Failure mode:
- "It passes the rule" used to avoid first-principles risk analysis.

### 8. Carbon and lifecycle are now first-class constraints

Grandmaster lineage: IMO GHG Strategy, modern ship design.

Rule:
- A modern ship concept must be judged against fuel pathway, carbon intensity, operational profile, retrofit space, and lifecycle cost.

Checks:
- EEDI/EEXI/CII where applicable.
- Voyage profile, payload efficiency, speed-power curve, hotel load.
- Alternative fuel volume/weight/safety implications.

Failure mode:
- Adding green technology as a decorative retrofit without checking mission, volume, safety, and operations.

## Evaluation rubric

Use a 0-3 score for each gate:

- 0 = missing or unsupported.
- 1 = mentioned but not quantified.
- 2 = quantified with plausible method but weak validation or incomplete assumptions.
- 3 = quantified, method-domain valid, assumptions explicit, and supported by procedure/test/rule/source.

Gates:
1. Mission and operating profile.
2. Hydrostatics, loading, trim, and stability.
3. Resistance, propulsion, and speed-power evidence.
4. Seakeeping, manoeuvring, and dynamic loads.
5. Structural load path, fatigue, ultimate strength, and production feasibility.
6. Rule, class, flag, safety, and environmental compliance.
7. Lifecycle, maintainability, retrofit, and carbon pathway.
8. Evidence quality and uncertainty.

Interpretation:
- Any 0 in stability, structure, rule compliance, or evidence quality is a stop sign.
- A high total score with a low mission score means the design may be technically elegant but commercially/operationally wrong.
- A high compliance score with low physics score means it may pass a minimum rule but still be fragile.

