plot5<- function(){
        # read data files
        NEI <- readRDS("./summarySCC_PM25.rds")
        SCC <- readRDS("./Source_Classification_Code.rds")
        
        #get Baltimore records
        baltimore<- subset(NEI,fips == "24510" )
        
        # get records of emissions from motor vehicles
        Mobile<- grepl("Mobile - On-Road* ",SCC$EI.Sector)
        Mobile_subset<- SCC[Mobile,]
        
        Mobile.Emissions<- baltimore[baltimore$SCC %in% Mobile_subset$SCC,]
        
        Mobile.Emissions.year<- aggregate(Emissions ~ year,
                                        data = Mobile.Emissions,FUN = sum)
        
        #plot
        barplot(height = Mobile.Emissions.year$Emissions, 
                names.arg = Mobile.Emissions.year$year,
                col = "orange",
                xlab = "years",ylab =expression('Total PM'[2.5]* ' Emissions'),
                main = expression('Total PM'[2.5]* ' Emissions from motor vehicle Sources over years'))
        
        dev.copy(png,file = "plot5.png")
        dev.off()
        
}
