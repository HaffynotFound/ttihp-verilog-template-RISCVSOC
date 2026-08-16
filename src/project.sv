/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_haffynotfound_riscv_soc (
    input  logic [7:0] ui_in,
    output logic [7:0] uo_out,
    input  logic [7:0] uio_in,
    output logic [7:0] uio_out,
    output logic [7:0] uio_oe,
    input  logic       ena,
    input  logic       clk,
    input  logic       rst_n
);

    logic [31:0] pr_data;
    logic [31:0] write_data;
    logic [31:0] data_add;
    logic        mem_write;
    logic        wave;
    logic        wave1;
    logic        wave2;

    top top1 (
        .clk(clk),
        .rst(~rst_n),
        .write_data(write_data),
        .data_add(data_add),
        .mem_write(mem_write),
        .pr_data(pr_data),
        .wave(wave),
        .wave1(wave1),
        .wave2(wave2)
    );

    // 32-bit pr_data -> 8-bit output
    // ui_in[1:0] selects which byte is displayed
    always_comb begin
        case (ui_in[1:0])
            2'b00: uo_out = pr_data[7:0];
            2'b01: uo_out = pr_data[15:8];
            2'b10: uo_out = pr_data[23:16];
            2'b11: uo_out = pr_data[31:24];
            default: uo_out = 8'h00;
        endcase
    end

    // Waveform outputs
    assign uio_out[0] = wave;
    assign uio_out[1] = wave1;
    assign uio_out[2] = wave2;

    // Remaining uio outputs unused
    assign uio_out[7:3] = 5'b0;

    // Enable uio[2:0] as outputs
    assign uio_oe[2:0] = 3'b111;
    assign uio_oe[7:3] = 5'b000;

    // Unused inputs
    wire _unused = &{ena, uio_in, 1'b0};

endmodule

`default_nettype wire
