module TrvPSel(Slc, Travas);
	input [3:0] Travas;
	output [1:0] Slc;
	
	or(Slc[1], Travas[3], Travas[2]);
	or(Slc[0], Travas[3], Travas[1]);

endmodule