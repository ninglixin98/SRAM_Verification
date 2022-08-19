`ifndef NLX_SRAM_PKG_SV
`define NLX_SRAM_PKG_SV

package nlx_sram_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "nlx_sram_transaction.sv" 
  `include "nlx_sram_master_driver.sv"
  `include "nlx_sram_master_monitor.sv"
  `include "nlx_sram_master_sequencer.sv"
  `include "nlx_sram_master_agent.sv"
  
endpackage

`endif//nlx_sram_PKG_SV

