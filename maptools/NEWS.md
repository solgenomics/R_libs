# Please note that **maptools** will be retired during October 2023, plan transition at your earliest convenience (see https://r-spatial.org/r/2023/05/15/evolution4.html and earlier blogs for guidance); some functionality will be moved to **sp**.

# Version 1.1-7 (development, rev. 413-)

* remove gpclib and Rgshhs

* Make retirement in October 2023 explicit, move package start-up messages to load from attach

* `elide()` deprecated and moved to `sp`

# Version 1.1-6 (2022-12-14, rev. 411-413)

* CRAN `sprintf()` warnings

# Version 1.1-5 (2022-10-22, rev. 402-410)

* `lineLabel.R` and `pointLabelLattice.R` deprecated, see https://github.com/oscarperpinan/rastervis/issues/93

* functions using shapelib fully deprecated

* `pointLabel()` deprecated; moved to **car** rev. 725

# Version 1.1-4 (2022-04-17, rev. 401)

* remove escaping of underscore in manual pages

# Version 1.1-3 (2022-03-08, rev. 400)

* Fix unconditional library(RColor-Brewer) call in help pages

# Version 1.1-2 (2021-09-07, rev. 392-399)

* Version check for forthcoming GEOS 3.10

# Version 1.1-1 (2021-03-15, rev. 381-391)

* Upgrade **spatstat**-family reverse dependencies


# Version 1.0-2 (2020-08-24, rev. 371-380)

* New `as.im.RasterLayer()` version

* Update stored **sp** objects

# Version 1.0-1 (2020-05-14, rev. -370)

* Update for `linnet` coercion methods

* Added read support for (very) legacy MAP objects