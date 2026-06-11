#' German Federal Digital Budget Data (2019--2025)
#'
#' @description
#' Budget lines from the German federal budget (*Bundeshaushalt*) assessed for
#' digitalisation content by the Agora Digitale Transformation research project.
#' The dataset covers five fiscal years: 2019, 2021, 2023, 2024, and 2025.
#' Approximately 61 incomplete records (missing \code{soll} or
#' \code{titel_text}) have been removed from the raw source file.
#'
#' Each row is one budget line (*Haushaltstitel*). Lines were screened by up
#' to four detection methods (keyword search, machine learning, expert
#' knowledge, budget series matching). Lines that passed at least one method
#' were manually reviewed and assigned a digitalisation class
#' (\code{digi_klasse}) and a thematic digital category (\code{kategorie}).
#'
#' @format A data frame with approximately 27,000 rows and 23 columns:
#' \describe{
#'
#'   \item{id}{Character. Unique identifier for the budget line, composed of
#'   chapter (\emph{Kapitel}), title number, and function code.}
#'
#'   \item{jahr}{Integer. Fiscal year. One of: \code{2019}, \code{2021},
#'   \code{2023}, \code{2024}, \code{2025}. Note that 2020 and 2022 are not
#'   included; years were sampled by the research project.}
#'
#'   \item{einzelplan}{Character (2-digit). Departmental budget
#'   (\emph{Einzelplan}), corresponding to a federal ministry or top-level
#'   body. The 26 codes present in this dataset are:
#'   \describe{
#'     \item{\code{"01"}}{Office of the Federal President
#'       (\emph{Bundespräsident und Bundespräsidialamt})}
#'     \item{\code{"02"}}{German Bundestag (\emph{Deutscher Bundestag})}
#'     \item{\code{"03"}}{Federal Council (\emph{Bundesrat})}
#'     \item{\code{"04"}}{Federal Chancellery (\emph{Bundeskanzler und
#'       Bundeskanzleramt})}
#'     \item{\code{"05"}}{Federal Foreign Office (\emph{Auswärtiges Amt})}
#'     \item{\code{"06"}}{Federal Ministry of the Interior
#'       (\emph{Bundesministerium des Innern und für Heimat}, BMI)}
#'     \item{\code{"07"}}{Federal Ministry of Justice
#'       (\emph{Bundesministerium der Justiz}, BMJ)}
#'     \item{\code{"08"}}{Federal Ministry of Finance
#'       (\emph{Bundesministerium der Finanzen}, BMF)}
#'     \item{\code{"09"}}{Federal Ministry for Economic Affairs
#'       (\emph{Bundesministerium für Wirtschaft und Klimaschutz}, BMWK)}
#'     \item{\code{"10"}}{Federal Ministry of Food and Agriculture
#'       (\emph{Bundesministerium für Ernährung und Landwirtschaft}, BMEL)}
#'     \item{\code{"11"}}{Federal Ministry of Labour and Social Affairs
#'       (\emph{Bundesministerium für Arbeit und Soziales}, BMAS)}
#'     \item{\code{"12"}}{Federal Ministry for Digital and Transport
#'       (\emph{Bundesministerium für Digitales und Verkehr}, BMDV;
#'       until 2021: BMVI)}
#'     \item{\code{"14"}}{Federal Ministry of Defence
#'       (\emph{Bundesministerium der Verteidigung}, BMVg)}
#'     \item{\code{"15"}}{Federal Ministry of Health
#'       (\emph{Bundesministerium für Gesundheit}, BMG)}
#'     \item{\code{"16"}}{Federal Ministry for the Environment
#'       (\emph{Bundesministerium für Umwelt, Naturschutz, nukleare Sicherheit
#'       und Verbraucherschutz}, BMUV)}
#'     \item{\code{"17"}}{Federal Ministry for Family Affairs
#'       (\emph{Bundesministerium für Familie, Senioren, Frauen und Jugend},
#'       BMFSFJ)}
#'     \item{\code{"19"}}{Federal Constitutional Court and other federal
#'       courts (\emph{Bundesverfassungsgericht})}
#'     \item{\code{"20"}}{Federal Court of Auditors
#'       (\emph{Bundesrechnungshof})}
#'     \item{\code{"21"}}{Federal Commissioner for Data Protection and Freedom
#'       of Information (\emph{Bundesbeauftragte für den Datenschutz und die
#'       Informationsfreiheit}, BfDI)}
#'     \item{\code{"22"}}{Independent Oversight Council
#'       (\emph{Unabhängiger Kontrollrat}). In earlier budget years this
#'       \emph{Einzelplan} held the Federal Commissioner for Stasi Records
#'       (BStU; dissolved 2021).}
#'     \item{\code{"23"}}{Federal Ministry for Economic Cooperation and
#'       Development (\emph{Bundesministerium für wirtschaftliche
#'       Zusammenarbeit und Entwicklung}, BMZ)}
#'     \item{\code{"24"}}{Federal Ministry for Digital Affairs and State
#'       Modernisation (\emph{Bundesministerium für Digitales und
#'       Staatsmodernisierung}, BMDS; new ministry, present from 2025)}
#'     \item{\code{"25"}}{Federal Ministry for Housing and Urban Development
#'       (\emph{Bundesministerium für Wohnen, Stadtentwicklung und Bauwesen},
#'       BMWSB)}
#'     \item{\code{"30"}}{Federal Ministry of Education and Research
#'       (\emph{Bundesministerium für Bildung und Forschung}, BMBF). From
#'       2026 restructured as BMFTR (research, technology and space).}
#'     \item{\code{"32"}}{Federal Debt (\emph{Bundesschuld})}
#'     \item{\code{"60"}}{General Financial Administration
#'       (\emph{Allgemeine Finanzverwaltung})}
#'   }}
#'
#'   \item{kapitel}{Character. Chapter number within the
#'   \emph{Einzelplan}. Provides finer administrative subdivision within a
#'   ministry.}
#'
#'   \item{gruppe}{Character (3-digit). Expenditure or revenue group code
#'   from the federal \emph{Gruppierungsplan}. Describes the \emph{type} of
#'   spending (not its purpose). Key ranges:
#'   \describe{
#'     \item{\code{4xx}}{Personnel expenditure (salaries, pensions)}
#'     \item{\code{5xx}}{Administrative and operational expenditure, including
#'       \code{532} IT operations and services and \code{554} military
#'       procurement}
#'     \item{\code{6xx}}{Transfers and grants (to local authorities,
#'       enterprises, social institutions, international organisations)}
#'     \item{\code{7xx}}{Debt service}
#'     \item{\code{8xx}}{Capital investment and investment grants}
#'     \item{\code{9xx}}{Special financing items (e.g. \code{981} global
#'       expenditure reduction)}
#'   }
#'   See \code{\link{gruppe_labels}} for descriptions of the most common
#'   codes.}
#'
#'   \item{funktion}{Character (3-digit). Function code from the federal
#'   \emph{Funktionenplan} (BMF). Describes the \emph{political purpose} of
#'   the expenditure (e.g. defence, health, education). Present for all rows.
#'   The code hierarchy has three levels: \code{funktion_lvl1} (1 digit),
#'   \code{funktion_lvl2} (2 digits), and \code{funktion} (3 digits).}
#'
#'   \item{funktion_lvl1}{Character (1-digit). \emph{Hauptfunktion}: the
#'   broadest level of the \emph{Funktionenplan}, derived as the first digit
#'   of \code{funktion}. Nine categories:
#'   \describe{
#'     \item{\code{"0"}}{General services (\emph{Allgemeine Dienste})}
#'     \item{\code{"1"}}{Education, science, research, cultural affairs
#'       (\emph{Bildungswesen, Wissenschaft, Forschung, kulturelle
#'       Angelegenheiten})}
#'     \item{\code{"2"}}{Social security, family, labour market policy
#'       (\emph{Soziale Sicherung, Familie und Jugend, Arbeitsmarktpolitik})}
#'     \item{\code{"3"}}{Health, environment, sport
#'       (\emph{Gesundheit, Umwelt, Sport und Erholung})}
#'     \item{\code{"4"}}{Housing and urban development
#'       (\emph{Wohnungswesen, Städtebau, Raumordnung})}
#'     \item{\code{"5"}}{Food, agriculture, forestry
#'       (\emph{Ernährung, Landwirtschaft und Forsten})}
#'     \item{\code{"6"}}{Energy, water, trade, services
#'       (\emph{Energie- und Wasserwirtschaft, Gewerbe, Dienstleistungen})}
#'     \item{\code{"7"}}{Transport and communications
#'       (\emph{Verkehrs- und Nachrichtenwesen})}
#'     \item{\code{"8"}}{Finance (\emph{Finanzwirtschaft})}
#'   }
#'   See \code{\link{hf_labels}} for the official German labels.}
#'
#'   \item{funktion_lvl2}{Character (2-digit). \emph{Oberfunktion}: the
#'   mid-level of the \emph{Funktionenplan}, derived as the first two digits
#'   of \code{funktion}. 56 codes are present in this dataset. See
#'   \code{\link{of_labels}} for the full lookup table.}
#'
#'   \item{soll}{Numeric. Planned (\emph{Soll}) expenditure for the budget
#'   line, in thousands of EUR. Present for all rows.}
#'
#'   \item{digi_soll_eng}{Numeric. Planned digital expenditure, narrow
#'   definition, in thousands of EUR. \code{NA} for non-digital lines.}
#'
#'   \item{digi_soll_weit}{Numeric. Planned digital expenditure, broad
#'   definition, in thousands of EUR. \code{NA} for non-digital lines. The
#'   broad definition includes lines where only a share of spending is
#'   digital.}
#'
#'   \item{ist}{Numeric. Actual (\emph{Ist}) expenditure, in thousands of
#'   EUR. Available for closed fiscal years (2019, 2021, 2023, 2024);
#'   \code{NA} for 2025 (not yet closed).}
#'
#'   \item{digi_ist_eng}{Numeric. Actual digital expenditure, narrow
#'   definition, in thousands of EUR.}
#'
#'   \item{digi_ist_weit}{Numeric. Actual digital expenditure, broad
#'   definition, in thousands of EUR.}
#'
#'   \item{titel_text}{Character. Full text of the budget line: chapter
#'   heading, title-group purpose, title designation, and explanatory notes
#'   concatenated. Keywords identified by the TexAn text-analysis method are
#'   enclosed in square or curly brackets (\code{[keyword]},
#'   \code{\{keyword\}}). See \code{\link{texan_keywords}} for the full
#'   keyword list.}
#'
#'   \item{digi_klasse}{Integer or \code{NA}. Methodological digitalisation
#'   class assigned by the research project (see Table 1 of Bertschek et al.,
#'   2026). Describes \emph{how} a line was classified, not its topic.
#'   \describe{
#'     \item{\code{NA}}{Not flagged by any detection method; not assessed.}
#'     \item{\code{0}}{Flagged by at least one method but assessed as
#'       \emph{not digital} after expert review.}
#'     \item{\code{1}}{Confirmed digital via manual expert review.}
#'     \item{\code{2}}{Confirmed digital as part of a digital budget series
#'       identified in a predecessor project.}
#'     \item{\code{3}}{Confirmed digital by the machine-learning classifier
#'       (\code{ml_tag}).}
#'     \item{\code{4}}{Confirmed digital via expert knowledge from the
#'       federal administration (\code{expert_tag}).}
#'     \item{\code{5}}{Confirmed digital via TexAn keyword match plus
#'       subsequent confirmation.}
#'     \item{\code{6}}{Confirmed digital due to planned expenditure exceeding
#'       EUR 100 million (\code{large_soll_tag}).}
#'     \item{\code{7}}{Confirmed digital by a combination of several
#'       detection methods.}
#'     \item{\code{8}}{Confirmed digital -- special case or manual override.}
#'   }}
#'
#'   \item{kategorie}{Integer (1--9) or \code{NA}. Digital thematic category
#'   assigned by the research project. Set only for confirmed digital lines
#'   (\code{digi_klasse} 1--8); \code{NA} otherwise. Each digital line
#'   carries exactly one category. Values:
#'   \describe{
#'     \item{\code{1}}{Infrastructure (\emph{Infrastruktur}): physical and
#'       digital infrastructure investment.}
#'     \item{\code{2}}{Digital economy (\emph{Digitale Wirtschaft}):
#'       digitalisation of the private sector and economic promotion.}
#'     \item{\code{3}}{Digital public administration (\emph{Digitale
#'       Verwaltung}): e-government, administrative IT, OZG
#'       implementation.}
#'     \item{\code{4}}{Digital skills (\emph{Digitale Kompetenzen}):
#'       education and training for the digital economy.}
#'     \item{\code{5}}{Culture and civil society (\emph{Kultur und
#'       Zivilgesellschaft}): digital media, cultural preservation,
#'       civic tech.}
#'     \item{\code{6}}{Research and innovation (\emph{Forschung &
#'       Innovation}): publicly funded R\&D in digital technologies.}
#'     \item{\code{7}}{Healthcare (\emph{Gesundheitswesen}): digital health
#'       infrastructure and telemedicine.}
#'     \item{\code{8}}{Armed forces (\emph{Bundeswehr}): military
#'       digitalisation. Exclusively \emph{Einzelplan} 14.}
#'     \item{\code{9}}{Indivisible expenditure (\emph{Unteilbare Ausgaben}):
#'       cross-cutting digital spending not assignable to a single theme.}
#'   }
#'   See \code{\link{kat_labels}} for the German label lookup.}
#'
#'   \item{any_tag}{Integer (0/1). \code{1} if the line was flagged by at
#'   least one of the four detection methods: keyword search (\code{texan_tag}),
#'   machine learning (\code{ml_tag}), expert knowledge (\code{expert_tag}),
#'   or budget series matching (\code{digital_series_tag}). Lines with
#'   \code{any_tag = 1} were subsequently reviewed and assigned a
#'   \code{digi_klasse}.}
#'
#'   \item{expert_tag}{Integer (0/1). \code{1} if the line was identified
#'   using additional information provided by experts within the federal
#'   administration.}
#'
#'   \item{large_soll_tag}{Integer (0/1). \code{1} if planned expenditure
#'   (\code{soll}) is at least EUR 100 million, triggering additional
#'   review.}
#'
#'   \item{ml_tag}{Integer (0/1). \code{1} if the line was flagged by the
#'   machine-learning text classifier.}
#'
#'   \item{digital_series_tag}{Integer (0/1). \code{1} if the line is part
#'   of a digital budget series established in a predecessor project.}
#'
#'   \item{texan_tag}{Integer (0/1). \code{1} if the line was flagged by the
#'   TexAn keyword text-analysis method. Matched keywords are marked with
#'   \code{[...]} or \code{\{...\}} in \code{titel_text}. See
#'   \code{\link{texan_keywords}} for the complete list of 23 keywords and
#'   their regular expressions.}
#'
#' }
#'
#' @section Data transformations:
#' The following changes were applied to the raw source file in
#' \code{data-raw/prepare.R}:
#' \enumerate{
#'   \item Approximately 61 rows with missing \code{soll} or
#'     \code{titel_text} were removed.
#'   \item \code{funktion_lvl1} and \code{funktion_lvl2} were derived from
#'     \code{funktion} by string subsetting.
#'   \item The nine original one-hot category columns
#'     (\code{_1_infra} \ldots \code{_9_unteilbare_ausg}) were collapsed
#'     into the single integer column \code{kategorie} and removed.
#' }
#'
#' @source Bertschek, I., Breithaupt, P., Heinemann, F., Niebel, T., and
#'   Schildknecht, J. (2026). \emph{Der Digitalhaushalt 2025: Wird er den
#'   hohen Erwartungen gerecht?} Agora Digitale Transformation gGmbH.
#'   \doi{10.5281/zenodo.19550821}
#'
#'   Dataset: Agora Digitale Transformation gGmbH,
#'   \emph{Digitalhaushalt Open Data}.
#'   Licence: CC BY-SA 4.0
#'   (\url{https://creativecommons.org/licenses/by-sa/4.0/}).
#'
#' @seealso
#'   \code{\link{kat_labels}}, \code{\link{hf_labels}},
#'   \code{\link{of_labels}}, \code{\link{gruppe_labels}},
#'   \code{\link{texan_keywords}}
#'
#' @examples
#' data(digitalhaushalt)
#'
#' # Rows per fiscal year
#' table(digitalhaushalt$jahr)
#'
#' # Confirmed digital lines by theme
#' digi <- subset(digitalhaushalt, !is.na(kategorie))
#' table(kat_labels[as.character(digi$kategorie)])
#'
#' # Total planned digital spending (narrow) per year, EUR billion
#' aggregate(digi_soll_eng ~ jahr,
#'           data = digitalhaushalt,
#'           FUN  = function(x) round(sum(x, na.rm = TRUE) / 1e6, 1))
"digitalhaushalt"
