;;;-------------------------------PREGUNTAS-------------------------------------


;; Pregunta segur(si/no), (si/no), indiferent
(deffunction preguntaBinariaBis (?text $?valors-permesos)
  (printout t crlf)
  (format t "%s (%s) " ?text (implode$ ?valors-permesos))
  (printout t crlf)
  (bind ?r (readline))
  (bind ?r (str-cat ?r))
  (while (not (member$ (lowcase ?r) ?valors-permesos)) do
    (format t "¿%s? (%s) " ?text (implode$ ?valors-permesos))
    (printout t crlf)
    (bind ?r (readline))
  )
  (if (eq (str-compare "segur si" ?r) 0)
    then (bind ?resp 2)
    else
      (if (eq (str-compare "si" ?r) 0)
        then (bind ?resp 1)
        else
          (if (eq (str-compare "indiferent" ?r) 0)
            then (bind ?resp 0)
            else
              (if (eq (str-compare "no" ?r) 0)
                then (bind ?resp -1)
                else
                  (bind ?resp -2)
              )
          )
      )
    )
    ?resp
)

;; Pregunta serveis positiva
(deffunction preguntaServeisPositiva (?text)
  (bind ?valors-serveis (create$ "centresalut" "escoles" "hipermercats" "supermercats" "oci" "transportpublic" "zonesverdes"))
  (bind ?valorsPermesosServeiSegur (create$ "segur centresalut" "segur escoles" "segur hipermercats" "segur supermercats" "segur oci" "segur transportpublic" "segur zonesverdes"))
  (printout t crlf)
  (format t "%s (%s) " ?text (implode$ ?valors-serveis))
  (printout t crlf)
  (bind ?r (readline))
  (bind ?r (str-cat ?r))
  (while TRUE
    do
    (bind ?op1 (lowcase ?r))
    (if (eq (str-compare "indiferent" ?op1) 0)
      then (return (create$ 0 null))
    )
    (if (member$ ?op1 ?valors-serveis)
      then (return (create$ 1 ?op1))
    )
    (if (member$ ?op1 ?valorsPermesosServeiSegur)
      then
        (bind ?resp (explode$ ?r))
        (bind ?op2 (lowcase (nth$ 2 ?resp)))
        (bind ?r1 (str-cat ?op2))
        (return (create$ 2 ?r1))
    )
    (printout t ?text crlf)
    (bind ?r (readline))
    (bind ?r (str-cat ?r))
  )
  (return (create$ 0 null))
)

;; Pregunta serveis negativa
(deffunction preguntaServeisNegativa (?text)
  (bind ?valors-serveis (create$ "centresalut" "escoles" "hipermercats" "supermercats" "oci" "transportpublic" "zonesverdes"))
  (bind ?valorsPermesosServeiSegur (create$ "segur centresalut" "segur escoles" "segur hipermercats" "segur supermercats" "segur oci" "segur transportpublic" "segur zonesverdes"))
  (printout t crlf)
  (format t "%s (%s) " ?text (implode$ ?valors-serveis))
  (printout t crlf)
  (bind ?r (readline))
  (bind ?r (str-cat ?r))
  (while TRUE
    do
    (bind ?op1 (lowcase ?r))
    (if (eq (str-compare "indiferent" ?op1) 0)
      then (return (create$ 0 null))
    )
    (if (member$ ?op1 ?valors-serveis)
      then (return (create$ -1 ?op1))
    )
    (if (member$ ?op1 ?valorsPermesosServeiSegur)
      then
        (bind ?resp (explode$ ?r))
        (bind ?op2 (lowcase (nth$ 2 ?resp)))
        (bind ?r1 (str-cat ?op2))
        (return (create$ -2 ?r1))
    )
    (printout t ?text crlf)
    (bind ?r (readline))
    (bind ?r (str-cat ?r))
  )
  (return (create$ 0 null))
)

;;; Pregunta per un integer
(deffunction preguntaInteger (?text ?min ?max)
	(printout t crlf)
	(printout t ?text crlf)
	(bind ?r (read))
	(while (not(and(>= ?r ?min)(<= ?r ?max))) do
    (printout t "Numero invalid; ha d'estar entre " ?min " i " ?max crlf)
		(bind ?r (read))
	)
	?r
)

(deffunction preguntaIntegerUnbound (?text)
	(printout t crlf)
	(printout t ?text crlf)
	(bind ?r (read))
	(while (not (and (integerp ?r) (>= ?r 0))) do
    		(printout t "Introdueix un número positiu" crlf)
		(bind ?r (read))
	)
	?r
)

(deffunction preguntaFlexible (?text $?valors-permesos)
  (printout t crlf)
  (format t "%s (%s) " ?text (implode$ ?valors-permesos))
  (printout t crlf)
  (bind ?r (read))
  (bind ?r (str-cat ?r))
  (while (not (member$ (lowcase ?r) ?valors-permesos)) do
    (format t "%s (%s) " ?text (implode$ ?valors-permesos))
    (printout t crlf)
    (bind ?r (readline))
  )
  (if (eq (str-compare "si" ?r) 0)
    then (bind ?resp 1)
    else
      (if (eq (str-compare "no" ?r) 0)
        then (bind ?resp -1)
        else
          (bind ?resp 0)
      )
  )
  ?resp
)
