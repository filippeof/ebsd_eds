function [EDS,  varargout] = loadEDS(edsFname, varargin)

%Read header
edsH = file2cell(edsFname,123);%118 elements + 5 header lines
nH =length( find(strncmp('#',edsH,1)));

% Count  and read phase names
idC = strfind(edsH,'Counts');
id = find(not(cellfun('isempty', idC)));
nPhases=length(id);

for i=1:nPhases
    linestr = strtrim (edsH (id (i) ));
    linesplit= strsplit (linestr{:},' ');
    elementNames{i} = cell2mat( linesplit(3) );
end

 %%
%  fid = fopen(edsFname);
 
edsColumns = ['%f%f',repmat('%f',1,nPhases)];
% EDS = textscan(fid,edsColumns ,'HeaderLines', nH, 'Whitespace','\t');
% fclose(fid);
EDS = readtable(edsFname,'Format', edsColumns,'ReadVariableNames',false);
EDS.Properties.VariableNames{1}='x';
EDS.Properties.VariableNames{2}='y';
for i=1: length(elementNames)
EDS.Properties.VariableNames{2+i} = elementNames{i};
end
%%