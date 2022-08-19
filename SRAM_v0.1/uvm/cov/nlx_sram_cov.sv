`ifndef NLX_SRAM_COV_SV
`define NLX_SRAM_COV_SV

class nlx_sram_cov extends nlx_sram_subscriber;

  `uvm_component_utils(nlx_sram_cov)

  //covergroup definition below
  //T1 AHB address
  //T2 AHB transfer type & size
  covergroup nlx_sram_t1_address_cg(bit [31:0] addr_start, bit [31:0] addr_end) with function sample(bit [31:0] addr);
    option.name = "T1 SRAM address range coverage";
    ADDR: coverpoint addr {
      bins addr_start            = {[addr_start : addr_start+3]};
      bins addr_end              = {[addr_end-3 : addr_end]};
      bins addr_out_of_range     = {[addr_end+1 : 32'hFFFF_FFFF]};
      bins legal_range[16]       = {[addr_start : addr_end]}; 
    }
    BYTEACC: coverpoint addr[1:0] {
      bins addr_byte_acc_b01     = {2'b01};
      bins addr_byte_acc_b11     = {2'b11};
      bins addr_halfword_acc_b10 = {2'b10};
      bins addr_word_acc_b00     = {2'b00};
    }
  endgroup

  covergroup nlx_sram_t2_type_size_cg with function sample(burst_type_enum btype, burst_size_enum bsize);
    BURST_TYPE: coverpoint btype {
      bins single  = {SINGLE};
      bins incr    = {INCR};
      bins wrap4   = {WRAP4};
      bins incr4   = {INCR4};
    }
    BURST_SIZE: coverpoint bsize {
      bins size_8bit  = {BURST_SIZE_8BIT};
      bins size_16bit = {BURST_SIZE_16BIT};
      bins size_32bit = {BURST_SIZE_32BIT};
      bins size_64bit = {BURST_SIZE_64BIT};
    }
  endgroup

  function new(string name = "nlx_sram_cov", uvm_component parent);
    super.new(name, parent);
    nlx_sram_t1_address_cg = new(32'h0000, 32'hFFFF);
    nlx_sram_t2_type_size_cg = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(lvc_ahb_transaction tr);
    nlx_sram_t1_address_cg.sample(tr.addr);
    nlx_sram_t2_type_size_cg.sample(tr.burst_type, tr.burst_size);
  endfunction

  task do_listen_events();
  endtask
  
endclass



`endif//nlx_sram_COV_SV
