`ifndef NLX_SRAM_MASTER_SEQUENCER_SV
`define NLX_SRAM_MASTER_SEQUENCER_SV

class nlx_sram_master_sequencer #(type REQ = nlx_sram_transaction, type RSP = REQ) extends uvm_sequencer #(REQ, RSP);
  virtual nlx_sram_if vif;
  `uvm_component_utils(nlx_sram_master_sequencer)

  function new(string name = "nlx_sram_master_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask


endclass


`endif//nlx_sram_MASTER_SEQUENCER_SV
