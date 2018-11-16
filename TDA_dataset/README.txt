This is the data set described in the following paper:
Eyal Gutflaish, Aryeh Kontorovich, Sivan Sabato, Ofer Biller, Oded Sofer, "Temporal Anomaly Detection: Calibrating the Surprise", Proceedings of the 33rd AAAI Conference on Artificial Intelligence (AAAI-19), 2019. 
Please contact the first author at eyalgutf@gmail.com with any questions. 

THE DATA SET IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE DATA SET OR THE USE OR
OTHER DEALINGS IN THE DATA SET.


The TDA dataset is released in the file TDADateSet.mat (matlab).
It is a Matlab file, which can be loaded into matlab using 'load'.

The file includes the following Matlab variables:

- mat {1x1488 cell}: a cell array of binary access matrices of size 4702x11654. 
Each access matrix records database accesses that occurred during a single hour. 
mat{t}(i,j) == 1 if if user i accessed database table j during time interval t. 

- mat_timestamps {1 x 1488 cell}: the timestamps representing the start time 
of each of the time intervals recorded in the access matrices. 
The timestamp format is yyyymmddhhMMss.
The matrices correspond to consecutive hour-long time intervals 
recorded between July 1st, 2015 and August 31st, 2015. 

This dataset is also available in CSV format at https://www.kaggle.com/eyalgut/binary-traffic-matrices