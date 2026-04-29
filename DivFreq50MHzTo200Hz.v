module DivFreq50MHzTo200Hz(Q, Clk, rst);									
	input Clk;									
	input rst;									
	output Q;									
										
	wire [16:0] q;									
									
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
	FlipFlopJK FF17 (.clk(q[16]), .rst(rst), .j(1'b1), .k(1'b1), .q(Q));																						
										
endmodule									