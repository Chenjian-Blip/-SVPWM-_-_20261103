# Troubleshooting

## No PWM at the expected pin

Trigger: oscilloscope shows no transitions.

1. Verify that the loaded BIT hash matches the intended project.
2. Check the actual FPGA ball and connector pin in the XDC and board schematic.
3. Confirm the board clock pin and frequency.
4. Check reset, startup delay, arm state, enable state, and whether the design requires VIO.
5. Probe the FPGA pin before the driver input.
6. If the project was moved, rebuild from the Tcl script instead of trusting stale run data.

## A phase reads as a stable voltage

Trigger: a multimeter or slow acquisition shows a constant phase voltage, such as several volts.

PWM can average to a stable value. Use an oscilloscope at the FPGA PWM pin and driver logic input. For bridge output measurements, use a suitable differential method and compare phase-to-phase voltage. Do not conclude “no PWM” from a DC multimeter reading alone.

## Low supply current and motor does not rotate

Trigger: current remains low and the rotor is still or only twitches.

Check EN polarity, PWM polarity, 3-PWM/6-PWM mode, common ground, phase order, driver fault state, modulation, electrical frequency, load, and supply current limit. Low bus current may mean the bridge is disabled or the rotating field does not produce sustained torque. Do not raise modulation until logic mode and phase outputs are verified.

## Strong vibration or motion over only part of a revolution

Trigger: rotor oscillates, reverses, or moves through a limited angle.

Possible causes include open-loop loss of synchronism, incorrect phase order, too-low starting torque, unsuitable electrical frequency, motor pole-pair assumptions, driver mode mismatch, or missing position feedback. Chaotic carrier variation is not a substitute for an open-loop startup ramp or closed-loop commutation.

## Driver damage after running

Trigger: board fails after a period of operation.

Disconnect all power. Inspect for shoot-through caused by polarity/mode mismatch, inadequate deadtime, unsafe automatic enable, probe-ground shorts, overvoltage, insufficient current protection, thermal overload, or damaged gate-driver/MOSFET parts. Do not reconnect the FPGA until the driver input pins are checked for unsafe voltage.

## Normal and chaos FFT look similar

Trigger: both spectra show a broad or continuous-looking region.

Use identical probe point, sample rate, record length, window, span, RBW, averaging and amplitude scale. Disable display persistence while comparing. Ensure the acquisition includes enough switching cycles and does not alias the carrier. A PWM waveform already contains many harmonics; broad spectra alone do not prove chaos. Compare carrier-period statistics and integrated band power as well as screenshots.

## BIT parameters cannot be identified

Trigger: only a BIT is supplied.

A BIT may confirm device compatibility and has a hash, but it does not reliably reveal the original Verilog, parameter names, comments, project paths or design intent. Locate the matching project by hash against known outputs or regenerate from candidate source projects.

## Vivado project does not open or rebuild

Trigger: missing sources, locked IP, absolute paths, or version errors.

Check Vivado version, target part, source path relativity, IP upgrade status, and Tcl scripts. If a path containing non-ASCII characters causes a tool-specific issue, copy the project to a short ASCII path and document the workaround. Recreate generated directories rather than editing cached run files.

## Hash mismatch

Trigger: a delivered BIT or source file hash differs from the manifest.

Treat it as a different version. Do not relabel the file. Rebuild, regenerate the manifest, and explain exactly what changed.
