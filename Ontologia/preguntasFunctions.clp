;;;-------------------------------PREGUNTAS-------------------------------------


;;; Pregunta de si o no
(deffunction preguntaBinaria (?text)
  (printout t  ?text " (si/no):" crlf)
  (bind ?r (read))
  (while (not (or
                (eq ?r si) (eq ?r no)))
      (printout t "Resposta invalida a de ser  si o no" crlf)
        (bind ?r (read))
      )
  (if  (eq ?r si)
    then TRUE
    else FALSE
  )
)

;; Pregunta segur(si/no), (si/no), indiferent
;;(bind ?pBalco (preguntaBinariaBis "Vols Balco?" (create$ "segur si" "si" "indifirent" "no" "segur no")))
(deffunction preguntaBinariaBis (?text $?valors-permesos)
    (progn$
    (?var ?valors-permesos)
    (lowcase ?var))
  (format t "¿%s? (%s) " ?text (implode$ ?valors-permesos))
  (bind ?r (read))
  (while (not (member (lowcase ?r) ?valors-permesos)) do
    (format t "¿%s? (%s) " ?text (implode$ ?valors-permesos))
    (bind ?r (read))
  )
  ;;afegir la gestio de retorn (2...-2)
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

;;; Pregunta de qualsevol tipus
(deffunction preguntaVariable (?text)
	(format t "%s" ?text)
	(bind ?r (read))
  ?r
)
