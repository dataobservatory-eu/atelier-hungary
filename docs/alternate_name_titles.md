# Névváltozatok


Excel táblázat:
\[[data-raw/alternate_name_titles.xlsx](https://github.com/dataobservatory-eu/atelier-hungary/blob/main/data-raw/alternate_name_titles.xlsx)\](<https://github.com/dataobservatory-eu/atelier-hungary/blob/main/data-raw/alternate_name_titles.xlsx>)

``` r
library(here)
```

    here() starts at C:/_markdown/atelier-hungary

``` r
library(readxl)
```

Alternatív nevek és azonosítók kezelése.

- Name title (preferred name) személyekre

- Alternatív névváltozatok (például Franz, Ferencz és Ferenc)

- Name title (preferred name) intézményi névre

- Alternative names (magyar alternatív írásmód, névváltozat, német név,
  stb.)

- Name title (preferred name) a műteremre, mint egy épületen, címen
  belüli egységre.

- Name title magyarul egyelőre, de majd lesz mondjuk angol is.

Az adatbázisban gyakran ugyanaz a személy, intézményi név vagy műterem
több névváltozatban szerepel, ezek részben amiatt vannak, hogy az évek,
évtizedek alatt a műterem költözött, és akár a helyesírás is változott.

``` r
readxl::read_excel(file.path("data-raw", "alternate_name_titles.xlsx"))
```

    # A tibble: 3 × 5
      name_title_original institutional_name institutional_name_alt atelier_name    
      <chr>               <chr>              <chr>                  <chr>           
    1 Apollo (Kiss fotó)  Kiss-féle Apolló   Apollo (Kiss fotó)     Kiss-féle Apoll…
    2 Kiss-féle Apolló    Kiss-féle Apolló   <NA>                   Kiss-féle Apoll…
    3 Róth Jenő Apolló    Róth Jenő Apolló   <NA>                   Róth Jenő műter…
    # ℹ 1 more variable: atelier_name_alt <lgl>

Azt gondolom, hogy jelenleg nem cél az egységesítés, csak a táblázat
szerkezetének javítása. Tehát az eredeti cím mező legyen meg, és legyen
legalább egy intézményi és műterem név és alternatív névnek helye. Ha
egy sorban nincsen alternatív név, nem számít, és az alternatív nevek
ismétlődése sem.

A preferrált névváltozat meghatározása véleményem szerint Bognár Katalin
és a főosztálya feladata. A mi dolgunk a jelenleg mező megfelelő
átalakítása névváltozatokra, és egyelőre csak annak rögzítése, hogy
minden névváltozat megfelelő oszlopba kerüljön *legalább egyszer*. A
preferrált nevekre Anna tehet javaslatot, de ezeket majd úgyis a
kurátornak kell ellenőriznie.
