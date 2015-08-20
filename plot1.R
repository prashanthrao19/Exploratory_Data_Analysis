plot1<- function(){
        # read data files
        NEI <- readRDS("./summarySCC_PM25.rds")
        SCC <- readRDS("./Source_Classification_Code.rds")
        
        # get aggregate emissions per year
        total.emissions<- aggregate(Emissions ~ year, NEI,sum)
        
        #plot
        barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,
                xlab="year", ylab=expression('Total PM'[2.5]*' Emission'),
                main=expression('Total PM'[2.5]*' Emission over years'),col = "red")
        
        dev.copy(png,file = "plot1.png")
        dev.off()
}
