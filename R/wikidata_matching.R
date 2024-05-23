
library(tidyverse)
library(here)
wikidata <- read.csv(file.path("data-raw", "wikidata_hungarian_photographers.csv")) %>%
  rename ( GivenName = lastnameLabel, 
           FamilyName  = givenNameLabel) %>%
  mutate ( FamilyName = trimws(FamilyName, "both"), 
           GivenName = trimws(GivenName, "both"))

mnm <- readxl::read_excel(file.path("data-raw", "anna", "fotostudiok_4.xlsx")) %>%
  select ( orig_nr, table, date, FamilyName, GivenName, Name )   %>%
  mutate ( FamilyName = trimws(FamilyName, "both"), 
           GivenName   = trimws(GivenName, "both"))

wikidata_in_mnm <- wikidata %>% 
    semi_join ( mnm, by = c("FamilyName", "GivenName") ) %>%
    distinct ( item, .keep_all = TRUE )

wikidata_select <- wikidata[which (wikidata$GivenName %in% mnm$GivenName & wikidata$FamilyName %in% mnm$FamilyName), ]


mnm %>% 
  left_join(wikidata_in_mnm) %>%
  filter (!is.na(item)) %>% 
  write_excel_csv(here::here("data-raw", "anna", "fotostudiok_4_in_wikidata.csv"))




