function ipr= loadIPR(iprFname)
%  IPR file structure:
%  Table of header tags:
%         -  version: 2 byte unsigned short; *Current version number: 334*
%         -  imageType: 2 byte unsigned short; *0=empty; 1=electron; 2=xmap; 3=disk; 4=overlay*
%         -  label: 8 byte char array; *Image label*
%         -  sMin: 2 byte unsigned short; *Min collected signal*
%         -  sMax: 2 byte unsigned short; *Max collected signal*
%         -  color: 2 byte unsigned short; *color: 0=gray; 1=R; 2=G; 3=B; 4=Y; 5=M; 6=C; 8=overlay*
%         -  presetMode: 2 byte unsigned short; *0=clock; 1=live*
%         -  presetTime: 4 byte unsigned long; *Dwell time for x-ray (millisec)*
%         -  dataType: 2 byte unsigned short; *0=ROI;  1=Net intensity; 2=K ratio; 3=Wt%;  4=Mthin2*
%         -  timeConstantOld: 2 byte unsigned short; *Amplifier pulse processing time [usec]*
%         -  reserved1: 2 byte short; *Not used*
%         -  roiStartChan: 2 byte unsigned short; *ROI starting channel*
%         -  roiEndChan: 2 byte unsigned short; *ROI ending channel*
%         -  userMin: 2 byte short; *User Defined Min signal range*
%         -  userMax: 2 byte short; *User Defined Max signal range*
%         -  iADC: 2 byte unsigned short; *Electron detector number: 1; 2; 3; 4*
%         -  reserved2: 2 byte short; *Not used*
%         -  iBits: 2 byte unsigned short; *conversion type: 8; 12 (not used)*
%         -  nReads: 2 byte unsigned short; *No. of reads per point*
%         -  nFrames: 2 byte unsigned short; *No. of frames averaged (not used)*
%         -  fDwell: 4 byte float; *Dwell time (not used)*
%         -  accV: 2 byte unsigned short; *V_acc in units of 100V*
%         -  tilt: 2 byte short; *Sample tilt [deg]*
%         -  takeoff: 2 byte short; *Takeoff angle [deg]*
%         -  mag: 4 byte unsigned long; *Magnification*
%         -  wd: 2 byte unsigned short; *Working distance [mm]*
%         -  mppX: 4 byte float; *Microns per pixel in X direction*
%         -  mppY: 4 byte float; *Microns per pixel in Y direction*
%         -  nTextLines: 2 byte unsigned short; *No. of comment lines *
%         -  charText: (4 x 32) byte character array; *Comment text*
%         -  reserved3: 4 byte float; *Not used*
%         -  nOverlayElements: 2 byte unsigned short; *No. of overlay elements*
%         -  overlayColors: 16 array of 2 byte unsigned short; *Overlay colors*
%         -  timeConstantNew: 4 byte float; *Amplifier time constant [usec]*
%         -  reserved4: 2 array of 4 byte float; *Not used*

%% fseek(fid,[1],'eof');
%A = fread(fileID,sizeA,precision)
fid=fopen(spdFname);

fseek(fid,[1],'eof');
version= fread(fid,[1],'uint8')

%...

fclose(fid)

end