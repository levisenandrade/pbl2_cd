module Cont5Bits(q, Inp, rst);
	input Inp;
	input rst;
	output [4:0] q;

	wire [4:0]qn;
	wire [3:0] T;
	
	or(T[0], qn[4], qn[2]);
	
	FlipFlopJK FF0 (
	.clk(Inp),
	.rst(rst),
	.j(1'b1),
	.k(T[0]),
	.q(q[0]),
	.qbar(qn[0]));
	
	FlipFlopJK FF1 (
	.clk(Inp),
	.rst(rst),
	.j(q[0]),
	.k(q[0]),
	.q(q[1]),
	.qbar(qn[1]));
	
	and(T[1], q[0], q[1]);
	
	FlipFlopJK FF2 (
	.clk(Inp),
	.rst(rst),
	.j(T[1]),
	.k(T[1]),
	.q(q[2]),
	.qbar(qn[2]));
	
	and(T[2], q[2], T[1]);
	
	FlipFlopJK FF3 (
	.clk(Inp),
	.rst(rst),
	.j(T[2]),
	.k(T[2]),
	.q(q[3]),
	.qbar(qn[3]));

	and(T[3], q[3], q[2], q[1], q[0]);
	
	FlipFlopJK FF4 (
	.clk(Inp),
	.rst(rst),
	.j(T[3]),
	.k(T[3]),
	.q(q[4]),
	.qbar(qn[4]));
endmodule