# Release checklist

## Repository structure

- [ ] Directory and file names use lowercase English letters, digits, underscores, or hyphens, except required standard files such as README.md and SKILL.md.
- [ ] Root README explains purpose, prerequisites, reproduction steps, and limitations.
- [ ] Source, simulation, build, board, data, skill, and report content is discoverable.
- [ ] The public repository has an approved open-source license.

## Reproducibility

- [ ] Vivado version and FPGA part are recorded.
- [ ] Build command and scripts are included.
- [ ] Source paths are relative or documented.
- [ ] Simulation and implementation can be rerun from a clean workspace.
- [ ] WNS, TNS, DRC, IO, utilization, and BIT outputs are present.
- [ ] SHA-256 manifest matches the delivered files.

## Comparison quality

- [ ] Baseline and chaos versions use controlled settings.
- [ ] All intentional differences are listed.
- [ ] Resource and timing metrics come from reports.
- [ ] Physical measurements use the same instrument configuration.
- [ ] Raw data is included or linked.

## Integrity

- [ ] No simulated result is labeled as physical measurement.
- [ ] No performance percentage is claimed without raw data.
- [ ] Third-party code, papers, and images are credited.
- [ ] AI collaboration records include prompts, answers, corrections, and adopted decisions.
- [ ] Known failure conditions and safety limits are disclosed.
