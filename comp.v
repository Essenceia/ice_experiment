
module top(
	input clk,
	input switch0_i,
	input [7:0] pmod_i,
	output led0_o
);
reg  [7:0] pmod_meta_q;
reg  [7:0] pmod_q;
reg  [7:0] a;
reg  [7:0] b;


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
	{b, a} <= {a, pmod_q};
end

wire res;


assign res =  a[b[2:0]];

/*
always @(a or b )begin
	case(b[7:0])//synopsys full_case parallel_case
		8'h1: res <= a[0];
		8'h2: res <= a[1];
		8'h4: res <= a[2];
		8'h8: res <= a[3];
		8'h10: res <= a[4];
		8'h20: res <= a[5];
		8'h40: res <= a[6];
		8'h80: res <= a[6];
	endcase
end
*/
// These are pretty janky logic level count
// I am not totally brain dead 
// yes I am
assign led0_o =  res;
//assign led0_o =  |a & |b[4:0];
endmodule
