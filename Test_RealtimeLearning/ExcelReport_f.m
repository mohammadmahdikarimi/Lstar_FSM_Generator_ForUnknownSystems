function [ filename ] = ExcelReport_f( Ts,Tsa,Ts_el,Tsa_el,E,fnm, sheet )
%EXCELREPORT_F Summary of this function goes here
%   Detailed explanation goes here

if ~exist('sheet','var')
    filename = 'testdata.xlsx';
else
    filename=sprintf('%s.xlsx',fnm);
end

if ~exist('sheet')
    sheet = 1;
end


% delete(filename)

xlRange=sprintf('A1:%c1',char(65+size(Ts_el,2)));
xlswrite(filename, ['L* DFSM',E], sheet, xlRange);

xlRange=sprintf('A2:A%d', size(Ts,2)+1);
xlswrite(filename,Ts',sheet, xlRange)

xlRange=sprintf('A%d:A%d', size(Ts,2)+3, size(Ts,2)+size(Tsa,2)+2);
xlswrite(filename,Tsa',sheet,xlRange)

xlRange=sprintf('%c2:%c%d',char(66), char(65+size(Ts_el,2)), size(Ts_el,1)+1);
xlswrite(filename, Ts_el, sheet, xlRange)

xlRange=sprintf('%c%d:%c%d',char(66), size(Ts,2)+3 , char(65+size(Tsa_el,2)), size(Ts,2)+2+size(Tsa_el,1));
xlswrite(filename, Tsa_el, sheet, xlRange)

% open(filename)
end

