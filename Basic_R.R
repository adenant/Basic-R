#################################################################################################
# Basic R and Intro to Data Manipulation and Visualization                                                           #
# SAPPK - Institut Teknologi Bandung                                                            #
#                                                                                               #
# Script names  : Basic_R                                                                       #
# Purpose       : This script contains line commands that performs basic tasks, and             #
#                 introduction to data manipulation and visualization for Urban Analytics       #
# Programmer    : Adenantera Dwicaksono                                                         #
# First Created : 10/29/2019 12:08 PM                                                            #
# Last updated  : 10/29/2019                                                                     #
#################################################################################################

################################################################################################# 
# Note: This comment provides information about any requirements that need to be met before
#       running the script. It tells other users important requirements to execute the script
#       without errors.
#
# Requirements:
#     - R and R studio are properly install in the desktop
#
################################################################################################# 


#################################################################################################
# Note:  This comments describes any processes that will be performed by the script
#
# This script performs the following steps:
#   Step 1: Install packages, load required library packages, and set working directories
#
################################################################################################# 

##################
# 1: Install packages, load required library packages, and set working directories
##################

#The following packages are essential for running the following processes, and have been installed
#in my machine and therefore no need to reinstall them. It the script is run in other
#machine, these packages must have been installed 

#install.packages("stringr")



# open libraries of spatial utilities
library(stringr)


# set working directory
wd <- 'D:/Gdrive/ITB/Teaching/2019-2020/PL3102/01_Basic R' # a string object containing
                                                                # the location of the main working directory
setwd(wd) # This set the working directory

#set data folder
input.dir <- paste0(wd,"/",'Data')

#specify output folder
output.dir <- paste0(wd,"/",'Output')

# check folder contents
dir()

##############################################
# 2. Demo of R as an over-powered calculator
##############################################

## R is an over-powered calculator - you can use it to calculate numbers
# Example: Type the following into the console or run them from the script.

1 + 1

sqrt(9)             ## sqrt() is a function.

sqrt(1+5+6-3)       ## We can pass values to functions and get results.


# EXERCISE: # What is the value of (1+3)*(1+4+6) ? Write the "equation" here and run it.


## ASSIGNMENT-OPERATORS

# The equals sign can be used to assign value to a variable.

a = 1
a 

# But the preferred assignment operator is "<-".
# RStudio Shortcut: [Alt] [-] will insert the R assignment operator.

a <- 1
a

## EXERCISE - Create an object "sank" and give it a value of "1912".


##############################################
# 3. Data Types in R
##############################################

## ATOMIC DATA TYPE

# Atomic data contains only a single value or object

# Numeric
pi <- 3.14159

#We can confirm this using typeof() function
typeof(pi)         

# Integers - Integers are funny. They have to be created consciously.
starboard <- 10

typeof(starboard)

# We can (double) confirm this:
is.integer(starboard)

# we can assign a number to an integer using as.integer()

port <- as.integer(starboard)
port
typeof(port)

# What would happen if a float data is converted integer?  

port <- as.integer(3.14159)
port


# LOGICAL variables are often created in the process of comparing things.
starboard <- 10; port <- 15;

# Question: Is this TRUE or FALSE?
starboard == port


# Character

# You can use " or ' to create a character

# Some character vars:
first_name <- "Captain"
last_name <- "Smith"

# Let's put them together using paste funtion
paste(first_name, last_name, sep=" ")


## VECTORS

#   - Vectors are 1-dimensional *(length)*.
#   - Vectors can contain only one data type *(integer, character, date)*.
#   - Vectors containing multiple data types are characters.

# Example:
yard_arm <- c(1,2,3,4,5)      
yard_arm


## VECTORS-LENGTH

# The variable yard_arm has five distinct values in it.
length(yard_arm)



# Vector Indexing using "[]"

## Returns the THIRD value stored in yard_arm.
yard_arm[3] 


## Returns ALL values in yard_arm with a value greater than 2.
yard_arm[ yard_arm>2 ]        ## Easy way to filter data.


## Arithmatic Operations on Vector

starboard <- c(25,30,40,45,50)
port <- c(90,70,50,30,10)

starboard + port


starboard <- c(25,30,40,45,50)
port <- 3

starboard * port


## We can do math on vectors.
starboard <- c(25,30,40,45,50)

mean(starboard)


# We can do math on vectors.
sd(starboard)



###################################
# 4. Matrix and Data Frames
###################################

# Two main object types that can be used to store tabular data in R include the data frame and matrix. 
# Data frames can contain input columns that are of multiple types (e.g. character, numeric etc); and 
# a matrix a single type. 
# You can create these within R manually or by reading in other common formats such as spreadsheets 
# or csv files.

# A data frame can be created using the data.frame() function.

# Create two vectors
a <- rep(2010:2017, each = 4) # this uses the rep() function to repeat values

b <- round(runif(32, 0, 40)) # runif can be used to generate random numbers - in this case between 0 and 40

# Create data frame
c <- data.frame(a,b)

# Check the content of the data frame:
head(c)
tail(c)

#Create a list of numbers
a <- 1:25 #The colon signifies a range
head(a)

#Create a matrix with 5 rows and 5 columns
b <- matrix(a,nrow=5, ncol=5)
b

# It is possible to perform algreba operations onto matrix
b*10
b*b

# When a matrix prints, the columns and rows show their index as a set of numbers within square brackets.
# These can be used to extract values from the matrix. 
# These are formatted as [row number, column number]. For example:

#Extract first row
b[1,]

#Extract fourth column
b[,4]

#Extract third and fourth columns
b[,3:4] # The colon is used to define a numeric vector between the two numbers

#Extract first and fourth rows
b[c(1,5),] # The c() is used to create a numeric vector with the numbers separated by a comma

#Extract the value in the third row and fourth column
b[3,4]

# You can also reference the column names themselves using the $ symbol, for example:
c$a

#A different way of returning the column called "a"
c[,"a"]

# We can also find out what a data frame column names are using the colnames() function:
colnames(c)

# we can also use the same function to set new column names:
colnames(c) <- c("Year","Count")


###################################
# 5. Getting External Data into R - Reading Tabular Data
###################################

# A common way in which data can be stored externally are the the use of .csv files. 
# These are text files, and have a very simple format where columns of attributes are 
# separated by a comma 1, and each row by a carriage return.

# In the following example you will read in some U.S. Census Bureau, 2010-2014 
# American Community Survey (ACS) 5-Year Estimate data. This was downloaded from the 
# American Fact Finder website. The data are for census tracts in San Francisco and 
# relate to median earnings in the past 12 months.

#Read CSV file - creates a data frame called earnings
earnings <- read.csv("./Data/ACS_14_5YR_S2001_with_ann.csv")

#Show column headings
colnames(earnings)

#UID - Tract ID
#pop - estimated total population over 16 with income
#pop_m - estimated total population over 16 with income (margin of error)
#earnings - estimated median earnings
#earnings - estimated median earnings (margin of error)

# It is possible to show the structure of the object using the str() function.
str(earnings)

# Not all tabular data are distributed as textfiles, and another very common format i
# s Microsoft Excel format - .xls or xlsx. Unlike .csv files there are no built in function 
# to read these formats, however, extension packages exist (e.g. XLConnect)

#Download and install package
install.packages("XLConnect")

#Load package
library(XLConnect)

# The following code downloads an Excel File from the London Data Store and then reads this into R.
download.file("https://files.datapress.com/london/dataset/number-bicycle-hires/2016-11-16T08:14:05/tfl-daily-cycle-hires.xls","./Data/tfl-daily-cycle-hires.xls")

#Read workbook
workbook <- loadWorkbook("./Data/tfl-daily-cycle-hires.xls")

#Read the Data Sheet
cycle_hire <- readWorksheet(workbook, sheet="Data")

###################################
# 6. Getting External Data into R - Reading Spatial Data
###################################

# Spatial data are distributed in a variety of formats, but commonly as Shapefiles. 
# These can be read into R using a number of packages, however, is illustrated here with "rgdal". 
# The following code loads a Census Tract Shapefile which was downloaded from the SF OpenData.

#Download and install package
install.packages("rgdal")

#Load package
library(rgdal)

# Read Shapefile
SF <- readOGR(dsn = "D:/Gdrive/ITB/Teaching/2019-2020/PL3102/01_Basic R/Data", layer = "tl_2010_06075_tract10")

# This has created a SpatialPolygonsDataFrame Reading Spatial Data object and can view 
# the tract boundaries using the plot() function:
plot(SF)

# The San Francisco peninsula is shown, however, the formal boundaries extend into the ocean 
# and also include the Farallon Islands. For cartographic purposes it may not be desirable to #
# show these extents, and later we will explore how these can be cleaned up.

#The slotNames() function prints their names.
slotNames(SF)

#Show the top rows of the data object
head(SF@data)

# The "data" slot contains a data frame with a row of attributes for each of the spatial polygons 
# contained within the SF object; thus, one each row equates to one polygon. 
# Other slots contain useful information such as the spatial projection.

###################################
# 7. Creating Spatial Data
###################################

# Sometimes it is necessary to create a spatial object from scratch, which is most common for 
# point data given that only a single co-ordinate is required for each feature. 
# This can be achieved using the SpatialPointsDataFrame() function and is used within this 
# example to create a 311 point dataset. 311 data record non emergency calls within the US, 
# and in this case are those which occurred within San Francisco between 
# January and December 2016. The 311 data used here have been simplified from the original 
# data to only a few variables, and those calls without spatial references have been removed.

# Read csv into R
data_311 <- read.csv("./Data/311.csv")
# Have a look at the structure
head(data_311)

# Create the SpatialPointsDataFrame
SP_311 <- SpatialPointsDataFrame(coords = data.frame(data_311$Lon, data_311$Lat), 
                                 data = data.frame(data_311$CaseID,data_311$Category), 
                                 proj4string = SF@proj4string)

# Show the results
plot(SP_311)


###################################
# 8. Subsetting Data
###################################

# It is often necessary to subset data; either restricting a data frame to a set of 
# columns or rows; or in the case of spatial data, creating an extract for a particular 
# set of geographic features. Subsetting can occur in a number of different ways

#Create a table of frequencies by the categories used within the 311 data
table(data_311$Category)

# Use the subset() function to extract rows from the data which relate to Sewer Issues
sewer_issues <- subset(data_311,Category == "Sewer Issues")

# Use the square brackets "[]" to perform the same task
sewer_issues <- data_311[data_311$Category == "Sewer Issues",]

# Extract a list of IDs for the "Sewer Issues"
sewer_issues_IDs <- subset(data_311,Category == "Sewer Issues", select = "CaseID")

# Subsetting can also be useful for spatial data. In the example above the full extent of 
# San Francisco was plotted, however, for cartographic purposes it may be preferable to 
# remove the "Farallon Islands". This has a GEOID10 of "06075980401" which can be used to 
# remove this from a plot:
plot(SF[SF@data$GEOID10 != "06075980401",]) # Removes Farallon Islands from the plot

# This can also be quite useful if you want to plot only a single feature, for example:
plot(SF[SF@data$GEOID10 == "06075980401",]) # Only plots Farallon Islands

# You can also use the same syntax to create a new object - for example:
SF <- SF[SF@data$GEOID10 != "06075980401",] # Overwrites the SF object
plot(SF)

###################################
# 9. Clipping Spatial Data
###################################

# Clipping is a process of subsetting using overlapping spatial data. 
# The following code uses the outline of the coast of the U.S. to clip the boundaries of 
# the SD spatial data frame object:

#Load library
library("raster")
#Read in coastal outline (Source from - https://www.census.gov/geo/maps-data/data/cbf/cbf_counties.html)
coast <- readOGR(dsn = paste0(wd,"/Data"), layer = "cb_2015_us_county_500k")

# Clip the the SF spatial data frame object to the coastline
SF_clipped <- crop(SF, coast)

#Plot the results
plot(SF_clipped)
SF_clipped <- crop(SF, coast) 

#Plot the results
plot(SF_clipped)

###################################
# 10. Merging Tabular Data
###################################

# So far we have utilized a single data frame or spatial object; however, it is often 
# the case that in order to generate information, data from multiple sources are required. 
# Where data share a common "key", these can be used to combine / link tables together. 
# This might for example be an identifier for a zone; and is one of the reasons 
# why most statistical agencies adopt a standard sets of geographic codes to identify areas.

# In the earlier imported data "earnings" this included a UID column which relates to a Tract ID. 
# We can now import an additional data table called bachelors - this also includes the same ID.

#Read CSV file - creates a data frame called earnings
bachelors <- read.csv("./Data/ACS_14_5YR_S1501_with_ann.csv")

# Using the matching ID columns on both datasets we can link them together to create a 
# new object with the merge() function:
#Perform the merge
SF_Tract_ACS <- merge(x=earnings,y=bachelors,by.x="UID",by.y="UID")
SF_Tract_ACS <- merge(earnings,bachelors,by="UID")
# An alternative method to the above, but a shortened version as the ID columns are 
# the same on both tables
#You can also use all.x=TRUE (or all.y=TRUE) to keep all the rows from either the x or y 
# table - for more details type ?merge()
# The combined table now looks like
head(SF_Tract_ACS) # shows the top of the table

###################################
# 11. Removing and Creating Attributes
###################################

# It is sometimes necessary to remove variables from a tabular object or to create new values. 
# In the following example we will remove some unwanted columns in the SF_clipped object, 
# leaving just the zone id for each polygon.

#Remind yourself what the data look like...
head(SF_clipped@data)

SF_clipped@data <- data.frame(SF_clipped@data[,"GEOID10"]) #Makes a new version of the @data slot with just the values of the GEOID10 column - this is wrapped with the data.frame() function

#The data frame within the data slot now looks as follows
head(SF_clipped)

# One thing you may not like on this new data frame is the column heading which has got a bit messy. 
# We can clean this up using the colnames() function.

colnames(SF_clipped@data) <- "GEOID10" #Update column names
head(SF_clipped@data) #Check the updated values

# These tract ID are supposed to match with those in the "SF_Tract_ACS" object, however, 
# if you are very observant you will notice that there is one issue; the above have a 
# leading zero.

head(SF_Tract_ACS) # show the top of the SF_Tract_ACS object

# As such, in this instance we will create a new column on the SF_Tract_ACS data frame with a 
# new ID that will match the SF GEOID10 column. We can achieve this using the $ symbol and will 
# call this new variable "GEOID10".

# Creates a new variable with a leading zero
SF_Tract_ACS$GEOID10 <- paste0("0",SF_Tract_ACS$UID)
head(SF_Tract_ACS)

# The earnings data had some values that were stored as factors rather than numeric or integers, 
# and the same is true for both the bachelors data; and now the combined SF_Tract_ACS object. 
# We can check this again as follows:
str(SF_Tract_ACS)

# We can also remove the UID column. A quick way of doing this for a single variable is to use "NULL":
SF_Tract_ACS$UID <- NULL

# We will now convert the factor variables to numerics. The first stage will be to remove 
# the "-" and "**" characters from the variables with the gsub() function, replacing these 
# with NA values. This also has the effect of converting the factors to characters.

#Replace the "-" and "*" characters
SF_Tract_ACS$earnings <- gsub("-",NA,SF_Tract_ACS$earnings,fixed=TRUE) #replace the "-" values with NA
SF_Tract_ACS$earnings_m <- gsub("**",NA,SF_Tract_ACS$earnings_m,fixed=TRUE) #replace the "**" values with NA
SF_Tract_ACS$Bachelor_Higher <- gsub("-",NA,SF_Tract_ACS$Bachelor_Higher,fixed=TRUE) #replace the "-" values with NA
SF_Tract_ACS$Bachelor_Higher_m <- gsub("**",NA,SF_Tract_ACS$Bachelor_Higher_m,fixed=TRUE) #replace the "**" values with NA

# We will now convert these to numeric values:
SF_Tract_ACS$earnings <- as.numeric(SF_Tract_ACS$earnings)
SF_Tract_ACS$earnings_m <- as.numeric(SF_Tract_ACS$earnings_m)
SF_Tract_ACS$Bachelor_Higher <- as.numeric(SF_Tract_ACS$Bachelor_Higher)
SF_Tract_ACS$Bachelor_Higher_m <- as.numeric(SF_Tract_ACS$Bachelor_Higher_m )

# Now all the variables other than the "GEOID10" are stored as integers or numerics:
str(SF_Tract_ACS)

###################################
# 12. Merging Spatial Data
###################################

# It is also possible to join tabular data onto a spatial object (e.g. SpatialPolygonsDataFrame) 
# in the same way as with regular data frames. In this example, we will join the newly 
#created SF_Tract_ACS data onto the SF_clipped data frame.

SF_clipped <- merge(SF_clipped,SF_Tract_ACS, by="GEOID10") # merge
head(SF_clipped@data)#show the attribute data

###################################
# 13.Spatial Joins
###################################

# Earlier in this practical we created a SpatialPointDataFrame which we later cropped 
# using the point.in.poly() function to create the "SP_311_PIP" object. 
#As a reminder of what this looks like it is plotted below:
plot(SP_311_PIP)

# We will now clean up the associated data frame by removing all of the attributes apart 
# from the category ("data_311.Category") and then add a sensible column name.
SP_311_PIP@data <- data.frame(SP_311_PIP@data[,"data_311.Category"])#subset data
colnames(SP_311_PIP@data) <- "Category" #update column names

# Although point.in.poly() was used to clip a dataset to an extent earlier, 
# the other really useful feature of this point in polygon function is that 
# it also appends the attributes of the polygon to the point. For example, 
# we might be interested in finding out which census tracts each of the 311 calls resides within. 
# As such, we will implement another point in polygon analysis to create a new object SF_clipped_311:

SF_clipped_311 <- point.in.poly(SP_311_PIP, SF) # point in polygon
#Cleanup the attributes
SF_clipped_311@data <- SF_clipped_311@data[,c("GEOID10","Category")] #note that we don't need to use the data.frame() function as we are keeping more than one column
#Show the top rows of the data
head(SF_clipped_311@data)

###################################
# Writing out and saving your data
###################################

# In order to share data it is often useful to write data frames or spatial 
# objects back out of R as external files. This is very simple, and R supports multiple formats. 
# In these examples, a CSV file and a Shapefile are both created.

#In this example we write out a CSV file from the data slot of the SpatialPointsDataFrame SF_clipped_311
write.csv(SF_clipped_311@data,"311_Tract_Coded.csv")

#This will write out a Shapefile for San Francisco - note, a warning is returned as the column 
# names are a little longer than are allowed within a Shapefile and as such are 
# automatically shortened.
writeOGR(SF_clipped, ".", "SF_clipped", driver="ESRI Shapefile")

###################################
# Basic plotting
###################################

#Import the dataset
ozone_airq_df <- read.csv("./Data/daily_44201_2017.csv")

#install package
install.packages("tidyverse")

library(tidyverse)

#We just need a few variables:
ozone_airq_df2 <- ozone_airq_df[,c('State.Code', 'Site.Num', 'Latitude', 'Longitude', 'Date.Local', 
                                   'State.Name', 'County.Name', 'CBSA.Name', 'AQI')]

g1 <- ozone_airq_df2 %>% 
  filter(stcofips == "06059") %>% # Orange County
  ggplot() + 
  geom_point(aes(x=dateL, y=AQI, color=SiteID)) +
  geom_smooth(aes(x=dateL, y=AQI, color=SiteID), method="loess")+
  scale_colour_brewer(palette = "Set2") + 
  labs(x = "Month", y = "Air Quality Index")

library(plotly)
ggplotly(g1)
