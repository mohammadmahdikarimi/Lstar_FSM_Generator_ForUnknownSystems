function [ t ] = Teacher_fc( m )
%TEACHER This teacher funcion produces every column of the table
% U is the global answers of the system
global U

    if ~iscell(m)
        if null(strmatch(m,U,'exact'))
            display('No match')
            t=0;
        else
            strmatch(m,U,'exact');
            display('match')
            t=1;
        end
    end
    
    if iscell(m)
        M=m;
        for i2=1:size(m,2)
            m=M(i2);
            if isempty(strmatch(m,U,'exact'))
                %             display('No match')
                t(i2,1)=0;
            else
                strmatch(m,U,'exact');
                %             display('match')
                t(i2,1)=1;
            end
        end
    end
end

