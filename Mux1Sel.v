module Mux1Sel(S, InpA, InpB, Slc);		
	input InpA, InpB;	
	input Slc;	
	output S;	
		
	wire nSlc;
	wire [1:0]T;
		
	not(nSlc, Slc);	
		
	and(T[0], nSlc, InpA);	
	and(T[1], Slc, InpB);	
		
	or(S, T[0], T[1]);
		
endmodule