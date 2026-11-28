# Protocol Emulator ASIC — project rules for Claude

Jane Street Protocol Emulator ASIC Competition entry (Tiny Tapeout, IHP 130 nm CMOS5L, 8x4 tiles).
Deadline 2027-01-18. Internal: RTL freeze 2027-01-09, submission-ready 2027-01-15.
Owner: Devansh Srivastava. Learning goal: owner must understand every change.

## Hard rules (never break)
- Keep the ttihp-verilog-template layout. Top module: `tt_um_devansh10_protoemu`. `info.yaml` tiles stay "8x4".
- Every new src file: add to `info.yaml` source_files AND `PROJECT_SOURCES` in test/Makefile.
- Only 24 digital pins: ui_in[7:0] in, uo_out[7:0] out, uio[7:0] bidirectional (uio_oe=1 drives). Plus clk, rst_n.
- Reset every state flop with synchronous active-low `rst_n` (flops do not power up at 0).
- Protocols are firmware on a programmable engine. No protocol-specific hardwired datapaths.
- No latches, no `initial` blocks in src/, no combinational loops, all outputs assigned.
- Do not edit src/config.json without explaining why to the owner first.

## Workflow
- Never commit to `main` directly. Work on a branch, open a PR, owner merges.
- One change per branch. Small diffs with a rationale in the commit message.
- Before pushing: `cd test && make -B` must pass.
- "Green" on GitHub = test + gds + gl_test + precheck jobs all pass (~70 min). `docs` failures: investigate separately.
- Agents may propose; only test/CI evidence accepts. Never claim timing/area improved without report numbers.
- Never weaken or delete a test to make it pass. A mismatch between spec, model and RTL must be investigated.
- Log every AI-assisted change in `docs/ai_usage.md` (date, tool, task, accepted/rejected, bugs caught). Required by competition rules.

## Commands
- Simulate: `cd test && make -B`   (waveform: `gtkwave tb.fst tb.gtkw`)
- Gate-level sim: copy GL netlist to `test/gate_level_netlist.v`, then `make -B GATES=yes`
- Python venv: ~/venvs/tt (cocotb 2.0.1, Icarus 12)

## Explain as you go
The owner is an analog/mixed-signal engineer new to digital physical design. When you change RTL or read reports,
explain briefly what and why (area, timing, reset, synthesis effects).
