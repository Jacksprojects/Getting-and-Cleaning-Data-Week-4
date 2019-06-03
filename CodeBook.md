## Explaination of the individual data sets: 

* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
* Each person performed six activities while wearing a smartphone (Samsung Galaxy S II) on the waist:
  + walking, walking upstairs, walking downstairs, sitting, standing, laying  

* Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
* The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


## Explanation of the raw data:
Each record is provided with:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* An activity label. 
* An identifier of the subject who carried out the experiment.

The unzipped folder includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* **'train/subject_train.txt'**: Each row identifies the subject who performed the activity for each window sample.
  + Its range is from 1 to 30. 

* **'train/Inertial Signals/total_acc_x_train.txt'**: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
  + Every row shows a 128 element vector. 
  + The same description applies for the **'total_acc_x_train.txt' **and **'total_acc_z_train.txt'** files for the Y and Z axis. 

* **'train/Inertial Signals/body_acc_x_train.txt'**: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* **'train/Inertial Signals/body_gyro_x_train.txt'**: The angular velocity vector measured by the gyroscope for each window sample. 
  + The units are radians/second. 

## Additonal transformations: 

* The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
* The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
* The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
* From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.


## Step by step instructions on how the script works:

**1.0**: Download the folder containing the separate data sets.

* If the data does not exist at the specified directory, the directory is created, the data sets are downlaoded and unzipped to the specified location.


**2.0**: Merge train and test data sets.

* **2.1** All independant train and test data sets are read into r using the *read.table()* function.
* **2.2** Both features and activity labels are read into r using the *read.table()* function.
* **2.3** Column names for the train and test data sets are assigned from the corresponding features data.
  + Activity labels and subject ID column names are given manually.
* **2.4** All train data is combined into a single data set titled *train_merged* using column bind.
  + All test data is combined into a single data set titled *test_merged* using column bind.
* **2.5** Both *train_merged* and *test_merged* are combined using row bind.

**3.0** List the standard deviation and mean for each measurement. 

* **3.1** A character vector of column names is created using the colnames() function.
* **3.2** A logical vector is crreated using the *grepl()* function. This is used to select all columns from the merged data set that refer to "mean" or "std" along with the activity and subject IDs.
* **3.3** The merged data set is then subset using the logical vector created in the previous step.
* **3.4** The names of the activites are subsitiuted in lieu of the 1-6 numeric factor levels. These have been manually replaced using the *relevel()* function from *plyr* as the original descriptions were all uppercase.

**4.0** Create an additional independant data set conatining the average of each variable for each activity and each subject.

* **4.1** The *aggregate()* function is used to create the new data set and collate rows using *order()* to order the observations in terms of both subject ID and activity.
* **4.2** The script will then write this data set to the specified directory using the *write.table()* function if it does not already exist.

## License to use this data:

* Use of this dataset in publications must be acknowledged by referencing the following publication: 
  + Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

* This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

* Authors: Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
