module mul_X#(
	parameter W = 32,
	parameter [W-1:0] X = 5
)(
	input  [W-1:0] d_i,
	output [W-1:0] d_o
);
	assign d_o = d_i * X;
endmodule

module top (input a, b, output y);
	localparam W = 32;
  	wire [W-1:0] x;
  	wire [W-1:0] r0;
	
	assign x = { a, 29'b0,b, a};

	mul_X #(.W(W),.X(6))m_5(
		.d_i(x),
		.d_o(r0)
	);	

	assign y = |(r0);

endmodule

