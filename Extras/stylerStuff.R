library(styler)


a = tidyverse_style()
body(a[["token"]][["force_assignment_op"]])[[2]][[3]][[3]] = "LEFT_ASSIGN"
body(a[["token"]][["force_assignment_op"]])[[4]][[3]] = "="
body(a[["token"]][["force_assignment_op"]])[[3]][[3]] = "EQ_ASSIGN"

force_assignment_op  <- function (pd) 
{
  to_replace <- pd$token == "LEFT_ASSIGN"
  pd$token[to_replace] <- "EQ_ASSIGN"
  pd$text[to_replace] <- "="
  pd
}

newStyle <- function(...) {
  ts <- tidyverse_style(...)
  ts$token$force_assignment_op <- force_assignment_op
  ts
}

style_text(c("ab <- 3", "a  <-3"), strict = FALSE, style = newStyle)