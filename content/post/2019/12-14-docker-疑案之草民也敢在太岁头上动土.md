---
title: Docker 疑案之草民也敢在太岁头上动土
date: '2019-12-14'
slug: docker-疑案之草民也敢在太岁头上动土
categories: 2019
tags: []
authors: []
---



> post 是在 2020-08-23 写的，细节已经懒得查证了。

Today I found a strange thing---normal user can delete the _root_ files created by Docker---while revising `.travis.yml` of **localsite**.

Three days later, I decide to switch to super user when run R in Docker on Travis. Attached to the end is the formal code (using normal user):


`RUN echo 'R_LIBS_USER="~/.local/lib/R"' > /usr/lib/R/etc/Renviron.site `
```yaml
cache: 
  directories: [$HOME/.local/lib/R/]

install:
  # create container
  - docker run -dt --name rlang0 -w $HOME -u `id -u`:`id -g` -e CI=true -e GITHUB_PAT=$GITHUB_PAT -v $TRAVIS_BUILD_DIR:$HOME -v $HOME/.local/lib/R:$HOME/.local/lib/R dongzhuoer/rlang:rmarkdown 2> /dev/null
  # add user & group (assuming the image contains no user)
  - docker exec -u root rlang0 groupadd `id -gn` -g `id -g`
  - docker exec -u root rlang0 useradd $USER -u `id -u` -g `id -g`
  # (optional) install additional software & packages
  - docker exec -u root rlang0 bash -c "apt update && apt -y install hugo"
  - docker exec -u root rlang0 Rscript -e "remotes::update_packages(c('magrittr'))"
script: docker exec rlang0 Rscript -e "rmarkdown::render('main.Rmd')"
```
