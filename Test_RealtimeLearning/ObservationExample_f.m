function [ Ts,Tsa,Ts_el,Tsa_el,str ,message  ] = ObservationExample_f( Ts, Tsa, Ts_el, Tsa_el, E )
%COUNTEREXAMPLE_F Summary of this function goes here
%   Detailed explanation goes here
global A U U_temp U_system
count=0;
prompt = 'Any Available Observation Example? y/n [n]: ';
str = input(prompt,'s');

while ~isequal(str,'y') && ~isequal(str,'n') && ~isempty(str)
    
    prompt = 'Again Please!! Any Available Observation Example? y/n [n]: ';
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
    prompt = 'Please Provide a Observation Example:';
    Oex = input(prompt,'s');
    U_system(end+1)={Oex}
    % adding prefix of the string into the Ts( if they are not
    % already in the Ts
    
    % (no need to add the observation as counter example, just update the
    % table)
    
    %{
    for i=1:size(Oex,2)
        [Lia2,~]=ismember(Oex(1,1:i),Ts);
        [Lia3,Locb3]=ismember(Oex(1,1:i),Tsa);
        if Lia2==0
            Ts(end+1)={Oex(1,1:i)};
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
                Tsa(end+1)=strcat(Oex(1,1:i),A(j));
            end
        end
    end
    %}
    
    % add its suffix to U_temp to assume that future moves are in system
    U_temp={};
    for j=1:size(A,2)
        U_temp(end+1)=strcat(Oex,A(j));
    end
    U=cat(2,U_system, U_temp);


    Ts_el=Teacher_f(Ts,E);
    Tsa_el=Teacher_f(Tsa,E);
    message=sprintf('Observation Example %s is provided',Oex);
end

end

