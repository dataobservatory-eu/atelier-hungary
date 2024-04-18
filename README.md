# Atelier Hungary

🙋‍♀️ A Nemzeti Múzeum Történeti Fényképtára közzétette Szakács Margit Fényképészek és fényképészműtermek Magyarországon (1840-1945) című könyvének adattárát. A célunk ennek az adattárnak a modernizálása.

## Folders

`bib`: Contains all bibliography: used citations, data used, visualisation used, datasets created, visualizations created, public text document outputs created. For bibliography management use [Zotero/atelier-hungary/](https://www.zotero.org/groups/5416546/atelier-hungary/) and export Biblatex files into `bib\`. ([How to use Zotero](https://contributors.dataobservatory.eu/collaboration-tools.html#zotero)?)

`data-raw`:  Raw, unprocessed data, as received, downloaded, collected.

`data`: This folder contains the processed data or our outputs. 

`_not_included`: If you work offline, create a subfolder named `_not_included`.  Anything you put here, your notes, doodles, ideas *will not be syncronised to the cloud*.  Everything else will.

## Tidy data

Make all tables [tidy](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html).

- Use only machine-readable and programmable variable names: variable names (columns) use `snake_case` or `lowerCamelCase`, without space, hyphen, and other special characters.
- For row names, row identification, use only alphanumeric characters, for example, integer numbers, without `.` or any other character.

## Standard File Names

1. Use only lowercase alphanumeric characters, hyphen (`-`), underscore (`_`).
2. Instead of using space, use `-` between words and abbreviations.
3. Use underscore `_` between shorthand descriptions, dates, and other semantically different parts of the filename.
4. If you use dates in file names, use the `YYYYMMDD` standard.
5. Use a subfolder for logically connected intermediary files.

For example:

`data-raw/places/atelier-hungary-places_2012_20230316.xlsx`
`data-raw/persons/atelier-hungary-photographers_2012_20230316.xlsx`


## Questions?

Let's continue on [Keybase](https://contributors.dataobservatory.eu/collaboration-tools.html#keybase). 

## Contributors

🌈 Contribution guidelines - you must abide by the [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/) Code of Conduct.
