`ifndef NLX_SRAM_BASE_TEST_SV
`define NLX_SRAM_BASE_TEST_SV

virtual class nlx_sram_base_test extends uvm_test;
  nlx_sram_config cfg;
  nlx_sram_env env;

  function new (string name = "nlx_sram_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //create cfg
    cfg = nlx_sram_config::type_id::create("cfg");
    //do parameter configuration
    cfg.addr_start = 16'h0000;
    cfg.addr_end = 16'hFFFF;
    //get cfg.vif from top
    if(!uvm_config_db#(virtual nlx_sram_if)::get(this,"","vif", cfg.vif)) begin
      `uvm_fatal("GETVIF","cannot get vif handle from config DB")
    end
    //set cfg to env
    uvm_config_db#(nlx_sram_config)::set(this, "env", "cfg", cfg);
    uvm_config_db#(nlx_sram_config)::set(this, "env.sram_mst", "cfg", cfg);
    env = nlx_sram_env::type_id::create("env", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.phase_done.set_drain_time(this, 1us);
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask

endclass

`endif//nlx_sram_BASE_TEST_SV
