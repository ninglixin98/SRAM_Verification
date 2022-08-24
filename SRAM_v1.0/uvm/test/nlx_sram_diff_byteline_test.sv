`ifndef NLX_SRAM_DIFF_BYTELINE_TEST_SV
`define NLX_SRAM_DIFF_BYTELINE_TEST_SV

class nlx_sram_diff_byteline_test extends nlx_sram_base_test;

  `uvm_component_utils(nlx_sram_diff_byteline_test)

  function new (string name = "nlx_sram_diff_byteline_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    nlx_sram_diff_byteline_virt_seq seq = nlx_sram_diff_byteline_virt_seq::type_id::create("this");
    super.run_phase(phase);
    phase.raise_objection(this);
    seq.start(env.virt_sqr);
    phase.drop_objection(this);
  endtask

endclass




`endif//nlx_sram_diff_byteline_TEST_SV
