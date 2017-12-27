

library(data.table)
library(plyr)
library(e1071)


# Raw Data
data.MSD <- read.csv(file="ilc_mdsd03.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)
data.MSD
str(data.MSD)

data.LE <- read.csv(file="demo_mlexpecedu_1_Data.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)
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
df.MSD.primary <- df.MSD.primary[-grep(":",df.MSD.primary$Value),]
df.MSD.primary

data.MSD.secondary <- DT.MSD[DT.MSD$TIME == "2016" & DT.MSD$ISCED11 == "Upper secondary and post-secondary non-tertiary education (levels 3 and 4)", ] 
data.MSD.secondary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
df.MSD.secondary <- as.data.frame(data.MSD.secondary)
df.MSD.secondary <- df.MSD.secondary[-grep(":",df.MSD.secondary$Value),]
df.MSD.secondary

data.MSD.tertiary <- DT.MSD[DT.MSD$TIME == "2016" & DT.MSD$ISCED11 == "Tertiary education (levels 5-8)", ] 
data.MSD.tertiary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
df.MSD.tertiary <- as.data.frame(data.MSD.tertiary)
df.MSD.tertiary <- df.MSD.tertiary[-grep(":",df.MSD.tertiary$Value),]
df.MSD.tertiary

data.LE.primary <- DT.LE[DT.LE$TIME == "2015" & DT.LE$ISCED11 == "Less than primary, primary and lower secondary education (levels 0-2)", ] 
data.LE.primary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.LE.primary
data.LE.primary <- data.LE.primary[-grep(":",data.LE.primary$Value),]
data.LE.primary

data.LE.secondary <- DT.LE[DT.LE$TIME == "2015" & DT.LE$ISCED11 == "Upper secondary and post-secondary non-tertiary education (levels 3 and 4)", ] 
data.LE.secondary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.LE.secondary
data.LE.secondary <- data.LE.secondary[-grep(":",data.LE.secondary$Value),]
data.LE.secondary

data.LE.tertiary <- DT.LE[DT.LE$TIME == "2015" & DT.LE$ISCED11 == "Tertiary education (levels 5-8)", ] 
data.LE.tertiary[ , c("AGE","UNIT", "TIME", "SEX", "Flag.and.Footnotes", "ISCED11") := NULL]
data.LE.tertiary
data.LE.tertiary <- data.LE.tertiary[-grep(":",data.LE.tertiary$Value),]
data.LE.tertiary

df <- join_all(list(df.MSD.primary ,
              df.MSD.secondary, 
              df.MSD.tertiary,
              data.LE.primary,
              data.LE.secondary,
              data.LE.tertiary), 
         by='GEO', type='left')
class(df)
df
df <- df[complete.cases(df), ]
colnames(df) <- c("Country", "MSD_1", "MSD_2", "MSD_3", "LE_1", "LE_2", "LE_3")
df

svm(df$MSD_1~., data=df)

Country <- df$Country
MSD_1 <- as.numeric(as.character(df$MSD_1))
MSD_2 <- as.numeric(as.character(df$MSD_2))
MSD_3 <- as.numeric(as.character(df$MSD_3))
LE_1 <- as.numeric(as.character(df$LE_1))
LE_2 <- as.numeric(as.character(df$LE_2))
LE_3 <- as.numeric(as.character(df$LE_3))

df1 <- data.frame(Country, MSD_1, MSD_2, MSD_3, LE_1, LE_2, LE_3)
df1











