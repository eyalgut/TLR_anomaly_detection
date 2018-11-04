This code implements the algorithm described in the following paper:
Eyal Gutflaish, Aryeh Kontorovich, Sivan Sabato, Ofer Biller, Oded Sofer, "Temporal Anomaly Detection: Calibrating the Surprise", Proceedings of the 33rd AAAI Conference on Artificial Intelligence (AAAI-19), 2018. 
Please contact the first author at eyalgutf@gmail.com with any questions. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

Public:
	Learning stage: LearnModel(mat_arr_cell_train_model,mat_arr_cell_train_reg,files_mat_reg)
		This will create the Folder IBM_New_Model which is needed for the Classsfication stage

	Classification stage: percent_dist_items=getTestRanking(mats_test,file_mats_names_test) 
		percent_dist_items contains the anomaly score in % for every interval (staring from interval 25 since, 
		the first 24 are used as ``pivots'' for the autoregressive model.
		For more details see design for further details)

*See the Demo.m script for a demonstration of the learning and classification scenarios
*The matrices that correspond to the 2 month IBM dataset we received is supplied in Folder DateSet, 
based on the fields [DB-User,DB-table].
		-A smaller version of the dataset is on Folder demoDateSet, which the demo script uses.
*Please do not change the location of the files without updating the code accordingly
*For  further details refer to ``Design'' document