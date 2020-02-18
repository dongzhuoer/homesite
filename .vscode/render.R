setwd(here::here())
library(magrittr)

# rename post .md files
yamls <- blogdown:::scan_yaml()
yamls %<>% {.[stringr::str_detect(names(.), '^content/post/')]}
yamls %<>% {.[stringr::str_detect(names(.), '.Rmd$')]}
for (i in seq_along(yamls))
    if('slug' %in% names(yamls[[i]])) {
        old <- names(yamls)[i]
        if (basename(dirname(old)) %in% c("book")){
           new <- paste0(dirname(old), '/', yamls[[i]]$slug, '.Rmd')
        } else {
            folder <- paste0(dirname(dirname(old)), '/', stringr::str_sub(yamls[[i]]$date, 1, 4))
            dir.create(folder, showWarnings = FALSE)
            month_day <- stringr::str_sub(yamls[[i]]$date, 6)
            new <- paste0(dirname(old), '/', month_day, '-', yamls[[i]]$slug, ".Rmd")
        }
        file.rename(old, new)
    }

# build website
system('rm -r public/*')
blogdown::build_site(local = T)
