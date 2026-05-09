# Sistema sequencial de monitoramento com contagem de eventos em Verilog
Um projeto funcional de um circuito sequencial escrito em Verilog que aprimora o código do [Problema 1](https://github.com/levisenandrade/pbl1_cd) para ser implementado na FPGA DE10-Lite. O objetivo deste projeto é ser capaz de manipular contadores, registradores e lógica síncrona.

Este projeto apresenta a resolução do Problema 2 do modelo PBL da Disciplina de Circuitos Digitais. Cada módulo utilizado no projeto será descrito e apresentado neste README.

## Main

O módulo Main atua como a unidade central de processamento e controle do sistema, integrando subsistemas de hardware para monitorar quatro entradas distintas (Fumaça, Temperatura, Presença e Luz) tratadas por circuitos de debounce. Ele coordena a lógica de contagem individual de 5 bits para cada entrada e implementa um mecanismo de segurança de "trava geral" que bloqueia o sistema ao atingir estados críticos, gerenciando simultaneamente a multiplexação de dados para exibir informações em múltiplos displays de 7 segmentos.

## Codificador de Letras (7 Segmentos)

Circuito combinacional que converte uma entrada binária de 2 bits em padrões de iluminação para um display de 7 segmentos. Ele mapeia quatro combinações binárias de entrada para padrões específicos de acendimento, permitindo a exibição de caracteres ou símbolos em um display.

## Contador síncrono de 2 bits 
Utiliza Flip-Flops JK com lógica combinacional de realimentação para controlar as transições de estado de forma sincronizada ao sinal de clock.   
* Lógica de Controle: Possui portas OR intermediárias que determinam as entradas J e K do segundo estágio, baseando-se nos estados atuais de saída.   
* Seletor de Varredura: Atua como o gerador de endereços para a multiplexação dos sensores, permitindo a alternância cíclica de exibição.   
* Sincronismo Total: As transições de todos os bits ocorrem simultaneamente, garantindo maior estabilidade temporal para o sistema de monitoramento.   Módulo 4: Por ter 2 bits, ele percorre $2^2 = 4$ estados possíveis antes de reiniciar o ciclo. 
  
## Contador síncrono de 5 bits
Contador binário síncrono de 5 bits projetado para registrar o histórico de ativações dos sensores (0 a 31). Utiliza lógica de transporte antecipado para garantir estabilidade nas transições de estado.  
* Sincronismo: Todos os estágios compartilham o mesmo clock de entrada (Inp), eliminando atrasos de propagação acumulados.  
* Lógica de Carry: Emprega portas AND para controlar o incremento dos bits superiores apenas quando os anteriores atingem nível alto.
* Controle de Reset: Possui entrada rst para zerar a contagem imediatamente, atendendo aos requisitos de segurança do sistema.  
* Capacidade: Módulo 32 ($2^5$), permitindo o monitoramento completo até o limite crítico de 20 eventos definido pelo projeto. 

## Conversor
Circuito combinacional projetado para converter um valor binário de 5 bits (0 a 31) em sua representação decimal codificada em binário (BCD), separando o valor em Dezenas e Unidades.

* Entrada e Saída: Recebe um barramento de 5 bits ($2^5 = 32$ estados possíveis) e gera saídas distintas para a dezena (2 bits) e unidade (4 bits).
  
## Debouncer e detector de borda
Circuito projetado para estabilizar sinais de entrada provenientes de chaves mecânicas (push-buttons), eliminando o efeito bounce, e gerar um pulso único de duração de um ciclo de clock para cada acionamento.

* Utiliza um shift register com Flip-Flops JK para validar a entrada. O sinal só é considerado "estável" após permanecer em nível alto por um valor determinado de ciclos consecutivos do clock filtrado.
* Implementa uma lógica que compara o estado atual com o estado anterior, resultando em um pulso de saída.

## Divisor de frequência
Divisor de frequência de 27 estágios; utiliza uma cadeia de Flip-Flops JK em modo toggle para realizar a divisão sucessiva por 2 em cada estágio, resultando em um fator de redução total de 2^27 no sinal de saída.

## Flipflop JK
Implementação comportamental de um Flip-Flop JK sensível à borda de subida (posedge) com reset assíncrono. Inclui suporte aos modos de operação Hold, Reset, Set e Toggle, além de fornecer saídas complementares (Q e Qˉ​).

## Codificador do sistema de travamento

Esse módulo recebe as travas individuais de cada contador e os transformam em um código binário predefinido para cada letra, por exemplo:
Temos o código 1000, sendo FTPL. O módulo recebe, identifica o código e o transforma em 00, que significa F. Isso para cada sensor, sendo 0100 -> 01 -> T. 

Acesso às releases:
https://github.com/levisenandrade/pbl2_cd/releases/
