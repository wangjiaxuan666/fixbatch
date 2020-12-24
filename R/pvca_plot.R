#' Title A plot function for dispaly the result of principal variance component analysis
#'
#' The function is written based on the  the PVCA R package(http://watson.nci.nih.gov/bioc_mirror/packages/release/bioc/manuals/pvca/man/pvca.pdf).
#' My new R packages fixbatch need the function to to estimate factor's partition of the total variability. So I fork the packages and Adjust in my own style.
#'
#' @param data the result of pvca
#' @param col color of barplot
#' @param las the orientation of x-axis font
#' @param main overall  title for the plot.
#' @param ylim limits for the y axis.
#' @param xlab a label for the x axis.
#' @param ylab a label for the y axis.
#' @param ...  add the parameter of barplot
#'
#' @importFrom graphics barplot text
#'
#' @return plot the base R
#' @export
#'
#' @examples
#' print("Just try it")
pvca_plot <- function(data,
                      col="#69b3a2",
                      las = 0,
                      main = "PVCA estimation bar chart",
                      ylim= c(0,1.1),
                      xlab = "Effects",
                      ylab = "Weighted average proportion variance",
                      ...){
  bp <- graphics::barplot(data,
                xlab = xlab,
                ylab = ylab,
                ylim= ylim,
                col= col,
                las = las,
                main = main,
                ...)
  graphics::text(bp,data,labels = paste(round(100*data, 2), "%", sep=""),pos = 3, cex = 1.2)
}
