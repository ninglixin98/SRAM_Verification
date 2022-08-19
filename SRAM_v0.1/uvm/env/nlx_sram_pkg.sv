`ifndef NLX_SRAM_PKG_SV
`define NLX_SRAM_PKG_SV

package nlx_sram_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import nlx_sram_pkg::*;
  `include "nlx_sram_config.sv"
  `include "nlx_sram_subscriber.sv"
  `include "nlx_sram_cov.sv"
  `include "nlx_sram_scoreboard.sv"
  `include "nlx_sram_virtual_sequencer.sv"
  `include "nlx_sram_env.sv"
  `include "nlx_sram_seq_lib.svh"
  `include "nlx_sram_tests.svh"
endpackage

`endif//nlx_sram_PKG_SV

