`ifndef NLX_SRAM_COV_SV
`define NLX_SRAM_COV_SV

class nlx_sram_cov extends nlx_sram_subscriber;

  `uvm_component_utils(nlx_sram_cov)

  covergroup rkv_ahbram_t1_address_cg(bit [15:0] addr_start, bit [15:0] addr_end) with function sample(bit [15:0] addr);
    option.name = "T1 SRAM address range coverage";
    ADDR: coverpoint addr {
      bins addr_start            = {[addr_start : addr_start+3]};
      bins addr_end              = {[addr_end-3 : addr_end]};
      bins addr_out_of_range     = {[addr_end+1 : 32'hFFFF_FFFF]};
      bins legal_range           = {[addr_start : addr_end]}; 
    }
  endgroup

  covergroup rkv_ahbram_t2_we_cg with function sample(bit [3:0] we);
    option.name = "T2 SRAM write enable coverage";
    WE: coverpoint we {
      bins read_all                     = {4'b0000};
      bins write_byte_0001              = {4'b0001};
      bins write_byte_0010              = {4'b0010};
      bins write_byte_0011              = {4'b0011};
      bins write_byte_0100              = {4'b0100};
      bins write_byte_0101              = {4'b0101};
      bins write_byte_0110              = {4'b0110};
      bins write_byte_0111              = {4'b0111};
      bins write_byte_1000              = {4'b1000};
      bins write_byte_1001              = {4'b1001};
      bins write_byte_1010              = {4'b1010};
      bins write_byte_1011              = {4'b1011};
      bins write_byte_1100              = {4'b1100};
      bins write_byte_1101              = {4'b1101};
      bins write_byte_1110              = {4'b1110};
      bins write_all_1111               = {4'b1111};
    }
  endgroup

  covergroup rkv_ahbram_t3_cs_cg with function sample(bit cs);
    option.name = "T3 SRAM chipsel coverage";
    WE: coverpoint cs {
      bins cs_disable = {1'b0};
      bins cs_enable  = {1'b1};
    }
  endgroup


  function new(string name = "nlx_sram_cov", uvm_component parent);
    super.new(name, parent);
    rkv_ahbram_t1_address_cg = new(16'h0000, 16'hFFFF);
    rkv_ahbram_t2_we_cg = new();
    rkv_ahbram_t3_cs_cg = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(nlx_sram_transaction tr);
    rkv_ahbram_t1_address_cg.sample(tr.addr);
    rkv_ahbram_t2_we_cg.sample(tr.we);
    rkv_ahbram_t3_cs_cg.sample(tr.cs);
  endfunction

  task do_listen_events();
  endtask
  
endclass



`endif//nlx_sram_COV_SV
