---
name: cmc5-svpwm-engineering
description: Audit, reproduce, compare, package, and troubleshoot paired Vivado SVPWM projects with a fixed-carrier baseline and a chaos-modulated variant. Use for FPGA motor-control engineering packages, BIT/source traceability, timing-resource comparison, build verification, oscilloscope/FFT test planning, and safe board bring-up.
---

# CMC5 SVPWM Engineering

Use this skill to turn a pair of Vivado SVPWM implementations into an evidence-backed, reproducible engineering package. Treat the fixed-carrier version as the baseline and the chaos-modulated version as the experimental variant.

## Required outcome

Produce or verify:

- complete RTL, constraints, simulation, project, BIT, and implementation reports;
- an exact mapping from each BIT to its source project using SHA-256;
- a normal-versus-chaos comparison using the same electrical frequency, modulation, deadtime, top-level interface, and pin constraints;
- reproducible build and verification commands;
- a clear separation between simulation evidence, Vivado implementation evidence, and physical-board measurements;
- hardware safety notes appropriate to automatic-start motor-control images.

## Workflow

1. Preserve the supplied files. Never reconstruct or overwrite a project solely from a BIT file.
2. Inventory both variants and identify the target part, top module, XPR, RTL, XDC, testbench, BIT, timing report, utilization report, DRC report, and build scripts.
3. Confirm that the comparison changes only the intended chaos mechanism. Record every other configuration difference.
4. Run [scripts/verify-project.ps1](scripts/verify-project.ps1) on each variant. Supply the expected BIT hash when traceability matters.
5. When Vivado is available, run the project-provided simulation and batch build. Record the exact Vivado version and command.
6. Use [scripts/compare-vivado-reports.ps1](scripts/compare-vivado-reports.ps1) to extract WNS, TNS, LUT, register, BRAM, and DSP data.
7. Use [scripts/make-manifest.ps1](scripts/make-manifest.ps1) to generate a stable SHA-256 manifest for delivery.
8. Package the two variants separately inside one parent engineering package. Keep names unambiguous and include a root README.

## Evidence rules

- A matching filename is not proof that a BIT came from a project; use a stored hash or regenerate it.
- A successful synthesis is not proof of timing closure; require implementation timing data.
- A rendered waveform or FFT screenshot is not proof of motor behavior; document probe point, ground reference, sample rate, span, window, averaging, bus voltage, current limit, and load.
- Do not claim that chaotic modulation fixes an electrical fault. It may redistribute switching-spectrum energy, but it does not remove copper loss, phase lag, saturation, missing phases, incorrect drive polarity, or insufficient bus voltage.
- Do not infer driver input polarity or 3-PWM/6-PWM mode from prior boards. Re-check the exact driver manual or schematic.

## Hardware boundary

Automatic-start BIT files can assert enable and PWM immediately after configuration. Require motor power to be disconnected during programming and wiring changes. Never treat FPGA weak pulls as a hardware shutdown circuit. Stop if the driver voltage compatibility, enable polarity, PWM mode, common ground, or current protection is unknown.

Read [references/hardware-safety.md](references/hardware-safety.md) before proposing a board test or programming sequence.

## Task routing

- For reusable prompts and interaction workflows, read [references/prompt-workflows.md](references/prompt-workflows.md).
- For project specifications, test records, and final-report structures, read [references/case-templates.md](references/case-templates.md).
- For common Vivado, waveform, FFT, current, and motor faults, read [references/troubleshooting.md](references/troubleshooting.md).
- For the verified AX7020 CMC5 example and measured implementation facts, read [references/cmc5-case-study.md](references/cmc5-case-study.md).
- For release packaging and contest submission, read [references/release-checklist.md](references/release-checklist.md).

## Failure conditions

Report the skill as blocked or incomplete when:

- only BIT files are available and the requested source-level conclusion cannot be proven;
- the target board or driver is ambiguous;
- the XDC does not match the stated connector wiring;
- implementation reports are missing or timing fails;
- the comparison changes multiple control parameters without documenting them;
- the requested physical test lacks a safe shutdown path or independent current protection;
- the claimed performance improvement has no reproducible raw data.
