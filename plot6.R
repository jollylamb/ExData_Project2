library(ggplot2)

drawPlot6 <- function(){
  
  #read in the data files
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  
  #get the codes for sources whose EI.Sector contains "mobile on-road"
  #based this on docs found at
  #http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf
  mvCodes <- grep("mobile - on-road", scc$EI.Sector, ignore.case = T)
  scc.MV <- as.character(scc$SCC[mvCodes])
  
  #subset the nei data based on MV
  nei <- nei[nei$SCC %in% scc.MV,]
  
  #subset out data for Baltimore, MD and Los Angeles, CA
  cities <- subset(nei, (fips=="24510" | fips=="06037"))
  
  #aggregate the data by year and fips
  ag <- aggregate(cities$Emissions, list(FIPS=cities$fips, Year=cities$year), FUN=sum)
  
  #open the png device
  png(file="plot6.png")
  
  #draw the graph; the aggregate function created the column x containing the totals
  ggplot(ag, aes(Year, x)) + geom_line() + facet_grid(.~FIPS) + 
    labs(y="Total Emissions", title="Emissions from Motor Vehicle Sources in Los Angeles, CA and Baltimore, MD")
  
  #close the pnd device
  dev.off()
}