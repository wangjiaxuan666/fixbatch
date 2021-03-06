% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/col_sum.R
\name{col_sum}
\alias{col_sum}
\title{Title Calculate column value sum of the every row}
\usage{
col_sum(data)
}
\arguments{
\item{data}{must be a data.frame or matrix}
}
\value{
vcxtor
}
\description{
Title Calculate column value sum of the every row
}
\examples{
y <- matrix( rpois(1000, lambda=5), nrow=200 )
col_sum(y)
n = dim(y)
colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
y = as.data.frame(y)
col_sum(y)
}
