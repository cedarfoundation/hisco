#' @name hisco_hsn
#' @title Hisco HSN codes 
#' @description Hisco coding table from original HSN source, to historical classsystems, 
#'   HISCLASS, HISCLASS 5, SOCPO and Universal HISCAM 
#' @docType data
#' @usage data(hisco_hsn)
#' @format A data frame with 4142 rows and 13 variables:
#' \describe{
#'   \item{hisco}{HISCO basic code}
#'   \item{status}{HISCO status code}
#'   \item{relation}{HISCO relation code}
#'   \item{product}{HISCO  product code}
#'   \item{hisclass}{HISCLASS code}
#'   \item{hisclass_5}{HISCLASS code comprised in 5 classes}
#'   \item{socpo}{SOCPO code}
#'   \item{hiscam_u1}{Universal HISCAM code}
#'   \item{hiscam_nl}{HISCAM code for HSN data}
#'   \item{release}{HSN release version}
#'   \item{hisclass_label}{HISCLASS label}
#'   \item{hisclass_5_label}{HISCLASS 5 label}
#'   \item{socpo_label}{SOCPO label}
#' }
#' @source The dataset is based on the Kees Mandemakers, Sanne Muurling, 
#'   Ineke Maas, Bart Van de Putte, Richard L. Zijdeman, Paul Lambert, 
#'   Marco H.D. van Leeuwen, Frans van Poppel and Andrew Miles, 
#'   \emph{HSN standardized, HISCO-coded and classified occupational titles, 
#'   release 2013.01} (IISG Amsterdam 2013); Marco H. D. van Leeuwen, 
#'   Ineke Maas and Andrew Miles, \emph{HISCO. Historical International 
#'   Standard Classification of Occupations} (Leuven University Press 2002)
#'   downloaded from \url{http://www.iisg.nl/hsn/data/occupations.html} 
#'   \emph{Accessed, 2014-09-02}.
NULL

#' @name hisco
#' @title Hisco codes
#' @description Hisco coding table, to historical classsystems, 
#'   HISCLASS, HISCLASS 5, SOCPO and Universal HISCAM 
#' @docType data
#' @usage data(hisco)
#' @format A data frame with 4123 rows and 12 variables:
#' \describe{
#'   \item{hisco}{HISCO basic code}
#'   \item{en_hisco_text}{Plain text description of occupation}
#'   \item{status}{HISCO status code}
#'   \item{relation}{HISCO relation code}
#'   \item{product}{HISCO  product code}
#'   \item{hisclass}{HISCLASS code}
#'   \item{hisclass_5}{HISCLASS code comprised in 5 classes}
#'   \item{socpo}{SOCPO code}
#'   \item{hiscam_u1}{Universal HISCAM code}
#'   \item{hisclass_label}{HISCLASS label}
#'   \item{hisclass_5_label}{HISCLASS 5 label}
#'   \item{socpo_label}{SOCPO label}
#' }
#' @source The dataset is based on the Kees Mandemakers, Sanne Muurling, 
#'   Ineke Maas, Bart Van de Putte, Richard L. Zijdeman, Paul Lambert, 
#'   Marco H.D. van Leeuwen, Frans van Poppel and Andrew Miles, 
#'   \emph{HSN standardized, HISCO-coded and classified occupational titles, 
#'   release 2013.01} (IISG Amsterdam 2013); Marco H. D. van Leeuwen, 
#'   Ineke Maas and Andrew Miles, \emph{HISCO. Historical International 
#'   Standard Classification of Occupations} (Leuven University Press 2002)
#'   downloaded from \url{http://www.iisg.nl/hsn/data/occupations.html} 
#'   \emph{Accessed, 2014-09-02}; Pre-processed by Glenn Sandström, 
#'   Umeå university.
NULL

#' @name hisclass
#' @title Hisclass meta data
#' @description Characteristict of hisclass classes.
#' @docType data
#' @usage data(hisclass)
#' @format A data frame with 14 rows and 6 variables:
#' \describe{
#'   \item{hisclass}{hisclass code}
#'   \item{hisclass_label}{Description of class}
#'   \item{manual}{Manual/Non-manual}
#'   \item{skill_level}{Skill level}
#'   \item{supervision}{Supervision}
#'   \item{sector}{Economic sector}
#' }
#' @source Leeuwen, M.H.D.V. & Maas, I. (2011). \emph{HISCLASS: a 
#'   historical international social class scheme. Leuven: 
#'   Leuven University Press};  Mandemakers etal. (2013) 
#'   \emph{HSN standardized, HISCO-coded and classified occupational 
#'   titles, release 2013.01}.
NULL

#' @name socpo
#' @title SOCPO meta data
#' @description Characteristict of SOCPO classes.
#' @docType data
#' @usage data(socpo)
#' @format A data frame with 14 rows and 6 variables:
#' \describe{
#'   \item{socpo}{SOCPO code}
#'   \item{socpo_label}{Class name}
#'   \item{socpo_description}{Desciription of class}
#' }
#' @source Leeuwen, M.H.D.V. & Maas, I. (2011). \emph{HISCLASS: a 
#'   historical international social class scheme. Leuven: 
#'   Leuven University Press};  Mandemakers etal. (2013) 
#'   \emph{HSN standardized, HISCO-coded and classified occupational 
#'   titles, release 2013.01}.NULL
NULL 

#' @name hisclass_5
#' @title HISCLASS 5 meta data
#' @description Characteristict of HISCLASS 5 classes.
#' @docType data
#' @usage data(hisclass_5)
#' @format A data frame with 6 rows and 4 variables:
#' \describe{
#'   \item{hisclass_5}{HISCLASS 5 code}
#'   \item{hisclass_relation}{Relation to HISCLASS}
#'   \item{hisclass_5_label}{Class label}
#'   \item{hisclass_5_description}{Desciription of class}
#' }
#' @source Leeuwen, M.H.D.V. & Maas, I. (2011). \emph{HISCLASS: a 
#'   historical international social class scheme. Leuven: 
#'   Leuven University Press};  Mandemakers etal. (2013) 
#'   \emph{HSN standardized, HISCO-coded and classified occupational 
#'   titles, release 2013.01}.
NULL
