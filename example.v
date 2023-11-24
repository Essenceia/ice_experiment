/*
module mul_X#(
	parameter W = 32,
	parameter [W-1:0] X = 5
)(
	input  [W-1:0] d_i,
	output [W-1:0] d_o
);
	assign d_o = d_i * X;
endmodule
*/


module top (
	input  clk, 
	input  switch0_i,
	input  switch1_i, 
	output led0_o,
	output led1_o,
	output led2_o,
	output led3_o,
	output [6:0] segA_o
	);
	wire reset; 
	assign reset = switch0_i;

	/* counter */
	reg   [27:0] cnt_q; 
	always @(posedge clk or posedge reset)begin
		if(reset)begin
			cnt_q <= 'b0;
		end else begin
			cnt_q <= cnt_q + 'd1;
		end
	end
	asc_to_7seg m_7seg(
		.bin({4'b0, cnt_q[27:24]}),
		.seg(segA_o)
	);

	/* no sync */
	assign led0_o = switch0_i;

	/* 2ff sync */
	reg meta_q;
	reg stable_q;
	always @(posedge clk) begin
		meta_q <= switch0_i;
		stable_q <= meta_q;
	end	
	assign led1_o = stable_q;

	/* default led */
	assign led2_o = 1'b0;
	assign led3_o = 1'b0;
endmodule

