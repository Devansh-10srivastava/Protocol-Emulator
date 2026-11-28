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

  reg [31:0] count;
  reg [31:0] product;

  always @(posedge clk) begin
    if (!rst_n) begin
      count   <= 32'd0;
      product <= 32'd0;
    end else if (ena) begin
      count   <= count + 32'd1;
      product <= count * {ui_in, uio_in, ui_in, uio_in};  // 32x32 multiply: deliberately slow
    end
  end

  assign uo_out  = product[31:24] ^ count[7:0];
  assign uio_out = 8'd0;
  assign uio_oe  = 8'd0;



endmodule
