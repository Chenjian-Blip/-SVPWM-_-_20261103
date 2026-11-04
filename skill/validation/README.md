# Validation record

## Skill structure

- Validator: skill-creator quick_validate.py
- Result: Skill is valid

## Project verification script

The verify-project.ps1 script was run against both packaged AX7020 projects.

- chaos project: passed
- baseline project: passed
- chaos BIT SHA-256 matched the expected value
- baseline BIT SHA-256 matched the expected value
- XPR, RTL, XDC, simulation, BIT, timing, utilization, and DRC files were detected

Detailed JSON results are stored in:

- chaos-project-check.json
- baseline-project-check.json

## Vivado report comparison script

The compare-vivado-reports.ps1 script was run against the stored implementation reports. It extracted:

- baseline: 384 LUT, 196 registers, 0 BRAM, 7 DSP, WNS 8.469 ns, TNS 0 ns
- chaos: 1142 LUT, 520 registers, 0 BRAM, 19 DSP, WNS 4.290 ns, TNS 0 ns
- timing met for both variants

The generated table is stored in vivado-comparison.md.

## Scope

This validation proves that the skill files are structurally valid and that the scripts work on the supplied Vivado reports and project layout. It does not replace a fresh Vivado rebuild or a new physical-board test.
