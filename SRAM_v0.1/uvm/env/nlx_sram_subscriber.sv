`ifndef NLX_SRAM_SUBSCRIBER_SV
`define NLX_SRAM_SUBSCRIBER_SV



class nlx_sram_subscriber extends uvm_component;

  //sram analyse import
  uvm_analysis_imp #(nlx_sram_transaction, nlx_sram_subscriber) sram_trans_observed_imp;

  //events
  
  protected uvm_event_pool _ep;
  
  nlx_sram_config cfg;
  virtual nlx_sram_if vif;

  `uvm_component_utils(nlx_sram_subscriber)

  function new (string name = "nlx_sram_subscriber", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sram_trans_observed_imp = new("sram_trans_observed_imp", this);
    //get config handle from test layer
    if(!uvm_config_db#(nlx_sram_config)::get(this,"","cfg", cfg)) begin
      `uvm_fatal("GETCFG","cannot get cfg handle from config DB")
    end

    vif = cfg.vif;

    //local event pool
    _ep = new("_ep");
  endfunction


  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    do_events_trigger();
    do_listen_events();
  endtask

  //analyse port write function
  virtual function void write(nlx_sram_transaction tr);
  endfunction

  //trigger events
  virtual task do_events_trigger(); 
  endtask

  virtual task do_listen_events();
  endtask
  
endclass


`endif//nlx_sram_SUBSCRIBER_SV
