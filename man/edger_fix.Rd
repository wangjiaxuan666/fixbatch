% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/edger_fix.R
\name{edger_fix}
\alias{edger_fix}
\title{Calculate normalization factors to scale the raw library sizes. the script is
created by Yunshun Chen. The work use the function calcNormFactors and cpm.}
\usage{
edger_fix(data = NULL, ...)
}
\arguments{
\item{data}{input obversation}

\item{...}{form calcNormFactors}
}
\value{
data
}
\description{
Calculate normalization factors to scale the raw library sizes. the script is
created by Yunshun Chen. The work use the function calcNormFactors and cpm.
}
\examples{
y <- matrix( rpois(1200, lambda=6), nrow=200 )
n = dim(y)
colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#y = as.data.frame(y)
#re <- edger_fix(data)
}
