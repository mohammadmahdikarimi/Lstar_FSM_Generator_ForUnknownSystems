function [ Transport_Index , F] = DfsGen_f( Ts,Tsa,Ts_el,Tsa_el )
%DFSGEN_F Summary of this function goes here
%   Detailed explanation goes here

% finding unique states
global A
[s1,ia1,ic1]=unique(Ts_el,'rows','stable');
for i1=1:size(s1)
    for i2=1:size(A,2)
        se1=strcat(Ts(ia1(i1)), A(i2));
        
        % now find the corresponding row for the state created and to see in
        % which table it is.
        
        [Lia1,Locb1]=ismember(se1,Ts);
        [Lia2,Locb2]=ismember(se1,Tsa);
        st_nav=0;
        if Lia1
            se1_el=Ts_el(Locb1,:);
        elseif Lia2
            se1_el=Tsa_el(Locb2,:);
        else
            error('no stirng for %s',se1{1})
            st_nav=1;
        end
        
        [Lia3,Locb3]=ismember(se1_el,s1,'rows');
        % at this time I know where the state goes with the event, to which
        % state now just I make a table with the row of unique states and
        % columns of available alphabet puting the future state number in
        % each place
        Transport_Index(i1 , i2) = Locb3;
    end
end
F=all(s1(:,1),2);

end

