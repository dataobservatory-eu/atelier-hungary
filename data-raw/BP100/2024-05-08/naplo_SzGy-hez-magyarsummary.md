##### Adatgazdász szakmai gyakorlat 2024 I. félév

# A Budapest100 szupertábla tisztítása

##### Könnyű Orsolya és Ott Péter

Célunk a BP100_szupertabla.xlsx tisztítása további gépi feldolgozás céljára. A táblázatot a Reprex cég biztosította és a feladatokat is a Reprex határozta meg. Alap eszköznek a Reprex az OpenRefine-t (O_R) ajánlotta, így ezt tanultuk és használtuk elsősorban.  Jelen összefoglaló MarkText szoftver segítségével készült.

## Naplózás

A tisztítási munkát több szinten is naplóztuk: egy különálló szövegfájlban (.TXT) és az O_R saját "history" funkciójával, magában az O_R projekt export fájlban (.GZ).  Van egy korábbi .GZ fájl is a kezdetekről, de ez valamiért 100Mb feletti, ezért nem mellékeltem.

## Előkészítés

Az  O_R-ban vannak ún. "rekordok", amik nem feltétlenül egyeznek az eredeti sorokkal. Az eredeti .XLSX (Excel tábla)  első oszlopa sok üres cellát tartalmaz, ami az O_R-ben nem kívánt rekord számozáshoz vezet. Ezért az első oszlop "atamélység" üres cellái "n.d" értéket kaptak. Ezek után a rekordok és sorok száma már megegyezik, ami a kívánt állapot, mivel minden ház egy sorban van.

A Linux (plain text) hozzáférhetősége érdekében a cellákon belüli sortöréseket felszámoltuk.

### Egyes oszlopok tisztítása

Több oszlopot tisztítottunk, különböző módszerekkel. Az alábbi táblázat csak összefoglaló, további részletek a napló fájlokban.  Aláhúzva az eredeti oszlopok nevei, ezek változatlanok maradtak, alattuk a származék oszlopok, melyeket mi tettünk a táblázathoz.

| Oszlop név                       | Kitöltött cella, db.                   | Módszer                                                                                                                                     | Tartalmi megjegyzés                                                                                                      |
| -------------------------------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| orig_ln                          | 1041                                   | LibreOffice Calc                                                                                                                            | a .TSV verzióé (= O_R sorszám+1)                                                                                         |
| <u>MAI CÍM</u>                   | 978                                    | eredeti; címek főleg "--" szeparátorral, de ez nem következetes                                                                             | mi legyen a "blank" mezőkkel?                                                                                            |
| maicim_1                         | 954, ahol 1-2 cím van, 710 ahol csak 1 | tesztek, köztérnév gyűjtés Linux eszközökkel (Awk, Grep, Sort, Uniq); szeparátor kiegészítés O_R `replace()`; O_R `split()`                 | az első v. egyetlen egyszerű cím egy köztérnévvel                                                                        |
| maicim_2                         | 243, ahol pontosan 2 db. cím van       | ibid                                                                                                                                        | második cím; ezek főleg sarkokat jelölnek; ha 2-nél több cím van, több ház-elrendezés is lehet - utóbbiakat félretettük  |
| maicim_rest                      | vegyes megj. 138, további cím 27       | ibid                                                                                                                                        | maradék infó: a 2 feletti címek ill. "**" után vegyes megjegyzések                                                       |
| <u>TÁRGY</u>                     | 885                                    | eredeti; az oszlop kópiájából folyamatosan töröltem a kiszervezett adatokat (redukció)                                                      | mi legyen a "blank" mezőkkel?                                                                                            |
| targy_név                        | 180                                    | Linux tesztek + kézi jelölés + O_R `forEach(cells["..."].value.find())`                                                                     | a házban levő intézmény neve v. a ház neve; milyen fomátum lehet?                                                        |
| targy_func_orig                  |                                        | Linux eszközök, Vim szerkesztés, kézi kategorizálás, O_R `find(), replace(), coalesce()`, regex különböző kombinációi; kézi egyedi editálás | kézzel válogatott kulcsszavak funkció meghatározáshoz; soronként több funkció is lehet; a funkció nincs mindig megadva!! |
| targy_cat                        |                                        | Linux; kézi; több próbálkozás, pl. Wikidata, stb. után végül a KSH "épületjegyzék" szerint, folyamatban!!                                   | kulcsszavak absztrakt kategóriái                                                                                         |
| targy_height                     |                                        | O_R `forEach(value.find()).join()`                                                                                                          | magasság emeletek száma. Ha keressük a házat, hasznos tudni. nincs mindig megadva                                        |
| targy_qnt                        |                                        | O_R `match(), replace(), coalesce()` és regex a magyar többes számhoz                                                                       | számosság: hány (ismert, sok, vagy egy) entitásról van szó                                                               |
| múlt-jelen (nincs külön oszlopa) | 40                                     | kézzel jelölve:  "\|", több tárgy-származék oszlopban                                                                                       | minta: régebbi "\|" későbbi; megfontolandó a külön táblába tétel!!                                                       |
| t_n_t_s2                         | 142                                    | redukciós taktika állapota szerint                                                                                                          | maradvány leírók, pl. "bér", "szék",                                                                                     |
| <u>forrás</u>                    | 578                                    | eredeti; csak a linkekkel foglalkoztunk                                                                                                     | sok az ismeretlen utalás                                                                                                 |
| forras_link_nr                   | 14                                     | O_R `find(RE#..., length())`                                                                                                                | hány linket tartalmaz                                                                                                    |
| forras_link_host                 | 14 (8 különböző)                       | O_R `forEach(value.find(), v, v.parseUri().parseJson().host).join()`                                                                        | csak a link webhelye                                                                                                     |
| forras_link                      | 14                                     | O_R `forEachIndex(value.find(), i, v, "("+(i + 1) + ") <" + v + ">").join()`                                                                | link számozva és formázva ("<...>") (az esetleges belső referálás érdekében)                                             |
| <u>további inf.</u>              | 401                                    | eredeti; csak a linkekkel foglalkoztunk                                                                                                     | legkomplexebb oszlop, sokszor hosszú szöveggel, külön kellene RDF-esíteni!                                               |
| tov-inf_link_nr                  | 106 nonzero                            | ld. forrás_link_nr                                                                                                                          | hány linket tartalmaz                                                                                                    |
| tov-inf_link_scheme-host         | 103                                    | ld. forrás_link_host                                                                                                                        | csak a link webhelye, 3 hiányzik??                                                                                       |
| tov-inf_link_numbered            | 106                                    | ld. forrás_link                                                                                                                             | link számozva és formázva ("<...>")                                                                                      |

## Általános megjegyzések az OpenRefine-nal kapcsolatban

- A szoftver megkönnyíti az adatok tisztítását és lehet vissza- és előrelépni a módosításokban.

- Az O_R-ben jó, hogy vissza lehet lépni a módosításokban. Ha visszalépünk egy korábbi állapotba és valamit csinálunk, a korábbi állapot utáni lépések mind elvesznek (nincs verzió kezelés). A cellák egyedi editálásához nehéz utólag hozzáférni, ez csak a projekt archívum (.GZ) fájl elemzéséből jön vissza. Mivel a szoftver tanulása és használata nem tandem, hanem párhuzamosan történt, a felsorolt sajátosságok negatíven befolyásolták a munka/naplózás következetességét.

## A mostani csomag

- A jelenlegi (2024-05-03) fájlok a következők:

- Ez az összefoglaló (naplo_SzGy-hez-magyarsummary.md)

- A fenti táblázatnak megfelelő .TSV és .SQL, az O_R-ből exportálva (az .SQL-ben a táblanéven és néhány oszlopnéven változtattam, az ékezetes betűk hiánya miatt)

- Az O_R teljes project (BP100-szupertabla-noquote-xlsx-tsv.openrefine.tar.gz), ami O_R-ben nyitható, adatokkal és historyval

- Részletes szöveges napló-jegyzetfüzet (naplo_SzGy.txt), GVim-ben célszerű nyitni a behajtások (sor összevonások) miatt, amik a `:se fdm=marker` utasítással válnak láthatóvá.

- 2 Excel fájl, ami az épület kategorizálást segíti. Ezt Python/SQL kóddal próbáljuk majd tető alá hozni.

## Készültség?

Az egyes oszlopokat igyekeztünk végigcsinálni (1041 sor van), de soknál maradtak "zajos" értékek; magát a zajt próbáltuk külön sorokba izolálni, így a táblázatból zajszűréssel könnyen készíthető egy "probléma mentes" változat, legalábbis ami a feldolgozott sorokat illeti. Az épület kategorizálás még folyamatban van, ez sem triviális, mivel vannak vegyes kategóriák. A "forrás" és "további inf" oszlopok különösképpen következetlenek, így maradnánk a linkek feldolgozásánál, itt még esetleg a nem működőket meg lehetne jelölni. Ezen fűggőségek miatt még nem készítettem egy "hibátlan" válogatást, de úgy becsülöm, hogy kb. 10 óra munka után kb. a sorok kétharmada egész jó állapotban lehet. Jelenleg nehéz haladni, sok az iskolai beadandó feladat.
