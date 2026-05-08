module Main(a, b, c, d, e, f, g, TravaGeral, S, F, T, P, L, CLK, Slc0, Slc1, reset);

	input F, T, P, L, Slc0, Slc1, reset, CLK;
	output [3:0]a;
	output [3:0]b;
	output [3:0]c;
	output [3:0]d;
	output [3:0]e;
	output [3:0]f;
	output [3:0]g;
	output [7:0]S;	
	output TravaGeral;
	
	wire [3:0]N;
	wire [4:0]M;
	wire Alt, Inv, Prg, Clock;
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
	
	Logic L0(.S(N), .A(InF), .B(InT), .C(InP), .D(InL));
	
	Mux4inp4bits Mux0(
	.S(M), 
	.A({1'b0, N[3], N[2], N[1], N[0]}), 
	.B({1'b1, InF, InT, InP, InL}), 
	.C(4'b01001), 
	.D(4'b01000), 
	.Slc0(Slc0), 
	.Slc1(Slc1));
	
	ConvDispP1 DispProb1(.a(aOrg), .b(bOrg), .c(cOrg), .d(dOrg), .e(eOrg), .f(fOrg), .g(gOrg), .A(M[4]), .B(M[3]), .C(M[2]), .D(M[1]), .E(M[0]));
		
	wire aOrg, bOrg, cOrg, dOrg, eOrg, fOrg, gOrg;
		
	or(a[0], TravaGeral, aOrg);
	or(b[0], TravaGeral, bOrg);
	or(c[0], TravaGeral, cOrg);
	or(d[0], TravaGeral, dOrg);
	or(e[0], TravaGeral, eOrg);
	or(f[0], TravaGeral, fOrg);
	or(g[0], TravaGeral, gOrg);
	
	LogicaLEDs Log0(
	.Alt(Alt), 
	.Inv(Inv), 
	.Prg(Prg), 
	.A(M[3]), 
	.B(M[2]), 
	.C(M[1]), 
	.D(M[0]));

	wire [7:0] SOrg;
	
	Mux4inp8bits Mux1(
	.S(SOrg), 
	.A({1'b0, Prg, Inv, Alt, 1'b0, 1'b0, 1'b0, 1'b0}), 
	.B({1'b0, 1'b0, 1'b0, 1'b0, InF, InT, InP, InL}), 
	.C(8'b10000000), 
	.D(8'b01000000), 
	.Slc0(Slc0), 
	.Slc1(Slc1));
	
	and(S[0], SOrg[0], NTrvGeral);
	and(S[1], SOrg[1], NTrvGeral);
	and(S[2], SOrg[2], NTrvGeral);
	and(S[3], SOrg[3], NTrvGeral);
	and(S[4], SOrg[4], NTrvGeral);
	and(S[5], SOrg[5], NTrvGeral);
	and(S[6], SOrg[6], NTrvGeral);
	and(S[7], SOrg[7], NTrvGeral);
	
	// Problema 2
	
	Cont5Bits ContF(
	.q(CF), 
	.Inp(InpF), 
	.rst(rst));
	
	wire [1:0]nCF;
	not(nCF[0], CF[1]);
	not(nCF[1], CF[3]);
	
	and(Trv[0], CF[0], nCF[0], CF[2], nCF[1], CF[4]);
    
	 Cont5Bits ContT(
	.q(CT), 
	.Inp(InpT), 
	.rst(rst));
	
	wire [1:0]nCT;
	not(nCT[0], CT[1]);
	not(nCT[1], CT[3]);
	
	and(Trv[1], CT[0], nCT[0], CT[2], nCT[1], CT[4]);
	
	Cont5Bits ContP(
	.q(CP), 
	.Inp(InpP), 
	.rst(rst));
	
	wire [1:0]nCP;
	not(nCP[0], CP[1]);
	not(nCP[1], CP[3]);
	
	and(Trv[2], CP[0], nCP[0], CP[2], nCP[1], CP[4]);
	
	Cont5Bits ContL(
	.q(CL), 
	.Inp(InpL), 
	.rst(rst));
	
	wire [1:0]nCL;
	not(nCL[0], CL[1]);
	not(nCL[1], CL[3]);
	
	and(Trv[3], CL[0], nCL[0], CL[2], nCL[1], CL[4]);
	 
	 DivFreq Freq(
	 .Q(Clock), 
	 .Clk(CLK));
	 
	 Cont2Bits Timer(
	 .q(Tmr),
	 .rst(rst),
	 .Clk(Clock));
	 
	 Mux1Sel MXSeletor0(
	 .S(Seletor[1]),
	 .InpA(Tmr[1]),
	 .InpB(PriSlc[1]), //Aqui e a saida do codificador das travas!!!!!
	 .Slc(TravaGeral)); //Aqui e se travou ou nao
	 
	 Mux1Sel MXSeletor1(
	 .S(Seletor[0]),
	 .InpA(Tmr[0]),
	 .InpB(PriSlc[0]), //Aqui e a saida do codificador das travas!!!!!
	 .Slc(TravaGeral)); //Aqui e se travou ou nao
	 
	 codificador_letras codwarzone(.sel({Seletor[1], Seletor[0]}), .segmento({g[3], f[3], e[3], d[3], c[3], b[3], a[3]}));
	 
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
	 .Pulso(FF), 
	 .Inp(F), 
	 .Clk(CLK), 
	 .rst(1'b0));

	 Debouncer DB1(
	 .Pulso(FT), 
	 .Inp(T), 
	 .Clk(CLK), 
	 .rst(1'b0));
	 
	 NegDebouncer DB2(
	 .Pulso(FP), 
	 .Inp(nFP), 
	 .Clk(CLK), 
	 .rst(1'b0));
	 
	 not(nFP, P);
	 not(nFL, L);
	 
	 NegDebouncer DB3(
	 .Pulso(FL), 
	 .Inp(nFL), 
	 .Clk(CLK), 
	 .rst(1'b0));
	 
	 wire FF, FT, FP, FL;
	 wire InF, InT, InP, InL;
	 
	 and(InpF, FF, NTrvGeral);
	 and(InpT, FT, NTrvGeral);
	 and(InpP, FP, NTrvGeral);
	 and(InpL, FL, NTrvGeral);
	 
	 and(InF, F, NTrvGeral);
	 and(InT, T, NTrvGeral);
	 and(InP, P, NTrvGeral);
	 and(InL, L, NTrvGeral);
	 
endmodule
