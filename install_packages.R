
# install the pak package manager
install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")

# install others using pak
pak::pak(c("rmarkdown", "knitr", "roger", "cli"))
