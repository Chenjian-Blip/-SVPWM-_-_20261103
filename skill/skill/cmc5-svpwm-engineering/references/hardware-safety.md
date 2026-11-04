# Hardware safety

## Trigger conditions

Read this reference whenever the task involves programming an FPGA connected to a motor driver, enabling PWM, changing wiring, or measuring a switching node.

## Pre-power checklist

1. Disconnect the motor-side DC bus before FPGA programming or rewiring.
2. Confirm the exact driver board and whether it expects 3-PWM or 6-PWM.
3. Confirm EN/SHDN and PWM active levels from the exact schematic/manual or a powered logic-side measurement.
4. Confirm FPGA IO is compatible with the driver input voltage and that no 5 V signal can return to the FPGA.
5. Connect logic grounds correctly. Do not use a grounded oscilloscope clip on a floating high-side switching node.
6. Start with an independently current-limited supply and a reachable hardware shutdown path.
7. Verify PWM and enable at the FPGA/driver logic input before connecting the motor bus.
8. For automatic-start BIT files, assume outputs become active immediately after configuration delay.

## Stop conditions

Stop the test immediately if:

- driver temperature rises abnormally;
- supply current jumps unexpectedly;
- phase outputs are simultaneously active in a way inconsistent with deadtime;
- the enable polarity is uncertain;
- the scope ground connection could short the bridge;
- the motor stalls while current rises;
- the driver reports a fault.

## Limits of the skill

The skill cannot certify electrical safety from HDL alone. Weak FPGA pull resistors are not a replacement for a hardwired shutdown. Open-loop SVPWM without current feedback cannot guarantee phase current.
