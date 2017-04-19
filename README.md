# ebsd_eds
Couple EDS information with EBSD in Mtex/Matlab

EDAX/TSL EDS text files(exported from OIM):

.txt: Text file with headers(#) anda data in 2+n columns, where n= number of EDS channels(elements):

X | Y | 'Element 1'  |  'Element 2'  | 'Element 3'  | 'Element n'  |


EDAX/TSL EDS binary files:

.SPD: Contains map data

.SPC: Spectral information

.IPR: Spatial calibration


Description of binary files are found in:

https://umd.app.box.com/s/nf4eqti4g07b76hh9zud25h6y1b6mmht/0/5299018885

Python code for parsing binary data is found in:

https://github.com/hyperspy/hyperspy/blob/RELEASE_next_minor/hyperspy/io_plugins/edax.py

However quantification of spectra in hyperspy is not yet available for SEM-EDS. See pull request here:

https://github.com/hyperspy/hyperspy/issues/1402
