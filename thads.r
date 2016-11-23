require(plyr)
require(dplyr)
require(ggplot2)
require(scales)

# data from https://www.huduser.gov/portal/datasets/hads/hads.html
url <- 'https://www.huduser.gov/portal/datasets/hads/hads.html'
# file: 'thads2013n.txt'
# data dictionary and guide: HADS_doc.pdf, HADS_codebook.pdf
# national data file has 64535 observations of 99 variables
# metro data file has 65899 observations of 98 variables

######################
# Create Data Frames #
######################
filename <- 'thads2013n.txt' # derived from AHS national data
thads <- read.table(filename, header=T, sep=',')
# alphabetical list of variables
thads_vars <- names(thads)[order(names(thads))]
thads_vars

filename_met <- 'thads2013m.txt' # derived from metro data
thads_met <- read.table(filename_met, header=T, sep=',')
# alphabetical list of variables
thads_met_vars <- names(thads_met)[order(names(thads_met))]
thads_met_vars

##### Create Revised Data Frames #####
national <- thads[, c(2,11,18,26,15,21,22,19,23,3,25,27,6)]
metro <- thads_met[, c(18,4,11,20,8,14,15,12,16,3,19,21,33)]

################################################################
#                         VARIABLES                            #
# ORIGINAL      DATA FRAME    DESCRIPTION                      #
################################################################
# AGE1          age           Age of head of household
# BEDRMS        bedrooms      Number of bedrooms in unit
# NUNITS        units         Number of units in building
# OWNRENT       own           Owner, renter
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

# examine utilCost for each population

hist(national$utilCost,
     main="Histogram for Utility Costs,\nNational Sample", 
     xlab="Utility Cost", 
     border="darkred",
     col="grey97",
     xlim=c(0, 1000),
     breaks=12)

hist(metro$utilCost, 
     main="Histogram for Utility Costs,\nMetro Sample", 
     xlab="Utility Cost", 
     border="blue",
     col="grey97",
     xlim=c(0, 1000),
     breaks=12)

# Using ggplot2
ggplot(national, aes(utilCost)) +
  geom_histogram(color="darkred", fill="grey97")

ggplot(metro, aes(utilCost)) +
  geom_histogram(color="blue", fill="grey97")

#################
# NEW VARIABLES #
#################


# sticking with national data for now
# create new columns: monthlyIncome, utilShareInc
national <- national %>%
  mutate(monthlyIncome = round(income / 12, 0),
         utilShareInc = round(utilCost / monthlyIncome, 3)) # what if they have 0 income? NaN problems...

# owners vs. renters
homeowners <- national %>%
  filter(own==1)

renters <- national %>%
  filter(own==2)

head(renters)
head(homeowners)
head(national)

# breakdown of utility costs by own/rent
plt <- ggplot(national, aes(utilCost)) +
  geom_histogram(fill="grey97", 
                 color="steelblue",)

plt + facet_grid(. ~ own)

# what is the breakdown of home values?
# one way of looking at it: the growth curve of sorted home values
plot(sort(homeowners$value), type="l",
     main="Chart of Sorted Home Values\nNational Sample Homeowners",
     col="blue",
     xlab="Sorted Homeowners",
     ylab="Home Value"
     )



# another way: histogram of home values
ggplot(homeowners, aes(x=value)) +
  geom_histogram(binwidth=50000,
                 color="lightgreen",
                 fill="grey97") +
  theme_classic() +
  labs(title="Home Values\nNational Sample")


# statistical summary
summary(homeowners$value)
median(homeowners$value)

# Problem: homeowners contains many records with $2520000 homes.
# Also, we have a number of people with negative income values, 
# indicating NA values
# Solution: create modified data frame that omits those records.
ho2 <- homeowners[homeowners$value < 2520000 &
                            homeowners$income >= 0, ]

# distribution of incomes
g <- ggplot(df, aes(x=income))
g + geom_histogram(binwidth=20000, 
                 fill="honeydew", 
                 col="cyan3") + 
  theme_classic() +
  xlim(0, 500000) +
  labs(title="Income Distribution\nHomeowners") +
  scale_x_continuous(labels=comma)





