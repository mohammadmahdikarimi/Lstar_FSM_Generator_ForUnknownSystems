function [ Ts,Tsa,Ts_el,Tsa_el,msg, E, Consistency_Check ] = Consistent_f( Ts,Tsa,Ts_el,Tsa_el,E )
%CONSISTENT_F Checks if the table is consistent or not, if its consistent
%the message would be issued to report the consistency of the table, but
%if the table is not consistnet it will try to make the table consistent by
%increasing the columns of the table according to the Lstar algorithm

%%% Example1:
% Ts={'','0','1','11'};
% Tsa={'00','01','10','110','111'};
%
% Ts_el=[1 0;0 1;0 0;1 0];
% Tsa_el=[1 0;0 0;0 0;0 1;0 0];
% E = {'','0'}

%%% Example2:
% global A U
% A={'a','b'};
% U={'aa','bb','bab'};
% Ts={'','a','b','aa','bb'};
% Tsa={'ab','ba','aaa','aab','bba','bbb'};
% 
% Ts_el=[0 0;0 1;0 0;1 0;1 0];
% Tsa_el=[0 0;0 0;0 0;0 0;0 0;0 0];
% E = {'','a'}

global A
j1=unique(Ts_el,'rows','stable');
Consistency_Check=0;
for i=1:size(j1,1)
    % find all eqal rows
    index = find(all(bsxfun(@eq, Ts_el, j1(i,:)), 2));
    if size(index,1)>1
        
        % find all combination of choosing 2 out of all similar rows to
        % check their corresponding event transition answer
        
        c1 = nchoosek(index,2);
        for i2=1:size(c1,1)
            t1=Ts{c1(i2,1)};
            t2=Ts{c1(i2,2)};
            for i3=1:size(A,2)
                % add one event to the state
                t3=strcat(t1,A(i3));
                t4=strcat(t2,A(i3));
                
                [Lia1,Locb1]=ismember(t3,Ts);
                [Lia2,Locb2]=ismember(t3,Tsa);
                st_nav=0;
                if Lia1
                    t3_el=Ts_el(Locb1,:);
                    %%%% I was trying to compare the element of two
                    %%%% equivalet rows
                    
                elseif Lia2
                    t3_el=Tsa_el(Locb2,:);
                else
                    sprintf('no stirng for %s',t3{1})
                    st_nav=1;
                end
                
                [Lia3,Locb3]=ismember(t4,Ts);
                [Lia4,Locb4]=ismember(t4,Tsa);
                
                if Lia3
                    t4_el=Ts_el(Locb3,:);
                elseif Lia4
                    t4_el=Tsa_el(Locb4,:);
                else
                    sprintf('no stirng for %s',t4{1})
                    st_nav=1; % created string is not available in any table
                end
                
                % at this point I know what rows are equal and their
                % corresponding string is available
                
                if ~st_nav
                    
                    % here we find the event that makes the change in the
                    % row of the table with the same event
                    Consistency_Check=~isequal(t4_el,t3_el);
                    if Consistency_Check
                        % add the A(i3) (the alphabet that we added in the
                        % end of the equal row strings and the event that
                        % makes the inequality.
                        
                        % I want to find the first event that makes the
                        % inequality in the observing row
                        index2=find(abs(t4_el-t3_el));
                        E(end+1)=strcat(A(i3),E(index2(1)));
                        Ts_el=Teacher_f(Ts,E);
                        Tsa_el=Teacher_f(Tsa,E);
                        msg='Tabel is now consistent';
                        return;
                    end
                end
                
            end
        end
    end
end


if ~Consistency_Check
    msg='Tabel was already consistent';
    %     disp(msg)
else
    msg='WEIERED';
end
