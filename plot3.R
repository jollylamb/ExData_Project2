library(ggplot2)

drawPlot3 <- function(){
  
  #read the file
  nei <- readRDS("summarySCC_PM25.rds")
  
  #select the data for Baltimore, MD
  baltimore <- subset(nei, fips=="24510")
  
  #aggregate the data by year and type
  #found an extremely helpful example at
  #http://davetang.org/muse/2013/05/22/using-aggregate-and-apply-in-r/
  ag <- aggregate(baltimore$Emissions, list(Type=baltimore$type, Year=baltimore$year), FUN=sum)
  
  #open the png device
  png(file="plot3.png", width=800, height=600)
  
  #draw the graph; the aggregate function created the column x containing the totals
  ggplot(ag, aes(Year, x)) + geom_point() + facet_grid(.~Type) + labs(y="Total Emissions")
  
  #close the png device
  dev.off()
}