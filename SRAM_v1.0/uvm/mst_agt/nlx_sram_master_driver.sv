`ifndef NLX_SRAM_MASTER_DRIVER_SV
`define NLX_SRAM_MASTER_DRIVER_SV

class nlx_sram_master_driver #(type REQ = nlx_sram_transaction, type RSP = REQ) extends uvm_driver #(REQ, RSP);
  
  virtual nlx_sram_if vif;
  `uvm_component_utils(nlx_sram_master_driver)

  function new(string name = "nlx_sram_master_driver", uvm_component parent = null);
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
    fork  
      get_and_drive();
    join_none
  endtask

  virtual task get_and_drive();
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), "sequencer got next item", UVM_HIGH)
      drive_transfer(req);
      void'($cast(rsp, req.clone()));
      rsp.set_sequence_id(req.get_sequence_id());
      rsp.set_transaction_id(req.get_transaction_id());
      seq_item_port.item_done(rsp);
      `uvm_info(get_type_name(), "sequencer item_done_triggered", UVM_HIGH)
    end
  endtask

  virtual task drive_transfer(REQ t);
    if(t.we == 4'b0)
      read_data(t);
    else
      write_data(t);
  endtask

  virtual task read_data(REQ t);
    @(vif.cb_mst);
    vif.we <= t.we;
    vif.addr <= t.addr;
    vif.cs <= t.cs;
    t.data <= vif.rdata;
    //@(vif.cb_mst);
    //_do_drive_idle();
  endtask

  virtual task write_data(REQ t);
    @(vif.cb_mst);
    vif.we <= t.we;
    vif.addr <= t.addr;
    vif.wdata <= t.data;
    vif.cs <= t.cs;
    //@(vif.cb_mst);
    //_do_drive_idle();
  endtask

  virtual protected task _do_drive_idle();
    vif.cb_mst.addr   <= 0;
    vif.cb_mst.we  <= 0;
    vif.cb_mst.wdata <= 0;
  endtask
 
endclass




`endif//nlx_sram_MASTER_DRIVER_SV
