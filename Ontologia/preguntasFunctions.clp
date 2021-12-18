;;;-------------------------------PREGUNTAS-------------------------------------


;; Pregunta segur(si/no), (si/no), indiferent
(deffunction preguntaBinariaBis (?text $?valors-permesos)
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
(deffunction preguntaServeisPositiva (?text $?valors-serveis)
  (format t "%s (%s) " ?text (implode$ ?valors-serveis))
  (printout t crlf)
  (bind ?r (readline))
  (bind ?r (str-cat ?r))
  (bind ?resp (explode$ ?r))
  (while TRUE
    do
    (bind ?op1 (lowcase (nth$ 1 ?resp)))
    (if (eq ?op1 indiferent)
      then (return (create$ 0 null))
    )
    (if (member$ ?op1 ?valors-serveis)
      then (return (create$ 1 ?op1))
    )
    (if (> (length$ ?resp) 1)
      then
        (bind ?op2 (lowcase (nth$ 2 ?resp)))
        (if (and (member$ ?op2 ?valors-serveis) (eq ?op1 segur))
          then (return (create$ 2 ?op2))
        )
    )
    (printout t ?text crlf)
    (bind ?r (readline))
    (bind ?r (str-cat ?r))
    (bind ?resp (explode$ ?r))
  )
  (return (create$ 0 null))
)

;; Pregunta serveis negativa
(deffunction preguntaServeisNegativa (?text $?valors-serveis)
  (format t "%s (%s) " ?text (implode$ ?valors-serveis))
  (printout t crlf)
  (bind ?r (readline))
  (bind ?r (str-cat ?r))
  (bind ?resp (explode$ ?r))
  (while TRUE
    do
    (bind ?op1 (lowcase (nth$ 1 ?resp)))
    (if (eq ?op1 indiferent)
      then (return (create$ 0 null))
    )
    (if (member$ ?op1 ?valors-serveis)
      then (return (create$ -1 ?op1))
    )
    (if (> (length$ ?resp) 1)
      then
        (bind ?op2 (lowcase (nth$ 2 ?resp)))
        (if (and (member$ ?op2 ?valors-serveis) (eq ?op1 segur))
          then (return (create$ -2 ?op2))
        )
    )
    (printout t ?text crlf)
    (bind ?r (readline))
    (bind ?r (str-cat ?r))
    (bind ?resp (explode$ ?r))
  )
  (return (create$ 0 null))
)

;;; Pregunta per un integer
(deffunction preguntaInteger (?text ?min ?max)
	(printout t crlf)
	(printout t ?text crlf)
	(bind ?r (read))
	(while (not(and(>= ?r ?min)(<= ?r ?max))) do
    (printout t "Numero invalid a de estar entre " ?min " i " ?max crlf)
		(bind ?r (read))
	)
	?r
)

(deffunction preguntaFlexible (?text $?valors-permesos)
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
