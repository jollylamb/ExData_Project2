library(dplyr)

drawPlot1 <- function(){
  
  #read the file
  nei <- readRDS("summarySCC_PM25.rds")
  
  #group by year
  grouped <- group_by(nei, year)
  
  #sum up the emissions
  totals <- summarize(grouped, total=sum(Emissions, na.rm = T))
  
  #open the png device
  png(file="plot1.png")
  
  #draw the graph
  plot(totals$year, totals$total, type="l", xlab="Year", ylab="Total Emissions")
  
  #close the png device
  dev.off()
}