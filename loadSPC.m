function spc= loadSPC(spcFname)
%% SPC file structure:
%  Table of header tags:
%         - fVersion: 4 byte float; *File format Version*
%         - aVersion: 4 byte float; *Application Version*
%         - fileName: 8 array of 1 byte char; *File name w/o '.spc' extension (OLD)*
%         - collectDateYear: 2 byte short; *Year the spectrum was collected*
%         - collectDateDay: 1 byte char; *Day the spectrum was collected*
%         - collectDateMon: 1 byte char; *Month the spectrum was collected*
%         - collectTimeMin: 1 byte char; *Minute the spectrum was collected*
%         - collectTimeHour: 1 byte char; *Hour the spectrum was collected*
%         - collectTimeHund: 1 byte char; *Hundredth second the spectrum was collected*
%         - collectTimeSec: 1 byte char; *Second the spectrum was collected*
%         - fileSize: 4 byte long; *Size of spectrum file in bytes*
%         - dataStart: 4 byte long; *Start of spectrum data in bytes offset from 0 of file*
%         - numPts: 2 byte short; *Number of spectrum pts*
%         - intersectingDist: 2 byte short; *Intersecting distance * 100 (mm)*
%         - workingDist: 2 byte short; *Working distance * 100*
%         - scaleSetting: 2 byte short; *Scale setting distance * 100*
% 
%         - filler1: 24 byte;
% 
%         - spectrumLabel: 256 array of 1 byte char; *Type label for spectrum, 0-39=material type, 40-255=sample*
%         - imageFilename: 8 array of 1 byte char; *Parent Image filename*
%         - spotX: 2 byte short; *Spot X  in parent image file*
%         - spotY: 2 byte short; *Spot Y in parent image file*
%         - imageADC: 2 byte short; *Image ADC value 0-4095*
%         - discrValues: 5 array of 4 byte long; *Analyzer Discriminator Values*
%         - discrEnabled: 5 array of 1 byte unsigned char; *Discriminator Flags (0=Disabled,1=Enabled)*
%         - pileupProcessed: 1 byte char; *Pileup Processed Flag (0=No PU,1=Static PU, 2=Dynamic PU,...)*
%         - fpgaVersion: 4 byte long; *Firmware Version.*
%         - pileupProcVersion: 4 byte long; *Pileup Processing Software Version*
%         - NB5000CFG: 4 byte long; *Defines Hitachi NB5000 Dual Stage Cfg 0=None, 10=Eucentric Crossx,11= Eucentric Surface 12= Side Entry - Side 13 = Side Entry - Top*
% 
%         - filler2: 12 byte;
% 
%         - evPerChan: 4 byte long; *EV/channel*
%         - ADCTimeConstant: 2 byte short; *ADC Time constant*
%         - analysisType: 2 byte short; *Preset mode 1=clock, 2=count, 3=none, 4=live, 5=resume*
%         - preset: 4 byte float; *Analysis Time Preset value*
%         - maxp: 4 byte long; *Maximum counts of the spectrum*
%         - maxPeakCh: 4 byte long; *Max peak channel number*
%         - xRayTubeZ: 2 byte short; *XRF*
%         - filterZ: 2 byte short; *XRF*
%         - current: 4 byte float; *XRF*
%         - sampleCond: 2 byte short; *XRF Air= 0, Vacuum= 1, Helium= 2*
%         - sampleType: 2 byte short; *Bulk or thin*
%         - xrayCollimator: 2 byte unsigned short; *0=None, 1=Installed*
%         - xrayCapilaryType: 2 byte unsigned short; *0=Mono, 1=Poly*
%         - xrayCapilarySize: 2 byte unsigned short; *Range : 20 – 5000 Microns*
%         - xrayFilterThickness: 2 byte unsigned short; *Range : 0 – 10000 Microns*
%         - spectrumSmoothed: 2 byte unsigned short; *1= Spectrum Smoothed, Else 0*
%         - detector_Size_SiLi: 2 byte unsigned short; *Eagle Detector 0=30mm, 1=80mm*
%         - spectrumReCalib: 2 byte unsigned short; *1= Peaks Recalibrated, Else 0*
%         - eagleSystem: 2 byte unsigned short; *0=None, 2=Eagle2, 3=Eagle3, 4-Xscope*
%         - sumPeakRemoved: 2 byte unsigned short; *1= Sum Peaks Removed, Else 0*
%         - edaxSoftwareType: 2 byte unsigned short; *1= Team Spectrum, Else 0*
% 
%         - filler3: 6 byte;
% 
%         - escapePeakRemoved: 2 byte unsigned short; *1=Escape Peak Was Removed, Else 0*
%         - analyzerType: 4 byte unsigned long; *Hardware type 1=EDI1, 2=EDI2, 3=DPP2, 31=DPP-FR, 32=DPP-FR2, 4=DPP3, 5= APOLLO XLT/XLS/DPP-4 (EDPP)*
%         - startEnergy: 4 byte float; *Starting energy of spectrum*
%         - endEnergy: 4 byte float; *Ending energy of spectrum*
%         - liveTime: 4 byte float; *LiveTime*
%         - tilt: 4 byte float; *Tilt angle*
%         - takeoff: 4 byte float; *Take off angle*
%         - beamCurFact: 4 byte float; *Beam current factor*
%         - detReso: 4 byte float; *Detector resolution*
%         - detectType: 4 byte unsigned long; *Detector Type: 1=Std-BE, 2=UTW, 3=Super UTW, 4=ECON 3/4 Open, 5=ECON 3/4 Closed, 6=ECON 5/6 Open, 7=ECON 5/6 Closed, 8=TEMECON; Add + 10 For Sapphire SiLi Detectors, (11-18), which started shipping in 1996. 30 = APOLLO 10 SDD, 31=APOLLO XV, 32 = APOLLO 10+, 40 = APOLLO 40 SDD ,50 = APOLLO-X, 51=APOLLO-XP, 52 = APOLLO-XL, 53 = APOLLO XL-XRF, 60 =APOLLO-XLT-LS, 61 =APOLLO-XLT-NW, 62 =APOLLO-XLT-SUTW*
%         - parThick: 4 byte float; *Parlodion light shield thickness*
%         - alThick: 4 byte float; *Aluminum light shield thickness*
%         - beWinThick: 4 byte float; *Be window thickness*
%         - auThick: 4 byte float; *Gold light shield thickness*
%         - siDead: 4 byte float; *Si dead layer thickness*
%         - siLive: 4 byte float; *Si live layer thickness*
%         - xrayInc: 4 byte float; *X-ray incidence angle*
%         - azimuth: 4 byte float; *Azimuth angle of detector*
%         - elevation: 4 byte float; *Elevation angle of detector*
%         - bCoeff: 4 byte float; *K-line B coefficient*
%         - cCoeff: 4 byte float; *K-line C coefficient*
%         - tailMax: 4 byte float; *Tail function maximum channel*
%         - tailHeight: 4 byte float; *Tail height adjustment percentage*
%         - kV: 4 byte float; *Acc voltage*
%         - apThick: 4 byte float; *Ap window thickness*
%         - xTilt: 4 byte float; *x tilt angle for mDX*
%         - yTilt: 4 byte float; *y tilt angle for mDX*
%         - yagStatus: 4 byte unsigned long; *0 = N/A, 1 = YAG OUT, 2 = YAG IN*
% 
%         - filler4: 24 byte;
% 
%         - rawDataType: 2 byte unsigned short; *TEM or SEM data*
%         - totalBkgdCount: 4 byte float; *Accumulated background counts*
%         - totalSpectralCount: 4 byte unsigned long; *Accumulated spectrum counts*
%         - avginputCount: 4 byte float; *Average spectral counts*
%         - stdDevInputCount: 4 byte float; *Standard deviation of spectral counts*
%         - peakToBack: 2 byte unsigned short; *Peak to background setting. 0 = off, 1 = low, 2 = medium, 3 = high, 4 = user selected*
%         - peakToBackValue: 4 byte float; *Peak to back value*
% 
%         - filler5: 38 byte;
% 
%         - numElem: 2 byte short; *Number of peak id elements 0-48*
%         - at: 48 array of 2 byte unsigned short; *atomic numbers for peak id elems*
%         - line: 48 array of 2 byte unsigned short; *line numbers for peak id elems*
%         - energy: 48 array of 4 byte float; *float energy of identified peaks*
%         - height: 48 array of 4 byte unsigned long; *height in counts of id' ed peaks*
%         - spkht: 48 array of 2 byte short; *sorted peak height of id' ed peaks*
% 
%         - filler5_1: 30 byte;
% 
%         - numRois: 2 byte short; *Number of ROI's defined 0-48*
%         - st: 48 array of 2 byte short; *Start channel # for each ROI*
%         - end: 48 array of 2 byte short; *End channel # for each ROI*
%         - roiEnable: 48 array of 2 byte short; *ROI enable/disable flags*
%         - roiNames: (24 x 8) array of 1 byte char; *8 char name for eah ROI*
% 
%         - filler5_2: 1 byte;
% 
%         - userID: 80 array of 1 byte char; *User ID (Vision S/W) - Overlapping*
% 
%         - filler5_3: 111 byte;
% 
%         - sRoi: 48 array of 2 byte short; *sorted ROI heights*
%         - scaNum: 48 array of 2 byte short; *SCA number assigned for each ROI*
% 
%         - filler6: 12 byte;
% 
%         - backgrdWidth: 2 byte short; *Background width*
%         - manBkgrdPerc: 4 byte float; *Percentage to move manual background down*
%         - numBkgrdPts: 2 byte short; *Number of background points (2-64)*
%         - backMethod: 4 byte unsigned long; *Background method 1=auto, 2=manual*
%         - backStEng: 4 byte float; *Starting energy of background*
%         - backEndEng: 4 byte float; *Ending energy of background*
%         - bg: 64 array of 2 byte short; *Channel # of background point*
%         - bgType: 4 byte unsigned long; *Background type. 1 = curve, 2 = linear.*
%         - concenKev1: 4 byte float; *First concentration background point*
%         - concenKev2: 4 byte float; *Second concentration background point*
%         - concenMethod: 2 byte short; *0 = Off, 1 = On*
%         - jobFilename: 32 array of 1 byte char; *Vision Job Filename*
% 
%         - filler7: 16 byte;
% 
%         - numLabels: 2 byte short; *Number of displayed labels*
%         - label: (10 x 32) array 1 byte char; *32 character labels on the spectrum*
%         - labelx: 10 array of 2 byte short; *x position of label in terms of channel #*
%         - labely: 10 array of 4 byte long; *y position of label in terms of counts*
%         - zListFlag: 4 byte long; *Flag to indicate if Z List was written*
%         - bgPercents: 64 array of 4 byte float; *Percentage to move background point up and down.*
%         - IswGBg: 2 byte short; *= 1 if new backgrd pts exist*
%         - BgPoints: 5 array of 4 byte float; *Background points*
%         - IswGConc: 2 byte short; *= 1 if given concentrations exist*
%         - numConcen: 2 byte short; *Number of elements (up to 24)*
%         - ZList: 24 array of 2 byte short; *Element list for which given concentrations exist*
%         - GivenConc: 24 array of 4 byte float; *Given concentrations for each element in Zlist*
% 
%         - filler8: 598 byte;
% 
%         - s: 4096 array of 4 byte long; *counts for each channel*
%         - longFileName: 256 array of 1 byte char; *Long filename for 32 bit version*
%         - longImageFileName: 256 array of 1 byte char; *Associated long image file name*
%         - ADCTimeConstantNew: 4 byte float; *Time constant: 2.5… 100 OR 1.6… 102.4 us*
% 
%         - filler9: 60 byte;
% 
%         - numZElements: 2 byte short; *number of Z List elements for quant*
%         - zAtoms: 48 array of 2 byte short; *Z List Atomic numbers*
%         - zShells: 48 array of 2 byte short; *Z List Shell numbers*
%%
% fseek(fid,[1],'eof');
%A = fread(fileID,sizeA,precision)

fid=fopen(spcFname);

fseek(fid,[1],'eof');
fversion= fread(fid,[1],'float')

fseek(fid,[5],'eof');
aversion= fread(fid,[1],'float')

fseek(fid,[9],'eof');
filename= fread(fid,[1],'char')

fseek(fid,[17],'eof');
collectDate= fread(fid,[1],'char')%*struct date
fseek(fid,[21],'eof');
collectTime= fread(fid,[1],'char')%*struct time

fseek(fid,[25],'eof');
fileSize= fread(fid,[1],'uint')

fseek(fid,[29],'eof');
dataStart= fread(fid,[1],'uint')

fseek(fid,[33],'eof');
numPts= fread(fid,[1],'uint8')

fseek(fid,[35],'eof');
IntersectingDist= fread(fid,[1],'uint8')

fseek(fid,[37],'eof');
WorkingDist= fread(fid,[1],'uint8')

fseek(fid,[39],'eof');
ScaleSetting= fread(fid,[1],'uint8')

%<Filler1>

fseek(fid,[65],'eof');
spectrumLabel= fread(fid,[1],'char')

fseek(fid,[321],'eof');
imageFilename = fread(fid,[1],'char')

fseek(fid,[329],'eof');
spotX= fread(fid,[1],'uint8')

fseek(fid,[331],'eof');
spotY= fread(fid,[1],'uint8')

%<Filler2>
%<Filler3>
%<Filler4>
%<Filler5>
%<Filler6>
%<Filler7>
%<Filler8>
%<Filler9>

fclose(fid);
end

