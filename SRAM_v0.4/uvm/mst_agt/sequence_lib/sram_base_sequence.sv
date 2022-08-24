`ifndef SRAM_BASE_SEQUENCE_SV
`define SRAM_BASE_SEQUENCE_SV

class sram_base_sequence extends uvm_sequence #(nlx_sram_transaction);

  `uvm_object_utils(sram_base_sequence)    
  function new(string name=""); 
    super.new(name);
  endfunction : new

endclass

`endif//sram_BASE_SEQUENCE_SV

