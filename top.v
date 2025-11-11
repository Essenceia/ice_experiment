
module top(
	input clk,
	input switch0_i,
	input [7:0] pmod_i,
	output led0_o,
	output [6:0] segA_o, 
	output [6:0] segB_o 
);
reg  [7:0]  pmod_meta_q;
reg  [7:0]  pmod_q;
reg  [7:0]  a;
reg  [7:0]  b;
reg  [28:0] cnt_q;
reg         unused_cnt_q;

always @(posedge clk) begin
	if(switch0_i)begin
		pmod_meta_q <= 8'b0;
		pmod_q <= 8'b0;
		cnt_q <= 10'b0;
	end else begin
		pmod_meta_q           <= pmod_i;
		pmod_q                <= pmod_meta_q;
		{unused_cnt_q, cnt_q} <= cnt_q + 29'd1;
	end
end

always @(posedge clk) begin
	{b, a} <= {a, pmod_q};
end

wire res;
assign res =  a[b[2:0]];

asc_to_7seg m_7segB(
	.bin({4'b0, cnt_q[24:21]}),
	.seg(segB_o)
);

asc_to_7seg m_7segA(
	.bin({4'b0, cnt_q[28:25]}),
	.seg(segA_o)
);

/* output */
assign led0_o =  res;
endmodule
