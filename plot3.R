plot3<- function(){
        # read data files
        NEI <- readRDS("./summarySCC_PM25.rds")
        SCC <- readRDS("./Source_Classification_Code.rds")
        
        # get baltimore data and aggregate it by year and type
        baltimore<- subset(NEI,fips == "24510")
        
        total.emissions<- aggregate(Emissions ~ year + type, 
                                    data = baltimore,FUN =sum)
        
        #plot
        library(ggplot2)
        
        png("plot3.png")
        
        g<-ggplot(total.emissions, aes(x=factor(year), y=Emissions, fill=type)) +
                geom_bar(stat= "identity") +
                facet_grid(.~type) +
                xlab("year") +
                ylab(expression("Total PM"[2.5]*" Emission")) +
                ggtitle(expression("Total PM"[2.5]*" Emissions in Baltimore City by source type over years"))
        print(g)
        
        dev.off()
}

