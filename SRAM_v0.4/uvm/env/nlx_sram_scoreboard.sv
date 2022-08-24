`ifndef NLX_SRAM_SCOREBOARD
`define NLX_SRAM_SCOREBOARD

class nlx_sram_scoreboard extends nlx_sram_subscriber;

  bit [31:0] mem [int unsigned];

  //typedef enum {CHECK_LOADCOUNTER} check_type_e;
  
  `uvm_component_utils(nlx_sram_scoreboard)

  function new (string name = "nlx_sram_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    do_data_check();
  endtask

  virtual function void write(nlx_sram_transaction tr);
    if(is_addr_valid(tr.addr) && tr.cs == 1'b1) begin
    //if(is_addr_valid(tr.addr)) begin
      if(tr.we == 4'b0000)
        read_data(tr);
      else
        write_data(tr);
    end
  endfunction

  function bit is_addr_valid(bit [31:0] addr);
    if(addr >= cfg.addr_start && addr <= cfg.addr_end)
      return 1;
  endfunction

  function write_data(nlx_sram_transaction tr);
    bit [31:0] rdata = mem[tr.addr];
    bit [31:0] mdata;
    mdata[7:0] = tr.we[0] ? tr.data[7:0] : rdata[7:0];
    mdata[15:8] = tr.we[1] ? tr.data[15:8] : rdata[15:8];
    mdata[23:16] = tr.we[2] ? tr.data[23:16] : rdata[23:16];
    mdata[31:24] = tr.we[3] ? tr.data[31:24] : rdata[31:24];
    mem[tr.addr] = mdata;
  endfunction

  task read_data(nlx_sram_transaction tr);
    wait_reset_mem();
    check_data(tr);
  endtask

  function check_data(nlx_sram_transaction tr);
    cfg.scb_check_count++;
    if(mem[tr.addr] == tr.data) begin
      `uvm_info("DATACHECK", $sformatf("sram[%0x] data expected 'h%0x = actual 'h%0x", tr.addr, mem[tr.addr], tr.data), UVM_LOW)
    end
    else begin
      cfg.scb_check_error++;
      `uvm_error("DATACHECK", $sformatf("sram[%0x] data expected 'h%0x != actual 'h%0x", tr.addr, mem[tr.addr], tr.data))
    end
  endfunction

  //control check enable and disable
  task do_listen_events();
  endtask

  //do check
  virtual task do_data_check();
  endtask

  virtual task wait_reset_mem();
    fork 
      forever begin
        @(negedge vif.rstn);
        mem.delete;
      end
    join_none
  endtask

 endclass

`endif//nlx_sram_SCOREBOARD
