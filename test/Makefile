# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

SIM ?= icarus
FST ?= -fst
TOPLEVEL_LANG ?= verilog

SRC_DIR = $(PWD)/../src

PROJECT_SOURCES = \
    adder.sv \
    alu.sv \
    alu_decoder.sv \
    apb_master.sv \
    apb_slave_pwm.sv \
    apb_slave_timer.sv \
    apb_slave_uart.sv \
    baud_rate.sv \
    bridge.sv \
    control_logic.sv \
    controller.sv \
    core.sv \
    d_ff.sv \
    datapath.sv \
    decoder_logic.sv \
    deserializer.sv \
    dmem.sv \
    extender.sv \
    fifo.sv \
    fifo_master.sv \
    imem.sv \
    main_decoder.sv \
    master.sv \
    mux_2.sv \
    mux_3.sv \
    normal.sv \
    pwm.sv \
    register_file.sv \
    serializer.sv \
    square.sv \
    timer.sv \
    top.sv \
    uart_rx.sv \
    uart_soc.sv \
    uart_tx.sv \
    project.sv

ifneq ($(GATES),yes)

SIM_BUILD = sim_build/rtl

VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

COMPILE_ARGS += -g2012

else

SIM_BUILD = sim_build/gl

COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
# COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=\#1

VERILOG_SOURCES += $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_io/verilog/sg13g2_io.v
VERILOG_SOURCES += $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_stdcell/verilog/sg13g2_stdcell.v

VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

COMPILE_ARGS += -I$(SRC_DIR)

VERILOG_SOURCES += $(PWD)/tb.v

TOPLEVEL = tb

COCOTB_TEST_MODULES = test

include $(shell cocotb-config --makefiles)/Makefile.sim
