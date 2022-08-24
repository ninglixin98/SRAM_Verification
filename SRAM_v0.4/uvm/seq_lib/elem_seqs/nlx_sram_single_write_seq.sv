`ifndef NLX_SRAM_SINGLE_WRITE_SEQ_SV
`define NLX_SRAM_SINGLE_WRITE_SEQ_SV

class nlx_sram_single_write_seq extends nlx_sram_base_element_sequence;

  rand bit [15:0]  addr;
  rand bit [31:0]  data;
  rand bit  [3:0]  we;
  rand bit cs;

  constraint single_write_cstr{
    soft we == 4'b1111;
    soft cs == 1'b1;
  }

  `uvm_object_utils(nlx_sram_single_write_seq)
  function new (string name = "nlx_sram_single_write_seq");
    super.new(name);
  endfunction

  virtual task body();
    sram_master_single_trans sram_single;
    `uvm_info("body", "Entered...", UVM_LOW)
    `uvm_do_on_with(sram_single, p_sequencer.mst_sqr, 
                    {addr == local::addr; data == local::data; we == local::we; cs == local::cs;})
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass


`endif//nlx_sram_SINGLE_WRITE_SEQ_SV

