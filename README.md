HISCO classification
====================

A package for classifing HISCO codes (Historical International Standard Classification of Occupations) to HISCLASS, HISCLASS 5, SOCPO and Universal HISCAM historical social class systems.

For further references see [HSN standardized, HISCO-coded and classified occupational titles, release 2013.01](http://www.iisg.nl/hsn/data/occupations.html)

Examples
--------

Getting the default, HISCLASS.

``` r
library(hisco)
hisco_codes <- c(22670, 22675, 22680, 22690, 30000, 31000, 31020, 31030, 31040)
hisco_to_ses(hisco_codes)
```

    ## [1] 6 6 6 6 5 5 4 2 4

SOCPO classification with status codes.

``` r
hisco_to_ses(hisco_codes, "socpo", status = rep(33, length(hisco_codes)))
```

    ## [1] NA  3  3  3 42 42 42 42 42

Classification to label HISCLASS.

``` r
hisco_to_ses(hisco_codes, "hisclass", output = "labled")
```

    ##   hisclass                                        hisclass_label
    ## 1        6                                               Foreman
    ## 2        6                                               Foreman
    ## 3        6                                               Foreman
    ## 4        6                                               Foreman
    ## 5        5                    Lower clerical and sales personnel
    ## 6        5                    Lower clerical and sales personnel
    ## 7        4 Lower professionals, and clerical and sales personnel
    ## 8        2                                  Higher professionals
    ## 9        4 Lower professionals, and clerical and sales personnel

With summary statistics.

``` r
hisco_to_ses(hisco_codes, messages = TRUE)
```

    ## 
    ## 
    ## HISCLASS matches:

    ## 
    ## 
    ## hisclass_label                                            n   prop
    ## ------------------------------------------------------  ---  -----
    ## Foreman                                                   4   0.44
    ## Higher professionals                                      1   0.11
    ## Lower clerical and sales personnel                        2   0.22
    ## Lower professionals, and clerical and sales personnel     2   0.22

    ## 
    ## 
    ## HISCLASS 5 matches:

    ## 
    ## 
    ## hisclass_5_label       n   prop
    ## -------------------  ---  -----
    ##  Elite                 1   0.11
    ## Lower middle class     8   0.89

    ## 
    ## 
    ## SOCPO matches:

    ## 
    ## 
    ## socpo_label         n   prop
    ## ----------------  ---  -----
    ## Elite               1   0.11
    ## Middle Class        4   0.44
    ## Skilled workers     4   0.44

    ## 
    ## 
    ## HISCAM_U1 matches:

    ## 
    ## 
    ## match     n   prop
    ## ------  ---  -----
    ## TRUE      9      1

    ## [1] 6 6 6 6 5 5 4 2 4
