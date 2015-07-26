library(dplyr)

drawPlot4 <- function(){
  
  #read in the data files
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  
  #get the SCC vals for coal combustion
  #decided to use just the sources whose EI.Sector contained coal 
  #http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf
  #based this decision on what I read in the above doc
  coalRows <- grep("coal", scc$EI.Sector, ignore.case=T)
  scc.coal <- as.character(scc$SCC[coalRows])
  
  #subset the pm2.5 data on the coal combustion sources
  nei <- nei[nei$SCC %in% scc.coal,]
  
  #group by year
  grouped <- group_by(nei, year)
  
  #sum up the emissions
  totals <- summarize(grouped, total=sum(Emissions, na.rm = T))
  
  #open the png device
  png(file="plot4.png")
  
  #draw the graph
  plot(totals$year, totals$total, type="l", xlab="Year", ylab="Total Emissions", 
       main="Emissions from Coal Combustion Related Sources")
  
  #close the png device
  dev.off()
}