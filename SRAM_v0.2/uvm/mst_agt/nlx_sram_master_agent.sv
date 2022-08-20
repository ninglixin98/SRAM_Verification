`ifndef NLX_SRAM_MASTER_AGENT_SV
`define NLX_SRAM_MASTER_AGENT_SV

class nlx_sram_master_agent extends uvm_agent;
  
  nlx_sram_config cfg;
  nlx_sram_master_driver driver;
  nlx_sram_master_monitor monitor;
  nlx_sram_master_sequencer sequencer;
  virtual nlx_sram_if vif;
  `uvm_component_utils(nlx_sram_master_agent)

  function new(string name = "nlx_sram_master_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(nlx_sram_config)::get(this,"","cfg", cfg)) begin
      `uvm_fatal("GETCFG","cannot get cfg handle from config DB")
    end
    if(!uvm_config_db#(virtual nlx_sram_if)::get(this,"","vif", vif)) begin
      `uvm_fatal("GETVIF","cannot get vif handle from config DB")
    end

    monitor = nlx_sram_master_monitor::type_id::create("monitor", this);
    if(cfg.is_active) begin
      driver = nlx_sram_master_driver::type_id::create("driver", this);
      sequencer = nlx_sram_master_sequencer::type_id::create("sequencer", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    monitor.vif = vif;
    if(cfg.is_active) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
      driver.vif = vif;
      sequencer.vif = vif;
    end
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask


endclass


`endif//nlx_sram_MASTER_AGENT_SV
