`ifndef NLX_SRAM_CONFIG_SV
`define NLX_SRAM_CONFIG_SV

class nlx_sram_config extends uvm_object;

  int seq_check_count;
  int seq_check_error;

  int scb_check_count;
  int scb_check_error;

  bit enable_scb = 1;
  bit enable_cov = 1;

  bit [31:0] addr_start;
  bit [31:0] addr_end;
  int data_width;
  logic init_logic = 1'b0;
  bit is_active = 1;
  virtual nlx_sram_if vif;
 
  `uvm_object_utils(nlx_sram_config)

  function new (string name = "nlx_sram_config");
    super.new(name);
  endfunction : new

endclass

`endif // nlx_sram_CONFIG_SV
