`ifndef NLX_SRAM_SINGLE_READ_SEQ_SV
`define NLX_SRAM_SINGLE_READ_SEQ_SV

class nlx_sram_single_read_seq extends nlx_sram_base_element_sequence;

  rand bit [15:0]  addr;
  rand bit [31:0]  data;
  rand bit [3:0]   we;

  constraint single_read_cstr{
    soft we == 4'b0000;
  }

  `uvm_object_utils(nlx_sram_single_read_seq)
  function new (string name = "nlx_sram_single_read_seq");
    super.new(name);
  endfunction

  virtual task body();
    sram_master_single_trans sram_single;
    `uvm_info("body", "Entered...", UVM_LOW)
    `uvm_do_on_with(sram_single, p_sequencer.mst_sqr, 
                    {addr == local::addr; we == local::we;})
    data = sram_single.data;
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass


`endif//nlx_sram_SINGLE_READ_SEQ_SV
