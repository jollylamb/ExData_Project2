library(dplyr)

drawPlot5 <- function(){
  
  #read in the data files
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  
  #get the codes for sources whose EI.Sector contains "mobile on-road"
  #based this on docs found at
  #http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf
  mvCodes <- grep("mobile - on-road", scc$EI.Sector, ignore.case = T)
  scc.MV <- as.character(scc$SCC[mvCodes])
  
  #subset the nei data based on MV and Baltimore, MD
  nei <- nei[nei$SCC %in% scc.MV,]
  baltimore <- subset(nei, fips=="24510")
  
  #group by year
  grouped <- group_by(baltimore, year)
  
  #sum up the emissions
  totals <- summarize(grouped, total=sum(Emissions, na.rm = T))
  
  #open the png device
  png(file="plot5.png")
  
  #draw the graph
  plot(totals$year, totals$total, type="l", xlab="Year", ylab="Total Emissions", 
       main="Total Emissions for Balitomore, MD from Motor Vehicle Sources")
  
  #close the png device
  dev.off()
}