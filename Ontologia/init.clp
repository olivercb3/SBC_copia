(defrule initAndLoad "Load Files"
  ;;hauria de ser amb initial-fact pero no sabem com es fa
  ?trigger <- (initial)
	=>
	(load "Prototype.clp")
  (load "preguntasFunctions.clp")
  (load "printObjectesFuncions.clp")
  (load "inputRules.clp")
  (assert (initial-main))
)
