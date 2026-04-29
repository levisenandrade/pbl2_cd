module FlipFlopJK (
    input clk,
    input rst,
    input j,
    input k,
    output reg q,
    output qbar
);

    // Lógica para a saída invertida
    assign qbar = ~q;

    // Bloco comportamental sensível à borda de subida do clock
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 1'b0; // Reset assíncrono para garantir estado inicial
        end else begin
            case ({j, k})
                2'b00: q <= q;    // No change (Mantém o estado)
                2'b01: q <= 1'b0; // Reset (Zera a saída)
                2'b10: q <= 1'b1; // Set (Força um na saída)
                2'b11: q <= ~q;   // Toggle (Inverte - essencial para o divisor)
            endcase
        end
    end

endmodule