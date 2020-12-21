#' Calculate normalization factors to scale the raw library sizes. the script is
#' created by Yunshun Chen. The work use the function calcNormFactors and cpm.
#'
#' @param data input obversation
#' @param ... form calcNormFactors
#'
#' @return data
#' @export edger_fix
#' @importFrom edgeR DGEList calcNormFactors cpm
#' @importFrom xbox get_df
#' @examples
#' y <- matrix( rpois(1200, lambda=6), nrow=200 )
#' n = dim(y)
#' colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
#' rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#' #y = as.data.frame(y)
#' #re <- edger_fix(data)
edger_fix <- function(data = NULL,...){
  data_df = xbox::get_df(data)
  data_edger <- edgeR::DGEList(counts = data_df)
  data_cnf = edgeR::calcNormFactors(data_edger,...)
  dat_result = edgeR::cpm(data_cnf)
  return(dat_result)
}
