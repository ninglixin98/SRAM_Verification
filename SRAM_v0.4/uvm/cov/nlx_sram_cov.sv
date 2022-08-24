`ifndef NLX_SRAM_COV_SV
`define NLX_SRAM_COV_SV

class nlx_sram_cov extends nlx_sram_subscriber;

  `uvm_component_utils(nlx_sram_cov)

  function new(string name = "nlx_sram_cov", uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass



`endif//nlx_sram_COV_SV
