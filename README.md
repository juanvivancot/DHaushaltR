# DHaushaltR

An R data package providing the **German Federal Digital Budget** dataset
from the [Agora Digitale Transformation](https://www.agora-digitale-transformation.de)
research project, covering fiscal years 2019, 2021, 2023, 2024, and 2025.

## Installation

```r
# install.packages("pak")
pak::pak("juanvivancot/DHaushaltR")
```

## What's included

| Object | Description |
|---|---|
| `digitalhaushalt` | ~27 000 budget lines with digital classification, spending amounts, and resolved Funktionenplan codes |
| `kat_labels` | Digital theme category codes 1–9 → German names |
| `hf_labels` | Hauptfunktion codes "0"–"8" → official names (BMF Funktionenplan) |
| `hf_labels_short` | Hauptfunktion codes → shortened names for plots |
| `of_labels` | Oberfunktion codes "01"–"89" → official names |
| `gruppe_labels` | 3-digit Gruppe codes → spending-type descriptions |
| `texan_keywords` | Named regex vector for TexAn text analysis |
| `texan_keyword_types` | Type classification (`"Concept"` / `"Institution"`) for each keyword |

## Quick start

```r
library(DHaushaltR)
library(dplyr)

data(digitalhaushalt)

# Total planned digital spending (narrow) per year, EUR billion
digitalhaushalt |>
  filter(!is.na(digi_soll_eng)) |>
  group_by(jahr) |>
  summarise(bn = sum(digi_soll_eng, na.rm = TRUE) / 1e6)

# Add readable category labels
digitalhaushalt |>
  filter(!is.na(kategorie)) |>
  mutate(theme = kat_labels[as.character(kategorie)]) |>
  count(theme, sort = TRUE)
```

## Source and citation

This package is based on the following study — please cite it when using the data:

> Hütten, M., Eder, F., Prante, F., Scholl, T., and Stier, S. (2025).
> *Digitalhaushalt: Bundesausgaben für Digitalisierung 2019–2025.*
> Agora Digitale Transformation gGmbH.
> <https://agoradigital.de/wp-content/uploads/2026/04/ADT_Studie_Digitalhaushalt_2025.pdf>

For methodology, variable definitions, and classification decisions, the study
is the authoritative reference.

## Licence

**Dataset**: © Agora Digitale Transformation gGmbH,
[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

**Package code**: MIT © Juan Vivanco.