require(plyr)
require(dplyr)
require(ggplot2)

# data from https://www.huduser.gov/portal/datasets/hads/hads.html
url <- 'https://www.huduser.gov/portal/datasets/hads/hads.html'
# file: 'thads2013n.txt'
# data dictionary and guide: HADS_doc.pdf, HADS_codebook.pdf
# national data file has 64535 observations of 99 variables
# metro data file has 65899 observations of 98 variables

##### Create Data Frames #####
filename <- 'thads2013n.txt' # derived from AHS national data
thads <- read.table(filename, header=T, sep=',')
thads_vars <- names(thads)[order(names(thads))]

filename_met <- 'thads2013m.txt' # derived from metro data
thads_met <- read.table(filename_met, header=T, sep=',')
thads_met_vars <- names(thads_met)[order(names(thads_met))]

##### Create Revised Data Frames #####
national <- thads[, c(2,11,18,17,15,21,22,19,23,3,25,27,6)]
metro <- thads_met[, c(18,4,11,10,8,14,15,12,16,3,19,21,33)]

################################################################
# variables included in the revised data frame                 #
################################################################
# AGE1          age           Age of head of household
# BEDRMS        bedrooms      Number of bedrooms in unit
# NUNITS        units         Number of units in building
# TENURE        own           Owner, renter
# VALUE         value         Current market value of unit
# PER           persons       Number of persons in unit
# ZINC2         income        Household income
# ROOMS         rooms         Number of rooms in unit
# ZADEQ         adeq          Recorded adequacy of housing
# METRO/METRO3  metroType     City, secondary city, suburb
# STRUCTURETYPE dwellType     Type of dwelling
# UTILITY       utilCost      Utility costs
# FMR           fairMarket    Fair market rent


# rename the columns with more descriptive headings
newColNames <- c('age', 'bedrooms', 'units', 'own',
                 'value', 'persons', 'income', 'rooms',
                 'adeq', 'metroType', 'dwellType',
                 'utilCost', 'fairMarket')

colnames(metro) <- newColNames
colnames(national) <- newColNames


#############################
# EXPLORATORY DATA ANALYSIS #
#############################

# examine bedrooms vs. utilCost
sbst1 <- select(national, bedrooms, utilCost)
sbst1 <- sbst1[-37470, ]
hist(sbst1$utilCost, 
     main="Histogram for Utility Costs", 
     xlab="Utility Cost", 
     border="slategrey",
     col="lightgrey", 
     xlim=c(0, 1200), 
     breaks=9)








# METRO DATA
# Get summaries for renters vs owners
summary(filter(metro, own==1))
summary(filter(metro, own==2))



