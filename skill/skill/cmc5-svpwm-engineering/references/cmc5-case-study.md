# CMC5 AX7020 case study

This case records verified implementation facts from one paired project. It is an example, not a universal configuration.

## Common configuration

- FPGA board: AX7020
- part: XC7Z020CLG400-2
- system clock: 50 MHz
- electrical frequency: 3 Hz
- modulation: 8%, Q15 value 2621
- deadtime: 2 us
- startup: automatic after configuration delay

## Variant configuration

- baseline carrier: fixed 10 kHz
- chaos carrier: Lorenz-mapped, bounded to approximately 4-16 kHz

## Traceability

- chaos BIT SHA-256: 7A9666C37AEEEA88395DB599DA4D047E941CF0DAB52F3EEBC56D59D35114AE2D
- baseline BIT SHA-256: 31D4E1C72FB8A98FCD4BAC930D90092FF04D709F14B0580FA7E5E48500080DFF

## Vivado implementation results

| Metric | Chaos | Baseline |
|---|---:|---:|
| Slice LUT | 1142 | 384 |
| Slice register | 520 | 196 |
| Block RAM tile | 0 | 0 |
| DSP48E1 | 19 | 7 |
| WNS | 4.290 ns | 8.469 ns |
| TNS | 0 ns | 0 ns |
| Timing | met | met |

The chaos variant costs additional arithmetic resources and reduces timing margin, but both versions met the implementation timing constraints in the stored reports.

## Observed engineering lessons

- Active-level assumptions and 3-PWM/6-PWM mode must come from the exact driver documentation.
- A DC voltage reading on a motor phase can be the average of PWM.
- Low input current does not prove that the PWM algorithm is correct.
- Open-loop low-speed operation can vibrate even without chaos.
- Ordinary PWM already has harmonics; FFT settings can make normal and chaos spectra appear similarly broad.
- Automatic-start BIT files require the motor bus to be disconnected while programming.
- A BIT should be linked to source by SHA-256, not filename alone.
