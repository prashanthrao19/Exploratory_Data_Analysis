plot6<- function() {
        # Read data files
        NEI <- readRDS("./summarySCC_PM25.rds")
        SCC <- readRDS("./Source_Classification_Code.rds")

        # Get Baltimore emissions from motor vehicle sources
        baltimore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
        baltimore.emissions.aggr <- aggregate(Emissions ~ year, data=baltimore.emissions, FUN=sum)

        # Get Los Angeles emissions from motor vehicle sources
        la.emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
        la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)

        baltimore.emissions.aggr$City <- "Baltimore City, MD"
        la.emissions.aggr$City <- "Los Angeles County, CA"
        both.emissions <- rbind(baltimore.emissions.aggr, la.emissions.aggr)

        # plot
        library(ggplot2)
        
        
        g<-ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill= City)) +
        geom_bar(stat="identity") + 
        facet_grid(City  ~ ., scales="free") +
        ylab("total emissions (tons)") + 
        xlab("year") +
        ggtitle(expression("Motor vehicle emission variation\nin Baltimore and Los Angeles"))
        
        print(g)  
        dev.copy(png,file = "plot6.png")      
        dev.off()
}