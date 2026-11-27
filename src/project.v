/*
 * Copyright (c) 2026 Devansh Srivastava
 * SPDX-License-Identifier: Apache-2.0
 *
 * Day 1 flow-proof design: an 8-bit counter.
 * Purpose: push a trivial design through the full Tiny Tapeout IHP flow
 * (synthesis -> floorplan -> placement -> CTS -> routing -> checks)
 * before the real protocol-emulator RTL replaces it.
 */

`default_nettype none

module tt_um_devansh10_protoemu (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [7:0] count;

  // Synchronous active-low reset: flops do NOT power up at 0 on silicon,
  // so every state register must be reset explicitly.
  always @(posedge clk) begin
    if (!rst_n)
      count <= 8'd0;
    else if (ena)
      count <= count + 8'd1;
  end

  assign uo_out  = count;
  assign uio_out = 8'd0;
  assign uio_oe  = 8'd0;   // all bidirectional pins are inputs for now

  // Unused inputs, listed to silence lint warnings
  wire _unused = &{ui_in, uio_in, 1'b0};

endmodule
