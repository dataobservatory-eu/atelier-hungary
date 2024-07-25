library(here)
library(dplyr)

#[female_given_names_in_hungarian](https://query.wikidata.org/#%20SELECT%20%3Fitem%20%3FitemLabel%20%20%3FitemDescription%20WHERE%20%7B%0A%20%20%20%20%3Fitem%20wdt%3AP31%20%20wd%3AQ11879590%20.%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%23%20instance%20of%20female%20given%20name%0A%20%20%20%20%3Fitem%20wdt%3AP407%20wd%3AQ9067%0A%20SERVICE%20wikibase%3Alabel%20%7B%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%2Chu%22%20%7D%0A%7D%0Aorder%20by%20%3FitemLabel)
                                    
#                                    [male_given_names_in_hungarian](https://query.wikidata.org/#%20SELECT%20%3Fitem%20%3FitemLabel%20%20%3FitemDescription%20WHERE%20%7B%0A%20%20%20%20%3Fitem%20wdt%3AP31%20%20wd%3AQ11879590%20.%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%23%20instance%20of%20female%20given%20name%0A%20%20%20%20%3Fitem%20wdt%3AP407%20wd%3AQ9067%0A%20SERVICE%20wikibase%3Alabel%20%7B%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%2Chu%22%20%7D%0A%7D%0Aorder%20by%20%3FitemLabel)
                                                                      
                                                                      
keresztnevek <- readLines(con="https://file.nytud.hu/osszesffi.txt")
fotostudio_5_raw <- readxl::read_excel(here("data-raw", "anna", "fotostudiok_5_.xlsx"))

names (fotostudio_5_raw)
                                  
nytud_keresztnevek <- data.frame( given_name_string = keresztnevek[-1])

kettagu_nevek <- fotostudio_5_raw %>%
  filter ( is.na(Unsure), 
           is.na(FamilyName2)) %>%
  select ( `orig_nr.`, 
           table = table, 
           name_string = Name, 
           family_name_string = FamilyName, 
           given_name_string = GivenName) %>%
  mutate ( family_name_string = gsub(",", "", family_name_string)) %>%
  semi_join ( nytud_keresztnevek, by = "given_name_string"  ) 

given_name_correspondence <- data.frame(
  given_name_string = c("Albert", "Manó", "Béla", "Ernő", "Benedek"), 
  given_name_item = c("Q344", "Q32", "Q291", "Q345", "Q347")
)

famiy_name_correspondence <- data.frame(
  family_name_string = c("Agnelly", "Benedek", "Bódy"),
  family_name_item = c("Q346", "Q348", "Q349")
)

kettagu_nevek <- kettagu_nevek  %>%
  left_join ( kettagu_nevek %>% count(given_name_string) ) %>%
  left_join( given_name_correspondence) %>%
  left_join ( famiy_name_correspondence ) %>%
  mutate ( label_en = given_name_string, " ", family_name_string, 
           label_hu = name_string ) %>% 
  mutate ( description_en = "photographer, who was active in the Hungarian Kingdom.", 
           description_hu = "fényképész, aki a Magyar Királyság területén alkotott.") %>%
  mutate ( alias_1_en = ifelse(label_en != label_hu, label_hu, "")) %>%
  mutate ( instance_of = "Q66") %>%
  rename ( given_name_string_1  = given_name_string, 
           family_name_string_1  = family_name_string)


writexl::write_xlsx(kettagu_nevek, here::here("data-raw", "anna", "kettagu_nevek.xlsx"))
