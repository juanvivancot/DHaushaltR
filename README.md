# DHaushaltR

An R data package providing the **German Federal Digital Budget** dataset
from the [Agora Digitale Transformation](https://www.agora-digitale-transformation.de)
research project, covering fiscal years 2019, 2021, 2023, 2024, and 2025.

## Installation

```r
# install.packages("pak")
pak::pak("jvivanco/DHaushaltR")
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

## Licence

**Dataset**: © Agora Digitale Transformation gGmbH,
[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
Please cite as: Agora Digitale Transformation (2025), *Digitalhaushalt Open Data*.

**Package code**: MIT © Juan Vivanco.

## Citation

```r
citation("DHaushaltR")
```
