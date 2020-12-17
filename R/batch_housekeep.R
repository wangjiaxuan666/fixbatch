#' Found housekeep genes in batch effects group
#'
#' batch_housekeep allows users to  Found housekeep genes in batch effects group
#' by coefficient of variation and the expression sum.
#'
#' @param data Genomic measure matrix (dimensions probe x sample) - for example, expression matrix
#' @param expcv a number range 0 to 1, Sets the maximum quantile value of the coefficient of variation
#' @param exphigh a number range 0 to 1, Sets the maximum quantile value of expression sum
#' @param explow a number range 0 to 1, Sets the minimum quantile value of expression sum
#' @param batch must be a vctor,{Batch covariate (only one batch allowed)}
#'
#' @return data A housekeep gene x sample genomic measure matrix
#' @importFrom stats cor
#'
#' @examples
#' y <- matrix( rpois(1200, lambda=6), nrow=200 )
#' n = dim(y)
#' colnames(y) = paste(rep("sample",n[[2]]),1:n[[2]])
#' rownames(y) = paste(rep("gene",n[[1]]),1:n[[1]])
#' y = as.data.frame(y)
#' y[3,] <- c(0,0,0,1,1,1)
#' y[19,] <- c(1,0,1,0,1,0)
#' data = y
#' batch = rep(1:2, each = 3)
#' #re = batch_housekeep(data, bacth, expcv = 1, exphigh, explow = 0)
batch_housekeep <- function(data,
                      batch = NULL,
                      expcv = 1,
                      exphigh = 1,
                      explow = 0){
  # 必须数据输入
  if(is.null(data)){
    stop("the data parameter is NULL")
  } else{
    data <- as.matrix(data)#数据要改变成矩阵
  }

  # 必须数据输入
  if(is.null(batch)){
    stop("the batch parameter is NULL")
  } else{
    batch <- as.factor(batch)#批次要改成因子
  }

  # 每个样本都要有批次分组信息
  if(length(batch) != ncol(data)){ stop("the batch length isn't equal to the sample number of input data") }

  #检验是否包含NA以及去掉批次分组中和为零的行

  if(any(is.na(data))){
    stop(c('Found',sum(is.na(data)),'Missing Data Values'), sep=' ')
  } else {
    no_zero_list <- lapply(levels(batch), function(batch_level){
      if(sum(batch==batch_level)>1){
        return(which(apply(data[, batch==batch_level], 1, function(x){sum(x) != 0})))
      }
    })
    no_zero_rows <- Reduce(intersect, no_zero_list)
    data <- data[no_zero_rows, ]
  }

  #检验彼此分组中只有一个样本的组

  if(any(table(batch)==1)){
    stop("Note: someone batch has only one sample, can't caculate cv value")
  }

  #计算部分
  #---------------------------变异系数阈值-----------------------------

  col_batch_cv <- lapply(levels(batch), function(batch_level){
    if(sum(batch==batch_level)>1){
      return((apply(data[, batch==batch_level], 1,
                    function(x){sum(x, na.rm = T)/sd(x, na.rm = T)})))
    }else{
      cat("no possible")
    }
  })

  n.batch <- nlevels(batch)
  hk_cv_id <- list()

  for (i in 1:n.batch) {
    hk_cv_id[[i]] <- which(col_batch_cv[[i]] < quantile(col_batch_cv[[i]],prob = expcv))
  }
  #----------------------------总表达量阈值------------------------------
  hkid_cv <- Reduce(intersect, hk_cv_id)

  col_batch_sum <- lapply(levels(batch), function(batch_level){
    if(sum(batch==batch_level)>1){
      return((apply(data[, batch==batch_level], 1,
                    function(x){sum(x, na.rm = T)})))
    }else{
      cat("no possible")
    }
  })

  hk_sum_id <- list()
  for (i in 1:n.batch) {
    hk_sum_id[[i]] <- which(
      (col_batch_sum[[i]] < quantile(col_batch_cv[[i]],prob = exphigh))&(col_batch_sum[[i]] > quantile(col_batch_cv[[i]],prob = explow))
    )
  }

  hkid_sum <- Reduce(intersect, hk_sum_id)

  # 计算分别在各个批次都能满足阈值的行
  hkid <- intersect(hkid_sum, hkid_cv)
  # 提取满足阈值的数据框
  if (length(hkid) > 0) {
    cat(sprintf("Found %d genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.\n", length(hkid)))
    # keep a copy of the original data matrix and remove zero var rows
    dat_orig <- data
    dat_hk <- data[hkid, ]
  }

  return(dat_hk)
}
