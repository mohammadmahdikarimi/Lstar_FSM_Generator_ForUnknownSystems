function [ t2 ] = Teacher_f( m , e )
%TEACHER_F1 Summary of this function goes here
%   Detailed explanation goes here
for i1=1:size(e,2)
    m2=strcat(m,e(i1));
    t1(:,i1) = Teacher_fc( m2 );
end
t2=t1;

end

