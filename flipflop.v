 module flipflopJK (
    input clk,
    input reset,
    input j,
    input k,
    output reg q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: q <= q;    // Mantém estado
                2'b01: q <= 1'b0; // Reset
                2'b10: q <= 1'b1; // Set
                2'b11: q <= ~q;   // Toggle (Inverte)
            endcase
        end
    end
endmodule
