module NegDebouncer(Pulso, Inp, Clk, rst);
	input Inp, Clk, rst;
	output Pulso;
	
	wire [2:0] q;
	wire [1:0] nq;
	wire Clock, nInp, FiltInp, nFInp, nFiltInpAT, FiltInpAT;
	
	DivFreq50MHzTo200Hz DivF(
	.Q(Clock), 
	.Clk(Clk));
	
	not(nInp, Inp);
	not(nFInp, FiltInp);
	
	NegFlipFlopJK FF0  (.clk(Clock), .rst(rst), .j(Inp), .k(nInp), .q(q[0]), .qbar(nq[0]));
	NegFlipFlopJK FF1  (.clk(Clock), .rst(rst), .j(q[0]), .k(nq[0]), .q(q[1]), .qbar(nq[1]));
	NegFlipFlopJK FF2  (.clk(Clock), .rst(rst), .j(q[1]), .k(nq[1]), .q(q[2]));
	
	and(FiltInp, q[0], q[1], q[2]);

	NegFlipFlopJK FF_Edge (.clk(Clock), .rst(rst), .j(FiltInp), .k(nFInp), .q(FiltInpAT));
	
	not(nFiltInpAT, FiltInpAT);
	and(Pulso, FiltInp, nFiltInpAT);
	
endmodule
