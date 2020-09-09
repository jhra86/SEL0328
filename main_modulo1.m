%%SEL0328 - Tarefa 1
% Cálculo dos vetores de tempo e velocidade angular
% Alunos: João Henrique Romeiro Alves, Orlando Wozniak de Lima Nogueira
close all; clear; clc


%% item 1:
%Dados da tabela 8.6:
w_vector = [26, 74.86, 116.21, 164.07, 223.96, 281.45]; 
Vtg_vector = [3.9, 11.8, 18.4, 25.4, 34, 42.6];

%
%minimos quadrados: 
P = polyfit(w_vector, Vtg_vector, 1);

%
%Figura para mínimos quadrados
figure
plot(w_vector, Vtg_vector, '*')
hold on
plot(w_vector, P(2)+w_vector*P(1))
title('Mínimos quadrados para cálculo do ganho do tacogerador')
xlabel('Frequência do motor [rad/s]')
ylabel('Tensão de saída do tacogerador [V]')
hold off

%

% O ganho do tacogerador é o coeficiente angular desta reta:
Ktg = P(1); %aprox. 0.1505 [Vs/rad]


%% item 2
%Carrega os vetores de tempo e tensão de saída do Tacogerador (enviados 
%junto com este código). Estes vetores foram extraidos dos arquivos
%F0001CH1.csv e F0001CH2.csv
load('V_corrente.mat')
load('V_omega.mat')
load('t.mat')

V_corrente = V_corrente*10;
V_omega = V_omega*10; %multiplicar pelo fator probe attenuation

%
%plot da curva de tensão de saída do Tacogerador
figure
plot(V_omega)
title('curva da tensão de saída do Tacogerador')
ylabel('tensão de saída do tacogerador [V]')

%
%plot da curva de tensão sobre o resistor
figure
plot(V_corrente)
title('curva da tensão sobre o resistor em série com armadura')
ylabel('tensão sobre o resistor [V]')

%% Resposta final

%vetor de tempo: 
t_degrau = t;

%vetor de posição angular:
w_degrau = V_omega/Ktg;

%vetor de corrente:
R = 1; %resistência externa utilizada para medição da corrente
i_degrau = V_corrente/R;

%
%plot da curva de velocidade angular por tempo
figure
plot(t, w_degrau)
title('curva de velocidade angular')
ylabel('Velocidade angular do motor [rad/s]')
xlabel('tempo [s]')

%
%plot da curva de corrente por tempo
figure
plot(t, i_degrau)
title('curva de corrente')
ylabel('Corrente na armadura do motor [A]')
xlabel('tempo [s]')

%%

u = 12.4*[zeros(199,1); ones(2500-199, 1)];
sample_t = t(2)-t(1);

%plot da curva de velocidade angular por tempo
figure
plot(t, w_degrau, t, u)
title('entrada e resposta no trempo')
legend('velocidade angular [rad/s]', 'sinal de controle [V]')

%%

% Funções transferência (ident):

G1 = tf(652.3, [1, 50.84]); %1 polo

G2 = tf(12.832, conv([0.019696 , 1],[1.7776e-06 , 1])); %2 polos
