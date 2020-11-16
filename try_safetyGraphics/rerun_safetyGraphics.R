d <- './R/safetyGraphics-dev/inst/'


for (i in dir(d)){
	for (j in dir(paste(d, "/", i))){
		source(paste(d, "/", i, "/", j))
	}
}
library(safetyGraphics)
maxFileSize = NULL

load("./safetyGraphics-dev/data/meta.rda")
load("./safetyGraphics-dev/data/aes.rda")
load("./safetyGraphics-dev/data/charts.rda")
load("./safetyGraphics-dev/data/labs.rda")
load("./safetyGraphics-dev/data/dm.rda")


domainData=list(
	labs=labs, 
	aes=aes, 
	dm=dm
)

mapping=NULL
chartSettingsPaths = NULL


