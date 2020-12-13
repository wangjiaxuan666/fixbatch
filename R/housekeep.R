#' Title According to the coefficient of variation and the expression sum, the stable observation value is selected
#'
#' @param data must be a data.frame or matrix
#' @param expcv a number range 0 to 1, Sets the maximum quantile value of the coefficient of variation
#' @param exphigh a number range 0 to 1, Sets the maximum quantile value of expression sum
#' @param explow a number range 0 to 1, Sets the minimum quantile value of expression sum
#'
#' @return data
#' @export housekeep
#' @importFrom stats quantile
#'
#' @examples
#' y <- matrix( rpois(1000, lambda=5), nrow=200 )
#' n = dim(y)
#' colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
#' rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#' y = as.data.frame(y)
#' #data_hk = housekeep(data, expcv = 0.3, exphigh = 0.8, explow = 0.4)
#' #head(data_hk)
housekeep <- function(data, expcv = 1, exphigh = 1, explow = 0){
  cv = col_cv(data)
  gexp = col_sum(data)
  lowcv = quantile(cv,prob = expcv)
  highexp = quantile(gexp,prob = exphigh)
  lowexp = quantile(gexp,prob = explow)
  i_cv = cv <= lowcv
  i_gexp = (gexp < highexp) & (gexp > lowexp)
  dat_reslut = data[i_cv + i_gexp == 2 ,]
  cat("The stable housekeep gene number is",paste(dim(dat_reslut)[[1]]))
  return(dat_reslut)
}
