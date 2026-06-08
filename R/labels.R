#' Digital theme category labels
#'
#' A named character vector mapping the nine digital theme category codes
#' (column `kategorie` in [digitalhaushalt]) to their German names.
#'
#' @format A named character vector of length 9. Names are the integer codes
#'   as character strings (`"1"` to `"9"`); values are German labels.
#'
#' \describe{
#'   \item{1}{Infrastruktur}
#'   \item{2}{Digitale Wirtschaft}
#'   \item{3}{Digitale Verwaltung}
#'   \item{4}{Digitale Kompetenzen}
#'   \item{5}{Kultur & Zivilgesellschaft}
#'   \item{6}{Forschung & Innovation}
#'   \item{7}{Gesundheitswesen}
#'   \item{8}{Bundeswehr}
#'   \item{9}{Unteilbare Ausgaben}
#' }
#'
#' @seealso [digitalhaushalt], [hf_labels], [of_labels]
#'
#' @examples
#' kat_labels["3"]
#' # "Digitale Verwaltung"
#'
#' # Add readable labels to a subset of the data
#' data(digitalhaushalt)
#' digi <- subset(digitalhaushalt, !is.na(kategorie))
#' digi$kat_name <- kat_labels[as.character(digi$kategorie)]
"kat_labels"

#' Hauptfunktion labels (official, full-length)
#'
#' A named character vector mapping the nine Hauptfunktion codes
#' (first digit of `funktion`, stored in `funktion_lvl1`) to their official
#' German names as defined in the federal Funktionenplan (BMF).
#'
#' @format A named character vector of length 9. Names are single-digit
#'   character strings (`"0"` to `"8"`); values are official German labels.
#'
#' \describe{
#'   \item{0}{Allgemeine Dienste}
#'   \item{1}{Bildungswesen, Wissenschaft, Forschung, kulturelle Angelegenheiten}
#'   \item{2}{Soziale Sicherung, Familie und Jugend, Arbeitsmarktpolitik}
#'   \item{3}{Gesundheit, Umwelt, Sport und Erholung}
#'   \item{4}{Wohnungswesen, Städtebau, Raumordnung und kommunale Gemeinschaftsdienste}
#'   \item{5}{Ernährung, Landwirtschaft und Forsten}
#'   \item{6}{Energie- und Wasserwirtschaft, Gewerbe, Dienstleistungen}
#'   \item{7}{Verkehrs- und Nachrichtenwesen}
#'   \item{8}{Finanzwirtschaft}
#' }
#'
#' @source Funktionenplan des Bundesministeriums der Finanzen (BMF), 2024.
#'   \url{https://www.bundesfinanzministerium.de}
#'
#' @seealso [hf_labels_short], [of_labels], [digitalhaushalt]
#'
#' @examples
#' hf_labels["0"]
#' # "Allgemeine Dienste"
"hf_labels"

#' Hauptfunktion labels (shortened, for plots)
#'
#' A named character vector of shortened Hauptfunktion names, suitable for
#' axis labels and legends in plots. Codes and hierarchy match [hf_labels].
#'
#' @format A named character vector of length 9. Names are single-digit
#'   character strings (`"0"` to `"8"`); values are shortened German labels.
#'
#' @seealso [hf_labels], [digitalhaushalt]
#'
#' @examples
#' hf_labels_short["1"]
#' # "Bildung & Forschung"
"hf_labels_short"

#' Oberfunktion labels
#'
#' A named character vector mapping the Oberfunktion codes (first two digits
#' of `funktion`, stored in `funktion_lvl2`) to their official German names
#' as defined in the federal Funktionenplan (BMF). Only codes present in the
#' [digitalhaushalt] dataset are included (56 codes).
#'
#' @format A named character vector. Names are 2-digit character strings
#'   (e.g. `"01"`, `"16"`, `"71"`); values are official German labels.
#'
#' @source Funktionenplan des Bundesministeriums der Finanzen (BMF), 2024.
#'   \url{https://www.bundesfinanzministerium.de}
#'
#' @seealso [hf_labels], [digitalhaushalt]
#'
#' @examples
#' of_labels["03"]
#' # "Verteidigung"
#'
#' of_labels["16"]
#' # "Wissenschaft, Forschung, Entwicklung ausserhalb der Hochschulen"
"of_labels"

#' Gruppe (expenditure type) labels
#'
#' A named character vector mapping 3-digit `gruppe` codes to German
#' spending-type descriptions. Covers the codes most frequently encountered
#' in the digital budget lines of [digitalhaushalt], with particular depth
#' for the defence budget (Einzelplan 14, category 8).
#'
#' @format A named character vector. Names are 3-digit character strings;
#'   values are German labels.
#'
#' \describe{
#'   \item{422}{Bezüge der Beamten und Richter}
#'   \item{425}{Vergütungen der Arbeitnehmer}
#'   \item{511}{Geschäftsbedarf und IT-Kleinbedarf}
#'   \item{517}{Bewirtschaftung der Grundstücke, Gebäude und Räume}
#'   \item{526}{Geräte, Ausstattungs- und Ausrüstungsgegenstände}
#'   \item{532}{IT-Ausgaben (Betrieb und Services)}
#'   \item{544}{Forschung und Entwicklung (laufender Betrieb)}
#'   \item{551}{Wehrforschung und -entwicklung}
#'   \item{553}{Materialerhaltung}
#'   \item{554}{Militärische Beschaffung}
#'   \item{681}{Zuweisungen an Gebietskörperschaften}
#'   \item{686}{Zuschüsse an soziale und ähnliche Einrichtungen}
#'   \item{812}{Investitionsausgaben für Geräte und Ausrüstung}
#'   \item{831}{Darlehen und Beteiligungen}
#' }
#'
#' @seealso [digitalhaushalt]
#'
#' @examples
#' gruppe_labels["532"]
#' # "IT-Ausgaben (Betrieb und Services)"
"gruppe_labels"

#' TexAn keyword regular expressions
#'
#' A named character vector of regular expressions used by the TexAn text
#' analysis method to identify potentially digital budget lines. Patterns are
#' designed to match against the `titel_text` column of [digitalhaushalt],
#' which marks TexAn hits with bracket notation (`[`, `]`, `{`, `}`).
#'
#' Keywords are split into two types, accessible via the companion lookup:
#' * **Concept keywords** — substantive digital concepts
#'   (e.g. "Software", "KI", "Cloud")
#' * **Institution keywords** — agencies and research bodies whose work is
#'   predominantly or partially digital (e.g. "BSI", "ITZBund")
#'
#' The false-positive rate varies substantially by keyword. Institution
#' keywords in particular behave differently from concept keywords; see
#' [texan_keyword_types] for the type classification.
#'
#' @format A named character vector. Names are human-readable keyword labels;
#'   values are POSIX extended regular expressions for use with
#'   [base::grepl()] or [stringr::str_detect()].
#'
#' @seealso [texan_keyword_types], [digitalhaushalt]
#'
#' @examples
#' data(digitalhaushalt)
#'
#' # Find all lines matching the "KI" keyword
#' ki_pattern <- texan_keywords["KI / Kuenstliche Intelligenz"]
#' ki_lines <- subset(digitalhaushalt,
#'                    grepl(ki_pattern, titel_text, perl = TRUE))
#' nrow(ki_lines)
"texan_keywords"

#' TexAn keyword type classification
#'
#' A named character vector classifying each entry in [texan_keywords] as
#' either `"Concept"` (substantive digital concept) or `"Institution"`
#' (agency or research body). Names match those of [texan_keywords].
#'
#' @format A named character vector. Names are keyword labels; values are
#'   `"Concept"` or `"Institution"`.
#'
#' @seealso [texan_keywords]
"texan_keyword_types"
