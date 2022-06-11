---
title: GitHub API limit pushs me to learn how to use docker multi-stage build to hide
  secret
author: Zhuoer Dong
date: '2018-11-20'
slug: github-api-limit-teach-new-docker-tip
categories: 2018
tags: []
authors: []
---

# cause

GitHub API limit (when installing R packages from GitHub) on Travis CI has bothered me for a while, using personal token seems to be a nice solution.

But for Docker, that's a problem.



# strugle

At first, I spend some time to realize that it's impossible to ask Dockerfile to use environment variables on host machine ^[`Dockerfile` is portable, only `docker build` can interact with specific host machine]. 



# seemingly promissing dead end

Then I found a seemingly nice approch:

  - add `ARG GITHUB_PAT` to `Dockerfile`,
  - use `docker build --build-arg GITHUB_PAT=${GITHUB_PAT} ...`

But the official documentation warns me:

> It is not recommended to use build-time variables for passing secrets like github keys, user credentials etc. Build-time variable values are visible to any user of the image with the `docker history` command.



# success, yet to improve

Later, I decide to use build stages: 

  - one stage to install the packages
  - another stage to copy the `site-library/` folder. 

In this way, I can write the `GITHUB_PAT` value in `Dockerfile` ^[Of course the repository containing the `Dockerfile` has to be private then], and `docker history` can't see it since the second stage doesn't use it.



# merging together comes perfect way

After many experiments, I find that there are two conditions to meet for exposing an `ARG`

- the final stage contains `ARG TEST`
- the final stage contains at least one `RUN` command ^[Maybe other command also works, but `COPY` definitely not]

As you can see from `docker history`, even I just not use `TEST` at all), the value is still disclosed.

```
sha256:38e29efa3a95b241be1ad285a534e9353c2a13f2a0c5abac69ac76c5511131e9   44 minutes ago      |1 TEST=test /bin/sh -c echo haha
```



Finally, I figured out that after splitting into two stages, now I can pass `GITHUB_PAT` through `--build-arg`.


# Final solution

- `Dockerfile`
```dockerfile
FROM dongzhuoer/rlang:devtools as site-library

ARG GITHUB_PAT

RUN mkdir /usr/local/lib/R/site-library/
RUN R -e "remotes::install_github(c('tidyverse/tidyverse'), lib = '/usr/local/lib/R/site-library/')"



FROM dongzhuoer/rlang:devtools

LABEL maintainer="Zhuoer Dong <dongzhuoer@mail.nankai.edu.cn>"

COPY --from=site-library /usr/local/lib/R/site-library/ /usr/lib/R/site-library/
```


- Build command

```bash
docker build --build-arg GITHUB_PAT=${GITHUB_PAT} ...
```

The best parts of this method are:

  1. the `Dockerfile` is _absolutely portable_: anyone can still build the image ^[as long as the package repository is public]
  1. if you set the environment variable, `GITHUB_PAT`, you can take advantage of higher API rate limit.



# Epilogue

By the way, you need `RUN apt update && apt -y install git && rm -r /var/lib/apt/lists/` if the R package repository is private.

