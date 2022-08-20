`ifndef NLX_SRAM_IF_SV
`define NLX_SRAM_IF_SV

interface nlx_sram_if;
  logic clk;
  logic rstn;
  logic [3:0] we;
  logic [15:0] addr;
  logic [31:0] wdata;
  logic [31:0] rdata;

  initial begin: rstn_gen
    assert_reset(10);
  end

  task automatic assert_reset(int nclks = 1, int delay = 0);
    #(delay * 1ns);
    repeat(nclks) @(posedge clk);
    rstn <= 0;
    repeat(nclks) @(posedge clk);
    rstn <= 1;
  endtask

  clocking cb_mst @(posedge clk);
    default input #1ps output #1ps;
    output addr, we, wdata;
    input rdata;
  endclocking : cb_mst

  clocking cb_mon @(posedge clk);
    default input #1ps output #1ps;
    input addr, we, wdata, rdata;
  endclocking : cb_mon

endinterface

`endif//nlx_sram_IF_SV

