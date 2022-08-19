module sram #(parameter    MEMNAME = "SRAM", 
			  parameter  DATAWIDTH = 32,
			  parameter ADDERWIDTH = 16,
			  parameter    MEMBASE = 16'h0,
			  parameter     MEMTOP = 16'hFFFF,
			  parameter   MEMDEPTH = 1 << ADDERWIDTH)
			  
			 (input wire                  CLK,
			  input wire                  RSTn,
			  input wire [ADDERWIDTH-1:0] ADDRESS,
			  input wire                  CS,      //chip select
			  input wire [3:0]            WE,      // write or read
			  input wire [DATAWIDTH-1:0]  WDATA,
			  output wire [DATAWIDTH-1:0]  RDATA);
			  
			  reg [DATAWIDTH-1:0] RAM [0:MEMDEPTH-1]; //
			  reg [DATAWIDTH-1:0] rd_data;
			  
			  assign RDATA = (CS&(WE==4'h0)) ? RAM[ADDRESS] : 32'b0;
			  
			  wire [31:0] wr_data = RAM[ADDRESS];
			  
			  //读取数据保持不变，如果写入则写入对应字节线上的值
			  wire [7:0]  wbyte0 = WE[0] ? WDATA[7:0]   : wr_data[7:0];
			  wire [7:0]  wbyte1 = WE[1] ? WDATA[15:8]  : wr_data[15:8];
			  wire [7:0]  wbyte2 = WE[2] ? WDATA[23:16] : wr_data[23:16];
			  wire [7:0]  wbyte3 = WE[3] ? WDATA[31:24] : wr_data[31:24];
			  
			  integer i;
			  
			  always @(posedge clk or negedge rstn) begin
				if(CS) begin
					if(!rstn) begin
						for(i=0; i<MEMDEPTH; i=i+1)
							RAM[i] <= 32'b0; 
					end
					else
						RAM[ADDRESS] <= {wbyte3, wbyte2, wbyte1, wbyte0};
				end
			  end
			  
			  initial begin
				$write("RAM: ---------------------------------------------------------\n");
				$write("RAM: flat memory model\n");
				$write("RAM: %s [ %x : %x ]\n", MEMNAME, MEMBASE, MEMTOP);
				$write("RAM: memory width = %d bits\n", DATAWIDTH);
				$write("RAM: memory size  = %d kb\n", ((1<<ADDRWIDTH)>>(10-((DATAWIDTH/32)+1))));
				$write("RAM: ---------------------------------------------------------\n");
			  end
			  
endmodule
			  
			  
