`ifndef NLX_SRAM_BASE_ELEMENT_SEQUENCE_SV
`define NLX_SRAM_BASE_ELEMENT_SEQUENCE_SV

class nlx_sram_base_element_sequence extends uvm_sequence;
  
  nlx_sram_config cfg;
  virtual nlx_sram_if vif;

  `uvm_object_utils(nlx_sram_base_element_sequence)
  `uvm_declare_p_sequencer(nlx_sram_virtual_sequencer)

  function new (string name = "nlx_sram_base_element_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entered...", UVM_LOW)
    //to do
    //get cfg from p_sequencer(element sequencer)
    cfg = p_sequencer.cfg;
    //get vif and rgm from cfg
    vif = cfg.vif;
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

  //compare data
  virtual function void compare_data(logic[31:0] val1, logic[31:0] val2);
    cfg.seq_check_count++;
    if(val1 == val2)       
      `uvm_info("CMPSUC", $sformatf("val1 'h%0x === val2 'h%0x", val1, val2), UVM_LOW)
    else begin
      cfg.seq_check_error++;
      `uvm_error("CMPERR", $sformatf("val1 'h%0x !== val2 'h%0x", val1, val2))
    end
  endfunction
  
endclass

`endif//nlx_sram_BASE_ELEMENT_SEQUENCE_SV
