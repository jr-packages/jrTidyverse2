FROM jrpackages/jrnotes

ARG jr_pkg=jrTidyverse2

RUN apt-get update -qq && \
    apt-get -y upgrade && \
    apt-get -y --no-install-recommends install \
    libglpk-dev \
    libgmp3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r -n -1 -d TRUE --error $jr_pkg \
    && rm -rf /tmp/downloaded_packages/

