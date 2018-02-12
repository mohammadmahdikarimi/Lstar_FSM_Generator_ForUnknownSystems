function [ Ts,Tsa,Ts_el,Tsa_el,E ] = LstarLearning_f( a1, u1, na1 )
%J Summary of this function goes here
%   Detailed explanation goes here

global A U na U_system U_temp
A=a1;   % Alphabet
U_system=u1;   % Final values
na=na1; % Name of the model

% initializing the table
Ts={''};
Tsa={};
E={''};
flag_cl=1;
flag_co=1;
str='y';
% initializing the temporary final value of the system
prompt = 'Is it Realtime learning? y/n [n]: ';
str1 = input(prompt,'s');
U_temp={};

if isequal(str1,'y')
    for j=1:size(A,2)
        U_temp(end+1)=strcat('',A(j));
    end
end
U=cat(2,U_system, U_temp);


% initializing the table with empty element in Ts and their corresponding
% events in Tsa

for i=1:size(Ts,2)
    for j=1:size(A,2)
        Tsa(1,j+i-1)=A(1,j);
    end
end
Ts_el=Teacher_f(Ts,E);
Tsa_el=Teacher_f(Tsa,E);

%% Example:
% Ts={'','0','1','11'};
% Tsa={'00','01','10','110','111'};
%
% Ts_el=[1 0;0 1;0 0;1 0];
% Tsa_el=[1 0;0 0;0 0;0 1;0 0];
% E = {'','0'}
%%
sheet=1;  %Excel sheet
filename=sprintf('%s.xlsx',na);
delete(filename)

ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E ,na ,sheet);
sheet=sheet+1;


while str=='y'
    while ( flag_cl || flag_co )
        [ Ts,Tsa,Ts_el,Tsa_el,msg_cl,flag_cl ] = Close_f( Ts,Tsa,Ts_el,Tsa_el,E );
        if flag_cl
            ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E ,na ,sheet);
            sheet=sheet+1;
        end
        [ Ts,Tsa,Ts_el,Tsa_el,msg_co,E,flag_co ] = Consistent_f( Ts,Tsa,Ts_el,Tsa_el,E );
        
        if flag_co
            ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E ,na ,sheet);
            sheet=sheet+1;
        end
        
    end
    
    % [ Ts,Tsa,Ts_el,Tsa_el,msg_co,flag_co ] = Consistent_f( Ts,Tsa,Ts_el,Tsa_el,E )
    
    % resetting the flags here
    flag_cl=1;flag_co=1;
    
    
    % now that the system is complete and closed we make the DFSM out of the
    % table. we should now check the model and find the counter examples if
    % possible.
    [ Transport_Index , F] = DfsGen_f( Ts,Tsa,Ts_el,Tsa_el )
    
    DFSM_f( Transport_Index, F)

    % making a report from the table in excel
    
    % open(ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E ));
    
    [ Ts,Tsa,Ts_el,Tsa_el,str,msg ] = CounterExample_f( Ts, Tsa, Ts_el, Tsa_el, E )
    
    flag_ce=~isequal(msg,'Well Done!!');
    if flag_ce
        ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E ,na ,sheet);
        sheet=sheet+1;
    end
    
if str~='y'
    [ Ts,Tsa,Ts_el,Tsa_el,str,msg ] = ObservationExample_f( Ts, Tsa, Ts_el, Tsa_el, E )
    
    flag_ce=~isequal(msg,'Well Done!!');
    if flag_ce
        ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E ,na ,sheet);
        sheet=sheet+1;
    end
end
    
end
















end

