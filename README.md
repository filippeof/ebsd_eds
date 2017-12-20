# ebsd_eds
Couple EDS information with EBSD in Mtex/Matlab

Objective is to quantify spectrum and correlate spatially chemistry with orientation data(EBSD) in MTEX. 
For example, some pseudo code to extract grains presenting iron wt% higher than 50:

grainsIron=grains(eds('iron')>50)

# What is available (EDAX/TSL EDS):

- EDAX/TSL EDS text files (exported from OIM):

  - . Text file (.txt) with headers(#) and EDS data in 2+n columns, where n= number of EDS channels(elements):

        X | Y | 'Element 1'  |  'Element 2'  | 'Element 3'  | ... | 'Element n'  |


- EDAX/TSL EDS binary files:

  - .SPD: Contains map data

  - .SPC: Spectral information

  - .IPR: Spatial calibration

  Description of binary files are found in:

        https://umd.app.box.com/s/nf4eqti4g07b76hh9zud25h6y1b6mmht/0/5299018885

  Python code for parsing binary data is found in:

        https://github.com/hyperspy/hyperspy/blob/RELEASE_next_minor/hyperspy/io_plugins/edax.py

  Nonetheless, quantification of spectra in hyperspy is not yet available for SEM-EDS. Track issue here:

        https://github.com/hyperspy/hyperspy/issues/1402


# What is done:

- EDS counts reading per pixel per channel(element)

txt files can be parsed with the loadEDS.m function. Data position and each channel counts per second (cps) can be assessed with dot notation, ex: eds.x, eds.y, eds.iron. Example output is in 'output.png' image.

-> However, EDS counts and element abundance is not always proportional. To quantify the data some matrix corrections need to be applied, namely 'ZAF'(Atomic number, Absorption and FLuorescence absorption) corrections or standardless corrections. A Review of EDS quantification methods can be found in Goldstein et al. (2012). EDAX apparently uses a modified ZAF method for tilted samples called "eZAF 70deg Tilt" (Nowell et a. 2011). Information needed to quantify the results are available in the binaries. Therefore the first step would be to parse them in matlab.
  
 # What is needed:

- Parse binary files and extract relevant data
  - Parsing of binary files is underway (but is a hard task):
     - 'loadSPC.m'
     - 'loadSPD.m'
     - 'loadIPR.m'  
- Perform matrix corrections

- Quantify data
  
# References:
  
Goldstein, J., Newbury, D. E., Echlin, P., Joy, D. C., Romig Jr, A. D., Lyman, C. E., ... & Lifshin, E. (2012). Scanning electron         microscopy and X-ray microanalysis: a text for biologists, materials scientists, and geologists. Springer Science & Business Media.

Nowell, M., Anderhalt, R., Nylese, T., Eggert, F., de Kloe, R., Schleifer, M., & Wright, S. (2011). Improved EDS Performance at EBSD Geometry. Microscopy and Microanalysis, 17(S2), 398-399.


