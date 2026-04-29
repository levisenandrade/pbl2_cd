module Cont2Bits(q, rst, Clk);
	input Clk;
	input rst;
	output [1:0] q;
	
	wire [1:0]qn;

	FlipFlopJK FF0 (
	.clk(Clk),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[0]),
	.qbar(qn[0]));

	FlipFlopJK FF1 (
	.clk(qn[0]),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[1]),
	.qbar(qn[1]));
	
endmodule