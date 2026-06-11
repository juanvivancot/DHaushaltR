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
#' Bertschek, I., Breithaupt, P., Heinemann, F., Niebel, T., and
#' Schildknecht, J. (2026). *Der Digitalhaushalt 2025: Wird er den hohen
#' Erwartungen gerecht?* Agora Digitale Transformation gGmbH.
#' <https://doi.org/10.5281/zenodo.19550821>
#'
#' ## Licence
#' Package code: MIT. Dataset: CC BY-SA 4.0, Agora Digitale Transformation
#' gGmbH. See `?digitalhaushalt` for full attribution.
#'
#' @keywords internal
"_PACKAGE"
