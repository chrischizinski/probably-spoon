FROM rocker/tidyverse:latest

LABEL maintainer="Chris Chizinski <chris.chizinski@gmail.com>"

# Step 2 - Set arguments and environment variables
# Define arguments
ARG PROJECT_NAME=PROJECT_NAME
ARG VENV_NAME=VENV_NAME
ARG R_VERSION_MAJOR=4
ARG R_VERSION_MINOR=3
ARG R_VERSION_PATCH=1
ARG DEBIAN_FRONTEND=noninteractive
ARG CRAN_MIRROR=https://cran.rstudio.com/
ARG QUARTO_VER="1.3.450"

# Define environment variables
ENV PROJECT_NAME=$PROJECT_NAME
ENV VENV_NAME=$VENV_NAME
ENV R_VERSION_MAJOR=$R_VERSION_MAJOR
ENV R_VERSION_MINOR=$R_VERSION_MINOR
ENV R_VERSION_PATCH=$R_VERSION_PATCH
ENV QUARTO_VER=$QUARTO_VER
ENV CONFIGURE_OPTIONS="--with-cairo --with-jpeglib --enable-R-shlib --with-blas --with-lapack"
ENV TZ=UTC
ENV CRAN_MIRROR=$CRAN_MIRROR

RUN apt-get update && \
    apt-get install -y libssl-dev libcurl4-gnutls-dev libxml2-dev

# preinstall packages
RUN Rscript -e "install.packages(c('rmarkdown', 'knitr', 'roger', 'cli'), repos='http://cran.rstudio.com/', dependencies=TRUE)"

# Installing Quarto
RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN gdebi --non-interactive quarto-linux-amd64.deb