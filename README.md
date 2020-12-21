
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fixbatch

<!-- badges: start -->
<!-- badges: end -->

## Update

### fix bug 2020-12-19

-   [x] is have done

-   [ ] is not, but will be done next update

-   [x] add the function to select housekeep gene Separately from every
    batch group

-   [x] add the function to select some housekeep gene that you know
    its’ function or famous stable gene like actinB.

-   [x] add the `cpm` function to calculate the adjuts expression cpm
    value form `egdeR`

-   [ ] add the `combat` function form `sva`

the R packages is full fo bugs, beacuse it’s a naive packagse, so I
suggest every time when you use the R packages, should update R packages
fristly. Remember this step everytimes!

## Insatll

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

## 开发过程

[处理批次效应连续剧第一集（失败的R包）](https://mp.weixin.qq.com/s/_LNdR7b4LRhiKGqIcEXX2A)
[处理批次效应连续剧第二集（R包小有成效）](https://mp.weixin.qq.com/s/pWO9em16WE90T-6vxO3HMg)
