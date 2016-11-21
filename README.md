# thads

### Purpose
Analysis of HADS national housing data from 2013.

Data comes from huduser.gov in the form of two .txt files. There is a "national" data set and a "metro" data set. Also included are a guide and codebook.

### Geography
The "metro" data set appears to have values for the "SMSA" category that are incongruous with the list of possible values in the codebook. This obviously compromises our ability to subset this data by city, at least in a meaningful way.

### Research Questions
At the present time the questions are of an exploratory nature. How can we best understand this data set, what variables interact meaningfully, and how can we develop an efficient workflow for manipulating HADS data for analysis?

### Variables of Interest
For the sake of simplicity I have created data frames using the following variables:
* age
* bedrooms
* units
* own
* value
* persons
* income
* rooms
* adeq
* metroType
* dwellType
* utilCost
* fairMarket

These variables are mostly named differently in the actual data files. The comments in the copde give more details.

### Creating New Variables
