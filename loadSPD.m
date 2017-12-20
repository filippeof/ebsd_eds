function spd= loadSPD(spdFname)
%  SPD file structure:
% Table of header tags:
%      - tag: 16 byte char array;    *File ID tag ("MAPSPECTRA_DATA")*
%      - version: 4 byte long;       *File version*
%      - nSpectra: 4 byte long;      *Number of spectra in file*
%      - nPoints: 4 byte long;       *Number of map pixels in X direction*
%      - nLines: 4 byte long;        *Number of map pixels in Y direction*
%      - nChannels: 4 byte long;     *Number of channels per spectrum*
%      - countBytes: 4 byte long;    *Number of count bytes per channel*
%      - dataOffset: 4 byte long;    *File offset in bytes for data start*
%      - nFrames: 4 byte long;       *Number of frames in live spectrum mapping*
%      - fName: 120 byte char array; *File name of electron image acquired during mapping*
%%
% fseek(fid,[1],'eof');
%A = fread(fileID,sizeA,precision)
fid=fopen(spdFname);

fseek(fid,[1],'eof');
tag= fread(fid,[1],'char');

%...

fclose(fid)
end
