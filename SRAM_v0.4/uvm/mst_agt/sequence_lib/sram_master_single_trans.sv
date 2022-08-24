`ifndef SRAM_MASTER_SINGLE_TRANS_SV
`define SRAM_MASTER_SINGLE_TRANS_SV

class sram_master_single_trans extends sram_base_sequence;

  rand bit [15 :0]      addr;
  rand bit [31 :0]      data;
  rand bit   [3:0]       we;
  rand bit cs;


  constraint single_trans_cstr{
    soft we inside {[1111:0000]};
    soft cs == 1'b1;
  }

  `uvm_object_utils(sram_master_single_trans)    
  function new(string name=""); 
    super.new(name);
  endfunction : new

  virtual task body();
    `uvm_info(get_type_name(),"Starting sequence", UVM_HIGH)
	  `uvm_do_with(req, {
                        addr == local::addr;
                       data == local::data;
                       we == local::we;
                       cs == local::cs;
                      })
    get_response(rsp);
    if(we == 4'b0000)
      data = rsp.data;
    `uvm_info(get_type_name(),$psprintf("Done sequence: %s",req.convert2string()), UVM_HIGH)
  endtask: body

endclass

`endif//sram_MASTER_SINGLE_TRANS_SV
