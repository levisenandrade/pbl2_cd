module Debouncer(FiltInp, Inp, Clk, rst);
	input Inp, Clk, rst;
	output FiltInp;
	
	wire Clock, nInp;
	
	DivFreq50MHzTo200Hz DivF(
	.Q(Clock), 
	.Clk(Clk));
	
	not(nInp, Inp);
	
	FlipFlopJK FF0  (.clk(Clock), .rst(rst), .j(Inp), .k(nInp), .q(FiltInp));	

endmodule