module fifo_2_deep#(
	parameter DATA_W = 2
)(
	input w_clk,
	input r_clk,

	input w_nreset,
	input r_nreset,

	input w_rec_i,
	output w_full_o,
	input [DATA_W-1:0] w_data_i,

	input r_rec_i,
	output r_empty_o,
	output [DATA_W-1:0] r_data_o
);
reg   w_addr_q;
wire w_en;
wire w_valid;
reg   w_r_addr_q;
reg   w_r_addr_meta_q;

reg   r_addr_q;
wire r_en;
wire r_valid;
reg   r_w_addr_q;
reg   r_w_addr_meta_q;

reg [DATA_W-1:0] ram_data_q[1:0];
wire [DATA_W-1:0] ram_data_next[1:0];

/* write */
assign w_en = w_rec_i & ~w_full_o;
assign w_full_o = w_addr_q ^ w_r_addr_q;

always @(posedge w_clk) begin
	if (w_nreset) begin
		w_addr_q <= 1'b0;
	end else if ( w_en ) begin
		w_addr_q <= ~w_addr_q;
	end
end

/* cdc w -> r */
always @(posedge r_clk) begin
	r_w_addr_meta_q <= w_addr_q;
	r_w_addr_q <= r_w_addr_meta_q;
end
/* cdc r -> w */
always @(posedge w_clk) begin
	w_r_addr_meta_q <= r_addr_q;
	w_r_addr_q <= w_r_addr_meta_q;
end

/* async 2-port ram */
always @(posedge w_clk) begin
	if ( w_en) begin
		ram_data_q[w_addr_q] <= w_data_i;
	end
end

/* read */
assign r_empty_o = ~(r_addr_q ^ r_w_addr_q);
assign r_en = ~r_empty_o & r_rec_i;

always @(posedge clk) begin
	if (r_nreset)begin
		r_addr_q <= 1'b0;
	end else if (r_en) begin
		r_addr_q <= ~r_addr_q;
	end
end
assign r_data_o = ram_data_q[r_addr_q];

endmodule
