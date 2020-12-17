
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fixbatch

<!-- badges: start -->
<!-- badges: end -->

## Update

### fix bug 2020-12-17

-   [x] add the function to select housekeep gene Separately from every
    batch group

-   [ ] add the `cpm` function to calculate the adjuts expression cpm
    value form `egdeR`

-   [ ] add the `combat` function form `sva`

the R packages is full fo bugs, beacuse it’s a naive packagse, so I
suggest every time when you use the R packages, should update R packages
fristly. remember IT is everytime!

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

norm\_fix allows users to adjust for batch effects in datasets where the
batch covariate is known, using the packages `preprocessCore`, and the
function normalize.quantiles.
