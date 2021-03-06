% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/norm_fix.R
\name{norm_fix}
\alias{norm_fix}
\title{Adjust for batch effects using an housekeep gene}
\usage{
norm_fix(data, ...)
}
\arguments{
\item{data}{must be a data.frame or matrix}

\item{...}{parameter see \code{?housekeep}}
}
\value{
data
}
\description{
norm_fix allows users to adjust for batch effects in datasets where the batch covariate is known, using the
packages preprocessCore, and the function normalize.quantiles.
}
\examples{
y <- matrix( rpois(1000, lambda=5), nrow=200 )
n = dim(y)
colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
y = as.data.frame(y)
#y_fix2 = norm_fix(y,expcv = 0.3, exphigh = 0.8, explow = 0.4)
}
