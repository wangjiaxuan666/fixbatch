#' Title Calculate column value sum of the every row
#'
#' @param data must be a data.frame or matrix
#'
#' @return vcxtor
#' @export col_sum
#'
#' @examples
#' y <- matrix( rpois(1000, lambda=5), nrow=200 )
#' col_sum(y)
#' n = dim(y)
#' colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
#' rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#' y = as.data.frame(y)
#' col_sum(y)
col_sum <- function(data){
  a = apply(data, 1, sum, na.rm = T)
  a = a[a != 0]
  return(a)
}
