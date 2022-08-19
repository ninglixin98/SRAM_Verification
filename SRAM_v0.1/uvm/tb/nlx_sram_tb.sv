module nlx_sram_tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import nlx_sram_pkg::*;

  logic clk;
  logic rstn;

  initial begin : clk_gen
    clk = 0;
    forever #2ns clk = !clk;
  end

  sram dut(
    .CLK(sram_if.clk)
    ,.RSTn(sram_if.resetn)
    ,.CS(1'b1)
    ,.WE(sram_if.we)
    ,.ADDRESS(sram_if.addr)
    ,.WDATA(sram_if.wdata)
    ,.RDATA(sram_if.rdata)
  );

  nlx_sram_if sram_if();
  assign sram_if.clk    = clk;
  assign sram_if.resetn = rstn;

  initial begin
    uvm_config_db#(virtual nlx_sram_if)::set(uvm_root::get(), "uvm_test_top.env.sram_mst", "vif", sram_if);
    uvm_config_db#(virtual nlx_sram_if)::set(uvm_root::get(), "uvm_test_top", "vif", sram_if);
    uvm_config_db#(virtual nlx_sram_if)::set(uvm_root::get(), "uvm_test_top.env", "vif", sram_if);
    uvm_config_db#(virtual nlx_sram_if)::set(uvm_root::get(), "uvm_test_top.env.virt_sqr", "vif", sram_if);
    run_test();
  end


endmodule


