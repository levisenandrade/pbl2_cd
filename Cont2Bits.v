module Cont2Bits(q, rst, Clk);
	input Clk;
	input rst;
	output [1:0] q;
	
	wire [1:0]qn;
	wire J1, K1;

	FlipFlopJK FF0 (
	.clk(Clk),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[0]),
	.qbar(qn[0]));

	FlipFlopJK FF1 (
	.clk(Clk),
	.rst(rst),
	.j(J1),
	.k(K1),
	.q(q[1]),
	.qbar(qn[1]));
	
	or(J1, q[1], q[0]);
	or(K1, qn[1], q[0]);
	
endmodule