module DivFreq(Q, Clk, rst);									
	input Clk;									
	input rst;									
	output Q;									
										
	wire [26:0] q;									
									
	// Para o JK dividir a frequência, J e K devem estar sempre em 1.									
										
	// FF0 recebe o Clock principal									
	FlipFlopJK FF0  (.clk(Clk),   .rst(rst), .j(1'b1), .k(1'b1), .q(q[0]));									
										
	// FFs subsequentes recebem o clock da saída Q do anterior									
	FlipFlopJK FF1  (.clk(q[0]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[1]));									
	FlipFlopJK FF2  (.clk(q[1]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[2]));									
	FlipFlopJK FF3  (.clk(q[2]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[3]));									
	FlipFlopJK FF4  (.clk(q[3]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[4]));									
	FlipFlopJK FF5  (.clk(q[4]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[5]));									
	FlipFlopJK FF6  (.clk(q[5]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[6]));									
	FlipFlopJK FF7  (.clk(q[6]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[7]));									
	FlipFlopJK FF8  (.clk(q[7]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[8]));									
	FlipFlopJK FF9  (.clk(q[8]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[9]));									
	FlipFlopJK FF10 (.clk(q[9]),  .rst(rst), .j(1'b1), .k(1'b1), .q(q[10]));									
	FlipFlopJK FF11 (.clk(q[10]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[11]));									
	FlipFlopJK FF12 (.clk(q[11]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[12]));									
	FlipFlopJK FF13 (.clk(q[12]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[13]));									
	FlipFlopJK FF14 (.clk(q[13]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[14]));									
	FlipFlopJK FF15 (.clk(q[14]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[15]));									
	FlipFlopJK FF16 (.clk(q[15]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[16]));									
	FlipFlopJK FF17 (.clk(q[16]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[17]));									
	FlipFlopJK FF18 (.clk(q[17]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[18]));									
	FlipFlopJK FF19 (.clk(q[18]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[19]));									
	FlipFlopJK FF20 (.clk(q[19]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[20]));									
	FlipFlopJK FF21 (.clk(q[20]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[21]));									
	FlipFlopJK FF22 (.clk(q[21]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[22]));									
	FlipFlopJK FF23 (.clk(q[22]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[23]));									
	FlipFlopJK FF24 (.clk(q[23]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[24]));									
	FlipFlopJK FF25 (.clk(q[24]), .rst(rst), .j(1'b1), .k(1'b1), .q(q[25]));									
	FlipFlopJK FF26 (.clk(q[25]), .rst(rst), .j(1'b1), .k(1'b1), .q(Q));									
										
endmodule									