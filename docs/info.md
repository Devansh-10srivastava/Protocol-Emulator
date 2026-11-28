<!---
Project datasheet. Updated as the design evolves.
-->

## How it works

Current version is a flow-proof placeholder: an 8-bit counter. On every rising clock edge the
counter increments by one and drives `uo_out[7:0]`. Holding `rst_n` low resets it to 0.
All bidirectional pins are inputs (`uio_oe = 0`).

The final design will be a programmable protocol engine: a small instruction set that drives and samples
pins with cycle-accurate timing, so that UART, SPI, I2C and other protocols run as firmware.

## How to test

1. Apply a clock on `clk` (up to 50 MHz).
2. Hold `rst_n` low for a few cycles, then release it.
3. `uo_out[7:0]` counts up by one per clock and wraps from 255 to 0.

## External hardware

None for the current version. The final design will use Pmods for protocol peripherals.
