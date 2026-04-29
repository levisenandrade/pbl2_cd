module Main(a, b, c, d, e, f, g, S, F, T, P, L, CLK, Slc0, Slc1, reset);

	input F, T, P, L, Slc0, Slc1, reset, CLK;
	output [2:0]a;
	output [2:0]b;
	output [2:0]c;
	output [2:0]d;
	output [2:0]e;
	output [2:0]f;
	output [2:0]g;
	output [7:0]S;	
	
	wire [3:0]N;
	wire [4:0]M;
	wire Alt, Inv, Prg, Clock, TravaGeral;
	wire [3:0]Trv;
	wire [4:0] CF;
	wire [4:0] CT;
	wire [4:0] CP;
	wire [4:0] CL;
	wire [1:0] Tmr;
	wire [1:0] Seletor;
	wire [4:0] MGeral;
	wire [1:0] Dezn;
	wire [3:0] Unid;
	wire [1:0] PriSlc;
	wire rst;
	
	wire InpF, InpT, InpP, InpL, NTrvGeral;
	
	not(rst, reset);
	
	Logic L0(.S(N), .A(F), .B(T), .C(P), .D(L));
	
	Mux4inp4bits Mux0(
	.S(M), 
	.A({1'b0, N[3], N[2], N[1], N[0]}), 
	.B({1'b1, F, T, P, L}), 
	.C(4'b01001), 
	.D(4'b01000), 
	.Slc0(Slc0), 
	.Slc1(Slc1));
	
	ConvDispP1 DispProb1(.a(a[0]), .b(b[0]), .c(c[0]), .d(d[0]), .e(e[0]), .f(f[0]), .g(g[0]), .A(M[4]), .B(M[3]), .C(M[2]), .D(M[1]), .E(M[0]));
	
	LogicaLEDs Log0(
	.Alt(Alt), 
	.Inv(Inv), 
	.Prg(Prg), 
	.A(M[3]), 
	.B(M[2]), 
	.C(M[1]), 
	.D(M[0]));

	Mux4inp8bits Mux1(
	.S(S), 
	.A({1'b0, Prg, Inv, Alt, 1'b0, 1'b0, 1'b0, 1'b0}), 
	.B({1'b0, 1'b0, 1'b0, 1'b0, F, T, P, L}), 
	.C(8'b10000000), 
	.D(8'b01000000), 
	.Slc0(Slc0), 
	.Slc1(Slc1));
	
	Cont5Bits ContF(
	.q(CF), 
	.Trava(Trv[3]), 
	.Inp(InpF), 
	.rst(rst));
    
	 Cont5Bits ContT(
	.q(CT), 
	.Trava(Trv[2]), 
	.Inp(InpT), 
	.rst(rst));
	
	Cont5Bits ContP(
	.q(CP), 
	.Trava(Trv[1]), 
	.Inp(InpP), 
	.rst(rst));
	
	Cont5Bits ContL(
	.q(CL), 
	.Trava(Trv[0]), 
	.Inp(InpL), 
	.rst(rst));
	 
	 DivFreq Freq(
	 .Q(Clock), 
	 .Clk(CLK));
	 
	 Cont2Bits Timer(
	 .q(Tmr),
	 .rst(rst),
	 .Clk(Clock));
	 
	 Mux1Sel Seletor0(
	 .S(Seletor[1]),
	 .InpA(Tmr[1]),
	 .InpB(PriSlc[1]), //Aqui e a saida do codificador das travas!!!!!
	 .Slc(TravaGeral)); //Aqui e se travou ou nao
	 
	 Mux1Sel Seletor1(
	 .S(Seletor[0]),
	 .InpA(Tmr[0]),
	 .InpB(PriSlc[0]), //Aqui e a saida do codificador das travas!!!!!
	 .Slc(TravaGeral)); //Aqui e se travou ou nao
	 
	 TrvPSel Travas(
	 .Slc(PriSlc), 
	 .Travas({Trv[3], Trv[2], Trv[1], Trv[0]}));
	 
	 Mux4inp5bits MuxGeral(
	 .S(MGeral), 
	 .A(CF), 
	 .B(CT), 
	 .C(CP), 
	 .D(CL), 
	 .Slc0(Seletor[1]), 
	 .Slc1(Seletor[0]));
	 
	 Conversor Conv(
	 .Dez(Dezn), 
	 .Uni(Unid), 
	 .Q(MGeral));
	 
	 ConvDispP1 DispUniProb2(.a(a[1]), .b(b[1]), .c(c[1]), .d(d[1]), .e(e[1]), .f(f[1]), .g(g[1]), .A(1'b1), .B(Unid[3]), .C(Unid[2]), .D(Unid[1]), .E(Unid[0]));
	 ConvDispP1 DispDezProb2(.a(a[2]), .b(b[2]), .c(c[2]), .d(d[2]), .e(e[2]), .f(f[2]), .g(g[2]), .A(1'b1), .B(1'b0), .C(1'b0), .D(Dezn[1]), .E(Dezn[0]));
	 
	 or(TravaGeral, Trv[3], Trv[2], Trv[1], Trv[0]);
	 
	 not(NTrvGeral, TravaGeral);
	 
	 Debouncer DB0(
	 .FiltInp(FF), 
	 .Inp(F),
	 .Clk(CLK),
	 .rst(rst));

	 Debouncer DB1(
	 .FiltInp(FT), 
	 .Inp(T),
	 .Clk(CLK),
	 .rst(rst));
	 
	 Debouncer DB2(
	 .FiltInp(FP), 
	 .Inp(P),
	 .Clk(CLK),
	 .rst(rst));
	 
	 Debouncer DB3(
	 .FiltInp(FL), 
	 .Inp(L),
	 .Clk(CLK),
	 .rst(rst));
	 
	 wire FF, FT, FP, FL;
	 
	 and(InpF, FF, NTrvGeral);
	 and(InpT, FT, NTrvGeral);
	 and(InpP, FP, NTrvGeral);
	 and(InpL, FL, NTrvGeral);
	 
endmodule
