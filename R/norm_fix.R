#' Title Overall data were adjusted based on quantile value of housekeeping genes
#'
#' @param data must be a data.frame or matrix
#' @param ... parameter see `?housekeep`
#'
#' @return data
#' @export norm_fix
#' @importFrom preprocessCore normalize.quantiles.use.target normalize.quantiles.determine.target
#' @examples
#' y <- matrix( rpois(1000, lambda=5), nrow=200 )
#' n = dim(y)
#' colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
#' rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#' y = as.data.frame(y)
#' #y_fix2 = norm_fix(y,expcv = 0.3, exphigh = 0.8, explow = 0.4)
norm_fix <- function(data, ...){
  data_hk = housekeep(data, ...)
  norm_q = preprocessCore::normalize.quantiles.determine.target(as.matrix(data_hk))
  data_norm_adjust = preprocessCore::normalize.quantiles.use.target(as.matrix(data),norm_q)
  colnames(data_norm_adjust) = colnames(data)
  rownames(data_norm_adjust) = rownames(data)
  return(as.data.frame(data_norm_adjust))
}
