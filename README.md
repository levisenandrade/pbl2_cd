# Sistema sequencial de monitoramento com contagem de eventos em Verilog

Um projeto funcional de um circuito sequencial escrito em Verilog que aprimora o código do problema 1 (adicionar link) *** para ser implementado na FPGA DE10-Lite. O objetivo deste projeto é ser capaz de manipular contadores, registradores e lógica síncrona.

Este projeto apresenta a resolução do Problema 2 do modelo PBL da Disciplina de Circuitos Digitais. Cada módulo utilizado no projeto será descrito e apresentado neste README, são eles:

### Contador de 2 bits

Contador binário assíncrono (ripple counter) de 2 bits. Implementado em Verilog utilizando Flip-Flops JK configurados em modo toggle, com a saída complementar do primeiro estágio servindo de clock para o segundo.

*Não trava: Ele é um contador cíclico (00 → 01 → 10 → 11 → 00...).

* Menos complexo: Não possui portas lógicas (AND/OR) intermediárias, apenas os elementos de memória (FFs).

* Módulo 4: Por ter 2 bits, ele possui 2^2 = 4 estados possíveis.
### Contador de 5 bits

Contador assíncrono (ripple counter) de 5 bits implementado utilizando Flip-Flops JK. O módulo possui uma lógica de travamento (lock) baseada em uma porta OR que condiciona o sinal de entrada.

* Contagem: Ele utiliza 5 Flip-Flops JK em modo "toggle" (J=1, K=1) para contar de 0 a 31.

* Cascata (Ripple): O clock de cada estágio vem da saída barrada (qn) do estágio anterior, caracterizando um contador assíncrono.

* Lógica de Controle: A porta AND na entrada combina o sinal de pulso externo (Inp) com o sinal Trava.

* A "Trava": A porta OR monitora bits específicos. Se qualquer uma das condições (qn[0], qn[2], qn[4], q[1], q[3]) for verdadeira (nível alto), o contador continua operando. Se todas forem falsas, a saída Trava vai para 0 e bloqueia novos pulsos de clock.

### Conversor

### Divisor de Frequência

Divisor de frequência de 27 estágios; utiliza uma cadeia de Flip-Flops JK em modo toggle para realizar a divisão sucessiva por 2 em cada estágio, resultando em um fator de redução total de 2^27 no sinal de saída.

A frequência de saída é dada por:

f_{out} = \frac{f_{in}}{2^{27}} // colocar no formato latex

### Flipflop JK

Implementação comportamental de um Flip-Flop JK sensível à borda de subida (posedge) com reset assíncrono. Inclui suporte aos modos de operação Hold, Reset, Set e Toggle, além de fornecer saídas complementares (Q e Qˉ​).

### Codificador do sistema de travamento

Acesso às releases:
https://github.com/levisenandrade/pbl2_cd/releases/
