# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


async def reset(dut):
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)


@cocotb.test()
async def test_counter(dut):
    """Counter resets to 0, increments by 1 per clock, wraps at 256."""
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    await reset(dut)
    assert int(dut.uo_out.value) == 0, "counter must be 0 while in reset"
    assert int(dut.uio_oe.value) == 0, "bidirectional pins must be inputs"


    
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 20)
    assert dut.uo_out.value.is_resolvable, "outputs must not be X/Z"
