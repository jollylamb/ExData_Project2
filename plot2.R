library(dplyr)

drawPlot2 <- function(){
  
  #read the file
  nei <- readRDS("summarySCC_PM25.rds")
  
  #select the data for Baltimore, MD
  baltimore <- subset(nei, fips=="24510")
  
  #group by year
  grouped <- group_by(baltimore, year)
  
  #sum up the emissions
  totals <- summarize(grouped, total=sum(Emissions, na.rm = T))
  
  #open the png device
  png(file="plot2.png")
  
  #draw the graph
  plot(totals$year, totals$total, type="l", xlab="Year", ylab="Total Emissions", main="Total Emissions for Balitomore, MD")
  
  #close the png device
  dev.off()
}