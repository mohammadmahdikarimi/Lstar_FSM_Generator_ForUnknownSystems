function [  ] = DFSM_f( Transport_Index , F)
%DFSM_F Summary of this function goes here
%   Detailed explanation goes here
close all
global A na
st=size(Transport_Index,1);

j3=find(all(bsxfun(@eq, F(:,1), 1),2));
figure('Name',na)
hold on
for i=1:st
    
    pos = [-.5+(3*(i-1)) -.5 1 1];
    rectangle('Position',pos,'Curvature',[0 0])
    
    if ismember(i,j3)
        pos = [-.55+(3*(i-1)) -.55 1.1 1.1];
        rectangle('Position',pos,'Curvature',[0 0])
    end
    
    str2 = sprintf('State #%d',i);
    text(pos(1),pos(2)+0.1,str2,'FontWeight','bold')
    hold on
    
    % find all the unique element of the transport_index
    j1{i}=unique(Transport_Index(i,:));
    
    % then find their corresponding position in the matrix and save it in a
    % new variable in the way that for example we know what events are
    % responsible for the transition from i-->j with the new variable
    % index{i,j}, and i is the current state (the row) and j is the
    % transition destination through the event.
    for j2=1:size(j1{i},2)
        index{i,j1{i}(j2)} = find(all(bsxfun(@eq, Transport_Index(i,:), j1{i}(j2)), 1));
    end
    
    
    %%%% now I have plotted a box for each states then I should make the
    %%%% transition withe the arc function and put the corresponding
    %%%% pointer to it and thats it :)
    
    for i2=1:size(j1{i},2)
        if i<j1{i}(i2)
            C=+0.5;
            P1=[3*(i-1),C];
            P2=[3*(j1{i}(i2)-1),C];
            p=Arc_f( P1 , P2 , C );
            index{i,j1{i}(i2)};
            str2 = sprintf(' %s,',A{index{i,j1{i}(i2)}});
            str2=strcat('\rightarrow',str2);
            text(p(1,1)-0.3,p(1,2)+0.1,str2,'FontWeight','bold')
            
        elseif i>j1{i}(i2)
            
            C=0.5;
            P1=[3*(i-1),-C];
            P2=[3*(j1{i}(i2)-1),-C];
            p=Arc_f( P1 , P2 , C );
            index{i,j1{i}(i2)};
            str2 = sprintf(' %s,',A{index{i,j1{i}(i2)}});
            str2=strcat('\leftarrow',str2);
            text(p(1,1)-0.3,p(1,2)-0.1,str2,'FontWeight','bold')
        elseif i==j1{i}(i2)
            
            C=0.2;
            P1=[3*(i-1)+.5,0];
            P2=[3*(i-1)-.5,0];
            p=Arc_f( P1 , P2 , C );
            index{i,j1{i}(i2)};
            str2 = sprintf(' %s,',A{index{i,j1{i}(i2)}});
            str2=strcat('\leftrightarrow',str2);
            text(p(1,1)-0.3,p(1,2)-0.1,str2,'FontWeight','bold')
            
        end
        
    end
end
ylim manual
ylim([-3,3])
end

