`ifndef NLX_SRAM_ENV_SV
`define NLX_SRAM_ENV_SV

class nlx_sram_env extends uvm_env;
  nlx_sram_master_agent sram_mst;
  nlx_sram_virtual_sequencer virt_sqr;
  nlx_sram_config cfg;
  nlx_sram_cov cov;
  nlx_sram_scoreboard scb;

  `uvm_component_utils(nlx_sram_env)

  function new (string name = "nlx_sram_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get config handle from test layer
    if(!uvm_config_db#(nlx_sram_config)::get(this,"","cfg", cfg)) begin
      `uvm_fatal("GETCFG","cannot get cfg handle from config DB")
    end
    //set config handle to virt_sqr and sram_mst 
    //set congig to cov and scb
    uvm_config_db#(nlx_sram_config)::set(this, "virt_sqr", "cfg", cfg);
    uvm_config_db#(nlx_sram_config)::set(this, "cov", "cfg", cfg);
    uvm_config_db#(nlx_sram_config)::set(this, "scb", "cfg", cfg);

    uvm_config_db#(nlx_sram_agent_configuration)::set(this, "sram_mst", "cfg", cfg.sram_cfg);
    this.sram_mst = nlx_sram_master_agent::type_id::create("sram_mst", this);
    this.virt_sqr = nlx_sram_virtual_sequencer::type_id::create("virt_sqr", this);
    cov = nlx_sram_cov::type_id::create("cov", this);
    scb = nlx_sram_scoreboard::type_id::create("scb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //connect sequencer to virtual sequencer
    virt_sqr.sram_mst_sqr = sram_mst.sequencer;
    sram_mst.monitor.item_observed_port.connect(cov.sram_trans_observed_imp);
    sram_mst.monitor.item_observed_port.connect(scb.sram_trans_observed_imp);
  endfunction

 
  //report check results
  function void report_phase(uvm_phase phase);
    string reports = "\n";
    super.report_phase(phase);
    reports = {reports, $sformatf("====================================== \n")};//only {} allow
    reports = {reports, $sformatf("CURRENT TEST SUMMARY \n")};
    reports = {reports, $sformatf("SEQUENCE CHECK COUNT: %0d \n", cfg.seq_check_count)};
    reports = {reports, $sformatf("SEQUENCE CHECK ERROR: %0d \n", cfg.seq_check_error)};
    reports = {reports, $sformatf("SCOREBOARD CHECK COUNT: %0d \n", cfg.scb_check_count)};
    reports = {reports, $sformatf("SCOREBOARD CHECK ERROR: %0d \n", cfg.scb_check_error)};
    reports = {reports, $sformatf("====================================== \n")};
    `uvm_info("TEST_SUMMARY", reports, UVM_LOW)
  endfunction

endclass


`endif//nlx_sram_ENV_SV
