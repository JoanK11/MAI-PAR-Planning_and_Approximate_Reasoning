(define (domain robot-chef)

(:requirements :typing :strips :fluents :adl)

(:types Location Item - Object
    Ingredient Tool Dish - Item
    TCut TMix TCook - Tool
    CA SVA DWA PA MIXA CTA SA - Location
)

(:predicates
    (robot-at ?l) ; The robot is at location l
    (item-at ?i - Item ?l - Location) ; The item i is at location l
    (dish-prepared ?d - Dish) ; The dish d is prepared, preparat per ser servit
    (dish-served ?d - Dish)
    (adjacent ?l1 - Location ?l2 - Location) ; 
    (holding ?i - Item)
    (is-holding)
    (tool-clean ?t - Tool)
    (processing-order ?d - Dish)
    (is-processing-order)

    ; Ingredient State
    (ingredient-cut ?i - Ingredient)
    (ingredient-mixed ?i - Ingredient)
    (ingredient-cooked ?i - Ingredient)
    (ingredient-ready ?i - Ingredient)

    ; Ingredient Needs
    (needs-cutting ?i - Ingredient)
    (needs-mixing ?i - Ingredient)
    (needs-cooking ?i - Ingredient)

    (order-processed ?d - Dish)

    (ingredient-in-dish ?d - Dish ?i - Ingredient)
    (initial-tool-pos ?t - Tool ?l - Location)
)

(:action move ; Fet
    :parameters (?l1 - Location ?l2 - Location)
    :precondition (and (robot-at ?l1) (adjacent ?l1 ?l2))
    :effect (and (not (robot-at ?l1)) (robot-at ?l2))
)

(:action pick-up-item ; Fet
    :parameters (?i - Item ?l - Location)
    :precondition (and (robot-at ?l) (item-at ?i ?l) (not (is-holding)))
    :effect (and (not (item-at ?i ?l)) (holding ?i) (is-holding))
)

(:action drop-item ; Fet
    :parameters (?i - Item ?l - Location)
    :precondition (and (robot-at ?l) (holding ?i))
    :effect (and (item-at ?i ?l) (not (holding ?i)) (not (is-holding)))
)

(:action clean-tool ; Fet
    :parameters (?t - Tool ?l - DWA)
    :precondition (and (robot-at ?l) (item-at ?t ?l)) ; ToDo: Veure que després el planner no netejarà moltes vegades una tool neta
    :effect (tool-clean ?t)
)

; Assumpció no cal netejar eines mentres cuinem un dish
(:action cut-ingredient ; DONE
    :parameters (?i - Ingredient ?t - TCut ?l - CTA)
    :precondition (and (robot-at ?l) (holding ?t) (item-at ?i ?l) (needs-cutting ?i))
    :effect (and (ingredient-cut ?i) (not (needs-cutting ?i)) (not (tool-clean ?t)))
)

(:action mix-ingredient ; DONE
    :parameters (?i - Ingredient ?t - TMix ?l - MIXA)
    :precondition (and (robot-at ?l) (holding ?t) (item-at ?i ?l) (needs-mixing ?i))
    :effect (and (ingredient-mixed ?i) (not (needs-mixing ?i)) (not (tool-clean ?t)))
)

(:action cook-ingredient ; DONE
    :parameters (?i - Ingredient ?t - TCook ?l - CA)
    :precondition (and (robot-at ?l) (not (is-holding)) (item-at ?i ?l) (item-at ?t ?l) (needs-cooking ?i))
    :effect (and (ingredient-cooked ?i) (not (needs-cooking ?i)) (not (tool-clean ?t)))
)

(:action check-prepared
    :parameters (?i - Ingredient ?d - Dish)
    :precondition (and (ingredient-in-dish ?d ?i) ; ToDo: Fa falta ingredient-in-dish en la precondició??
        (or (not (needs-cutting ?i)) (ingredient-cut ?i))
        (or (not (needs-mixing ?i)) (ingredient-mixed ?i))
        (or (not (needs-cooking ?i)) (ingredient-cooked ?i))
    )
    :effect (ingredient-ready ?i)
)

(:action assemble-dish
    :parameters (?d - Dish ?l - PA)
    :precondition (and (robot-at ?l) (not (is-holding))
                    (forall (?i - Ingredient)
                        (imply
                            (ingredient-in-dish ?d ?i)
                            (and (ingredient-ready ?i) (item-at ?i ?l))
                        )
                    )
    )
    :effect (and (dish-prepared ?d) (item-at ?d ?l)
            (forall (?i - Ingredient)
                (when
                    (ingredient-in-dish ?d ?i)
                    (not (item-at ?i ?l))
                )
            )
    )
)

(:action serve-dish ; Fet
    :parameters (?d - Dish ?l - SVA)
    :precondition (and (robot-at ?l) (holding ?d) (dish-prepared ?d))
    :effect (and (dish-served ?d) (not (holding ?d)) (not (is-holding)))
)

(:action start-order ; Fet
    :parameters (?d - Dish)
    :precondition (and (not (is-processing-order)))
    :effect (and (is-processing-order) (processing-order ?d))
)

(:action end-order ; Fet
    :parameters (?d - Dish)
    :precondition (and (processing-order ?d) (dish-served ?d)
        (forall (?t - Tool)
            (and (tool-clean ?t)
                (exists (?l - Location)
                    (and (initial-tool-pos ?t ?l) (item-at ?t ?l))
                )
            )
        )
    )
    :effect (and (not (processing-order ?d)) (not (is-processing-order)) (order-processed ?d))
)
)