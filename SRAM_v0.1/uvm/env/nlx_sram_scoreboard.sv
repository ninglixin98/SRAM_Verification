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
    //if(is_addr_valid(tr.addr)) begin
      //case(tr.xact_type)
       // WRITE : store_data_with_hburst(tr);
       // READ  : check_data_with_hburst(tr);
      //endcase
    //end
  endfunction

  //control check enable and disable
  task do_listen_events();
  endtask

  //do check
  virtual task do_data_check();
  endtask

 endclass

`endif//nlx_sram_SCOREBOARD
