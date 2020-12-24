#' Title IT is exactly the same as sva::combat, only changing name. the sva website is
#' "https://bioconductor.org/packages/release/bioc/html/sva.html"
#'
#' @param ... the same as sva::combat
#'
#' @return matrix "?combat"
#' @export
#' @importFrom sva ComBat
#'
#' @examples
#' #browseVignettes("sva")
combat_fix <- function(...){
  sva::ComBat()(...)
}
