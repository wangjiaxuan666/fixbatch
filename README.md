
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fixbatch

<!-- badges: start -->
<!-- badges: end -->

## Update

### fix bug 2020-12-24

-   [x] add the function to select housekeep gene Separately from every
    batch group

-   [x] add the function to select some housekeep gene that you know
    its’ function or famous stable gene like actinB.

-   [x] add the `edger_fix` function to calculate the adjuts expression
    cpm value form `egdeR`

### fix bug 2020-12-29

-   [x] add the `pvca` function form pvca packgas in Bioconductor,this
    function can help us to estimate factors’ partition of the total
    variability. I have made some optimizations,such as suppressMessages
    on useless messages, add test of input data have NAs,fix the the R
    packages dependency relationship. and add `pvca_plot` plot function
    to display the result.

the R packages is full fo bugs, beacuse it’s a naive packagse, so I
suggest every time when you use the R packages, should update R packages
fristly. Remember this step everytimes!

``` r
devtools::update_packages("fixbatch")
```

## Insatll

``` r
devtools::install_github("wangjiaxuan/fixbatch")
```

``` r
library(fixbatch)
```

## Function

### col\_cv

calculate the coefficient of variation of the row value in a gene
expression matrix.

### col\_sum

calculate the sum of rows value in a gene expression matrix.

### housekeep

According to the coefficient of variation and the expression sum, the
stable observation value is selected

### batch\_housekeep

The function is made for select housekeep gene separately from every
batch group

### norm\_fix

norm\_fix allows users to adjust for batch effects in datasets where the
batch covariate is known, using the packages `preprocessCore`, and the
function `normalize.quantiles`.

### edger\_fix

Calculate normalization factors to scale the raw library sizes. the
script is created by Yunshun Chen. The work use the function
calcNormFactors and cpm.

### pvca

The function is written based on the ‘pvcaBatchAssess’ function of the
PVCA R
package(<http://watson.nci.nih.gov/bioc_mirror/packages/release/bioc/manuals/pvca/man/pvca.pdf>).
and adjust by Donghyung Lee for changed slightly to make it more
efficient and flexible for sequencing read counts
data(<https://github.com/dleelab/pvca>). But it didn’t update since 4
years ago. My new R packages fixbatch need the function to estimate
factor’s partition of the total variability. So I fork the packages and
Adjust in my own style.

### pvca\_plot

Title A plot function for dispaly the result of principal variance
component analysis

## 开发过程

1.  [处理批次效应连续剧第一集（失败的R包）](https://mp.weixin.qq.com/s/_LNdR7b4LRhiKGqIcEXX2A)
2.  [处理批次效应连续剧第二集（R包小有成效）](https://mp.weixin.qq.com/s/pWO9em16WE90T-6vxO3HMg)
