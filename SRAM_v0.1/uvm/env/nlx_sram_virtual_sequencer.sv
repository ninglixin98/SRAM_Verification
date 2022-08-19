`ifndef NLX_SRAM_VIRTUAL_SEQUENCER_SV
`define NLX_SRAM_VIRTUAL_SEQUENCER_SV

class nlx_sram_virtual_sequencer extends uvm_sequencer;
  
  nlx_sram_master_sequencer ahb_mst_sqr;
  nlx_sram_config cfg;
  `uvm_component_utils(nlx_sram_virtual_sequencer);
  
  function new (string name = "nlx_sram_virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get config handle from env layer
    if(!uvm_config_db#(nlx_sram_config)::get(this,"","cfg", cfg)) begin
      `uvm_fatal("GETCFG","cannot get cfg handle from config DB")
    end
    
  endfunction


endclass


`endif//nlx_sram_VIRTUAL_SEQUENCER_SV
