## Test environments
* local OS X install, R 3.5.1
* ubuntu 12.04 (on travis-ci), R 3.5.1
* win-builder (devel and release)

## R CMD check results
0 errors | 0 warnings | 0 notes

There were no ERRORs or WARNINGs or NOTEs

## Reverse dependencies

Reverse dependencies for the packages `naniar` and `PCRedux` were checked
and there were noERRORs or WARNINGs, but were two NOTEs for `PCRedux`. These were unrelated to `visdat`, and are presented below:

```
    *   checking installed package size ... NOTE
    
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        doc   3.9Mb
    

    *   checking dependencies in R code ... NOTE

    Namespace in Imports field not imported from: `caret`
      All declared Imports should be used.

```
