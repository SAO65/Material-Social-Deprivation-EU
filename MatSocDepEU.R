

library(data.table)
library(plyr)

# Raw Data
data.MSD <- read.csv(file="ilc_mdsd03.csv", header=TRUE, sep=",")
data.MSD
str(data.MSD)

data.LE <- read.csv(file="demo_mlexpecedu_1_Data.csv", header=TRUE, sep=",")
data.LE
str(data.LE)

# Tidy Data

attach(data.MSD)
attach(data.LE)

DT.MSD <- data.table(data.MSD)
DT.LE <- data.table(data.LE)

tables()

data.MSD.primary <- DT.MSD[DT.MSD$TIME == "2016" & DT.MSD$ISCED11 == "Less than primary, primary and lower secondary education (levels 0-2)", ] 
data.MSD.primary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.MSD.primary <- data.MSD.primary[order(data.MSD.primary[,"GEO"]), ]
df.MSD.primary <- as.data.frame(data.MSD.primary)
df.MSD.primary

data.MSD.secondary <- DT.MSD[DT.MSD$TIME == "2016" & DT.MSD$ISCED11 == "Upper secondary and post-secondary non-tertiary education (levels 3 and 4)", ] 
data.MSD.secondary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
df.MSD.secondary <- as.data.frame(data.MSD.secondary)

data.MSD.tertiary <- DT.MSD[DT.MSD$TIME == "2016" & DT.MSD$ISCED11 == "Tertiary education (levels 5-8)", ] 
data.MSD.tertiary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
df.MSD.tertiary <- as.data.frame(data.MSD.tertiary)

data.LE.primary <- DT.LE[DT.LE$TIME == "2015" & DT.LE$ISCED11 == "Less than primary, primary and lower secondary education (levels 0-2)", ] 
data.LE.primary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.LE.primary

data.LE.secondary <- DT.LE[DT.LE$TIME == "2015" & DT.LE$ISCED11 == "Upper secondary and post-secondary non-tertiary education (levels 3 and 4)", ] 
data.LE.secondary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.LE.secondary

data.LE.tertiary <- DT.LE[DT.LE$TIME == "2015" & DT.LE$ISCED11 == "Tertiary education (levels 5-8)", ] 
data.LE.tertiary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.LE.tertiary

join_all(list(df.MSD.primary ,df.MSD.secondary, df.MSD.tertiary), by='GEO', type='left')



















