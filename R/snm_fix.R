#' Title The function base on snm R packaegs(http://www.bioconductor.org/packages/release/bioc/html/snm.html), packaged into fixbatch. Citation within R, enter citation("snm")).
#'
#' @param data  a matrix, Equivalent to raw.dat (?snm) , genes (rows) by sample (columns) matrix of unnormalized by other function.
#' @param batch a data frame, sample(rows) by variables(columns), including the biology variables,adjust
#' @param bv a number vector which column number is biology variables.
#' @param av a number vector which column number is adjust variables.
#' @param iv a number vector which column number is inter variables.
#' @param bio.var If bv is null, can use bio.var. A model matrix of the biological variable of interest. Required.
#' @param adj.var If av is null, can use adj.var. A model matrix of the adjustment variables.
#' @param int.var If iv is null, can use int.var. A data frame of the intensity-dependent adjustment variables, one effect per column.
#' @param diagnose If set to TRUE, then diagnostic plots are displayed for each iteration.
#' @param verbose If set to TRUE, then the iteration number is printed to the R console, and the above
#' plots are displayed for each iteration.
#' @param rm.adj This option is used to control whether or not the probe-specific adjustment variables
#' should be removed from the normalized data returned by the snm function call. If the analyst
#' will perform subsequent formal statistical inference (e.g., hypotheses testing), then this option
#' should be set to FALSE. If the analyst will perform clustering or network analysis, then this
#' option should be set to TRUE.
#' @param ... see the parameter form "?snm" on snm R packages
#' i.e., the number of columns of raw.dat If bio.var contains an intercept, it is removed. If
#' adj.var=NULL, then an intercept is added automatically. It is possible not include int.var as
#' input, in which case it is treated as int.var=NULL and no intensity dependent effects are fit (see
#' examples below).
#' @importFrom xbox get_df get_mat
#' @importFrom  snm snm
#' @importFrom stats model.matrix
#' @return a normalizeed s4 object
#' @export
#'
#' @examples
#' #library(bladderbatch)
#' #library(fixbatch)
#' #data(bladderdata)
#' #pheno = pData(bladderEset)
#' #edata = exprs(bladderEset)
#' #re = snm_fix_all(data = edata, batch = pheno,bv = 4, av = 3, iv = 2)
snm_fix_all <- function(data = NULL,
                        batch = NULL,
                        bv = NULL,
                        av = NULL,
                        iv = NULL,
                        bio.var = NULL,
                        adj.var = NULL,
                        int.var = NULL,
                        diagnose = FALSE,
                        verbose = TRUE,
                        rm.adj = TRUE,
                        ...){
  # test input data and batch parameter
  if(is.null(data)){
    stop("the input 'data' can't be NULL")
  } else {
    data = xbox::get_mat(data) # matbe not need
  }
  # set parameter to variables
  # test input
  if(is.null(batch)){
    bio.var = xbox::get_mat(bio.var)
    adj.var = xbox::get_mat(adj.var)
    int.var = xbox::get_df(int.var)
  } else {
    # matbe not need
    batch = xbox::get_df(batch)
    # test
    v.number = length(c(bv,av,iv))
    v.unique.number = length(unique(c(bv,av,iv)))
    if(v.unique.number > ncol(batch)){stop("the number more than batch colunms,please check the variables vector number(bv,av,cv)")}
    if(v.unique.number != v.number){
      stop("the variables is Repeat")
    }
    if(is.null(bv)){
      if(is.null(bio.var)){
        stop("the biology variables is NULL")
      }
    } else {
      bio_var = batch[bv]
    }
    if(is.null(av)){
      if(is.null(adj.var)){
        stop("the adjust variables is NULL")
      } 
    } else {
      adj_var = batch[av]
    }
    if(is.null(iv)){
      int.var = NULL
    } else {
      int_var = batch[iv]
    }
  }
  # analysis
  # change the variables input when model.matrix can't work well automatically
  if(is.null(bio.var)){bio.var = model.matrix(~ ., data = bio_var)}
  if(is.null(adj.var)){adj.var = model.matrix(~ ., data = adj_var)}
  if(!is.null(iv)){
    if(is.null(int.var)){int.var = model.matrix(~ ., data = int_var)}
  }
  re<- snm::snm(raw.dat = data,
                bio.var = bio.var,
                adj.var = adj.var,
                int.var = int.var,
                diagnose = FALSE,
                verbose = TRUE,
                rm.adj = TRUE,
                ...)
  return(re)
}

#############################
# only need exp data
# snm_fix
#############################

#' Title Extract the  normalizeed data by function "snm". detailed description in which
#' the function base on snm R packaegs(http://www.bioconductor.org/packages/release/bioc/html/snm.html),
#' packaged into fixbatch. Citation within R, enter citation("snm")).snm_fix_all function is for all the result. snm_fix just for the adjust exp data.
#'
#' @param ... see in "?snm_fix_all"(for all result output) on "fixbatch"
#' @importFrom xbox get_df get_mat
#' @importFrom  snm snm
#' @importFrom stats model.matrix
#' @return a normalizeed data
#' @export
#'
#' @examples
#' #library(bladderbatch)
#' #library(fixbatch)
#' #data(bladderdata)
#' #pheno = pData(bladderEset)
#' #edata = exprs(bladderEset)
#' #re1 = snm_fix_all(data = edata, batch = pheno,bv = 4, av = 3, iv = 2)
#' #re = snm_fix(data = edata, batch = pheno,bv = 4, av = 3, iv = 2)
snm_fix <- function(...){
  re = snm_fix_all(...)
  re_data = re[["norm.dat"]]
  re_data = suppressMessages(xbox::get_df(re_data))
}
