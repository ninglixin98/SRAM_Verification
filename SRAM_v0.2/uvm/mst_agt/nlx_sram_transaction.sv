`ifndef NLX_SRAM_TRANSACTION_SV
`define NLX_SRAM_TRANSACTION_SV

class nlx_sram_transaction extends uvm_sequence_item;
  
  rand bit [15:0] addr;
  rand bit [3:0] we;
  rand bit [31:0] data;
  

  `uvm_object_utils_begin(nlx_sram_transaction)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(we, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "nlx_sram_transaction");
    super.new(name);
  endfunction

endclass


`endif//nlx_sram_TRANSACTION_SV
