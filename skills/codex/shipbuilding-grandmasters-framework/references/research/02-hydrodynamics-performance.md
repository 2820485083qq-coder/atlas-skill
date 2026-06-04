# 02-hydrodynamics-performance

Purpose: collect resistance, propulsion, seakeeping, planing, and model-test frameworks.

## SNAME Principles of Naval Architecture: resistance and flow

Source: SNAME, Principles of Naval Architecture
URL: https://sname.org/principles-naval-architecture
Reliability: official professional society source.

Key extraction:
- PNA is described by SNAME as the defining reference work and text for naval architecture.
- The Ship Resistance & Flow volume aims at accurate resistance prediction for hull geometry.
- It connects basic flow phenomena with model testing, empirical methods, computational methods, and hull-form design guidance.
- It treats wave and viscous effects and stern wake as important for both resistance and propeller performance.

Distilled principle:
- Resistance review must cover mechanisms, prediction method, and design guidance together.
- A hull-performance claim is weak if it omits stern wake and propeller interaction.

## Holtrop and Mennen: approximate power prediction

Source: Sage / International Shipbuilding Progress, "An approximate power prediction method"
URL: https://journals.sagepub.com/doi/10.3233/ISP-1982-2933501
Reliability: journal record.

Key extraction:
- Paper: J. Holtrop and G.G.J. Mennen, International Shipbuilding Progress, volume 29, issue 335, pages 166-170, first published July 1, 1982.
- Authors affiliated with Netherlands Ship Model Basin / MARIN.

Distilled principle:
- Statistical or empirical power prediction is a first-pass estimate, not a proof. It is valuable when hull type and parameter range match the calibration database.

Use in final skill:
- Add method-domain check: hull type, Froude number range, block coefficient, L/B, B/T, appendages, propulsion arrangement.

## Savitsky: planing hull dynamic equilibrium

Source: CiNii record for "Hydrodynamic Design of Planing Hulls"
URL: https://cir.nii.ac.jp/crid/1360861295038811520
Reliability: bibliographic record with abstract and DOI.

Key extraction:
- Daniel Savitsky, Marine Technology and SNAME News, 1964.
- The paper discusses hydrodynamic characteristics of prismatic planing surfaces.
- It gives empirical equations for lift, drag, wetted area, center of pressure, and porpoising stability limits as functions of speed, trim, deadrise angle, and loading.
- It combines these into procedures for horsepower, running trim, draft, and porpoising stability.

Distilled principle:
- Regime matters. Displacement, semi-displacement, and planing craft use different dominant physics.
- For high-speed craft, dynamic trim, wetted length, deadrise, and porpoising are not secondary details.

## Delft systematic yacht hull series

Source: Sage / International Shipbuilding Progress, Gerritsma, Onnink, Versluis, 1981
URL: https://journals.sagepub.com/doi/10.3233/ISP-1981-2832801
Reliability: journal record.

Key extraction:
- Resistance and stability were determined for 22 systematically varied yacht hull forms.
- Results were given in a form usable for sailing yacht design and velocity prediction.

Distilled principle:
- A reliable design family has systematic variation and experimental grounding.
- Do not extrapolate a series outside its hull-form family.

## ITTC resistance-test procedures

Source: ITTC Recommended Procedures and Guidelines, Resistance Test
URL: https://ittc.info/media/9595/75-02-02-01.pdf
Reliability: official ITTC procedure.

Key extraction:
- ITTC procedure 7.5-02-02-01, Resistance Test, effective 2021, revision 05.
- It is part of ITTC Quality System Manual and Testing and Extrapolation Methods.
- ITTC notes procedures are checked regularly and should be used in latest version.

Distilled principle:
- Model-test data without procedure, uncertainty, and extrapolation method is not strong evidence.

Use in final skill:
- Add evidence hierarchy: official procedure/model test with uncertainty > validated CFD > empirical method in range > unsupported estimate.

