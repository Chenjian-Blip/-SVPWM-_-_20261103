# Case templates

## 项目规格模板

~~~markdown
# Project specification

- project name:
- baseline project:
- experimental project:
- Vivado version:
- FPGA board:
- FPGA part:
- top module:
- system clock:
- motor driver:
- PWM mode:
- enable polarity source:
- PWM polarity source:
- electrical frequency:
- modulation:
- carrier strategy:
- deadtime:
- auto-start:
- expected BIT SHA-256:
- known limitations:
~~~

## 实板测试记录模板

~~~markdown
# Board test record

- date and operator:
- FPGA BIT and SHA-256:
- board and driver revision:
- motor:
- DC bus voltage:
- current limit:
- load:
- probe model and attenuation:
- probe point:
- ground reference:
- oscilloscope sample rate:
- timebase and record length:
- FFT span, window, RBW, averaging:
- observed waveform:
- observed current:
- observed motor state:
- shutdown condition:
- raw data path:
- photo/video path:
- conclusion and uncertainty:
~~~

## 普通版与混沌版报告模板

~~~markdown
# Baseline versus chaos report

## Controlled variables

| Item | Baseline | Chaos | Equal? |
|---|---|---|---|
| Electrical frequency | | | |
| Modulation | | | |
| Deadtime | | | |
| Pin constraints | | | |
| Driver mode | | | |
| Test setup | | | |

## Implementation

| Metric | Baseline | Chaos | Difference |
|---|---:|---:|---:|
| LUT | | | |
| Register | | | |
| BRAM | | | |
| DSP | | | |
| WNS | | | |
| TNS | | | |

## Measured results

Include raw-data links and instrument settings. Separate measured facts from interpretation.

## Limitations

List missing feedback, current protection, load conditions, sample size, and any parameter differences.
~~~
