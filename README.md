
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fixbatch

<!-- badges: start -->
<!-- badges: end -->

## Update

<<<<<<< HEAD
### fix bug 2020-12-17

-   [x] add the function to select housekeep gene Separately from every
    batch group

-   [ ] add the `cpm` function to calculate the adjuts expression cpm
    value form `egdeR`

-   [ ] add the `combat` function form `sva`

the R packages is full fo bugs, beacuse it’s a naive packagse, so I
suggest every time when you use the R packages, should update R packages
fristly. remember IT is everytime!
=======
- [ ] add the `cpm` function to calculate the adjuts expression cpm value form `egdeR`
- [ ] add the `combat` function form `sva`
>>>>>>> df358909355a58c9055eecbb5f4f704bb99acceb

## Insatll

``` r
library(fixbatch)
```

## Function

### col\_cv

calculate the coefficient of variation of the row value in a gene
expression matrix.

### col\_sum

calculate the sum the row value in a gene expression matrix.

### housekeep

According to the coefficient of variation and the expression sum, the
stable observation value is selected

## batch\_housekeep

he function to select housekeep gene Separately from every batch group

### norm\_fix

<<<<<<< HEAD
norm\_fix allows users to adjust for batch effects in datasets where the
batch covariate is known, using the packages `preprocessCore`, and the
function normalize.quantiles.
=======
## website

[处理批次效应连续剧第一集(失败的R包)](https://abego.cn/2020/12/14/remove-the-batch-effect-series-1-a-imcomplete-r-package/)
>>>>>>> df358909355a58c9055eecbb5f4f704bb99acceb
