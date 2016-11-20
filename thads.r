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

# revised data frame variables
# AGE1            Age of head of household
# BEDRMS          Number of bedrooms in unit
# NUNITS          Number of units in building
# TENURE          Owner, renter
# VALUE           Current market value of unit
# PER             Number of persons in unit
# ZINC2           Household income
# ROOMS           Number of rooms in unit
# ZADEQ           Recorded adequacy of housing
# METRO/METRO3    City, secondary city, suburb
# STRUCTURETYPE   Type of dwelling
# UTILITY         Utility costs
# FMR             Fair market rent


