`ifndef NLX_SRAM_MASTER_MONITOR_SV
`define NLX_SRAM_MASTER_MONITOR_SV

class nlx_sram_master_monitor extends uvm_monitor;
 
  virtual nlx_sram_if vif;
  uvm_analysis_port #(nlx_sram_transaction) item_observed_port;
  
  `uvm_component_utils(nlx_sram_master_monitor)
  
  function new(string name = "nlx_sram_master_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_observed_port = new("item_observed_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      monitor_trans();
    join_none
  endtask

  virtual task monitor_trans();
    nlx_sram_transaction t;
    forever begin
      collect_transfer(t);
      item_observed_port.write(t);
    end
  endtask

  virtual task collect_transfer(output nlx_sram_transaction t);
    t = nlx_sram_transaction::type_id::create("t");
    @(vif.cb_mon);
    t.addr = vif.cb_mon.addr;
    t.we = vif.cb_mon.we;
    t.data = vif.cb_mon.we == 4'b0 ? vif.cb_mon.rdata : vif.cb_mon.wdata;
  endtask


endclass


`endif//nlx_sram_MASTER_MONITOR_SV
