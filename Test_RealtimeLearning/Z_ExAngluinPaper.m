%{
%% EX1
A={'o','l'};
U={'','oo'};

[ Ts,Tsa,Ts_el,Tsa_el,E ]=LstarLearning_f(A,U,'Lstar Paper');
open('Lstar Paper.xlsx');
% %}
% 11 --> 011
%% EX1
A={'o','l'};
U={'','ll','oo','ollo','lloo','llll','olol'};

[ Ts,Tsa,Ts_el,Tsa_el,E ]=LstarLearning_f(A,U,'Lstar Paper');
% %}
% 11 --> 011
%% EX2
A={'o','l'};
U={'','lo','loo','looo','loooo'};

[ Ts,Tsa,Ts_el,Tsa_el,E ]=LstarLearning_f(A,U,'EX2');
%}
% 11 --> 011
%% EX2
A={'o','l'};
U={''};

[ Ts,Tsa,Ts_el,Tsa_el,E ]=LstarLearning_f(A,U,'EX2');

% 11 --> 011
%%
A={'o','l'};
U={'','ll','oo','ollo','lloo','llll','olol'};

[ Ts,Tsa,Ts_el,Tsa_el,E ]=LstarLearning_f(A,U,'Lstar Paper');

% 11 --> 011
%%
A={'o','l'};
U={'','ll','oo','ollo','lloo','llll','olol'};

[ Ts,Tsa,Ts_el,Tsa_el,E ]=LstarLearning_f(A,U,'Lstar Paper');

% 11 --> 011
%%
