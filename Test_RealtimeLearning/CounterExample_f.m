function [ Ts,Tsa,Ts_el,Tsa_el,str ,message  ] = CounterExample_f( Ts, Tsa, Ts_el, Tsa_el, E )
%COUNTEREXAMPLE_F Summary of this function goes here
%   Detailed explanation goes here
global A
count=0;
prompt = 'Any Available Counter Example? y/n [n]: ';
str = input(prompt,'s');

while ~isequal(str,'y') && ~isequal(str,'n') && ~isempty(str)
    
    prompt = 'Again Please!! Any Available Counter Example? y/n [n]: ';
    str = input(prompt,'s');
    count=count+1;
    if count==4
        break;
    end
end

if isempty(str) || isequal(str,'n')
    str = 'n';
    message='Well Done!!';
    return;
elseif str == 'y'
    prompt = 'Please Provide a Counter Example:';
    Cex = input(prompt,'s');
    
    % adding prefix of the string into the Ts( if they are not
    % already in the Ts
    
    for i=1:size(Cex,2)
        [Lia2,~]=ismember(Cex(1,1:i),Ts);
        [Lia3,Locb3]=ismember(Cex(1,1:i),Tsa);
        if Lia2==0
            Ts(end+1)={Cex(1,1:i)};
            % Ts_el(end+1)=Tsa_el(Locb3);
            % delete the corresponding row from Tsa
            if Lia3
                Tsa(Locb3)=[];
                %                     Tsa_el(Locb3)=[]; we dond need this one, why? as in
                %                     next step we are adding the suffix of the string to
                %                     the Tsa and this changes the dimention of Tsa and
                %                     Tsa_el. we also use Teacher_f funtion to make the new
                %                     Tsa_el from the begining.
                
            end
            % add its suffix to Tsa
            for j=1:size(A,2)
                Tsa(end+1)=strcat(Cex(1,1:i),A(j));
            end
        end
    end
    Ts_el=Teacher_f(Ts,E);
    Tsa_el=Teacher_f(Tsa,E);
    message=sprintf('Counter example %s is provided',Cex);
end

end

