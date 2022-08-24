`ifndef NLX_SRAM_ILLEGAL_ADDR_VIRT_SEQ_SV
`define NLX_SRAM_ILLEGAL_ADDR_VIRT_SEQ_SV

class nlx_sram_illegal_addr_virt_seq extends nlx_sram_base_virtual_sequence;
  `uvm_object_utils(nlx_sram_illegal_addr_virt_seq)

  function new (string name = "nlx_sram_illegal_addr_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] data;
    bit [15:0] addr;
    bit cs;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    for(int i = 0; i<100; i++) begin
      std::randomize(addr) with {addr inside {['h0000_FFFF : 'hFFFF_FFFF]};};
      std::randomize(wr_val) with {wr_val inside {['h0000_0000 : 'hFFFF_FFFF]};};
      data = wr_val;
      `uvm_do_with(single_write, {addr == local::addr; data == local::data; cs == 1'b1;})
      `uvm_do_with(single_read, {addr == local::addr; cs == 1'b1;})
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//nlx_sram_illegal_addr_VIRT_SEQ_SV
