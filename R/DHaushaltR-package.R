#' DHaushaltR: German Federal Digital Budget Data (2019–2025)
#'
#' @description
#' `DHaushaltR` provides the cleaned dataset from the Agora Digitale
#' Transformation research project on Germany's federal digital budget.
#' The dataset covers budget lines tagged for digitalisation across five
#' fiscal years (2019, 2021, 2023, 2024, 2025).
#'
#' ## Main objects
#'
#' * [digitalhaushalt] — the core data frame (~27 000 budget lines)
#' * [kat_labels] — digital theme category codes 1–9 → labels
#' * [hf_labels] — Hauptfunktion codes "0"–"8" → official labels
#' * [hf_labels_short] — Hauptfunktion codes → shortened plot labels
#' * [of_labels] — Oberfunktion codes "01"–"89" → official labels
#' * [gruppe_labels] — 3-digit Gruppe codes → spending-type labels
#' * [texan_keywords] — named regex vector for TexAn text analysis
#'
#' ## Source
#' Hütten, M., Eder, F., Prante, F., Scholl, T., and Stier, S. (2025).
#' *Digitalhaushalt: Bundesausgaben für Digitalisierung 2019–2025.*
#' Agora Digitale Transformation gGmbH.
#' <https://agoradigital.de/wp-content/uploads/2026/04/ADT_Studie_Digitalhaushalt_2025.pdf>
#'
#' ## Licence
#' Package code: MIT. Dataset: CC BY-SA 4.0, Agora Digitale Transformation
#' gGmbH. See `?digitalhaushalt` for full attribution.
#'
#' @keywords internal
"_PACKAGE"
