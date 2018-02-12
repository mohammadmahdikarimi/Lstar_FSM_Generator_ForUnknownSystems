function [ Ts,Tsa,Ts_el,Tsa_el,msg, Closeness_Check ] = Close_f( Ts,Tsa,Ts_el,Tsa_el,E )
% this function takes Ts and Tsa and their corresponding elements in the
% tabel and returns the new closed Ts and Tsa

Closeness_Check=0;
global A
% first finding the unique rows in Tsa_el (the table elements)
j2=unique(Tsa_el,'rows');

% find any row in Tsa_el which is not in Ts_el
for j4=1:size(j2,1)
    [~,Locb1]=ismember(j2(j4,:),Tsa_el,'rows');
    [Lia2,~]=ismember(j2(j4,:),Ts_el,'rows');
    
    % add the corresponding string to from Tsa to Ts
    
    if Lia2==0
        Closeness_Check=1;
        j3=Tsa(Locb1);
        
        % adding prefix of the string into the Ts( if they are not
        % already in the Ts
        
        for i=1:size(j3,2)
            [Lia2,~]=ismember(j3(1,1:i),Ts);
            [Lia3,Locb3]=ismember(j3(1,1:i),Tsa);
            if Lia2==0
                Ts(end+1)=j3(1,1:i);
                % Ts_el(end+1)=Tsa_el(Locb3);
                % delete the corresponding row from Tsa
                if Lia3
                    Tsa(Locb3)=[];
%                     Tsa_el(Locb3)=[];
                    
                end
                % add its suffix to Tsa
                for j=1:size(A,2)
                    Tsa(end+1)=strcat(j3(1,1:i),A(j));
                end
            end
        end
    end
    
    
end

if ~Closeness_Check
    msg='Tabel was already closed';
    %     disp(msg)
else
     msg='Tabel is now closed';
end
Ts_el=Teacher_f(Ts,E);
Tsa_el=Teacher_f(Tsa,E);

end

