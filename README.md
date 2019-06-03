# Getting-and-Cleaning-Data-Week-4
This repo contains four files:
1. A tidy data set titled "tidy_data_set" which is the output of the R script "run_analysis.R"
2. A code book in html format knitted by RMarkdown, and a similar document in markdown format titled "CodeBook" explaining both the the R script and the data sets which will be installed and unpacked upon running the R script.
3. The R script its self.

## Step by step instructions on how the R script works:

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
