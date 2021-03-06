% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pvca_plot.R
\name{pvca_plot}
\alias{pvca_plot}
\title{Title A plot function for dispaly the result of principal variance component analysis}
\usage{
pvca_plot(
  data,
  col = "#69b3a2",
  las = 0,
  main = "PVCA estimation bar chart",
  ylim = c(0, 1.1),
  xlab = "Effects",
  ylab = "Weighted average proportion variance",
  ...
)
}
\arguments{
\item{data}{the result of pvca}

\item{col}{color of barplot}

\item{las}{the orientation of x-axis font}

\item{main}{overall  title for the plot.}

\item{ylim}{limits for the y axis.}

\item{xlab}{a label for the x axis.}

\item{ylab}{a label for the y axis.}

\item{...}{add the parameter of barplot}
}
\value{
plot the base R
}
\description{
The function is written based on the  the PVCA R package(http://watson.nci.nih.gov/bioc_mirror/packages/release/bioc/manuals/pvca/man/pvca.pdf).
My new R packages fixbatch need the function to to estimate factor's partition of the total variability. So I fork the packages and Adjust in my own style.
}
\examples{
print("Just try it")
}
