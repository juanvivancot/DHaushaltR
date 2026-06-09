# data-raw/prepare.R
# Reproducible build script: reads the source xlsx and writes all package
# data objects to data/.
#
# Run once (or whenever the source file changes):
#   source("data-raw/prepare.R")
#
# Requires: readxl, dplyr, usethis (install if needed)

library(readxl)
library(dplyr)
library(usethis)

# ---- 0. Download source file -------------------------------------------------
# The dataset is published under CC BY-SA 4.0 by Agora Digitale Transformation.
xlsx_url <- "https://agoradigital.de/wp-content/uploads/2026/04/Digitalhaushalt_Open_Data_DOI.xlsx"
xlsx_tmp  <- tempfile(fileext = ".xlsx")
download.file(xlsx_url, xlsx_tmp, mode = "wb", quiet = TRUE)

# ---- 1. Read raw data --------------------------------------------------------
raw <- read_excel(xlsx_tmp, sheet = "Daten")

# ---- 2. Clean ----------------------------------------------------------------
# Drop ~61 rows with missing soll or titel_text.
df_clean <- raw |>
  filter(!is.na(soll), !is.na(titel_text))

# ---- 3. Derive Funktionenplan levels -----------------------------------------
df_clean <- df_clean |>
  mutate(
    funktion_lvl1 = substr(as.character(funktion), 1, 1),
    funktion_lvl2 = substr(as.character(funktion), 1, 2)
  )

# ---- 4. Collapse one-hot category columns ------------------------------------
# Original nine columns (_1_infra … _9_unteilbare_ausg) → single integer
# column `kategorie` (1–9, NA for non-digital rows).
.cat_cols <- grep("^_", names(df_clean), value = TRUE)
.cat_idx  <- as.integer(sub("^_([0-9]+)_.*$", "\\1", .cat_cols))
.m        <- as.matrix(df_clean[.cat_cols])
.m[is.na(.m)] <- 0
.has      <- rowSums(.m) == 1
df_clean$kategorie <- NA_integer_
df_clean$kategorie[.has] <- .cat_idx[
  max.col(.m[.has, , drop = FALSE], ties.method = "first")
]
df_clean <- df_clean[, !(names(df_clean) %in% .cat_cols)]
rm(.cat_cols, .cat_idx, .m, .has)

# Final column order: identifiers first, then amounts, then classification.
digitalhaushalt <- df_clean |>
  select(
    id, jahr, einzelplan, kapitel, gruppe, funktion,
    funktion_lvl1, funktion_lvl2,
    soll, digi_soll_eng, digi_soll_weit,
    ist,  digi_ist_eng,  digi_ist_weit,
    titel_text, digi_klasse, kategorie,
    any_tag, expert_tag, large_soll_tag, ml_tag,
    digital_series_tag, texan_tag
  )

# ---- 5. Lookup tables --------------------------------------------------------

kat_labels <- c(
  "1" = "Infrastruktur",
  "2" = "Digitale Wirtschaft",
  "3" = "Digitale Verwaltung",
  "4" = "Digitale Kompetenzen",
  "5" = "Kultur & Zivilgesellschaft",
  "6" = "Forschung & Innovation",
  "7" = "Gesundheitswesen",
  "8" = "Bundeswehr",
  "9" = "Unteilbare Ausgaben"
)

# Official titles from the federal Funktionenplan (BMF, 2024).
hf_labels <- c(
  "0" = "Allgemeine Dienste",
  "1" = "Bildungswesen, Wissenschaft, Forschung, kulturelle Angelegenheiten",
  "2" = "Soziale Sicherung, Familie und Jugend, Arbeitsmarktpolitik",
  "3" = "Gesundheit, Umwelt, Sport und Erholung",
  "4" = "Wohnungswesen, Städtebau, Raumordnung und kommunale Gemeinschaftsdienste",
  "5" = "Ernährung, Landwirtschaft und Forsten",
  "6" = "Energie- und Wasserwirtschaft, Gewerbe, Dienstleistungen",
  "7" = "Verkehrs- und Nachrichtenwesen",
  "8" = "Finanzwirtschaft"
)

hf_labels_short <- c(
  "0" = "Allgemeine Dienste",
  "1" = "Bildung & Forschung",
  "2" = "Soziale Sicherung",
  "3" = "Gesundheit & Umwelt",
  "4" = "Wohnen & Städtebau",
  "5" = "Landwirtschaft",
  "6" = "Energie & Gewerbe",
  "7" = "Verkehr & Nachrichten",
  "8" = "Finanzwirtschaft"
)

of_labels <- c(
  "01" = "Politische Führung und zentrale Verwaltung",
  "02" = "Auswärtige Angelegenheiten",
  "03" = "Verteidigung",
  "04" = "Öffentliche Sicherheit und Ordnung",
  "05" = "Rechtsschutz",
  "06" = "Finanzverwaltung",
  "11" = "Allgemeinbildende und berufliche Schulen",
  "12" = "Allgemeinbildende und berufliche Schulen",
  "13" = "Hochschulen",
  "14" = "Förderung für Schüler, Studierende und Weiterbildung",
  "15" = "Sonstiges Bildungswesen",
  "16" = "Wissenschaft, Forschung, Entwicklung außerhalb der Hochschulen",
  "18" = "Kultur und Religion",
  "19" = "Kultur und Religion",
  "21" = "Verwaltung für soziale Angelegenheiten",
  "22" = "Sozialversicherung einschl. Arbeitslosenversicherung",
  "23" = "Familienhilfe, Wohlfahrtspflege u. Ä.",
  "24" = "Soziale Leistungen für Folgen von Krieg und politischen Ereignissen",
  "25" = "Arbeitsmarktpolitik",
  "26" = "Kinder- und Jugendhilfe nach SGB VIII",
  "27" = "Kindertagesbetreuung nach SGB VIII",
  "28" = "Soziale Leistungen (SGB XII, AsylbLG, Eingliederungshilfe SGB IX)",
  "29" = "Sonstige soziale Angelegenheiten",
  "31" = "Gesundheitswesen",
  "32" = "Sport und Erholung",
  "33" = "Umwelt- und Naturschutz",
  "34" = "Nukleare Sicherheit und Strahlenschutz",
  "41" = "Wohnungswesen, Wohnungsbauprämie",
  "42" = "Geoinformation, Raumordnung und Landesplanung, Städtebauförderung",
  "43" = "Kommunale Gemeinschaftsdienste",
  "51" = "Verwaltung für Ernährung, Landwirtschaft und Forsten",
  "52" = "Landwirtschaft und Ernährung",
  "53" = "Forstwirtschaft und Jagd, Fischerei",
  "61" = "Verwaltung für Energie- und Wasserwirtschaft, Gewerbe und Dienstleistungen",
  "62" = "Wasserwirtschaft, Hochwasser- und Küstenschutz",
  "63" = "Bergbau, verarbeitendes Gewerbe und Baugewerbe",
  "64" = "Energie- und Wasserversorgung, Entsorgung",
  "65" = "Handel und Tourismus",
  "66" = "Geld- und Versicherungswesen",
  "68" = "Sonstiges Gewerbe und Dienstleistungen",
  "69" = "Regionale Fördermaßnahmen",
  "71" = "Verwaltung des Verkehrs- und Nachrichtenwesens",
  "72" = "Straßen",
  "73" = "Wasserstraßen und Häfen, Schifffahrt",
  "74" = "Eisenbahnen und öffentlicher Personennahverkehr",
  "75" = "Luftfahrt",
  "77" = "Nachrichtenwesen",
  "79" = "Sonstiges Verkehrswesen",
  "81" = "Grund- und Kapitalvermögen, Sondervermögen",
  "82" = "Steuern und Finanzzuweisungen",
  "83" = "Schulden",
  "84" = "Beihilfen, Unterstützungen u. Ä.",
  "85" = "Rücklagen",
  "86" = "Sonstiges",
  "88" = "Globalposten",
  "89" = "Haushaltstechnische Verrechnungen"
)

gruppe_labels <- c(
  "422" = "Salaries (civil servants and judges)",
  "425" = "Salaries (employees)",
  "511" = "Office supplies and minor IT equipment",
  "517" = "Building and property operations",
  "526" = "Equipment and furnishings",
  "532" = "IT expenditure (operations and services)",
  "544" = "Research and development (current operations)",
  "551" = "Defence research and development",
  "553" = "Material maintenance",
  "554" = "Military procurement",
  "681" = "Transfers to local authorities",
  "686" = "Grants to social and similar institutions",
  "812" = "Capital investment in equipment",
  "831" = "Loans and participations"
)

# TexAn keyword regular expressions (from Agora methodology, Section 2.2).
# Designed for grepl(pattern, titel_text, perl = TRUE).
texan_keywords <- c(
  "Software"                      = "\\[?\\{?Software",
  "Informationstechnologie / IT"  = "\\[?\\{?[Ii]nformationstechn",
  "Digitalisierung / Digital*"    = "\\[?\\{?[Dd]igital",
  "Telekommunikation"             = "\\[?\\{?Telekommunikation",
  "Datenschutz"                   = "\\[?\\{?Datenschutz",
  "Cybersicherheit"               = "\\[?\\{?[Cc]yber",
  "Netzpolitik"                   = "Netzpolitik",
  "Moderne Verwaltung"            = "Moderne Verwaltung",
  "KI / Künstliche Intelligenz"   = "Künstliche Intelligenz|\\[KI\\]|\\{KI\\}",
  "Cloud"                         = "\\[?\\{?[Cc]loud",
  "Blockchain"                    = "[Bb]lockchain",
  "Quantencomputing"              = "[Qq]uanten",
  "Fernmeldeanlagen"              = "Fernmelde",
  "Vernetzung / vernetzt"         = "\\[?\\{?[Vv]ernetz",
  "Neue Mobilität / e-Mob."       = "\\[e Mobilität|\\[E-Mobil|\\[neue Mobilität",
  "Interoperabilität"             = "Interoperabilität",
  "Geodaten"                      = "Geodaten",
  "Bundesnetzagentur"             = "Bundesnetzagentur",
  "BSI"                           = "Bundesamt für Sicherheit in der",
  "ITZBund"                       = "ikzentrum.*?Bund|ITZBund",
  "Helmholtz"                     = "Helmholtz",
  "Leibniz / WGL"                 = "Leibniz|WGL",
  "DZSF / Schienenverkehr"        = "DZSF|Schienenverkehrsforschung"
)

texan_keyword_types <- c(
  "Software"                      = "Concept",
  "Informationstechnologie / IT"  = "Concept",
  "Digitalisierung / Digital*"    = "Concept",
  "Telekommunikation"             = "Concept",
  "Datenschutz"                   = "Concept",
  "Cybersicherheit"               = "Concept",
  "Netzpolitik"                   = "Concept",
  "Moderne Verwaltung"            = "Concept",
  "KI / Künstliche Intelligenz"   = "Concept",
  "Cloud"                         = "Concept",
  "Blockchain"                    = "Concept",
  "Quantencomputing"              = "Concept",
  "Fernmeldeanlagen"              = "Concept",
  "Vernetzung / vernetzt"         = "Concept",
  "Neue Mobilität / e-Mob."       = "Concept",
  "Interoperabilität"             = "Concept",
  "Geodaten"                      = "Concept",
  "Bundesnetzagentur"             = "Institution",
  "BSI"                           = "Institution",
  "ITZBund"                       = "Institution",
  "Helmholtz"                     = "Institution",
  "Leibniz / WGL"                 = "Institution",
  "DZSF / Schienenverkehr"        = "Institution"
)

# ---- 6. Save to data/ --------------------------------------------------------
use_data(
  digitalhaushalt,
  kat_labels,
  hf_labels,
  hf_labels_short,
  of_labels,
  gruppe_labels,
  texan_keywords,
  texan_keyword_types,
  overwrite = TRUE,
  compress  = "xz"
)

message("Done. Run devtools::document() then devtools::check().")
