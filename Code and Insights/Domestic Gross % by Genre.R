mov <- read.csv(file.choose())
head(mov)
tail(mov)
str(mov)
summary(mov)



ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio == "WB") | (mov$Studio == "Fox") | (mov$Studio == "Universal") | (mov$Studio == "Sony") | (mov$Studio == "Paramount Pictures")



mov2 <- mov[filt & filt2,]
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p

q<-p+
  geom_jitter(aes(size=Budget...mill., colour=Studio))+
  geom_boxplot(aplha=0.7, outlier.color = NA)

q  


q<- q+
  xlab("Genre")+
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre")
q


q <- q + 
  theme(
    text = element_text(family="Comic Sans MS"),
    
    axis.title.x = element_text(colour="Blue", size=30),
    axis.title.y = element_text(colour="Blue", size=30),
    
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),  
    
    plot.title = element_text(colour="Black",
                     size=40),
    
    legend.title = element_text(size=20),
    legend.text  = element_text(size=12)
  )
q

q$labels$size = "Budget $M"
q
