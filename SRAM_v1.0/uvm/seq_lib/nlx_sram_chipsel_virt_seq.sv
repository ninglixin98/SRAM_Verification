`ifndef NLX_SRAM_CHIPSEL_VIRT_SEQ_SV
`define NLX_SRAM_CHIPSEL_VIRT_SEQ_SV

class nlx_sram_chipsel_virt_seq extends nlx_sram_base_virtual_sequence;
  `uvm_object_utils(nlx_sram_chipsel_virt_seq)

  function new (string name = "nlx_sram_chipsel_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] data;
    bit [15:0] addr;
    bit [3:0] we;
    bit cs;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    for(int i = 0; i<100; i++) begin
      std::randomize(addr) with {addr inside {['h0000 : 'hFFFF]};};
      std::randomize(wr_val) with {wr_val inside {['h0000_0000 : 'hFFFF_FFFF]};};
      std::randomize(we) with {we inside {['b0000 : 'b1111]};};
      data = wr_val;
      //normal write and read
      `uvm_do_with(single_write, {addr == local::addr; data == local::data; we == local::we; cs == 1'b1;})
      `uvm_do_with(single_read, {addr == local::addr; we == 4'b0000; cs == 1'b1;})
      
      //==========check if can read when cs is 0==================
      //set cs to 0 and read
      `uvm_do_with(single_read, {addr == local::addr; we == 4'b0000; cs == 1'b0;})
      //set cs to 1 and read
      `uvm_do_with(single_read, {addr == local::addr; we == 4'b0000; cs == 1'b1;})
      
      //==========check if can write when cs is 0=================
      //set cs to 0 and write
      `uvm_do_with(single_write, {addr == local::addr; data == 'hFFFF_FFFF; we == local::we; cs == 1'b0;})
      //set cs to 1 and read
      `uvm_do_with(single_read, {addr == local::addr; we == 4'b0000; cs == 1'b1;})
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//nlx_sram_chipsel_VIRT_SEQ_SV
