classificationPlots(aSAH$s100b, aSAH$outcome, levels=c("Good", "Poor"))
q$thresholds
cbind(q, c(NA, sort(unique(aSAH$s100b))))
c(min(aSAH$s100b),max(aSAH$s100b))

ls(pos = "package:mdma")

# roc en auc-functies vervangen, pROC lozen:
## voor ROC eerst thresholds nodig, dan sens en spec berekenen
## AUC obv MWU/n1*n2 (https://stats.stackexchange.com/questions/206911/relationship-between-auc-and-u-mann-whitney-statistic)

q <- classificationPlots(aSAH$s100b, aSAH$outcome, levels=c("Good", "Poor"))
q$thresholds
x <- aSAH$s100b
obs <- aSAH$outcome
xsort <- sort(unique(x))
xsort
thresholds <- (c(xsort,Inf)+c(-Inf,xsort))/2

x
# maak een lijst met length(thresholds) kopieen van x
# bepaal voor elk volgend element van de lijst welke waarden groter zijn van elk volgend element van thresholds

tlist <- rep(list(x), length(thresholds))
tlist

state <- "Poor"
obsBool <- obs == state
cbind(obs, obsBool)
out <- mapply(.Primitive(">="), tlist, thresholds) #WOW!!!
#colnames(out) <- paste0("x", thresholds)
View(out)
colMeans(out[obsBool == TRUE, ])
cbind(q[,c(3,1,2)],
      FPR = 1 - q[,2],
      sens = colMeans(out[obsBool == TRUE, ]),
      spec = 1 - colMeans(out[obsBool == FALSE, ]),
      FPR2 = colMeans(out[obsBool == FALSE, ]))
colnames(out)[20]
table(out[,4], obs)
lapply(data.frame(out), function(x) sweep(table(x, obs=="Good"), 2, colSums(table(x, obs=="Good")), '/'))

auc <- 1 - wilcox.test(x ~ obs)$statistic / prod(table(obs))
plot(density(x[obs=="Good"]), xlim=c(0,3))
lines(density(x[obs=="Poor"]), lty=3)

### cleanup
c(obs,"blaat") %in% c("Good", "Poor")

c(1,2,2,2,2,1,2,1,1,1,2,3)[c(1,2,2,2,2,1,2,1,1,1,2,3) %in% c(1,2)]

library(pROC)
detach("package:pROC", unload=TRUE)
r <- mdma::roc(pROC::aSAH$s100b, pROC::aSAH$outcome, c("Good","Poor"), "Poor")
class(r)
r
methods::showMethods("roc")
sloop::s3_methods_class("roc")

detach("package:mdma", unload=TRUE)
library(mdma)

lm.1 <- lm(mpg ~ hp, data = mtcars)
lm.2 <- lm(mpg ~ hp + wt, data = mtcars)
lm.3 <- lm(mpg ~ hp * wt, data = mtcars)
lm.4 <- lm(mpg ~ hp * wt + am, data = mtcars)
lm.5 <- t.test(QIDS$QIDS ~ QIDS$depression)
QIDS
probeInteraction(lm.5)
pI <- probeInteraction(lm.3, hp, wt, n.interval.moderator = 35)
probeInteraction(lm.3, hp, wt, n.interval.moderator = 35)

lm.3$call
as.character(lm.3$call[[2]][2])

print.probeInteraction <- function(object, ...){
  print(object$effects)
}

m <- pI

print(pI) |> round(3)

tTest(x1, x2)
posteriorModelOdds(lm.1, lm.2, lm.3, lm.4) |> round(3)

detach("package:mdma", unload = TRUE)
detach("package:pROC", unload = TRUE)
library(mdma)

core <- c("ggplot2", "dplyr", "MASS")
search <- paste0("package:",core)
to_load <- core[!search %in% search()]
to_load
pkg <- to_load[1]
if(pkg %in% loadedNamespaces()) dirname(getNamespaceInfo(pkg, "path"))
loadedNamespaces()
search()

l <- if(3==2) 7
l
library(ggplot2)
getNamespaceInfo("mdma", )
lsNamespaceInfo <- function(ns, ...) {
  ns <- asNamespace(ns, base.OK = FALSE)
  ls(..., envir = get(".__NAMESPACE__.", envir = ns, inherits = FALSE))
}
allinfoNS <- function(ns) sapply(lsNamespaceInfo(ns), getNamespaceInfo, ns=ns)

utils::str(allinfoNS("mdma")) |> View()
core
grep("^package:", search(), value=TRUE)
envs <- purrr::set_names(grep("^package:", search(), value=TRUE))

lapply(envs, function(x) ls(pos=x)) |> invert()

invert <- function(x) {
  if (length(x) == 0) return()
  stacked <- utils::stack(x)
  tapply(as.character(stacked$ind), stacked$values, list)
}

lapply(list(a=3,b=2), function(x) x+1) |> invert()
??invert()

installed.packages("mdma", priority = "high", fields = "License")

#creation of QIDS data
set.seed(4)
n <- 100
QIDS <- round(MASS::mvrnorm(n = n, mu = 14.5, Sigma = matrix(25)), 0)
QIDS[QIDS < 6] <- 6
QIDS[QIDS > 27] <- 27
hist(QIDS, breaks = 20)
jitter <- 3.5 * sample(rep(c(-1,1), n/2))
depressed <- (QIDS + jitter) > 14.5
depression <- rep(NA, n)
depression[depressed==TRUE] <- "Yes"
depression[depressed==FALSE] <- "No"
depression <- as.factor(depression)
a <- roc(QIDS$QIDS, QIDS$depression, c("Yes","No"), "Yes")
plot(a, ylim.3 = c(0,.2), xlab.3= "hoi", cutoffs.1 = 14.5, cutoffs.2 = 14.5, cutoffs.3 = 14.5)
mdma::classificationPlots(QIDS, depression, c("Yes","No"), "Yes")
rm(roc)
sloop::s3_methods_class("htest")
QIDS <- data.frame(QIDS, depression)
save(QIDS, file='data/QIDS.rda')

p <- load("data/QIDS.rda")
rm (p)

rm(QIDS)
QIDS

par()$mfrow
par(mfrow=c(2,2))

blaat <- function(x){
  oldpar <- par(mfrow=c(1,3))
  print(par()$mfrow)
  print(oldpar)
  on.exit(par(oldpar), add = TRUE)
  print(par()$mfrow)
  par(mfrow = c(1,3))
  return(1)
}

blaat(3)
par()$mfrow


library(mdma)
a <- roc(QIDS$QIDS, QIDS$depression, c("Yes","No"), "Yes")
a
plot(a, which = c(1,3), orientation = "vertical", ylim.3 = c(0,.2))
tTest(QIDS$QIDS, QIDS$depression)
class(QIDS$depression)
t.test(QIDS$QIDS[QIDS$depression == "Yes"], QIDS$QIDS[QIDS$depression == "Yes"])
tt <- tTest(QIDS$QIDS[QIDS$depression == "Yes"], QIDS$QIDS[QIDS$depression == "No"])
summary(tt)

x1 <- QIDS$QIDS[QIDS$depression == "Yes"]
x2 <- QIDS$QIDS[QIDS$depression == "No"]
tt <- tTest(x1, x2)
summary(tt, rnd = c(1,2,3))
print(tt)

pI <- probeInteraction(lm.3, hp, wt, n.interval.moderator = 35, alpha = .05)
plot(pI)

