#clear workspace
rm(list=ls(all=TRUE)) 

#our assumed state of the world
grpA_mean=105
grpB_mean=100
common_sd=20
#assuming equal n for the groups
sample_size = 20
alpha=.05

replications = 2000

cohens_d = abs((grpA_mean-grpB_mean)/common_sd)
print(cohens_d)

set.seed(5011)
t_statistics<-numeric()

for (i in 1:replications){
  grpA<-rnorm(sample_size,mean=grpA_mean,sd=common_sd)
  grpB<-rnorm(sample_size,mean=grpB_mean,sd=common_sd)
  test_em<-t.test(grpA,grpB,paired=F, var.equal=T)
  t_statistics<-c(t_statistics,test_em$statistic)
  
}


#plot the sampling distribution of t under the alternative
hist(t_statistics,20,freq=F)
#so for a 2-tailed .05 test we want t for lower 2.5%
crit_t<-qt(p=alpha/2,df=2*sample_size-2)

#plot critical values
abline(v=c(crit_t,abs(crit_t)),col = "lightgray", lwd=5)
#plot density of null distribution using a smooth line over histogram
xfit<-seq(fro=-3,to=3,by=.01)
yfit<-dt(xfit,df=2*sample_size-2)
lines(xfit,yfit,col='blue',lwd=2)

#ok so what is the power under this situation
obs_power<-sum(abs(t_statistics)>abs(crit_t))/replications
print(paste('The observed power using simulation is: ',as.character(obs_power)))


##OK how about a calculating it using the ideal non-central t-distribution
#under the alternative hypothesis
non_centrality_parameter<-cohens_d*1/sqrt(2/sample_size)
area_above<-pt(abs(crit_t),df=2*sample_size-2,ncp=non_centrality_parameter,lower.tail=F)
area_below<-pt(crit_t,df=2*sample_size-2,ncp=non_centrality_parameter,lower.tail=T)
print(paste('Power using ideal non-central t distribution is: ',
            as.character(area_below+area_above)))











