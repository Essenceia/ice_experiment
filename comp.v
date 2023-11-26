
module top(
	input clk,
	input switch0_i,
	input [7:0] pmod_i,
	output led0_o
);
reg  [7:0] pmod_meta_q;
reg  [7:0] pmod_q;
reg  [31:0] a;
reg  [31:0] b;
wire [31:0] unused;


always @(posedge clk) begin
	if(switch0_i)begin
		pmod_meta_q <= 'b0;
		pmod_q <= 'b0;
	end else begin
		pmod_meta_q <= pmod_i;
		pmod_q <= pmod_meta_q;
	end
end

always @(posedge clk) begin
	{b, a} <= {b[23:0] ,a, pmod_q};
end

wire res;
wire [31:0] unused;
assign {res. unused} = $countones(b);
assign led0_o =  res;
endmodule
