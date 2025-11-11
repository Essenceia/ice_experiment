// TODO: add tb

module top_tb;

reg clk = 0;
reg rst; 

// dump waves 
initial begin
	$dumpfile("build/top_tb.vcd");
	$dumpvars(0, top_tb);
	rst = 1'b1;
	#30;
	rst = 1'b0;
	#10000000 $finish;
end

always #1 clk = ~clk; 

top dut(
	.clk(clk),
	.switch0_i(rst),

	.pmod_i(8'b0),
	.led0_o(),
	.segA_o(),
	.segB_o()
);

endmodule
