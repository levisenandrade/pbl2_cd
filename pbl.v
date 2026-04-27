module pbl (
    input clk,
    input reset,
    output [4:0] q,  // A declaração já acontece aqui
	 output sinal_trava
);

wire [3:0] carry;
wire trava;
wire enable;

// Lógica de travamento (Detecta o valor 20: 10100)
wire n_q3, n_q1, n_q0;
not (n_q3, q[3]);
not (n_q1, q[1]);
not (n_q0, q[0]);
and (trava, q[4], n_q3, q[2], n_q1, n_q0);

// Inverte a trava para criar um sinal de "permite contagem"
not (enable, trava);

and (sinal_trava, q[4], n_q3, q[2], n_q1, n_q0);

// --- BIT 0 ---
// No JK, J=K=1 faz o bit inverter (Toggle). 
// Ele inverte sempre que o enable for 1.
FlipFlopJK ff0 (.clk(clk), .rst(reset), .j(enable), .k(enable), .q(q[0]));

// --- BIT 1 ---
// Inverte se (enable AND q[0])
and (carry[0], enable, q[0]);
FlipFlopJK ff1 (.clk(clk), .rst(reset), .j(carry[0]), .k(carry[0]), .q(q[1]));

// --- BIT 2 ---
// Inverte se (carry[0] AND q[1])
and (carry[1], carry[0], q[1]);
FlipFlopJK ff2 (.clk(clk), .rst(reset), .j(carry[1]), .k(carry[1]), .q(q[2]));

// --- BIT 3 ---
// Inverte se (carry[1] AND q[2])
and (carry[2], carry[1], q[2]);
FlipFlopJK ff3 (.clk(clk), .rst(reset), .j(carry[2]), .k(carry[2]), .q(q[3]));

// --- BIT 4 ---
// Inverte se (carry[2] AND q[3])
and (carry[3], carry[2], q[3]);
FlipFlopJK ff4 (.clk(clk), .rst(reset), .j(carry[3]), .k(carry[3]), .q(q[4]));

endmodule
