setwd(here::here())
library(magrittr)

# rename post .md files
yamls <- blogdown:::scan_yaml()
yamls %<>% {.[stringr::str_detect(names(.), '^content/post/')]}
yamls %<>% {.[stringr::str_detect(names(.), '.Rmd$')]}
for (i in seq_along(yamls))
    if('slug' %in% names(yamls[[i]])) {
        year <- stringr::str_sub(yamls[[i]]$date, 1, 4)
        category <- yamls[[i]]$categories[1]
        if (category == year) {
            month_day <- stringr::str_sub(yamls[[i]]$date, 6)
            new_file <- paste0("content/post/", year, '/', month_day, '-', yamls[[i]]$slug, ".Rmd")
        } else {
            new_file <- paste0("content/post/", category, '/', yamls[[i]]$slug, ".Rmd")
        }
        dir.create(dirname(new_file), showWarnings = FALSE, recursive = TRUE)
        old_file <- names(yamls)[i]
        file.rename(old_file, new_file)
    }
