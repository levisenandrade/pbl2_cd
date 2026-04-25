module Cont5Bits(q, Inp, rst);
	input Inp;
	input rst;
	output [4:0] q;
	
	wire Trava, Entrada;
	wire [4:0]qn;
	
	and(Entrada, Inp, Trava);

	FlipFlopJK FF0 (
	.clk(Entrada),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[0]),
	.qbar(qn[0]));

	// FFs subsequentes recebem o clock da saída Q do anterior

	FlipFlopJK FF1 (
	.clk(qn[0]),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[1]),
	.qbar(qn[1]));
	
	FlipFlopJK FF2 (
	.clk(qn[1]),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[2]),
	.qbar(qn[2]));
	
	FlipFlopJK FF3 (
	.clk(qn[2]),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[3]),
	.qbar(qn[3]));
	
	FlipFlopJK FF4 (
	.clk(qn[3]),
	.rst(rst),
	.j(1'b1),
	.k(1'b1),
	.q(q[4]),
	.qbar(qn[4]));
	
	
	or(Trava, qn[0], qn[2], qn[4], q[1], q[3]);

endmodule