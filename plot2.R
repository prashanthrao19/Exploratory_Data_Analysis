plot2<- function(){
        # read data files
        NEI <- readRDS("./summarySCC_PM25.rds")
        SCC <- readRDS("./Source_Classification_Code.rds")
        
        # get baltimore data and aggrgate it yea-wise
        baltimore<- subset(NEI,fips == "24510")
        
        total.emissions<- aggregate(Emissions ~ year, baltimore,sum)
        
        #plot
        barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,
                xlab="years", ylab=expression('Total PM'[2.5]*' Emission'),
                main=expression('Total PM'[2.5]*' Emission over years for Baltimore'),col = "red")
        
        dev.copy(png,file = "plot2.png")
        dev.off()
}
