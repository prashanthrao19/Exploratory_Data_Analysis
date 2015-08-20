plot4<- function(){
        # read data files
        NEI <- readRDS("./summarySCC_PM25.rds")
        SCC <- readRDS("./Source_Classification_Code.rds")
        
        # get records with Coal combustion in SCC
        Coal<- grepl("Fuel Comb.*Coal",SCC$EI.Sector)
        Coal_subset<- SCC[Coal,]
        
        # get records with Coal combustion in NEI
        Coal.Emissions<- NEI[NEI$SCC %in% Coal_subset$SCC,]
        Coal.Emissions.year<- aggregate(Emissions ~ year,
                                        data = Coal.Emissions,FUN = sum)
        #plot
        barplot(height = Coal.Emissions.year$Emissions, 
                names.arg = Coal.Emissions.year$year,
                col = "orange",
                xlab = "years",ylab =expression('Total PM'[2.5]* ' Emissions'),
                main = expression('Total PM'[2.5]* ' Emissions from Coal Sources over years'))
        
        dev.copy(png,file = "plot4.png")
        dev.off()
        
}
