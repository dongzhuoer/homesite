rendered_html <- dir(here::here("content"), "\\.html$", full = T, recursive = T) 
file.remove(rendered_html)
