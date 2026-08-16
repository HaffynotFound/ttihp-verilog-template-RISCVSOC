# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    dut._log.info("Starting JSoc Tiny Tapeout test")

    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    dut._log.info("Applying reset")

    await ClockCycles(dut.clk, 10)

    dut.rst_n.value = 1

    dut._log.info("Reset released")

    await ClockCycles(dut.clk, 200)

    dut._log.info("Testing PRDATA byte selection")

    for select in range(4):

        dut.ui_in.value = select

        await ClockCycles(dut.clk, 2)

        dut._log.info(
            f"PRDATA byte select {select:02b}: "
            f"uo_out = {dut.uo_out.value}"
        )

    dut._log.info("Testing peripheral outputs")

    await ClockCycles(dut.clk, 10)

    dut._log.info(
        f"uio_out = {dut.uio_out.value}"
    )

    dut._log.info(
        f"uio_oe = {dut.uio_oe.value}"
    )

    dut._log.info("Running JSoc")

    await ClockCycles(dut.clk, 500)

    dut._log.info("JSoc Tiny Tapeout test completed successfully")
