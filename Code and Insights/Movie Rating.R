movies <- read.csv(file.choose())
head(movies)

colnames(movies) <- c("Film","Genre","CriticRating", "AudienceRating","BudgetsMillion","Year")
head(movies,3)
tail(movies)
str(movies)
summary(movies)


factor(movies$Year)
movies$Year <- factor(movies$Year)
str(movies)




#------Aesthetics
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#add geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating) ) + 
    geom_point()

#add color size 
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                        colour=Genre, size=BudgetsMillion) ) + 
  geom_point()

#plotting with layers

p<-ggplot(data=movies, aes(x=CriticRating, 
                        y=AudienceRating,
                        colour=Genre, 
                        size=BudgetsMillion))
#point
p + geom_point()

#lines
p + geom_line()

#multiple lines

p + geom_point() +geom_line()
p + geom_line() +geom_point()

#----------overriding Aesthethics

q<- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                            colour=Genre,size=BudgetsMillion))

#add geom layer
q+ geom_point()

#overriding aes
#ex1
q+ geom_point(aes(size=CriticRating))

#ex2
q+ geom_point(aes(size=BudgetsMillion))

#ex3
q+ geom_point(aes(x=BudgetsMillion))+
  xlab("Budget Millions $")

#ex4
q + geom_line(size=1) +geom_point()


#--------mapping vs setting

r<- ggplot(data= movies, aes(x=CriticRating, y=AudienceRating))
r+geom_point()

#add colour
#1. mapping 
r+ geom_point(aes(colour=Genre))

#2, setting
r+ geom_point(colour="DarkGreen")

#error
#r+ geom_point(aes(colour="DarkGreen"))

#1.mapping

r+geom_point(aes(size=BudgetsMillion))
#2.setting
r+geom_point(size=10)

#error
#r+geom_point(aes(size=10))

#-------histograms and density charts

s <- ggplot(data=movies, aes(x=BudgetsMillion))
s+geom_histogram(binwidth = 10)

#addcolour
s+geom_histogram(binwidth = 10,aes(fill=Genre))

#add border
s+geom_histogram(binwidth = 10,aes(fill=Genre), colour="Black")

#>>>3




#density chart
s +geom_density(aes(fill=Genre))
s +geom_density(aes(fill=Genre), position = "stack")

#---------Starting  layer tips
t <- ggplot(data= movies, aes(x=AudienceRating))
t+ geom_histogram(binwidth = 10,
                  fill="White",colour="Blue")
#another way
t <- ggplot(data= movies)
t+ geom_histogram(binwidth = 10,
                  aes(x=AudienceRating),
                  fill="White",colour="Blue")

#>>>4


t+ geom_histogram(binwidth = 10,
                  aes(x=CriticRating),
                  fill="White",colour="Blue")

#>>>5

t<-ggplot()




#--------Statistical Transformation
?geom_smooth()


u <- ggplot(data= movies, aes(x=CriticRating, y=AudienceRating,
                              colour=Genre))
u+geom_point()+geom_smooth(fill=NA)


#boxplots

u <- ggplot(data=movies, aes(x=Genre,y=AudienceRating,
                             colour=Genre))
u+geom_boxplot()
u +geom_boxplot(size=1.2)
u +geom_boxplot(size=1.2)+geom_point()

#tip/hack
u +geom_boxplot(size=1.2)+geom_jitter()
#another way
u +geom_jitter() +geom_boxplot(size=1.2, aplha=0.5)
#>>>6


f <- ggplot(data=movies, aes(x=Genre,y=CriticRating,
                             colour=Genre))
f +geom_jitter() +geom_boxplot(size=1.2, aplha=0.5)



#---------using Facets


v <- ggplot(data=movies, aes(x=BudgetsMillion))
v+geom_histogram(binwidth = 10, aes(fill=Genre),
                 colour="Black")

#facets

v+geom_histogram(binwidth = 10, aes(fill=Genre),
                 colour="Black")+
  facet_grid(Year~., scales = "free")

#scatterplots:
w <- ggplot(data=movies, aes(x=BudgetsMillion,
                             y=AudienceRating,
                             colour=Genre))
w +geom_point(size=3)+
  facet_grid(Genre~.)

w +geom_point(size=3)+
  facet_grid(.~Year)

w +geom_point(size=3)+
  facet_grid(Genre~Year)

w +geom_point(aes(size=BudgetsMillion))+
  facet_grid(Genre~Year)+
  geom_smooth()
#>>>>1





#--------Cooordinates

m <- ggplot(data=movies, aes(x=CriticRating,
                             y=AudienceRating,
                             colour=Genre))
m+geom_point()                             

m+geom_point()+
  xlim(50,100)+
  ylim(50,100)

#this wont work well always
#example
n <- ggplot(data= movies, aes(x=BudgetsMillion))
n+ geom_histogram(binwidth=10,aes(fill=Genre), colour="Black")+
  ylim(0,50)

#instead zoom

n+ geom_histogram(binwidth=10,aes(fill=Genre), colour="Black")+
  coord_cartesian(ylim = c(0,50))

#improve >>>>>1

w +geom_point(aes(size=BudgetsMillion))+
  facet_grid(Genre~Year)+
  geom_smooth()+ coord_cartesian(ylim=c(0,100))

#------Theme
o <- ggplot(data=movies, aes(x=BudgetsMillion))
h <-o+geom_histogram(binwidth = 10,aes(fill=Genre), colour="Black")

h

#axes labels

h +xlab("Money Axis") + ylab("No. of Movies")+
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour = "Red",size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))


#legend formatting

h +xlab("Money Axis") + ylab("No. of Movies")+
  ggtitle("Movies Budget Distribution")+
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour = "Red",size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=30),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(colour = "DarkBlue",
                                  size=40,
                                  family="Courier")
        )



