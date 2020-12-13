#' Title Calculating coefficient of variation
#'
#' @param data must be a data.frame or matrix
#'
#' @return vcxtor
#' @export col_cv
#' @importFrom stats sd
#' @examples
#' y <- matrix( rpois(1000, lambda=5), nrow=200 )
#' col_cv(y)
#' n = dim(y)
#' colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
#' rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#' y = as.data.frame(y)
#' col_cv(y)
col_cv <- function(data){
  a = apply(data, 1, sum, na.rm =T)
  data = data[a != 0,]
  m = apply(data, 1, mean, na.rm  =T)
  s = apply(data, 1, sd, na.rm = T)
  cv = s/m
  return(cv)
}
