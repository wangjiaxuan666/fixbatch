#' A function for principal variance component analysis
#'
#' The function is written based on the 'pvcaBatchAssess' function of the PVCA R package(http://watson.nci.nih.gov/bioc_mirror/packages/release/bioc/manuals/pvca/man/pvca.pdf).
#' and adjust by Donghyung Lee for changed slightly to make it more efficient and flexible for sequencing read counts data(https://github.com/dleelab/pvca). But it didn't update since 4 years ago.
#' My new R packages fixbatch need the function to estimate factor's partition of the total variability. So I fork the packages and Adjust in my own style.
#'
#' @param counts The Normalized(e.g. TMM)/ log-transformed reads count matrix from sequencing data (row:gene/feature, col:sample)
#' @param meta  The Meta data matrix containing predictor variables (row:sample, col:predictor)
#' @param threshold The proportion of the variation in read counts explained by top k PCs. This value determines the number of top PCs to be used in pvca.
#' @param inter TRUE/FALSE - include/do not include pairwise interactions of predictors
#'
#' @return std.prop.val The vector of proportions of variation explained by each predictor.
#' @importFrom lme4 VarCorr lmer
#' @importFrom stats na.omit sigma
#' @export
#' @example #library(golubEsets)
#' #library(fixbatch)
#' #data(Golub_Merge)
#' #pct_threshold <- 0.6
#' #batch.factors <- (Golub_Merge@phenoData@data)[,c("ALL.AML", "BM.PB", "Source")]
#' #data = Golub_Merge@assayData[["exprs"]]
#' #pvcaObj <- pvca(data, batch.factors, pct_threshold,inter = FALSE)

pvca <- function(counts, meta, threshold = 0.7, inter = TRUE){

  # need add test of the input dat wether have NAs
  if(any(is.na(meta))){
    stop("the meta input matrix have NAs")
  }
  # whether need a test of NAs?
  counts.center <- t(apply(counts, 1, scale, center=TRUE, scale=FALSE))
  cor.counts <- cor(counts.center)
  dim(cor.counts)
  eigen.counts <- eigen(cor.counts)
  eigen.mat <- eigen.counts$vectors
  eigen.val <- eigen.counts$values
  n.eigen <- length(eigen.val)
  eigen.val.sum <- sum(eigen.val)
  percents.pcs <- eigen.val/eigen.val.sum
  meta <- as.data.frame(meta)

  all <- 0
  npc.in <- 0
  for(i in 1:n.eigen){
    all <- all + percents.pcs[i]
    npc.in <- npc.in + 1
    if(all > threshold){break}
  }
  if (npc.in < 3) {npc <- 3}

  pred.list <- colnames(meta)
  meta <- droplevels(meta)

  n.preds <- ncol(meta) + 1
  if(inter) {n.preds <- n.preds + choose(ncol(meta),2)}

  ran.pred.list <- c()
  for(i in 1:ncol(meta)){
    ran.pred.list <- c(ran.pred.list, paste0("(1|", pred.list[i],")"))
  }
  ##interactions
  if(inter){
    for(i in 1:(ncol(meta)-1)){
      for(j in (i+1):ncol(meta)){
        ran.pred.list <- c(ran.pred.list, paste0("(1|", pred.list[i], ":", pred.list[j], ")"))
        pred.list <- c(pred.list, paste0(pred.list[i], ":", pred.list[j]))
      }
    }
  }
  formula <- paste(ran.pred.list, collapse = " + ")
  formula <- paste("pc", formula, sep=" ~ ")
  ran.var.mat <- NULL
  suppressMessages(for(i in 1:npc.in){
    dat <- cbind(eigen.mat[,i],meta)
    colnames(dat) <- c("pc",colnames(meta))
    Rm1ML <- lme4::lmer(formula, dat, REML = TRUE, verbose = FALSE, na.action = stats::na.omit)
    var.vec <- unlist(lme4::VarCorr(Rm1ML))
    ran.var.mat <- rbind(ran.var.mat, c(var.vec[pred.list], resid = stats::sigma(Rm1ML)^2))
  })
  ran.var.mat.std <- ran.var.mat/rowSums(ran.var.mat)
  wgt.vec <- eigen.val/eigen.val.sum
  prop.var <- colSums(ran.var.mat.std*wgt.vec[1:npc.in])
  std.prop.var <- prop.var/sum(prop.var)
  return(std.prop.var)
}
