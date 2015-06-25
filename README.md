HISCO classification
====================

<!-- This README.md file is built by the R markdown file README.md please edit that file for updates -->
A package for classifying HISCO codes (Historical International Standard Classification of Occupations) to HISCLASS, HISCLASS 5, SOCPO and Universal HISCAM historical social class systems. The package is developed together with [Glenn Sandström](https://github.com/glennsandstrom).

For further references see [HSN standardized, HISCO-coded and classified occupational titles, release 2013.01](http://www.iisg.nl/hsn/data/occupations.html)

Installation
------------

``` r
library(devtools)
install_github("junkka/hisco")
```

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
hisco_to_ses(hisco_codes, "hisclass", output = "label")
```

    ## [1] Foreman                                              
    ## [2] Foreman                                              
    ## [3] Foreman                                              
    ## [4] Foreman                                              
    ## [5] Lower clerical and sales personnel                   
    ## [6] Lower clerical and sales personnel                   
    ## [7] Lower professionals, and clerical and sales personnel
    ## [8] Higher professionals                                 
    ## [9] Lower professionals, and clerical and sales personnel
    ## 14 Levels: Farmers and fishermen Foreman ... Unskilled workers not specified

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
    ## Elite                  1   0.11
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

Using a custom reference table
------------------------------

The HISCO classification table is not complete, and can require manual updating to fit certain use cases. To do this you can supply your own reference table to `hisco_to_ses` ether as the path to a `.csv` file or a `data.frame`.

``` r
hisco_to_ses(hisco_codes, reference = ref_data_frame)
```

To start a new manual updating of the reference file you can attain the reference file in the package though:

``` r
write_reference("my_hisco.csv")
```

You will now have a `.csv` file with the following structure

| Variable           | Type | Examples                                               |
|:-------------------|:-----|:-------------------------------------------------------|
| hisco              | int  | -3, -3, -3, -3, -3, -2, -2, -1, -1, -1, -1, -1, -1,... |
| en\_hisco\_text    | fctr | Non work related title, Non work related title, No ... |
| status             | int  | NA, 13, 41, 42, 51, 33, NA, 11, 11, 12, 13, 31, 33,... |
| relation           | int  | NA, NA, NA, NA, NA, 21, NA, 51, NA, NA, NA, NA, NA,... |
| product            | int  | NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,... |
| hisclass           | int  | NA, 11, NA, NA, 1, NA, NA, NA, 1, 8, 11, NA, NA, NA... |
| hisclass\_5        | int  | NA, 5, NA, NA, 1, NA, NA, NA, 1, 4, 5, NA, NA, NA, ... |
| socpo              | int  | NA, 1, 42, 5, 5, NA, NA, 42, 42, 3, 1, 2, 1, 42, 5,... |
| hiscam\_u1         | dbl  | NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,... |
| hisclass\_label    | fctr | NA, Unskilled workers, NA, NA, Higher manager, NA, ... |
| hisclass\_5\_label | fctr | NA, Unskilled workers and farm workers, NA, NA, ...    |
| socpo\_label       | fctr | NA, Unskilled workers, Middle Class, Elite, Elite, ... |

In this file you can manually update HISCO classifications by adding or updating status relation, product, hiclass, hisclass\_5, socpo, and hiscam\_u1 codes using values from their respective social classification scheme. See [HSN standardized, HISCO-coded and classified occupational titles, release 2013.01](http://www.iisg.nl/hsn/data/occupations.html) for further information. However you cannot add any new HISCO codes and each hisco code cannot have more than one unique combination of status, relation and product. Furthermore, to use the updated reference file in the `hisco_to_ses` function the column names must be retained.

Use the updated reference file:

``` r
hisco_to_ses(hisco_codes, reference = "my_hisco.csv")
```
