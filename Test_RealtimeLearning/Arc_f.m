function [ peak ] = Arc_f( P1 , P2 , C )

% pick two arbitrary points
% P1 = [0 0];
% P2 = [5 0];
% bulid a parametric curve
t = (0:.01:1)';

% a straight line between the points
L_1 = (1-t)*P1 + t*P2;

% plus a parabolic offset, as a function of the
% parameter C. Thus as C --> 0, the curve approaches
% a straight line.
% C = -.5;
N = (P1-P2)*[0 -1;1 0];
L_2 = L_1 + C*(t.*(1-t))*N;


if P2(1,2)==0
    plot(L_2(:,1),L_2(:,2),'g')
elseif P2(1,2)==0.5
    plot(L_2(:,1),L_2(:,2),'b')
elseif P2(1,2)==-0.5
    plot(L_2(:,1),L_2(:,2),'r')
end

peak=L_2(abs(L_2(:,2))==max(abs(L_2(:,2))),:);

